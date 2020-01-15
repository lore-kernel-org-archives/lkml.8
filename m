Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D45AC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E482B222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AONAabfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:21:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726132AbgAOPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579101660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ki7tnjd8CszgUl/v/wFasJuUFOd5ESMGpqCxJao2aME=;
        b=AONAabfFiJsJVzmnwox5ujtgGCdcBLfHS5m9cYKAIKWB/82rzrY643JMI0uHygn2uwoFAp
        un67Z+ferT2tqKEYbGYpmRjEahvEfZy810V1Z3r0WsfY7c90p7j4sv3OFp9TwdQg62AHih
        +Wz4jYHF6iM63zKVNjAvZlUPVrcK9OE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-t5tku7EWON2LbmKcNIXJbg-1; Wed, 15 Jan 2020 10:20:59 -0500
X-MC-Unique: t5tku7EWON2LbmKcNIXJbg-1
Received: by mail-qt1-f200.google.com with SMTP id d18so11472183qtp.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ki7tnjd8CszgUl/v/wFasJuUFOd5ESMGpqCxJao2aME=;
        b=OHPz6vNmVksbXN8LHaLhQ+BOAJdYsboel0QKAL5H3iSquiWBdSOoUZB4GDrdCFR8or
         foCAxusSjk8v7++6xsErpSKkk43RhC3K9JdOYY9NcoGqU51FR3b+cmiAkW4OIFkMDUHN
         73RTuh01viydeUkkm4y5eX12Pnk/WUQZEpejNT225SdSuqD3mjnP8G538j3/nqZ/Bhvb
         wl6gpCrs9vi9VanfvFQFaHPT3/4TdxmQGeu18UsW8OT15CXVPz8uu9FngID3EwNmpwbf
         6uF0pPcg7flS8O4kN8SI+tTDQ+FVX4/VLzR8kR/GptPMXDjpgRzFjQz0BC74NO/KHGdW
         LMDA==
X-Gm-Message-State: APjAAAV6EMVmfEoulLr47d3d8PuAXQCI+w0SvW+frxhgekJOJhzVK0p/
        upeQU0y5kG0SBypLhFRuvi1wKrQ+Ifv5CL3Mz28gLFH475xumuF8VaKOcuvHcKfSfb+OUIT4MWC
        Gg4cATTI6uUIO+jQuCxftD+7A
X-Received: by 2002:a37:648c:: with SMTP id y134mr22704393qkb.175.1579101659112;
        Wed, 15 Jan 2020 07:20:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVTvtcNezjslT/T83pZqi27Oyc9HRfMsEwQ65HHw1XAmlwoI0NsNMWacRwNdOlm4NiqGw4Vw==
X-Received: by 2002:a37:648c:: with SMTP id y134mr22704364qkb.175.1579101658828;
        Wed, 15 Jan 2020 07:20:58 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id u52sm9782422qta.23.2020.01.15.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:20:58 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:20:55 -0500
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
Message-ID: <20200115152055.GF233443@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
 <20200109110110-mutt-send-email-mst@kernel.org>
 <20200109191514.GD36997@xz-x1>
 <20200109141634-mutt-send-email-mst@kernel.org>
 <20200114200134.GA233443@xz-x1>
 <20200115014735-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115014735-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 01:50:08AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 14, 2020 at 03:01:34PM -0500, Peter Xu wrote:
> > On Thu, Jan 09, 2020 at 02:35:46PM -0500, Michael S. Tsirkin wrote:
> > >   ``void flush_dcache_page(struct page *page)``
> > > 
> > >         Any time the kernel writes to a page cache page, _OR_
> > >         the kernel is about to read from a page cache page and
> > >         user space shared/writable mappings of this page potentially
> > >         exist, this routine is called.

[1]

> > > 
> > > 
> > > > Also, I believe this is the similar question that Jason has asked in
> > > > V2.  Sorry I should mention this earlier, but I didn't address that in
> > > > this series because if we need to do so we probably need to do it
> > > > kvm-wise, rather than only in this series.
> > > 
> > > You need to document these things.
> > > 
> > > >  I feel like it's missing
> > > > probably only because all existing KVM supported archs do not have
> > > > virtual-tagged caches as you mentioned.
> > > 
> > > But is that a fact? ARM has such a variety of CPUs,
> > > I can't really tell. Did you research this to make sure?
> > > 
> > > > If so, I would prefer if you
> > > > can allow me to ignore that issue until KVM starts to support such an
> > > > arch.
> > > 
> > > Document limitations pls.  Don't ignore them.
> > 
> > Hi, Michael,
> > 
> > I failed to find a good place to document about flush_dcache_page()
> > for KVM.  Could you give me a suggestion?
> 
> Maybe where the field is introduced. I posted the suggestions to the
> relevant patch.

(will reply there)

> 
> > And I don't know about whether there's any ARM hosts that requires
> > flush_dcache_page().  I think not, because again I didn't see any
> > caller of flush_dcache_page() in KVM code yet.  Otherwise I think we
> > should at least call it before the kernel reading kvm_run or after
> > publishing data to kvm_run.
> 
> But is kvm run ever accessed while VCPU is running on another CPU?
> I always assumed no but maybe I'm missing something?

IMHO we need to call it even if it's running on the same CPU - please
refer to [1] above, there's no restriction on which CPU the code is
running on.  I think it makes sense, especially the systems for
virtually-tagged caches because even if the memory accesses happened
on the same CPU, the virtual addresses to access the same page could
still be different when accessed from kernel/userspace.

Thanks,

-- 
Peter Xu

