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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01C42078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buUI7cTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHVUVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHVUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:21:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99EC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:21:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so2399530plk.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mN1iKDEyC3rA1Z74FeKTAwvaB/0bfpLiv8xA+/THcfE=;
        b=buUI7cTEXw0CqhjGusziy1qvMeUQnMbxSuk9u8oBhEVXDy2JpbTGHiz09OghHAtnfb
         MjyORiYBD8o3ITVKf0Wq0sN+HZZ0cc/wVawGT/LaMwH/62+zKuIwgZwStWoYDZxNCRm5
         vHxZWuuZZaPPUeIx90594xZARn15u1VfZAyc9VjVI4yI8VtqGIWTc9wgvWDM9aeKIth0
         vy1gt+NOUgcLOQ7iJco/fte1JhcP7QWZ7vdq+pTfzXC07SGTMj6duIVa5QC9Qx+BRXDg
         yjImBPiGxVO6589k8xFsVZ6349XQ3noBvELpS4OJ9stZgM1q+Poqc50FOOSIH5H3wRiw
         YsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mN1iKDEyC3rA1Z74FeKTAwvaB/0bfpLiv8xA+/THcfE=;
        b=lDRxgF7DY05KnCq7R6JYgwFAiu86T3joeMjsmsy5hiEDzVFAyDkkmrpnzEKoF2lf3O
         aSb/gvSW76NmEgbQqgz+gzEhKfz1G6O8Ga+n832VJfjR6W2XruYth5bUn5ygbeptsa56
         He3+XVpew7/WVlCCka/qHxisnRnh3dOgKOXhhb3ln8sryafWVKeWzNRWYlzOU5uNi3zF
         0miNmOJ3FOZP6U7e341OzfcGrRbQilqXnCHnhtNOkLwf8RZZsDlT21WYegBcHsO205R1
         Xw6Nm5Lx1np2GMqJE03bYnZzeQ8u7Oeic4cu21UIDyrghCnSEHUHyjeIuepSr/2QKQ71
         yP7g==
X-Gm-Message-State: AOAM5305tOtOWXm8BecA8OD9C8aa9LSkZS1q6+tmTBmYJ6eg6OtPQLra
        KWqXvHFt7jKbuO+ROWDQYma0Z/W4Xos=
X-Google-Smtp-Source: ABdhPJx8s/fRLcufDR11rS5meEUVanLoMvXI2iSut+yYBf8owMaDOrQ572+qGTM9anFMUNePTv3MUw==
X-Received: by 2002:a17:90a:a4ca:: with SMTP id l10mr5606289pjw.207.1598127710231;
        Sat, 22 Aug 2020 13:21:50 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id a2sm6591393pfh.152.2020.08.22.13.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 13:21:48 -0700 (PDT)
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
To:     Markus Mayer <mmayer@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200821165221.32267-1-mmayer@broadcom.com>
 <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
 <20200822164619.GA24669@kozik-lap>
 <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <81b2ad54-d4ef-cf98-886c-61c79e4cac62@gmail.com>
Date:   Sat, 22 Aug 2020 13:21:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2020 1:14 PM, Markus Mayer wrote:
> On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
>>> On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
>>>>> We would overrun the error_text array if we hit a TIMEOUT condition,
>>>>> because we were using the error code "ETIMEDOUT" (which is 110) as an
>>>>> array index.
>>>>>
>>>>> We fix the problem by correcting the array index and by providing a
>>>>> function to retrieve error messages rather than accessing the array
>>>>> directly. The function includes a bounds check that prevents the array
>>>>> from being overrun.
>>>>>
>>>>> This patch was prepared in response to
>>>>>      https://lkml.org/lkml/2020/8/18/505.
>>>>>
>>>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>>>
>>>> Your Signed-off-by does not match From field. Please run
>>>> scripts/checkpatch on every patch you send.
>>>>
>>>> I fixed it up, assuming markus.mayer@broadcom.com is the valid email
>>>> address.
>>>
>>> No. I have always been using mmayer@broadcom.com since it is shorter.
>>> That's also what's in the MAINTAINERS file. Please change it back. I
>>> accidentally used the long form for one of my e-mail replies which is
>>> where the confusion must have originated.
>>
>> I'll drop the patch then. You need to resend with SoB matching email.
> 
> Oh, I am starting to see what's happening here. This is new and
> apparently due to some changes with the mail server setup on our end.
> 
> I have this in my patch file:
> 
> $ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
>  From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
> From: Markus Mayer <mmayer@broadcom.com>
> Date: Fri, 21 Aug 2020 08:56:52 -0700
> 
> Sending patches like this used to work. Clearly our SMTP server has
> now taken it upon itself to rewrite the sender e-mail address. I
> wasn't expecting that. Let me look into it. Sorry for the hassle. It
> was not intentional.

Yes, if you used to use the SMTP relay server which did not require 
authentication for internal hosts, and now you use smtp.gmail.com with 
your broadcom.com username, the SMTP server will rewrite the From: to 
match the username used to authenticate with the server.
-- 
Florian
