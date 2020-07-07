Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95515C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6602B2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsjW0Kip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGGIEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:04:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgGGIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594109086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0mh35xkHSMPfz/goX6QsqA4ztMFVQSPiIBdm0V+Pjk=;
        b=BsjW0KipkM4JmSADFcWJ1iczZ2vRiHxe9Hu6afOXE94KIeC9lGiQTuwEZNOnwyQ0t0bpeZ
        VeMohP/UNjEjXa4h2ewfFO5djjiswOo1r7D7EsvxSWa67oQ3QdlEqNv1/QoW9X6XFMiE94
        8OouUv4c40EmRRM9ieJ+cqdB/Pstat8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-yfVvA9w4PwqwLeJWX5rndA-1; Tue, 07 Jul 2020 04:04:41 -0400
X-MC-Unique: yfVvA9w4PwqwLeJWX5rndA-1
Received: by mail-wr1-f69.google.com with SMTP id i10so47821965wrn.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0mh35xkHSMPfz/goX6QsqA4ztMFVQSPiIBdm0V+Pjk=;
        b=EtIs8gd8JMW7swKh6OpmLHL+XqmSoVL6ocPdunKhBg2BfvBnH5a3NEBlZf+6iqvfJp
         2Iook4N33fc/GWTL2qkIIzMeixSHKDyd0tsfjhTUemZk8n09VTfDCODsTUkTsrPqb41G
         6ULiZTYX30csIljSn0UAWpeS34Vdli/YcI2R9YcSSLEF+ahjBLEWtaO806ZyFAw9ovgR
         x1bEv3eAr79pE3AGKRiouCZZ3U6AyYm+jJTOtMd4YQrZ8ND/tmefzu5jM2hQsYXkyL58
         7bxvV5pRcdV6gq45Uc1G/7K/MEr6WJkzo9vR9N1eOc5XMlvRf6H0a1Dc9to8iu5i9tOm
         GV0g==
X-Gm-Message-State: AOAM533+l2QQFlzL/+QULT7AH1BvdkfZJiQX+Uymgqph7JvVv7E9GQUk
        peSzSjI6nkQUKbK+jZQjxs9oOeduExa0yLh7w1C5D8nJcmiwsa/TUkMzyIPh8LxDC2XPy1OH5GD
        hYE/NIM6OuNrp/vTRotOvuMGy
X-Received: by 2002:a1c:2157:: with SMTP id h84mr2804175wmh.35.1594109080790;
        Tue, 07 Jul 2020 01:04:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEXYEc8WO2QrC4l1AhnZ0dwyI2sMS9xYnpCs4+uKJSHDlLUn+io3PXSQkdxcCMVou80aHRHA==
X-Received: by 2002:a1c:2157:: with SMTP id h84mr2802969wmh.35.1594109064788;
        Tue, 07 Jul 2020 01:04:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id b62sm2419356wmh.38.2020.07.07.01.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:04:24 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: rewrite kvm_spec_ctrl_valid_bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>
References: <20200702174455.282252-1-mlevitsk@redhat.com>
 <20200702181606.GF3575@linux.intel.com>
 <3793ae0da76fe00036ed0205b5ad8f1653f58ef2.camel@redhat.com>
 <20200707061105.GH5208@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c1d9bbe-5f59-5b86-01e9-43c929b24218@redhat.com>
Date:   Tue, 7 Jul 2020 10:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707061105.GH5208@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/20 08:11, Sean Christopherson wrote:
> One oddity with this whole thing is that by passing through the MSR, KVM is
> allowing the guest to write bits it doesn't know about, which is definitely
> not normal.  It also means the guest could write bits that the host VMM
> can't.

That's true.  However, the main purpose of the kvm_spec_ctrl_valid_bits
check is to ensure that host-initiated writes are valid; this way, you
don't get a #GP on the next vmentry's WRMSR to MSR_IA32_SPEC_CTRL.
Checking the guest CPUID bit is not even necessary.

Paolo

> Somehwat crazy idea inbound... rather than calculating the valid bits in
> software, what if we throw the value at the CPU and see if it fails?  At
> least that way the host and guest are subject to the same rules.  E.g.
> 
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2062,11 +2062,19 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
>                         return 1;
> 
> -               if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
> -                       return 1;
> -
> +               ret = 0;
>                 vmx->spec_ctrl = data;
> -               if (!data)
> +
> +               local_irq_disable();
> +               if (rdmsrl_safe(MSR_IA32_SPEC_CTRL, &data))
> +                       ret = 1;
> +               else if (wrmsrl_safe(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl))
> +                       ret = 1;
> +               else
> +                       wrmsrl(MSR_IA32_SPEC_CTRL, data))
> +               local_irq_enable();
> +
> +               if (ret || !vmx->spec_ctrl)
>                         break;
> 
>                 /*
> 

