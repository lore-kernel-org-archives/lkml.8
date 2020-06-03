Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D2C20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HPiwpNtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgFCSrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:47:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 11:47:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so3517850wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TzkCJWzdXaXToiK1TH4bCK6fKN5cv3juL4tw/MkKx6w=;
        b=HPiwpNtwlOc31xmKeKSwthIlmCa/tOMQd/8kH1Smc+RG80zxiqip4pjUe/KbToiKth
         1jg+auUvy0TzI4kQ+wsVWroEXtGf4xb5T1Y1R4iT02cZ6lxnsOl1LqDfkPSDxdwdJwzY
         Ka9GI0aq/AGJf0EUB5aCHTK9PkWj4xdXCLoiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TzkCJWzdXaXToiK1TH4bCK6fKN5cv3juL4tw/MkKx6w=;
        b=ZIzKViS7F7klPLZ46AFPwHfPIa74hsutA+z6hm45hDwXxO9OL5gJQMu5XAaC1ggk+n
         V/Vkaoh0UfGQNU4UdkFRiXRpUrcV1Hqmpd24yLzWhezZHijDHFtNOOyL6/mM/ey2gede
         D1wnbGbp0tcn3sz91yjDjO2XAt/DpurAxCG/qvtIRO/L1oh0yJ3qWnYT7ISEDHUZWbsI
         U++8m7s6/ljt+i6f/lk20knoDEXyj0FAn3E3P+O7m0bdt/w5z7UmBpMR9rgjgLHDDN8q
         htN0Ihq0ivgmw36b/b6VGYRwXYyTbHssa7pirTpiYgaOiNqFRsUXySK0S2ughrhp+cG9
         7ulg==
X-Gm-Message-State: AOAM5315Qxigqh0goOBd8gQzSMqsUOHLAc0wHP920XqrQ/XZfDfiJwWC
        5lAwoab7xNssKpYctGfGKaDnfw==
X-Google-Smtp-Source: ABdhPJyU+ic03oHqmau6OU/msEDtw9ypuyg7l03D3xQ7uDwGOZ1+JJWX1PGIHshdEbfWG/GbBSGPDw==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr794147wrt.9.1591210054149;
        Wed, 03 Jun 2020 11:47:34 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k14sm4428396wrq.97.2020.06.03.11.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 11:47:33 -0700 (PDT)
Subject: Re: Re: [RESEND PATCH v5 5/5] Documentation/vmcoreinfo: Add
 documentation for 'TCR_EL1.T1SZ'
To:     Bhupesh Sharma <bhsharma@redhat.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        x86@kernel.org, kexec@lists.infradead.org,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
 <8a982138-f1fa-34e8-18fd-49a79cea3652@arm.com>
 <b7d8d603-d9fe-3e18-c754-baf2015acd16@redhat.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <51606585-77a3-265f-1d4e-19f25a90697d@broadcom.com>
Date:   Wed, 3 Jun 2020 11:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b7d8d603-d9fe-3e18-c754-baf2015acd16@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Would be great to get this patch series upstreamed?

On 2019-12-25 10:49 a.m., Bhupesh Sharma wrote:
> Hi James,
>
> On 12/12/2019 04:02 PM, James Morse wrote:
>> Hi Bhupesh,
>
> I am sorry this review mail skipped my attention due to holidays and 
> focus on other urgent issues.
>
>> On 29/11/2019 19:59, Bhupesh Sharma wrote:
>>> Add documentation for TCR_EL1.T1SZ variable being added to
>>> vmcoreinfo.
>>>
>>> It indicates the size offset of the memory region addressed by 
>>> TTBR1_EL1
>>
>>> and hence can be used for determining the vabits_actual value.
>>
>> used for determining random-internal-kernel-variable, that might not 
>> exist tomorrow.
>>
>> Could you describe how this is useful/necessary if a debugger wants 
>> to walk the page
>> tables from the core file? I think this is a better argument.
>>
>> Wouldn't the documentation be better as part of the patch that adds 
>> the export?
>> (... unless these have to go via different trees? ..)
>
> Ok, will fix the same in v6 version.
>
>>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst 
>>> b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> index 447b64314f56..f9349f9d3345 100644
>>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> @@ -398,6 +398,12 @@ KERNELOFFSET
>>>   The kernel randomization offset. Used to compute the page offset. If
>>>   KASLR is disabled, this value is zero.
>>>   +TCR_EL1.T1SZ
>>> +------------
>>> +
>>> +Indicates the size offset of the memory region addressed by TTBR1_EL1
>>
>>> +and hence can be used for determining the vabits_actual value.
>>
>> 'vabits_actual' may not exist when the next person comes to read this 
>> documentation (its
>> going to rot really quickly).
>>
>> I think the first half of this text is enough to say what this is 
>> for. You should include
>> words to the effect that its the hardware value that goes with 
>> swapper_pg_dir. You may
>> want to point readers to the arm-arm for more details on what the 
>> value means.
>
> Ok, got it. Fixed this in v6, which should be on its way shortly.
I can't seem to find v6?
>
> Thanks,
> Bhupesh
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

