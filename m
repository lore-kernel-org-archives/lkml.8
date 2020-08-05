Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3920842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RKIzBL+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHEFvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEFvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:51:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A883C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 22:51:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a14so39462044wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nh6RpHvoBY8ofwqqO/cHqcsqgVpuTrAuC8FfP1MFzgE=;
        b=RKIzBL+gqWhvN/gyd6TbeeRbqWFqDggHeRUAXYx3w8DL0qGytknrgACIDrxLfe/53b
         ESwpiKrFqh4gWRGa6CNB20e/sdr0H7P5/Z+2s8uTDJwYcslkESN8q5QhlmaZvmZm8rA1
         tXDQXJVQR4NnAA757OXPDTlEKOYtfo3Ol8r+plN13wSSdm/FSjW8oZWiEBYL87bpQLSR
         sv6Sd2Q7/FH0sybSpk2MaZR1GBy5PGhi2THikdRRc+Tc3PtKd6Q13ocpdH5oRbqCnYMO
         aGu4+uUdZeg36FWbcW7/4bI6ZeniEIc/V+t6hIJfudZkl5FpBmOnpmoxnLGhQfzfaqJ2
         iZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nh6RpHvoBY8ofwqqO/cHqcsqgVpuTrAuC8FfP1MFzgE=;
        b=c06WgSZiB1GbhdvGhKv6bXuS0uLVaCp56YYFxXcjyFdmkENzqJx0En5u71gE4Xp6D/
         k8kzV88T6e0+xn47HtH1vl/8sHtifPZ1z5f7doCMBupi+RsNa7ZwQBiigwIoM4k4gYnz
         WuN0lmYP5PCYXKVp/ZWdxU2LXPT8OH5h2AFpDQRv7Uf/AVSLU/xV1MLvzdJQbCFE5ZTS
         7SxQGesAIz6ONfoB0QQ2lIHGBUYdnGU0wkxPT/09M5TgFnuTt095qAuMIavzehEsgjVt
         jqA8L9QcCF1xKTP88485e+klrld9ARwgnUY2J5l8ry21u54f/n2K5V4L+LhBnll5McvR
         yWwg==
X-Gm-Message-State: AOAM531DJv7Q3UAEwXkgbhyWEqKrYaGVtOU5WKCXH2bxUpjteY7kuN3j
        +xtaUbBNc3MJBEU5wpLhkjw=
X-Google-Smtp-Source: ABdhPJwPGiRW4zC+XLGAEfZED+c80ltvfZI18KAgFrfM6iIm1ShX3m7rzIMkeev5Gc1uCX+c+ZJxhw==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr1164054wrr.411.1596606701466;
        Tue, 04 Aug 2020 22:51:41 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id i82sm1285154wmi.10.2020.08.04.22.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 22:51:41 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
 <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
 <19de15c2f07d447dace6bea483d38159@realtek.com>
 <152ef6c0-f3c0-bb67-4175-adced3c720cd@googlemail.com>
 <e1c295f28e3d4bdd8c78dfd3a5ed398c@realtek.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <68b9bdd2-a05e-7fb0-ec9a-70b03e0c5289@googlemail.com>
Date:   Wed, 5 Aug 2020 06:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e1c295f28e3d4bdd8c78dfd3a5ed398c@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Ricky.

