Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC65C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0555424670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQgNSKsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:01:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726523AbgANUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579032099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5YGCCGIX+lIuE1xVDvMmlXX8AVAofNe88Se1/lzptk=;
        b=bQgNSKsdn/+k6J/0nR5h6y6iw1hQLDxUY8vYTboOpK0Pxb/4uVJculfzo7aHJb+iFGd1eK
        YByexd5sJkRxg5VbekMN/u0dNF5kSZemEXkOP1FupqINwttYzPZgp4qVAci6It9354PGnE
        ewkdDlIOFvHXhndegUdZQi9KPzGI73E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-T90WYAvJMPafHPQOx4HfIQ-1; Tue, 14 Jan 2020 15:01:37 -0500
X-MC-Unique: T90WYAvJMPafHPQOx4HfIQ-1
Received: by mail-qk1-f197.google.com with SMTP id 194so9122580qkh.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 12:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F5YGCCGIX+lIuE1xVDvMmlXX8AVAofNe88Se1/lzptk=;
        b=lWQTONyqBTJ6k4QH+DWMZymCB7jrWEzICljxTKtiS5ZZZpiQ0BvOtnbehOoyxRd8vS
         Sm1n19wocJhilj5uNCFHY4x8bnbydryXoQZW3JvR+S3Qu+UwF9+fHTdZ6j2/ojxKk533
         RnYTMiR++3XSAKVkdeCzsD+YbzILgsG/vbPjw1uZ5Rq7L3QPCP1FNvK6RiabDs5DqO3r
         4m1r3tfq2cGaJ8BEbuKJdTeBl1DNfCpg23lgvJ6N7bQCEnrYjiGSzleJGHi2pqrFkuGW
         lfj8xWqCRpfpDl+nJzhO4ZrjN6yL1THaD5+XpWiipG/yycW/gnLCo/vU1lZ+BMOjvaOk
         FPBQ==
X-Gm-Message-State: APjAAAVNO+LkSCPluBkt78Ssu2/lQbJSaAbsYqjsk3W/HPCgRVgFbgAd
        ic/NxZXXkoFhBU1jbf+4q9tZAJHl/Dsz+RuNzJoTTj1xFLAFCebiUzOEZy/ALF30eQpWVKC1mnO
        CuAY1NuXMUdj/kxgUtI2thEac
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr22091576qvq.113.1579032097457;
        Tue, 14 Jan 2020 12:01:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNbvJ19TaniVCvM/mX2nsCuKcnV2VokhOKt9QMPvk/ivDM+6fGWGUc2wdsUeBtEK+BAUVjqA==
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr22091536qvq.113.1579032097113;
        Tue, 14 Jan 2020 12:01:37 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id m8sm8255953qtk.60.2020.01.14.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:01:36 -0800 (PST)
Date:   Tue, 14 Jan 2020 15:01:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <20200114200134.GA233443@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <20200109141634-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109141634-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:35:46PM -0500, Michael S. Tsirkin wrote:
>   ``void flush_dcache_page(struct page *page)``
> 
>         Any time the kernel writes to a page cache page, _OR_
>         the kernel is about to read from a page cache page and
>         user space shared/writable mappings of this page potentially
>         exist, this routine is called.
> 
> 
> > Also, I believe this is the similar question that Jason has asked in
> > V2.  Sorry I should mention this earlier, but I didn't address that in
> > this series because if we need to do so we probably need to do it
> > kvm-wise, rather than only in this series.
> 
> You need to document these things.
> 
> >  I feel like it's missing
> > probably only because all existing KVM supported archs do not have
> > virtual-tagged caches as you mentioned.
> 
> But is that a fact? ARM has such a variety of CPUs,
> I can't really tell. Did you research this to make sure?
> 
> > If so, I would prefer if you
> > can allow me to ignore that issue until KVM starts to support such an
> > arch.
> 
> Document limitations pls.  Don't ignore them.

Hi, Michael,

I failed to find a good place to document about flush_dcache_page()
for KVM.  Could you give me a suggestion?

And I don't know about whether there's any ARM hosts that requires
flush_dcache_page().  I think not, because again I didn't see any
caller of flush_dcache_page() in KVM code yet.  Otherwise I think we
should at least call it before the kernel reading kvm_run or after
publishing data to kvm_run.  However I'm also CCing Drew for this.

Thanks,

-- 
Peter Xu

