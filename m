Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E18C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BC920FC3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXxIwStB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHVUtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgHVUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:49:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDCC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:49:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n3so1895375pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hH9H2ABdvu9ijY93JDRl5gL40YddKNa5RSjoOsfkU4Q=;
        b=sXxIwStBLLksVtoDY6Thna2iknz5zpi0NCdBinkz6KrjU9uNu46he8yHY8M877YbOU
         C0GbsSkyhV792XReqRG14ji6CWGcrQx4nMbuDNrJv0C8kBFPXijZ8LRargFPwTJQhUlg
         S+IK2P8fg8HHOo0sjq8AWUdlvhrX2fTqa8hzpBge0AaKBSnS5ANEgFMX6GDdcKzppZS4
         5dDz5MO2UK54eIotNw+/j7tzw3tBgwoYnTl8d0HZ9af36ZWAwgAWJ3zxlL9NLTCnA/Eo
         KY5MYQ8Z38OXIxi1/v637x1EY3Dog34sMIIoHszE2w2OUP3kwq2xCg3sLY2G30PW6vp7
         4O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hH9H2ABdvu9ijY93JDRl5gL40YddKNa5RSjoOsfkU4Q=;
        b=M3dFyCu8KCVTQAfNnm2LNuQpqinDwxfAkO1pUPWhMBPS5VXOeriZ5madz1m2uF9rEl
         zUIPu5jesu2ahyI+JDdOu1j4WWLRUywYizG3aPUvFCwTW14vIvYHFn5BbfIjMsI+jWHr
         NC4OkElYello6oDmo4Ycu9HUDcrU63rk0GJcYjalg5n2YUcH8tyyPp1kTxyrupNNHSIa
         wVMerjst3Noo5c2Vl4Nly2mXbR6D4/oztZV3XQVTxPo7RD0p95445TE6/5Z3VJXBtl47
         2lFvLQ46WciN2ttZbP1dON3NotWKJtGSSkJqsqrxoCPBwG4m//2PXqoTdsWaHzDY6C4J
         WrKQ==
X-Gm-Message-State: AOAM531KwRXLRSEoLK+G4MDN5R5On1HMA5xRQLrhAK3U1Lk1aA6YCdn/
        +aJHj0zouG5v+PwG6NeoGRopHUCDavQ=
X-Google-Smtp-Source: ABdhPJzA2V6uZzLuxDmG9sZngQJ9nzaNbuju8ETafw3nojOp/GVQMK4+8LYyCKyCzE8qqezlfXHnFg==
X-Received: by 2002:a17:90a:514a:: with SMTP id k10mr5489033pjm.81.1598129376538;
        Sat, 22 Aug 2020 13:49:36 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id 143sm1079390pfc.66.2020.08.22.13.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 13:49:35 -0700 (PDT)
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200821165221.32267-1-mmayer@broadcom.com>
 <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
 <20200822164619.GA24669@kozik-lap>
 <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
 <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
 <CAGt4E5td_4YhL2y0Z6iS+eGv666TKrkKnEgM8vmTwNjNYMz6Dg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c68e34b4-4464-ddea-3284-6f05c6f0a5d2@gmail.com>
Date:   Sat, 22 Aug 2020 13:49:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <CAGt4E5td_4YhL2y0Z6iS+eGv666TKrkKnEgM8vmTwNjNYMz6Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2020 1:47 PM, Markus Mayer wrote:
> On Sat, 22 Aug 2020 at 13:21, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 8/22/2020 1:14 PM, Markus Mayer wrote:
>>> On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
>>>>> On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>
>>>>>> On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
>>>>>>> We would overrun the error_text array if we hit a TIMEOUT condition,
>>>>>>> because we were using the error code "ETIMEDOUT" (which is 110) as an
>>>>>>> array index.
>>>>>>>
>>>>>>> We fix the problem by correcting the array index and by providing a
>>>>>>> function to retrieve error messages rather than accessing the array
>>>>>>> directly. The function includes a bounds check that prevents the array
>>>>>>> from being overrun.
>>>>>>>
>>>>>>> This patch was prepared in response to
>>>>>>>       https://lkml.org/lkml/2020/8/18/505.
>>>>>>>
>>>>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>>>>
>>>>>> Your Signed-off-by does not match From field. Please run
>>>>>> scripts/checkpatch on every patch you send.
>>>>>>
>>>>>> I fixed it up, assuming markus.mayer@broadcom.com is the valid email
>>>>>> address.
>>>>>
>>>>> No. I have always been using mmayer@broadcom.com since it is shorter.
>>>>> That's also what's in the MAINTAINERS file. Please change it back. I
>>>>> accidentally used the long form for one of my e-mail replies which is
>>>>> where the confusion must have originated.
>>>>
>>>> I'll drop the patch then. You need to resend with SoB matching email.
>>>
>>> Oh, I am starting to see what's happening here. This is new and
>>> apparently due to some changes with the mail server setup on our end.
>>>
>>> I have this in my patch file:
>>>
>>> $ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
>>>   From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
>>> From: Markus Mayer <mmayer@broadcom.com>
>>> Date: Fri, 21 Aug 2020 08:56:52 -0700
>>>
>>> Sending patches like this used to work. Clearly our SMTP server has
>>> now taken it upon itself to rewrite the sender e-mail address. I
>>> wasn't expecting that. Let me look into it. Sorry for the hassle. It
>>> was not intentional.
>>
>> Yes, if you used to use the SMTP relay server which did not require
>> authentication for internal hosts, and now you use smtp.gmail.com with
>> your broadcom.com username, the SMTP server will rewrite the From: to
>> match the username used to authenticate with the server.
> 
> Actually, it was the other way around. Connecting to smtp.gmail.com
> does allow the "From:" header to be customized. The envelope sender,
> i.e. the "From " line at the very beginning of the e-mail, might still
> get rewritten, but that's okay since the "From:" header is left alone.
> The internal SMTP server, however, which does not require
> authentication, unexpectedly rewrites the "From:" header in the middle
> of the e-mail header.
> 
> Got it set up now in a way that should work. At least it did in my
> test. I'll send out v3 of the patch momentarily, and then we'll know
> for sure.

Reason #42 why I hide behind my gmail.com account! Glad you sorted it out.
-- 
Florian
