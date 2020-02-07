Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56106C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C91922464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np9/FvrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGXA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:00:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727048AbgBGXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 18:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581116424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mg3ZsC4pgFdFBM7wdlAk9wteMT5/edAs8oS1GJ/WtPQ=;
        b=Np9/FvrNGxhL80eslAlCFgn2asYw83e+Kky1dmMqjPUY4mkCRloqSoYK5GB32+vJiLHDOM
        ASCJ/0wy5kmFr+Lhegk03pgqM2AujdzQ+ETxIRSazp5O6tG/pbZxDICxO4mmkHzIFSecOS
        Urswv6cU9sL9jwxo8ShRaF7tKqzvzqM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-j2k62M8CPqiY4Zdugrg8uQ-1; Fri, 07 Feb 2020 18:00:21 -0500
X-MC-Unique: j2k62M8CPqiY4Zdugrg8uQ-1
Received: by mail-qt1-f199.google.com with SMTP id e8so571591qtg.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 15:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mg3ZsC4pgFdFBM7wdlAk9wteMT5/edAs8oS1GJ/WtPQ=;
        b=Nyw1ccuF4A6q+zcJj49jJp7nudmgQNaTk05gcNW26Fci0irSB8W+KjDHt1M01qYZRG
         UdlSTkHyfMd6z5DDfzGdiXMmBo/65uRGrEHsDuUKBDgBazS+xkg8+/6oCYBKz/W4wvwO
         KxlUSY4b/OmsmwM5ukMD7h0ik89bkvz1PDN8peqxsSVZ8pK7QsBf4DNuzePZxAsS566A
         DytdFpOsdOApvYYN2U3sMWktTcaVvTRKmF28o24gTBmul4e9rxKZ2kOb1YRTNZudSkkd
         brD1VjTdjCRW6TJD2kRakRKQQrjybLRpNayPNFisV5G675hsWrwrtGWSEwO0171gBC2Y
         h/Rg==
X-Gm-Message-State: APjAAAWBvdV3c5Zg84VQym1YfacAoaml6jIjY3b86iu1gd4rVo6Fsdv5
        S0Sn2HS9Bupfo5fHkObbi7EJgWaMNMjbuF3CKLiultNL9pTBlY3Yb3wqoad3k2SnOIjNydsLben
        GJdETQY/GIF97XTSFUAIWCk89
X-Received: by 2002:a05:620a:4e:: with SMTP id t14mr1267815qkt.396.1581116420705;
        Fri, 07 Feb 2020 15:00:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuF1LLIxUFKrrOHlnN6saW0tHnTBvZDP+QG2258sOq7kKKURMnwYV9pi8GIsHumI9LY+ZCrQ==
X-Received: by 2002:a05:620a:4e:: with SMTP id t14mr1267793qkt.396.1581116420453;
        Fri, 07 Feb 2020 15:00:20 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id g201sm709092qke.110.2020.02.07.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 15:00:19 -0800 (PST)
Date:   Fri, 7 Feb 2020 18:00:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-mips@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 0/4] KVM: MIPS: Provide arch-specific
 kvm_flush_remote_tlbs()
Message-ID: <20200207230015.GI720553@xz-x1>
References: <20200207223520.735523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207223520.735523-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:16PM -0500, Peter Xu wrote:
> [This series is RFC because I don't have MIPS to compile and test]
> 
> kvm_flush_remote_tlbs() can be arch-specific, by either:
> 
> - Completely replace kvm_flush_remote_tlbs(), like ARM, who is the
>   only user of CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL so far
> 
> - Doing something extra before kvm_flush_remote_tlbs(), like MIPS VZ
>   support, however still wants to have the common tlb flush to be part
>   of the process.  Could refer to kvm_vz_flush_shadow_all().  Then in
>   MIPS it's awkward to flush remote TLBs: we'll need to call the mips
>   hooks.
> 
> It's awkward to have different ways to specialize this procedure,
> especially MIPS cannot use the genenal interface which is quite a
> pity.  It's good to make it a common interface.
> 
> This patch series removes the 2nd MIPS usage above, and let it also
> use the common kvm_flush_remote_tlbs() interface.  It should be
> suggested that we always keep kvm_flush_remote_tlbs() be a common
> entrance for tlb flushing on all archs.
> 
> This idea comes from the reading of Sean's patchset on dynamic memslot
> allocation, where a new dirty log specific hook is added for flushing
> TLBs only for the MIPS code [1].  With this patchset, logically the

[1] https://lore.kernel.org/kvm/20200207194532.GK2401@linux.intel.com/T/#m2da733d75dab5e54e2ae68de94fe8411166d6274

> new hook in that patch can be dropped so we can directly use
> kvm_flush_remote_tlbs().
> 
> TODO: We can even extend another common interface for ranged TLB, but
> let's see how we think about this series first.
> 
> Any comment is welcomed, thanks.
> 
> Peter Xu (4):
>   KVM: Provide kvm_flush_remote_tlbs_common()
>   KVM: MIPS: Drop flush_shadow_memslot() callback
>   KVM: MIPS: Replace all the kvm_flush_remote_tlbs() references
>   KVM: MIPS: Define arch-specific kvm_flush_remote_tlbs()
> 
>  arch/mips/include/asm/kvm_host.h |  7 -------
>  arch/mips/kvm/Kconfig            |  1 +
>  arch/mips/kvm/mips.c             | 22 ++++++++++------------
>  arch/mips/kvm/trap_emul.c        | 15 +--------------
>  arch/mips/kvm/vz.c               | 14 ++------------
>  include/linux/kvm_host.h         |  1 +
>  virt/kvm/kvm_main.c              | 10 ++++++++--
>  7 files changed, 23 insertions(+), 47 deletions(-)
> 
> -- 
> 2.24.1
> 

-- 
Peter Xu

