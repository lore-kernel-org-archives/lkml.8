Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB19C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FFC207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK+Kknal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgGaHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:21:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51245 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731552AbgGaHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596180095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhINLqqhxnP4dI0gpE4qU/e48aN+/lH7whG0lTG2sOM=;
        b=IK+KknalzkUqJhe6zz2O77iyRkHVLYghSkNAVcECcvIlEH1GtLmgnB+q06gg59NJ2vt5+0
        9efH7dS9EZqyhr4CcO8o2iycq/yHk10w99H9qBJrkCcgT31+VaXLf9T57pIrtoIJMNtYPG
        C4X6aF6Bm7uYDHOfoN+XP9wIsD2tg9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-bJMtmHs0PKac0C-UexVk8g-1; Fri, 31 Jul 2020 03:21:30 -0400
X-MC-Unique: bJMtmHs0PKac0C-UexVk8g-1
Received: by mail-wr1-f72.google.com with SMTP id r29so4479295wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YhINLqqhxnP4dI0gpE4qU/e48aN+/lH7whG0lTG2sOM=;
        b=GpZbF8h+4KUZPe66kGY7ddUu3+Bi9KAkvo3CCRDk/KmDCF0ckGrQSzG+PWw9e2/Y2t
         DSfjgyp+cZc4ZezLRs3BKhp2nqnG7Zq8VtfGGyXc1DsV3TNXIgK2r4V+cg4p6/L/No2i
         kd2KJ+7UpJWp+c2x6IrEaAUiHmej1kIWycwOiwh7+49kr9IXMr4f1EQm40MPSgiuax9A
         8DdTuYwdbZbG2PF/DQUBar6wwfrGzFLMlLAvGoHqtn7TLHXcaIkM9Mha9U95BNBmGWTj
         CcJi5+uaBKENIJ2lyeYVzHE1VTgMXfWP9Jju0A19wzVcwGdFxh8fOnn5K6cOT3lOXJ1U
         EF/A==
X-Gm-Message-State: AOAM5324X4+IogeuxyWnzLO3X5gz0xABh+FJQZIxwrMFuOF3iR2MOBlK
        AJSOPiEzv5SYyLYgwEAnJV5mGluj684laL/EU4b+rfiQIZCcIlVfs6rZIqYGFCorrmUBAWNCaam
        owanEWkveRIKIlHXoATgBS5Gp
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr2761788wmd.82.1596180089309;
        Fri, 31 Jul 2020 00:21:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYuiwOQg3zrH0P/vMjCtmTUs3SPv1/R6CQYiqzJb5lGc+AXN0tsrZpBEo62hsb3u2/PJ4lTg==
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr2761767wmd.82.1596180089022;
        Fri, 31 Jul 2020 00:21:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445? ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
        by smtp.gmail.com with ESMTPSA id b186sm13204394wme.1.2020.07.31.00.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:21:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] KVM: SVM: Fix disable pause loop exit/pause
 filtering capability on SVM
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1596165141-28874-1-git-send-email-wanpengli@tencent.com>
 <1596165141-28874-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae8bf85f-00ee-c59c-e543-e0364481526c@redhat.com>
Date:   Fri, 31 Jul 2020 09:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596165141-28874-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/20 05:12, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> 'Commit 8566ac8b8e7c ("KVM: SVM: Implement pause loop exit logic in SVM")' 
> drops disable pause loop exit/pause filtering capability completely, I 
> guess it is a merge fault by Radim since disable vmexits capabilities and 
> pause loop exit for SVM patchsets are merged at the same time. This patch 
> reintroduces the disable pause loop exit/pause filtering capability support.
> 
> Reported-by: Haiwei Li <lihaiwei@tencent.com>
> Tested-by: Haiwei Li <lihaiwei@tencent.com>
> Fixes: 8566ac8b (KVM: SVM: Implement pause loop exit logic in SVM)
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v2 -> v3:
>  * simplify the condition in init_vmcb() 
> 
>  arch/x86/kvm/svm/svm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c0da4dd..bf77f90 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1090,7 +1090,7 @@ static void init_vmcb(struct vcpu_svm *svm)
>  	svm->nested.vmcb = 0;
>  	svm->vcpu.arch.hflags = 0;
>  
> -	if (pause_filter_count) {
> +	if (!kvm_pause_in_guest(svm->vcpu.kvm)) {
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
> +	if (!pause_filter_count || !pause_filter_thresh)
> +		kvm->arch.pause_in_guest = true;
> +
>  	if (avic) {
>  		int ret = avic_vm_init(kvm);
>  		if (ret)
> 

Queued all three, thanks.  Please do send a testcase for patch 1
however, I only queued it in order to have it in 5.8.

Paolo

