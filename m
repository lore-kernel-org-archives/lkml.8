Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD22C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF74B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP9Yx0Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBXNEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:04:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727329AbgBXNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582549491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mIKqdTyz5+ImR2nkZFVBhUc+4BM9OsRtqGi03fmbSvE=;
        b=XP9Yx0ZcPx5DtFhJBUfphXai0X6xqvj23DsbkEJGQOHzCeOrbHtMDTSmilMrKRxBAD53Je
        E+XxmZQFXTNMrreG3cQOiZr0JQxYeeOay0EWjeOpHXCWy0rVgNEOmAbX/GaW2gFny0N/Ba
        DvHv0T14zDxSVLjPgVGK97FeNxLDvCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-MBVb_VALNl-hjEOpCPDz1w-1; Mon, 24 Feb 2020 08:04:49 -0500
X-MC-Unique: MBVb_VALNl-hjEOpCPDz1w-1
Received: by mail-wr1-f70.google.com with SMTP id o9so5578851wrw.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mIKqdTyz5+ImR2nkZFVBhUc+4BM9OsRtqGi03fmbSvE=;
        b=hhBLO+JM7zSzvLUGaOAr4gz13ycljQaegpxjqBA3VszbOnvTJZWB4ax3hs6dwkExzE
         b0Mm3ihUlBXuHVdFwxLFyanyO4J4uYHfKXmdPrfrZAkZ4LLAP8E+l/rJdp/0cI1eqLE7
         cRx6uvuiF0m/FWfVkMR096U4SbwOcSc+uhPvG+F15thBUjXl1pMRE67Ouu+2uxbYvFFh
         CdGs+tWkl8iPt8dRlK0AqZfAr8cr/vTiGc3Izqd+MKxcgLMpfI4gtfETje9vgqJ5B9jS
         MDFmJnAPaP2/j5cc2n27N+4GjN2jGkH4kmSS2aGMr5gKPNnyzt9bBgpbjm6lAumF1Ufv
         UThA==
X-Gm-Message-State: APjAAAUcpPPIxOidOe9JcUZAwSC2wJIeyeo1cREaYeyjquaK6dLknS58
        Jn9kWcaRsMB6Xyei/c8hl5IO8Qj8LdhKjnjpyId5x9LANAPf954P5LlgFUTIydQiNzqU8sfIgir
        at8QoMgMezHYaFbwuEFoXpbZ1
X-Received: by 2002:adf:e401:: with SMTP id g1mr11153801wrm.165.1582549488599;
        Mon, 24 Feb 2020 05:04:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxG1YTc0sc80OFrDGBo0TAMpvdqkU5rb8GaSOHzb9RQKL5aY4N4+m+dNRLG71F1VA35nN64NA==
X-Received: by 2002:adf:e401:: with SMTP id g1mr11153777wrm.165.1582549488312;
        Mon, 24 Feb 2020 05:04:48 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c9sm18385475wme.41.2020.02.24.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:04:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] kvm: vmx: Use basic exit reason to check if it's the specific VM EXIT
In-Reply-To: <d9744594-4a66-d867-f785-64ce4d42b848@intel.com>
References: <20200224020751.1469-1-xiaoyao.li@intel.com> <20200224020751.1469-2-xiaoyao.li@intel.com> <87lfosp9xs.fsf@vitty.brq.redhat.com> <d9744594-4a66-d867-f785-64ce4d42b848@intel.com>
Date:   Mon, 24 Feb 2020 14:04:46 +0100
Message-ID: <87imjwp24x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/24/2020 6:16 PM, Vitaly Kuznetsov wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 

...

>>>   		rip = kvm_rip_read(vcpu);
>>>   		rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
>>>   		kvm_rip_write(vcpu, rip);
>>> @@ -5797,6 +5797,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>>>   {
>>>   	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>>   	u32 exit_reason = vmx->exit_reason;
>>> +	u16 basic_exit_reason = basic(exit_reason);
>> 
>> I don't think renaming local variable is needed, let's just do
>> 
>> 'u16 exit_reason = basic_exit_reason(vmx->exit_reason)' and keep the
>> rest of the code as-is.
>
> No, we can't do this.
>
> It's not just renaming local variable, the full 32-bit exit reason is 
> used elsewhere in this function that needs the upper 16-bit.
>
> Here variable basic_exit_reason is added for the cases where only basic 
> exit reason number is needed.
>

Can we do the other way around, i.e. introduce 'extended_exit_reason'
and use it where all 32 bits are needed? I'm fine with the change, just
trying to minimize the (unneeded) code churn.

-- 
Vitaly

