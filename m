Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143762073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoSBPE60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCEPZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:25:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbgCEPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583421934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vy5/EiEAp0wCHefyZwq4zlhiKyPciLoRoXRp/gwmNyU=;
        b=EoSBPE60EHTHhlER1CGVK2DyLC+5cIWigUvnFwr4a+73FCaXge0jw5rYZT28O/4EUQVMJp
        eFtGq0urvyKvHHHPuojHxLpBHpr+sEeNjf0PyNKRQNogPrjzc+G+OqokK7lMBgL2yNAGTG
        Yd4H5Arg3IFMvGVI1WHT2Ih41DvY078=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-spDHu0AFOxyaJm-nauE8SQ-1; Thu, 05 Mar 2020 10:25:32 -0500
X-MC-Unique: spDHu0AFOxyaJm-nauE8SQ-1
Received: by mail-wr1-f72.google.com with SMTP id u18so2423438wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vy5/EiEAp0wCHefyZwq4zlhiKyPciLoRoXRp/gwmNyU=;
        b=jpCdo+SMRr/52Q8E6GUlZ7ug72J+kawqlNt3qcNaIv1Tk6rIQpUrNfryhZvNTsehZY
         uk6WSlOgaIw/vrcBrtBsRUi8NYGfZSAEKtL1zavpsURjDDNpiOGLkgQhYngmIjl/iP7+
         8JHZBK7vqmtqd/RLXbzeTgPlcoR7qXbtyuG+mVFMYNQzLvIK28e97OLj8gHzrfBWpLG5
         eUurTx2G53OI/C1Ss9NLBrNVQq5bMIUv7AjRuO44C/BxJe04aqJPLmmfZAF8TzGj4yaK
         xWdbxPONSU1D2aeQlaIL/qN8sAQ3Rx0ySg1njjIrYW5cr6mzCpiGAn2OAfCN73IDQfeX
         3sHA==
X-Gm-Message-State: ANhLgQ2uZo17CBp0vVR1fpMmLmXN9sg0Au9U+PCqBVRTZ1GUguxvrYfr
        m22Ifbx6nfuod/5P/C9MGYfK443kSvLzdD1AgyEfmJ72t93StxQcGHSjQheD2wUgzjqXMaLDIkR
        4rDefp7nGSLyC+yNRUF07xwNs
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr10012835wmj.0.1583421931390;
        Thu, 05 Mar 2020 07:25:31 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtQWnJAQ64di79lN3HKkN0FhLCIQPUPAt48JNuzax0K/0I7UfpL5czy4vwD/j2Yo0yF954fWw==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr10012811wmj.0.1583421931138;
        Thu, 05 Mar 2020 07:25:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id b24sm9503524wmj.13.2020.03.05.07.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 07:25:30 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: small optimization for is_mtrr_mask calculation
To:     David Laight <David.Laight@ACULAB.COM>,
        linmiaohe <linmiaohe@huawei.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <1583376535-27255-1-git-send-email-linmiaohe@huawei.com>
 <2b678644-fcc0-e853-a53c-2651c1f6a327@redhat.com>
 <dc1870b0ea164015b1c1b6bc4d3248fe@AcuMS.aculab.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2129995e-3441-f362-aed1-7c247189c136@redhat.com>
Date:   Thu, 5 Mar 2020 16:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dc1870b0ea164015b1c1b6bc4d3248fe@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 16:10, David Laight wrote:
>>>  	index = (msr - 0x200) / 2;
>>> -	is_mtrr_mask = msr - 0x200 - 2 * index;
>>> +	is_mtrr_mask = (msr - 0x200) % 2;
>>>  	cur = &mtrr_state->var_ranges[index];
>>>
>>>  	/* remove the entry if it's in the list. */
>>> @@ -424,7 +424,7 @@ int kvm_mtrr_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>>>  		int is_mtrr_mask;
>>>
>>>  		index = (msr - 0x200) / 2;
>>> -		is_mtrr_mask = msr - 0x200 - 2 * index;
>>> +		is_mtrr_mask = (msr - 0x200) % 2;
>>>  		if (!is_mtrr_mask)
>>>  			*pdata = vcpu->arch.mtrr_state.var_ranges[index].base;
>>>  		else
>>>
>> If you're going to do that, might as well use ">> 1" for index instead
>> of "/ 2", and "msr & 1" for is_mtrr_mask.
> Provided the variables are unsigned it makes little difference
> whether you use / % or >> &.
> At least with / % the two values are the same.

Yes, I'm old-fashioned, but also I prefer ">>" and "&" for both signed
and unsigned, because if ever I need to switch from unsigned to signed I
will get floor-division instead of round-to-zero division (most likely
the code doesn't expect negative remainders if it was using unsigned).

(That perhaps also reflects on me working a lot with Smalltalk long
before switching to the kernel...).

Paolo

