Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D31AC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B4820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnFhKVwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBQIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:52:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33803 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728217AbgBQIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581929560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9G4eC97MKUgP+cXhellYbHRQe5FYP3q5I9qDq+0E3so=;
        b=fnFhKVwJfpsTU6aEnEURFeaGiI0axXg8LgEog+hYHm7UtB3PWcP9mKdABUMPCfzmukoxGk
        3Wdmb19TV9pfe8EIxM3vGEgHvQjEGUku1LyOXGpVXUcDyYLcdqf/eVzroMucml0vx4hNpj
        z4ZaBuW/YgQMFzMuCMt+jB5ao2mIAbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-7BZlheS2N2SsK4ZwsBfASw-1; Mon, 17 Feb 2020 03:52:39 -0500
X-MC-Unique: 7BZlheS2N2SsK4ZwsBfASw-1
Received: by mail-wm1-f72.google.com with SMTP id y125so2368757wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9G4eC97MKUgP+cXhellYbHRQe5FYP3q5I9qDq+0E3so=;
        b=iSUL7ySC/sYL2uMX2cFAZM5Wd1C7v45qNyONcicXhls+uYri0D0lOIy3yxmULy3x4a
         KFRxyABeQ1A+Zmp0iyLkK0JfTvNY6Z7xwSYHN4YjiYm94J/QCFJsztWuqEJKUcfJJgPR
         QgLQEu2zpUaUGYXstiGolb3Z/NUbCBtqYHTRCBMkdjUvbL2Sq6JVWoxpHOE4d1MXeVJ5
         AYEZKrbC0nRYCuSJGhUk/mzfCniiTZU6PuRBx1vRZX4vB2L2MBpUnkjlOI6GDSZnb+iF
         1Keyy9Cg+jghcqGjwxPIxc1VLyYLEtaz5SkIseWJpiuoegLsPOJhIo2MXAVZxxm8Ivu9
         13Xg==
X-Gm-Message-State: APjAAAV8rj8wt0scohpk4tqtkZjavMunKu4bDD+Rx0DktVKWofoEwcKR
        Uh6l+NTiBrXEp6/j4oD20qt/j9xfPOk4HSnIKwWvsjZc+njbVbG7QU6QVjFZ6tpBjbKChg9VmN5
        Ojxn4oLY9MLaXb92QOmN/1SVi
X-Received: by 2002:a05:600c:2c01:: with SMTP id q1mr20672139wmg.179.1581929557588;
        Mon, 17 Feb 2020 00:52:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMpzIPVEU5r46mv5Dyf9+hTP7Dzsi4UbPKOlvpGkJxEH57K69N/xQw0jEso6nxioT5dTqnvg==
X-Received: by 2002:a05:600c:2c01:: with SMTP id q1mr20672122wmg.179.1581929557376;
        Mon, 17 Feb 2020 00:52:37 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm21908626wrw.54.2020.02.17.00.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:52:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: VMX: Add VMX_FEATURE_USR_WAIT_PAUSE
In-Reply-To: <20200216104858.109955-1-xiaoyao.li@intel.com>
References: <20200216104858.109955-1-xiaoyao.li@intel.com>
Date:   Mon, 17 Feb 2020 09:52:36 +0100
Message-ID: <87r1ytbnor.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Commit 159348784ff0 ("x86/vmx: Introduce VMX_FEATURES_*") missed
> bit 26 (enable user wait and pause) of Secondary Processor-based
> VM-Execution Controls.
>
> Add VMX_FEATURE_USR_WAIT_PAUSE flag and use it to define
> SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE to make them uniformly.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/include/asm/vmx.h         | 2 +-
>  arch/x86/include/asm/vmxfeatures.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 2a85287b3685..8521af3fef27 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -72,7 +72,7 @@
>  #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
>  #define SECONDARY_EXEC_PT_USE_GPA		VMCS_CONTROL_BIT(PT_USE_GPA)
>  #define SECONDARY_EXEC_TSC_SCALING              VMCS_CONTROL_BIT(TSC_SCALING)
> -#define SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE	0x04000000
> +#define SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE	VMCS_CONTROL_BIT(USR_WAIT_PAUSE)
>  
>  #define PIN_BASED_EXT_INTR_MASK                 VMCS_CONTROL_BIT(INTR_EXITING)
>  #define PIN_BASED_NMI_EXITING                   VMCS_CONTROL_BIT(NMI_EXITING)
> diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
> index a50e4a0de315..1408f526bd90 100644
> --- a/arch/x86/include/asm/vmxfeatures.h
> +++ b/arch/x86/include/asm/vmxfeatures.h
> @@ -81,6 +81,7 @@
>  #define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
>  #define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
>  #define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
> +#define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* "" Enable TPAUSE, UMONITOR, UMWATI in guest */

"UMWAIT"

>  #define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
>  
>  #endif /* _ASM_X86_VMXFEATURES_H */

With the typo fixed (likely upon commit),

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

