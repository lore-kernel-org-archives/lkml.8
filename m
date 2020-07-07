Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66355C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416892073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIn98eWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGR0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:26:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbgGGR0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594142803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LrO7VqgYVoFRtAEnJtwxKftEVr1AjGjug4X5J7y9k0=;
        b=dIn98eWp9RHmiKsDMXPiKF+BUmNB48SQTo2/ffJOEyVD+4Jek2cMUEz8VEMWtptO4g86UZ
        S9w7qPdJDJcn18AMyZwx6ARqUnCR3R5qoAd1aehJtq0xEEszYdpn16rWrwYSGyQ39GdW5T
        BefEfh47WiSFM0pep3f1GMS8ASqBgTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-u2bssbMSPEmfWKliSg11ew-1; Tue, 07 Jul 2020 13:26:42 -0400
X-MC-Unique: u2bssbMSPEmfWKliSg11ew-1
Received: by mail-wr1-f70.google.com with SMTP id z1so19342137wrn.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LrO7VqgYVoFRtAEnJtwxKftEVr1AjGjug4X5J7y9k0=;
        b=UR2TpWlYMohaBjFT3J72f4oUhxZjHxtDEBfzSm4rUmQWJ/JhnkY/t7mJu02D4Iu2FX
         Lr16OjX2qC5nNTM2SvktDMgftPj5dl7eRC/gveDA/tKnM5cuq/NtQqWIg58J2j9pNSfB
         Gp3yCNt7iNE/XB6gJfgaisnis1Xo45B3CZYDTT02iywZFp4xMmQqyttaOU2akWkB4YEg
         BJpr7QEs93CX8sZ5XI+4Qatx37U5ygDRR37Zixd7feplRRjxbVOhxn3XQNm9YqbyQQxq
         kb+tK1l1xJZ4lCWDl24ZMfN/z5i7m0nXwZYjYkpYErP+MWRbL2bpa4brezS9MLVULhPx
         uMXg==
X-Gm-Message-State: AOAM532tCDNvATpFTEcVSyWyeek/dCvLMG4v57Prrr/CStU96AML+PkH
        rmYjCEoT0ZlYS/FBbnXecnEpl/aEk7gXn8b+IUFsz7xvreLN02LOp6UH0XFlknXz6OQJjRkuT+y
        d55ABHzEcZdxRTnYvEbz/OccS
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr5663954wme.177.1594142801266;
        Tue, 07 Jul 2020 10:26:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNNrn3AIg1g3/5R2NVngn8kYJ+htIdF6x+ntfOrYeAJwFW3NKZhvcjYcIPkbdIJED+yPp84A==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr5663931wme.177.1594142801054;
        Tue, 07 Jul 2020 10:26:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id a12sm1870753wrv.41.2020.07.07.10.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:26:40 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: rewrite kvm_spec_ctrl_valid_bits
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
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
 <a0ab28aa726df404962dbc1c6d1f833947cc149b.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e49c6f78-ac9a-b001-b3b6-7c7dcccc182c@redhat.com>
Date:   Tue, 7 Jul 2020 19:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a0ab28aa726df404962dbc1c6d1f833947cc149b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/20 13:30, Maxim Levitsky wrote:
>> Somehwat crazy idea inbound... rather than calculating the valid bits in
>> software, what if we throw the value at the CPU and see if it fails?  At
>> least that way the host and guest are subject to the same rules.  E.g.
>>
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -2062,11 +2062,19 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                     !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
>>                         return 1;
>>
>> -               if (data & ~kvm_spec_ctrl_valid_bits(vcpu))
>> -                       return 1;
>> -
>> +               ret = 0;
>>                 vmx->spec_ctrl = data;
>> -               if (!data)
>> +
>> +               local_irq_disable();
>> +               if (rdmsrl_safe(MSR_IA32_SPEC_CTRL, &data))
>> +                       ret = 1;
>> +               else if (wrmsrl_safe(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl))
>> +                       ret = 1;
>> +               else
>> +                       wrmsrl(MSR_IA32_SPEC_CTRL, data))
>> +               local_irq_enable();
>> +
>> +               if (ret || !vmx->spec_ctrl)
>>                         break;
>>
>>                 /*
>>
> I don't mind this as well, knowing that this is done only one per VM run anyway.

Maxim, this is okay as well; can you send a patch for it?

Paolo

