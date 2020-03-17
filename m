Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B14C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CAA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3mdthjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:51:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32637 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgCQRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584467474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZ3YXnH035CTgn/zabaWGPAuRHjg1vJA7HJMRtIfZdc=;
        b=H3mdthjLCKW4opngbQSnvq7h2isDjse3tfG4UzNRwj3XVG1tIx7cYsElmQhG6iJn95sqOa
        vONGTx/Hjhk44ss/+KCmXmduqKsArWrZfOAUW9MGMxPd+mmPMlmtElPAB9PHmMT0qxvsys
        oO3APsOJNjxjmjIdMFmBWVD7FWJweWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-LLIMRT18NOu9YpLFBJAlzg-1; Tue, 17 Mar 2020 13:51:10 -0400
X-MC-Unique: LLIMRT18NOu9YpLFBJAlzg-1
Received: by mail-wr1-f69.google.com with SMTP id v6so10939798wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZ3YXnH035CTgn/zabaWGPAuRHjg1vJA7HJMRtIfZdc=;
        b=qI2doOtrhvGjB7TsBCpeARlf3EPUAxpXxFGzUvdmSI+md5/XAj70xibkAIaWegP5je
         6HBpcvulvmWBrNTtjEfP0jl3q3E4406OsdKwhKurkYrppqWHB1rigXfAZCJWeeB7S8Z2
         fKC6UBKdn4fZeeyVP5D4VcfLQsMr+AAScy9vX7IYSB6yaHatTlC6AVSeTsCaIHCnwT5Q
         BY4bLdhihnPNfdqUGDuOlqvJHb7J8O0ZB9Ro8wTWGBhzgUOnNUxAfQFVgGExuzf1V8kx
         SM7PFjREYVkdV0lRTodtmjVCxifI72o9+rriag7a1EX7u7KHpa5I8Yh4CT2JChno3zbn
         3+0g==
X-Gm-Message-State: ANhLgQ1JF8sM2gDd8THfDutdvPUFmAoIw/89e8pI5qteJyRsqR8TtNTL
        olpP8/0AvG53mCIMywYIgWmeFtsaEzD1maOBimViV8A4MiVm5YoSCjlnZAA32dKvdrUAjiQszuT
        ofmS9W2AQX4FlEkT0yncC68rg
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr208078wrr.80.1584467469290;
        Tue, 17 Mar 2020 10:51:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsrEmzQtkhsbsRI8q8d2+zIRnyDx4qEt4scrdo92VR8I8ZYDCuTn48J7V4PwNyy4YhlkH+msQ==
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr208055wrr.80.1584467469016;
        Tue, 17 Mar 2020 10:51:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id g2sm5832166wrs.42.2020.03.17.10.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:51:07 -0700 (PDT)
Subject: Re: [PATCH 10/10] KVM: VMX: Convert vcpu_vmx.exit_reason to a union
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
 <20200312184521.24579-11-sean.j.christopherson@intel.com>
 <87eetwnxsu.fsf@vitty.brq.redhat.com>
 <20200317052821.GP24267@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b38ad68-b6fe-0087-25f6-7820588de94d@redhat.com>
Date:   Tue, 17 Mar 2020 18:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317052821.GP24267@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 06:28, Sean Christopherson wrote:
>>>  
>>> +union vmx_exit_reason {
>>> +	struct {
>>> +		u32	basic			: 16;
>>> +		u32	reserved16		: 1;
>>> +		u32	reserved17		: 1;
>>> +		u32	reserved18		: 1;
>>> +		u32	reserved19		: 1;
>>> +		u32	reserved20		: 1;
>>> +		u32	reserved21		: 1;
>>> +		u32	reserved22		: 1;
>>> +		u32	reserved23		: 1;
>>> +		u32	reserved24		: 1;
>>> +		u32	reserved25		: 1;
>>> +		u32	reserved26		: 1;
>>> +		u32	enclave_mode		: 1;
>>> +		u32	smi_pending_mtf		: 1;
>>> +		u32	smi_from_vmx_root	: 1;
>>> +		u32	reserved30		: 1;
>>> +		u32	failed_vmentry		: 1;
>> Just wondering, is there any particular benefit in using 'u32' instead
>> of 'u16' here?
> Not that I know of.  Paranoia that the compiler will do something weird?

Since we have an "u32 full" it makes sense to have u32 here too, it
documents that we're matching an u32 field in the other side of the union.

Paolo

