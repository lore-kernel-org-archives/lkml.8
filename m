Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71017C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4404F2467D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HadbDCCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAOGuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:50:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgAOGuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579071018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRmRVjt4VuQHcdX0Fq66G4p7865AfnsRCHZCOCF+SJY=;
        b=HadbDCCIh/xm2B33pCJqT9jCINGL/c3hJMLlTGKbCYf2/8EgwF7dUh9dgnuVhkr6BdG4vm
        /g78Kt0LR8gOZ+XhpWiz0CTF8lA6kt4R5f1Db0zh3UPLE02rFTnqjOPyBZn0+XxnRnY3Bu
        UHUOMBwBMI/XE/pGZ77yC0Mv/wzUjL0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-DqVDE-hvM0yhBZ86EvyVJg-1; Wed, 15 Jan 2020 01:50:17 -0500
X-MC-Unique: DqVDE-hvM0yhBZ86EvyVJg-1
Received: by mail-qt1-f199.google.com with SMTP id e37so10587264qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRmRVjt4VuQHcdX0Fq66G4p7865AfnsRCHZCOCF+SJY=;
        b=dLOk0djS9xgmbhTnLRV2aUjy6XFVgNs6dKRYGNvnOXNw/2cKhcSocLjDxajSeFw6Bw
         1GiUCC7zLwZzexM5OQTPdqavoQT/TSUh02JWAmJWbx6oIWpH5guDJ7946vQz7dGptxBI
         lDW5IwAlvdos9nKXgYpAYzZP8d11EFaRgccX830I5KhR/lLbvBDeCOavW3IxmYpwQh6O
         SmnwaVtHy9Dl+/f7W9u0mBBzQphCMDEbsTTDN5L1pm4T3ct/pbsszHr3bknmsoWH4Mti
         122Vdl5MJrvY2FTYcfLkdyRqPLZJnrKxGUMUPBNO4i7dWvlBvc9Wnbn/k+IZZVlbRdor
         aZPQ==
X-Gm-Message-State: APjAAAVNoz2BLKr42xa6IwVJ645VHEuacTsPT7mgvgFbrBhD8jxwOAs8
        Hoe4RnY5UH/BoKZNQisQX875hdXJRtRq0qQD3wBglNSVk18gl9Ax0+pvPQ3Dk13qTArEi+3VKVr
        P0uQXb66EmEq6JYyMO1zXM6aq
X-Received: by 2002:aed:3c16:: with SMTP id t22mr2158041qte.92.1579071016653;
        Tue, 14 Jan 2020 22:50:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+JHaQyK4cROIu3XDgjevbDMk5RwHCZJqLOBkK59TwqdwSAfqibCf47Af1w0kbJriP3UtBqg==
X-Received: by 2002:aed:3c16:: with SMTP id t22mr2158025qte.92.1579071016474;
        Tue, 14 Jan 2020 22:50:16 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id a36sm9168690qtk.29.2020.01.14.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:50:15 -0800 (PST)
Date:   Wed, 15 Jan 2020 01:50:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200115014735-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <20200109141634-mutt-send-email-mst@kernel.org>
 <20200114200134.GA233443@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114200134.GA233443@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 03:01:34PM -0500, Peter Xu wrote:
> On Thu, Jan 09, 2020 at 02:35:46PM -0500, Michael S. Tsirkin wrote:
> >   ``void flush_dcache_page(struct page *page)``
> > 
> >         Any time the kernel writes to a page cache page, _OR_
> >         the kernel is about to read from a page cache page and
> >         user space shared/writable mappings of this page potentially
> >         exist, this routine is called.
> > 
> > 
> > > Also, I believe this is the similar question that Jason has asked in
> > > V2.  Sorry I should mention this earlier, but I didn't address that in
> > > this series because if we need to do so we probably need to do it
> > > kvm-wise, rather than only in this series.
> > 
> > You need to document these things.
> > 
> > >  I feel like it's missing
> > > probably only because all existing KVM supported archs do not have
> > > virtual-tagged caches as you mentioned.
> > 
> > But is that a fact? ARM has such a variety of CPUs,
> > I can't really tell. Did you research this to make sure?
> > 
> > > If so, I would prefer if you
> > > can allow me to ignore that issue until KVM starts to support such an
> > > arch.
> > 
> > Document limitations pls.  Don't ignore them.
> 
> Hi, Michael,
> 
> I failed to find a good place to document about flush_dcache_page()
> for KVM.  Could you give me a suggestion?

Maybe where the field is introduced. I posted the suggestions to the
relevant patch.

> And I don't know about whether there's any ARM hosts that requires
> flush_dcache_page().  I think not, because again I didn't see any
> caller of flush_dcache_page() in KVM code yet.  Otherwise I think we
> should at least call it before the kernel reading kvm_run or after
> publishing data to kvm_run.

But is kvm run ever accessed while VCPU is running on another CPU?
I always assumed no but maybe I'm missing something?

>  However I'm also CCing Drew for this.
> 
> Thanks,
> 
> -- 
> Peter Xu

