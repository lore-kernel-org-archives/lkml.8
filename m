Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB95207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJQFkPYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgIBOqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:46:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727825AbgIBONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599055984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+SlazSrbBYVrkGDDfctr1NZcX102DoU/4jHmOlehDKs=;
        b=RJQFkPYMngzToFxfIY1SDGKxZzpWr/4wZvECnO0SVz7qr+xU0rEtVtz5GaI42Eqz3/PU6r
        +RvOxQgVqLiQPQLOGU9/4k0Q1WPLFZTAByjOkeLrwg4fMAmal1v2zhi5Ukxo5VNXai/dcG
        IAyqMHYO7BCFTwjtR0kYiowzB1SEoZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ZfMNzrg2P9qQbMr8YoamTQ-1; Wed, 02 Sep 2020 10:12:59 -0400
X-MC-Unique: ZfMNzrg2P9qQbMr8YoamTQ-1
Received: by mail-wr1-f70.google.com with SMTP id v5so2086669wrs.17
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+SlazSrbBYVrkGDDfctr1NZcX102DoU/4jHmOlehDKs=;
        b=VqXsJR07XqwNb3AKNzpBSFg4bpKnEMvsGAyLpYLFgadvzTEUz4Snc9UNoVbmxoVfKL
         EXRYFVI5e1h6L76Of1Ksg8B8Rs1N4qV6ZPmHdYU9j81B6RX1fO2HBCy6HGkrAsONzjqG
         f3zYaZ6EPI6mi+jY4J/orMSd/CdCVZlN0Os0NH76bsw0JOOnCzqoX7YZmQuAzqdoAzpB
         yDDPjRxmct0Arf8KtchNYT+62VZxXH1Ijm9AcgKOESuZsyW4slI6PH8j+K5fPRKiRwdG
         4+o5WE5bhyBZQzHAys5ru6OThtBq24Qio8ss1g9Z+VgruGxh7ZiKVsG2IJ16LABoyu22
         xMPA==
X-Gm-Message-State: AOAM532SpZn2YZ2b3NFfHCEAiaGkoFw0jQvf6va35WJmzgTU7pZGm0pW
        y44oR+a08VMkNfRm1HFnkUEI+354HwukDQCOmJuCpAcaCRJTpMinjTzKUZws3BK+Pl42pgLOQCk
        YTjdduzdU+839PJkJg5dv/Bbg
X-Received: by 2002:adf:e610:: with SMTP id p16mr7928647wrm.71.1599055978754;
        Wed, 02 Sep 2020 07:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxXtyvuCzBi/izdiadlCE9hj/SCj7ZzU6crCLAPok8THyns5DedtXVkwYAbCi73bOsWypnPw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr7928622wrm.71.1599055978525;
        Wed, 02 Sep 2020 07:12:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a85sm7218993wmd.26.2020.09.02.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:12:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH V2] kvm x86/mmu: use KVM_REQ_MMU_SYNC to sync when needed
In-Reply-To: <20200902135421.31158-1-jiangshanlai@gmail.com>
References: <87y2ltx6gl.fsf@vitty.brq.redhat.com> <20200902135421.31158-1-jiangshanlai@gmail.com>
Date:   Wed, 02 Sep 2020 16:12:55 +0200
Message-ID: <871rjkp8rc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai Jiangshan <jiangshanlai@gmail.com> writes:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> When kvm_mmu_get_page() gets a page with unsynced children, the spt
> pagetable is unsynchronized with the guest pagetable. But the
> guest might not issue a "flush" operation on it when the pagetable
> entry is changed from zero or other cases. The hypervisor has the 
> responsibility to synchronize the pagetables.
>
> The linux kernel behaves as above for many years, But
> 8c8560b83390("KVM: x86/mmu: Use KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes)

Nit: checkpatch.pl complains here with 

ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit 8c8560b83390 ("KVM: x86/mmu: Use
KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes")'
#118: 
8c8560b83390("KVM: x86/mmu: Use KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes)

> inadvertently included a line of code to change it without giving any
> reason in the changelog. It is clear that the commit's intention was to
> change KVM_REQ_TLB_FLUSH -> KVM_REQ_TLB_FLUSH_CURRENT, so we don't
> unneedlesly flush other contexts but one of the hunks changed
> nearby KVM_REQ_MMU_SYNC instead.
>
> The this patch changes it back.
>
> Link: https://lore.kernel.org/lkml/20200320212833.3507-26-sean.j.christopherson@intel.com/
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
> Changed from v1:
> 	update patch description
>
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4e03841f053d..9a93de921f2b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2468,7 +2468,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>  		}
>  
>  		if (sp->unsync_children)
> -			kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
>  
>  		__clear_sp_write_flooding_count(sp);

FWIW, 

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

but it'd be great to hear from Sean).

-- 
Vitaly