On 05/08/2020 03:35, 吳昊澄 Ricky wrote:
> 
> 
>> -----Original Message-----
>> From: Chris Clayton [mailto:chris2553@googlemail.com]
>> Sent: Tuesday, August 04, 2020 7:52 PM
>> To: 吳昊澄 Ricky; gregkh@linuxfoundation.org
>> Cc: LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd Bergmann
>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>> Intel NUC boxes
>>
>>
>>
>> On 04/08/2020 11:46, 吳昊澄 Ricky wrote:
>>>> -----Original Message-----
>>>> From: Chris Clayton [mailto:chris2553@googlemail.com]
>>>> Sent: Tuesday, August 04, 2020 4:51 PM
>>>> To: 吳昊澄 Ricky; gregkh@linuxfoundation.org
>>>> Cc: LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd Bergmann
>>>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>>>> Intel NUC boxes
>>>>
>>>>
>>>>
>>>> On 04/08/2020 09:08, 吳昊澄 Ricky wrote:
>>>>>> -----Original Message-----
>>>>>> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
>>>>>> Sent: Tuesday, August 04, 2020 3:49 PM
>>>>>> To: 吳昊澄 Ricky
>>>>>> Cc: Chris Clayton; LKML; rdunlap@infradead.org; philquadra@gmail.com;
>>>> Arnd
>>>>>> Bergmann
>>>>>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
>> on
>>>>>> Intel NUC boxes
>>>>>>
>>>>>> On Tue, Aug 04, 2020 at 02:44:41AM +0000, 吳昊澄 Ricky wrote:
>>>>>>> Hi Chris,
>>>>>>>
>>>>>>> rtsx_pci_write_register(pcr, FPDTL, OC_POWER_DOWN,
>>>> OC_POWER_DOWN);
>>>>>>> This register operation saved power under 1mA, so if do not care the 1mA
>>>>>> power we can have a patch to remove it, make compatible with NUC6
>>>>>>> We tested others our card reader that remove it, we did not see any side
>>>> effect
>>>>>>>
>>>>>>> Hi Greg k-h,
>>>>>>>
>>>>>>> Do you have any comments?
>>>>>>
>>>>>> comments on what?  I don't know what you are responding to here, sorry.
>>>>>>
>>>>> Can we have a patch to kernel for NUC6? It may cause more power(1mA) but
>> it
>>>> will have more compatibility
>>>>>
>>>>
>>>> Ricky,
>>>>
>>>> I don't understand why you want to completely remove the code that sets up
>> the
>>>> 1mA power saving. That code was there
>>>> even before your patch (bede03a579b3b4a036003c4862cc1baa4ddc351f), so I
>>>> assume it benefits some of the Realtek card
>>>> readers. Before your patch however, rtsx_pci_init_ocp() was not called for the
>>>> rts5229 reader, but the patch introduced
>>>> an unconditional call to that function into rtsx_pci_init_hw(), which is run for
>> the
>>>> rts5229. That is what now disables
>>>> the card reader.
>>>>
>>>> Now, I don't know whether other cards are affected, although I don't recall
>>>> seeing any reported as I searched the kernel
>>>> and ubuntu bugzillas for any analysis of the problem. I know this is not what
>> the
>>>> patch I sent does, but having thought
>>>> about it more, seems to me that the simplest fix is to skip the new call to
>>>> rtsx_pci_init_ocp() if the reader is an rts5229.
>>>>
>>>
>>> Because we are thinking about if others our card reader that not belong A
>> series(my ocp patch coverage) also on NUC6 platform maybe have the same
>> problem...
>>>
>>
>> OK. What if we do make the new call but only for the card readers that are in the
>> A series? Are they the ones that have
>> PID_5nnn defines in include/linux/rtsx_pci.h? Or is there another simple way of
>> identifying that a reader is a member of
>> the A series?
>>
>> I'm thinking of something like:
>> static bool rtsx_pci_is_series_A(pcr)
>> {
>> 	unsigned short device = pcr->pci->device;
>>
>> 	return device == PID524A || device == PID_5249 || device == PID_5250 ||
>> device == PID_525A
>> 			|| device == PID_525A || device == PID_5260 || device ==
>> PID_5261;
>> }
>>
>> then in rtsx_pci_init_hw() change the unconditional call to:
>>
>> 	if rtsx_pci_is_series_A(pcr)
>> 		rtsx_pci_init_ocp();
>>
>> Does that seem OK?
>>
> Previously, I want to remove
> else {
> 		/* OC power down */
> 		rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
> 			OC_POWER_DOWN);
> }
> Because in our A-series card Reader we already assigned option->ocp_en to 1 in self init_params() , this is an easy way to fix this problem
> 

Ah, OK. I'll prepare the patch and send it to you once I've tested it.

Chris
