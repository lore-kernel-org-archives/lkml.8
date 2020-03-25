Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64561C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AA420771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk4jGHnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCYLXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:23:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31358 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgCYLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585135429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4Tl6bQIkr3Iqlt21YwTz/ubUb2xT3zuSMPcl5tcUSk=;
        b=fk4jGHnFr5MZZDenGC+qJbGy8HVHxQ3Ps09dVspyrFwHNq/log1Ddufxjd3Dz7fAMNNosF
        /go7WYkmhXjeamNk7itIBld5v41F69z+fQwsxv1mtlaCiyXnVBwEqmGMqxZrq5kpq1+rwf
        yrNxqSl9IjTIVHAtUK4Bzo+PjSZzBeM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-1EXeYriqOLCR8woyWi-vBg-1; Wed, 25 Mar 2020 07:23:45 -0400
X-MC-Unique: 1EXeYriqOLCR8woyWi-vBg-1
Received: by mail-wr1-f69.google.com with SMTP id e10so1003428wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e4Tl6bQIkr3Iqlt21YwTz/ubUb2xT3zuSMPcl5tcUSk=;
        b=ZOtpcfKu8qq56g1BPL0KjVN0u/bK94FoaBqSThzsaKMfRNN1H26aMI8uTOFLq859sa
         HKMOWMm96wpTs7uRsh5ZpzCrhLB78RQ2AkPC3lznQ9ruugXn78TvX3jWQR9UQR3Lafgl
         BW5NDWiP7g5DzunItouymZVb7IV+ND0Mf3QyI+n0cEuF/nky6f/sbYeDvF6OPXjyy1bt
         OPEpGvQcxhchzW36EZqBwxCWQZ5RFkWWIHP73blYCgDTIvirUE5VN44OVdrAsGGCmQ/Y
         BAN3DhTnsqUbuKWh3qoQbqlTV4qKIoWmwityaja1Qh5xFwEYptTztQmrRCju/COwFenC
         eJnA==
X-Gm-Message-State: ANhLgQ29VeJ5CEVpFgJ/TPwlTpU5Gjp8YYhdWmPiupGqwnqeWflUx03i
        Ixp68YSgiwxFIBIdKiZsCLHF0OLjbQidz75+8HnrNKDIXUjSxx3eVQzD6NCATvyjDg5WR0ZN5v9
        mtvbpvjGsqzDU2q5SLtTOh9ek
X-Received: by 2002:adf:e70d:: with SMTP id c13mr2967964wrm.306.1585135424916;
        Wed, 25 Mar 2020 04:23:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsTGX8GAStTOUZFTGqunGZzqjJERoFUpumo5ctf4JSurFppaOOIPB4yfJvxqIO223aQMv6PYQ==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr2967939wrm.306.1585135424694;
        Wed, 25 Mar 2020 04:23:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w9sm11681078wrk.18.2020.03.25.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:23:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 17/37] KVM: SVM: Wire up ->tlb_flush_guest() directly to svm_flush_tlb()
In-Reply-To: <20200320212833.3507-18-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-18-sean.j.christopherson@intel.com>
Date:   Wed, 25 Mar 2020 12:23:42 +0100
Message-ID: <87wo7865kx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use svm_flush_tlb() directly for kvm_x86_ops->tlb_flush_guest() now that
> the @invalidate_gpa param to ->tlb_flush() is gone, i.e. the wrapper for
> ->tlb_flush_guest() is no longer necessary.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 62fa45dcb6a4..dfa3b53f8437 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5643,11 +5643,6 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
>  	invlpga(gva, svm->vmcb->control.asid);
>  }
>  
> -static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
> -{
> -	svm_flush_tlb(vcpu);
> -}
> -
>  static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
>  {
>  }
> @@ -7405,7 +7400,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  
>  	.tlb_flush = svm_flush_tlb,
>  	.tlb_flush_gva = svm_flush_tlb_gva,
> -	.tlb_flush_guest = svm_flush_tlb_guest,
> +	.tlb_flush_guest = svm_flush_tlb,
>  
>  	.run = svm_vcpu_run,
>  	.handle_exit = handle_exit,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

