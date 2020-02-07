Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A8C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF89B214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVoyEgNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGNo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:44:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46212 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:44:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id b35so764773pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TmoRmsENHw/YgWCwWFkHSM2l2USy9CK+G0NuOZCqp44=;
        b=fVoyEgNH50TPz5iNwBF4sRHBoHE1P/Fw7CCX0Sp3ZONdUEmOoHEaiOLGk2/cytkHxU
         Z7Rwa5fJvZPUm8K2/YpZM2+H+zzM6YtEWjUZEZjNO7U+FuZylBqVF4nSajmiU65nkNwx
         K37RVgHdVvMxZcJOw2l1zweoGQL30NyhBzYHIDB95zytrKB80NDB47b8+2EYS5H3Gk7X
         YkxVdPmS/QfGvUZ6TWSBEy+suT1cJlsZF0rEVQ9us5OdBrfJUCB/t/0mRxfDtpTr/ANm
         Z/ZA2DCLgP6CiRQuVKWIp2hnxLHZlGorBLBB2eQ0QEgB4n00BIjT3UhzrRb+Vz2PDfTr
         My/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TmoRmsENHw/YgWCwWFkHSM2l2USy9CK+G0NuOZCqp44=;
        b=WpnIu6e+Pu+BVH3+IgmJ3j0I4+Ma+FQGRu0qmRGjZ47xQldDXApN2dUexMeI2p1Isb
         sl3BkO+JY2X9JV6QKULh/gL+2s2MmFsACUtsPignkg0wL6UT7dw3p+8kZZNpfNPmdbWH
         Jxf3ZakfNOZyPKjnEJef9qjwpzj+i5oGM49MpKyXrGalEIohkplLcvzSzHguk9Km8hnn
         rDHKrNq6IhI+5cB2US58DcjHbC98JDkN3ql6I7mBPZAb+06eFIAOY7jwnQsc6GasN033
         OuwduGVrVAdnjabiM+6+mAW6nOOwmiu46RjpBv1fuoAe3vb/ed774n3bP7fIiM4ALCAB
         Uzsw==
X-Gm-Message-State: APjAAAVv868qhhCKyDF8Tc3lXPITyEPEGhosfucm8lrmNw3pRDFbh20C
        HDe3Wvo58fTf2w6yZ75OZrk=
X-Google-Smtp-Source: APXvYqzLIjVfPMlPuGmcyhC+sTDXsk/8JGDtyYCCRAsN9lqcd65jI1rVjkgVAQAgkzbMz6DWgiLl5A==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr9887692pfo.145.1581083094993;
        Fri, 07 Feb 2020 05:44:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16sm3155140pff.125.2020.02.07.05.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:44:53 -0800 (PST)
Subject: Re: [PATCH v5 17/17] powerpc/32s: Enable CONFIG_VMAP_STACK
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, dja@axtens.net
References: <cover.1576916812.git.christophe.leroy@c-s.fr>
 <2e2509a242fd5f3e23df4a06530c18060c4d321e.1576916812.git.christophe.leroy@c-s.fr>
 <20200206203146.GA23248@roeck-us.net>
 <c6285f2a-f8f5-0d97-2d80-061da1f1a7fc@c-s.fr>
 <0f866131-4292-a66b-2637-c34139277486@c-s.fr>
 <551bad84-3e80-265b-93ab-25eae4aa9807@roeck-us.net>
 <29bd8702-9b8f-6931-2bbc-db7e444907d5@c-s.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d6158967-fde3-1a87-44b6-07638bd2b5b0@roeck-us.net>
Date:   Fri, 7 Feb 2020 05:44:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <29bd8702-9b8f-6931-2bbc-db7e444907d5@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 5:29 AM, Christophe Leroy wrote:
> 
> 
> On 02/07/2020 01:08 PM, Guenter Roeck wrote:
>> On 2/7/20 12:28 AM, Christophe Leroy wrote:
>>>
>>>
>>> On 02/07/2020 06:13 AM, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 06/02/2020 à 21:31, Guenter Roeck a écrit :
>>>>> On Sat, Dec 21, 2019 at 08:32:38AM +0000, Christophe Leroy wrote:
>>>>>> A few changes to retrieve DAR and DSISR from struct regs
>>>>>> instead of retrieving them directly, as they may have
>>>>>> changed due to a TLB miss.
>>>>>>
>>>>>> Also modifies hash_page() and friends to work with virtual
>>>>>> data addresses instead of physical ones. Same on load_up_fpu()
>>>>>> and load_up_altivec().
>>>>>>
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>>
>>>>> This patch results in qemu boot failures (mac99 with pmac32_defconfig).
>>>>> Images fail silently; there is no console output. Reverting the patch
>>>>> fixes the problem. Bisect log is attached below.
>>>>>
>>>>> Assuming this was tested on real hardware, am I correct to assume that qemu
>>>>> for ppc32 (more specifically, qemu's mac99 and g3beige machines) no longer
>>>>> works with the upstream kernel ?
>>>>
>>>> Before submitting the series, I successfully tested:
>>>> - Real HW with powerpc 8xx
>>>> - Real HW with powerpc 832x
>>>> - Qemu's mac99
>>>>
>>>> I'll re-check the upstream kernel.
>>>>
>>>
>>> This is still working for me with the upstream kernel:
>>>
>>
>> Interesting. What is your kernel configuration, your qemu version, and
>> your qemu command line ?
> 
> Config is pmac32_defconfig + CONFIG_DEVTMPFS (But kernel also boots without CONFIG_DEVTMPFS)
> 
> QEMU emulator version 2.11.2
> 
> qemu-system-ppc -kernel vmlinux -M mac99 -initrd rootfs.cpio.gz -s -m 1024
> 
> Works with both GCC 5.5 and GCC 8.1
> 
Actually, the problem is that I have locking selftest options enabled
in my tests. Everything works if I disable those. The "culprit" seems
to be CONFIG_PROVE_LOCKING. Can you retest with CONFIG_PROVE_LOCKING=y ?

Thanks,
Guenter

