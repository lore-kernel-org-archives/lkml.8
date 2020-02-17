Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5CC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD6215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjkrIsYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgBQQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:40:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgBQQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581957630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fm9Mu329tflOhzJ9YEndE4Fe2Pm3uRmsk0n5PQaTgWY=;
        b=GjkrIsYmUt/lIRBOi3UXCJyEip3sl+SL9Tdhd+YKb8GVmfPl8J0FHudc+RUOZAm9rjOuJt
        H5ayk7HMVU+JNYboX65igFLfQHJ18AyaKLfqgNRB3gaSOyfYUL7uA7gB3HNuwZBd4Mh/XN
        k0ZGBG1ibgoFEd4ZB5jX8EDrua2mFOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-43QBt8A9OpC8hMEJvV4WAg-1; Mon, 17 Feb 2020 11:40:29 -0500
X-MC-Unique: 43QBt8A9OpC8hMEJvV4WAg-1
Received: by mail-wr1-f69.google.com with SMTP id 90so9204234wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fm9Mu329tflOhzJ9YEndE4Fe2Pm3uRmsk0n5PQaTgWY=;
        b=STwzYH0OQiNKbsFvT5X4BL+3X5XMYPfTwE9He94TMSx0zjNsmcc0JACXaWJohWdlkn
         5O+WVj8DnxwWGLweU8kSA/tDojJcW1Plm/9p43vnzW8Ic7VC6RcQxAsuSR/i8MJ1AKL3
         JVZ/d9pJK84fJqexxrpJ1aTBYP4GsP5esRaKi/SPjW17FkQKtNl7iQDSI5m1u1Ca9p3A
         FMpX/zTaNTk5atUkgudXUJ4ljOdofNgW90pwXanchpB66sGWOkqwqqZLWYxEsM2d5F9z
         gCgTGRFBmvmURZB0aSSKKasC/R66TvJpnkNQ9v/iozQZISSPdm/ownzl/JhvjvYvVXEI
         T13Q==
X-Gm-Message-State: APjAAAUZXlW2pvNmqHfuNOv2U56wHi/B/wivorddEiTum07ZhRKqjMtu
        aQ1U1AbNYw9ItUDKVAFuUr7VEbN9GWIO91ouco/Is9SEzuwmRDKOe89LqlfcPecskGPkkg66awB
        UA7IZ4kqVTrMxog1Kgd/8oQC0
X-Received: by 2002:a1c:740a:: with SMTP id p10mr23104941wmc.65.1581957627971;
        Mon, 17 Feb 2020 08:40:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCCTrFsnWEQy/Qavf0QH4TGCt6wA1yzkQAK3IxV3vfOTUJgIEepTQUFdbvUG6+zqWkVDBsGg==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr23104922wmc.65.1581957627771;
        Mon, 17 Feb 2020 08:40:27 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x17sm1732096wrt.74.2020.02.17.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:40:27 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH v2] KVM: VMX: Add 'else' to split mutually exclusive case
In-Reply-To: <1581951750-17854-1-git-send-email-linmiaohe@huawei.com>
References: <1581951750-17854-1-git-send-email-linmiaohe@huawei.com>
Date:   Mon, 17 Feb 2020 17:40:26 +0100
Message-ID: <87h7zp9ngl.fsf@vitty.brq.redhat.com>
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
> v1->v2:
> add braces to all if branches
> ---
>  arch/x86/kvm/vmx/vmx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a6664886f2e..a13368b2719c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6176,15 +6176,13 @@ static void handle_exception_nmi_irqoff(struct vcpu_vmx *vmx)
>  	vmx->exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  
>  	/* if exit due to PF check for async PF */
> -	if (is_page_fault(vmx->exit_intr_info))
> +	if (is_page_fault(vmx->exit_intr_info)) {
>  		vmx->vcpu.arch.apf.host_apf_reason = kvm_read_and_reset_pf_reason();
> -
>  	/* Handle machine checks before interrupts are enabled */
> -	if (is_machine_check(vmx->exit_intr_info))
> +	} else if (is_machine_check(vmx->exit_intr_info)) {
>  		kvm_machine_check();
> -
>  	/* We need to handle NMIs before interrupts are enabled */
> -	if (is_nmi(vmx->exit_intr_info)) {
> +	} else if (is_nmi(vmx->exit_intr_info)) {
>  		kvm_before_interrupt(&vmx->vcpu);
>  		asm("int $2");
>  		kvm_after_interrupt(&vmx->vcpu);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

