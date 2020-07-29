Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA821C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA9B206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OULqUF8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgG2MVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:21:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36272 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2MVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596025260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6W1T974VZvK5aHdyDKfm8iT0P3+yUruO/0hQztff7w=;
        b=OULqUF8WQ+jBXyTFiyqDCBvQPyHTde9J5Lk6aOUxznUqwGmfyDJkRPu5c//BgneRKkAaYZ
        pHk0QTrPZyBHi03s10yLnaGdSMvmarIY8Ko8ZmfpbCyvotZm80ey8MfBiMYf/GLBHcXbzS
        t/r9+VNUlQWdf6BNQeKRqQaSvEhk9c0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-8j5gBKxlMPWwXEr-4k2bSw-1; Wed, 29 Jul 2020 08:20:58 -0400
X-MC-Unique: 8j5gBKxlMPWwXEr-4k2bSw-1
Received: by mail-ed1-f71.google.com with SMTP id i3so8259672edq.21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d6W1T974VZvK5aHdyDKfm8iT0P3+yUruO/0hQztff7w=;
        b=aMUnYURapv8RGHJV02mgwgcXyje8G0tGabVIu2oBrOzXSkbP/tG3jbjdRZlBKhuFFX
         UGcejQ5mMkl+fDq8pJjgBiuB0lVVoDYxg4G9vo+qy68XTMsY4F93+0dxJV4zIQPDoWAN
         3FPHnQs2dqlYa1F+XumSMhCUqJ1WGM5fUB+B/kF7CpVlRIxfG7B3ft95nuEwC1iCYmOi
         5ffDDfQMufjrznJh0NlJ/tjdvrj7zsbxXMQHcY+5Oh44knMFB1ulbc4YQnu4DmeZ7a7H
         +20yWXQx7TEojJFe6oSXSxf9fORo3ZC990xeUnjY5lsOS7uL0jgf6HD6DlvxdJzgw7mi
         HIeQ==
X-Gm-Message-State: AOAM532QHt5fz4vwVXwE5Nbp37xZl8oU/FDr6HEyOktba3TApFtiAqMs
        rijO33rePssQB/vztkX4opF8oquVj1efvLYEiT0Yy+paj6FJc8cukox4I467kmcB1DTc3DjPLgJ
        4DoDKGHXRd03FaRJIHRkCpyUC
X-Received: by 2002:a05:6402:2031:: with SMTP id ay17mr4496494edb.46.1596025257246;
        Wed, 29 Jul 2020 05:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO5SyrFRx4z+lvlosTAQpCNz7fTshwRKVxOkDbzVCw5cgeIqEa4f1i3ysB4XP6Rnyox74DtQ==
X-Received: by 2002:a05:6402:2031:: with SMTP id ay17mr4496471edb.46.1596025257037;
        Wed, 29 Jul 2020 05:20:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o7sm1655137edq.53.2020.07.29.05.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:20:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Fix disable pause loop exit/pause filtering capability on SVM
In-Reply-To: <1595929506-9203-3-git-send-email-wanpengli@tencent.com>
References: <1595929506-9203-1-git-send-email-wanpengli@tencent.com> <1595929506-9203-3-git-send-email-wanpengli@tencent.com>
Date:   Wed, 29 Jul 2020 14:20:54 +0200
Message-ID: <87k0ymldg9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Commit 8566ac8b (KVM: SVM: Implement pause loop exit logic in SVM) drops
> disable pause loop exit/pause filtering capability completely, I guess it
> is a merge fault by Radim since disable vmexits capabilities and pause
> loop exit for SVM patchsets are merged at the same time. This patch
> reintroduces the disable pause loop exit/pause filtering capability
> support.
>
> We can observe 2.9% hackbench improvement for a 92 vCPUs guest on AMD 
> Rome Server.
>
> Reported-by: Haiwei Li <lihaiwei@tencent.com>
> Tested-by: Haiwei Li <lihaiwei@tencent.com>
> Fixes: 8566ac8b (KVM: SVM: Implement pause loop exit logic in SVM)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/svm/svm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c0da4dd..c20f127 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1090,7 +1090,7 @@ static void init_vmcb(struct vcpu_svm *svm)
>  	svm->nested.vmcb = 0;
>  	svm->vcpu.arch.hflags = 0;
>  
> -	if (pause_filter_count) {
> +	if (pause_filter_count && !kvm_pause_in_guest(svm->vcpu.kvm)) {
>  		control->pause_filter_count = pause_filter_count;
>  		if (pause_filter_thresh)
>  			control->pause_filter_thresh = pause_filter_thresh;
> @@ -2693,7 +2693,7 @@ static int pause_interception(struct vcpu_svm *svm)
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  	bool in_kernel = (svm_get_cpl(vcpu) == 0);
>  
> -	if (pause_filter_thresh)
> +	if (!kvm_pause_in_guest(vcpu->kvm))
>  		grow_ple_window(vcpu);
>  
>  	kvm_vcpu_on_spin(vcpu, in_kernel);
> @@ -3780,7 +3780,7 @@ static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
>  
>  static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
>  {
> -	if (pause_filter_thresh)
> +	if (!kvm_pause_in_guest(vcpu->kvm))
>  		shrink_ple_window(vcpu);
>  }
>  
> @@ -3958,6 +3958,9 @@ static void svm_vm_destroy(struct kvm *kvm)
>  
>  static int svm_vm_init(struct kvm *kvm)
>  {
> +	if (!pause_filter_thresh)
> +		kvm->arch.pause_in_guest = true;

Would it make sense to do

        if (!pause_filter_count || !pause_filter_thresh)
		kvm->arch.pause_in_guest = true;

here and simplify the condition in init_vmcb()?

> +
>  	if (avic) {
>  		int ret = avic_vm_init(kvm);
>  		if (ret)

-- 
Vitaly

