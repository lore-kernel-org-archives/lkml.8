Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C21C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED27B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8QAWZNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBQJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:34:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgBQJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581932079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVuEtX8FtIARnol8tLBo6pDDxNy2nZPTs0vmayLCtgs=;
        b=F8QAWZNCRQw3Hhz/bIG3H5v17Tt9aCSIB/oM4BafLHrctSRxmG0s/DA1IqQrYUzl4MftsO
        txI9oAz5hrRWDT6XhUlAh6I0HovfuoqttL3firqExV9J1ZabIG/ToEzMMUMEF6iYyzWSy3
        ld6gRtOLPNZJxzYmalEzWa07MESH1LY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-hNtWRimgOMSvDXOgms92lQ-1; Mon, 17 Feb 2020 04:34:38 -0500
X-MC-Unique: hNtWRimgOMSvDXOgms92lQ-1
Received: by mail-wm1-f69.google.com with SMTP id b8so2415228wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 01:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DVuEtX8FtIARnol8tLBo6pDDxNy2nZPTs0vmayLCtgs=;
        b=Uji0/WOLuFKNW1zyxtSflWKwo3NKGZ4WZ/MQCQ9NcfkYc6uXZu/LvjexLArI57+FaD
         G+EF2BXL9OBB3JZ3XOkw4sNdj/vIDsSE+1AqCizVd7xHqWtEaC+blH0LpwiWqj08yyfN
         GEa419WKdd0E4dvndNtJluGO12a17mt21g0/e31PjEUoHIxDvHHHLD3SQVCljBLw6hDb
         W7zqT/bKG551DKl8tyXeh36ntV7dPQH0ZWNN1scWkDp3aWNlyU8PzR7WXkWbknp6BuYj
         QMIDOP22Q6fLjsd2roaL2flLdrBtkuvCsZGas5vZFXKE5bpEp5V7L1XqyQrCuuVU5jmJ
         oM0g==
X-Gm-Message-State: APjAAAVkVGsP0p5eqTyRZ/o/Dwj0znYxm/xWR74od5MlZEbnGXXq0531
        92ASpAu2YsazBsxrEcz8h+vjlW+j21zBnygUkNbH2LKXZ0YlwpRBZXpApNpSYsYGsG86UVjJhqR
        HGWVE/JJNBF+6NX/oGkb/tQGf
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr21679974wmi.28.1581932076689;
        Mon, 17 Feb 2020 01:34:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+HZuR3VpZEihyptNVhIpQSpScRnQq1TUX9734Bk5y49B6BGh9pXci8R8b0fgtEnVT2wd1OQ==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr21679945wmi.28.1581932076437;
        Mon, 17 Feb 2020 01:34:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g2sm76613wrw.76.2020.02.17.01.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:34:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: VMX: Add 'else' to split mutually exclusive case
In-Reply-To: <1581561315-3820-1-git-send-email-linmiaohe@huawei.com>
References: <1581561315-3820-1-git-send-email-linmiaohe@huawei.com>
Date:   Mon, 17 Feb 2020 10:34:34 +0100
Message-ID: <87lfp1blqt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Each if branch in handle_external_interrupt_irqoff() is mutually
> exclusive. Add 'else' to make it clear and also avoid some unnecessary
> check.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a6664886f2e..bb5c33440af8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6178,13 +6178,11 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
>  	/* if exit due to PF check for async PF */
>  	if (is_page_fault(vmx->exit_intr_info))
>  		vmx->vcpu.arch.apf.host_apf_reason = kvm_read_and_reset_pf_reason();
> -
>  	/* Handle machine checks before interrupts are enabled */
> -	if (is_machine_check(vmx->exit_intr_info))
> +	else if (is_machine_check(vmx->exit_intr_info))
>  		kvm_machine_check();
> -
>  	/* We need to handle NMIs before interrupts are enabled */
> -	if (is_nmi(vmx->exit_intr_info)) {
> +	else if (is_nmi(vmx->exit_intr_info)) {

We'll need to add braces to all branches of the statement,

    if (is_page_fault(vmx->exit_intr_info)) {

    } else if (is_machine_check(vmx->exit_intr_info)) {

    } else if (is_nmi(vmx->exit_intr_info)) {

    }

then.

>  		kvm_before_interrupt(&vmx->vcpu);
>  		asm("int $2");
>  		kvm_after_interrupt(&vmx->vcpu);

-- 
Vitaly

