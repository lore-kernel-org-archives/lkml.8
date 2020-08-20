Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E223E208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQi6qneo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHTU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHTU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:57:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36405C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:57:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so1711076pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXpty4qb9h6cFJUDFinUoJRezlVq3prHzJfmZWarJ+g=;
        b=fQi6qneo4vpa7kcQ1iGnds1YBiLYb3qNvrRu7xthsowlzNaRARntyvjrTFdou2ST/G
         j/WlrUnlihsvTZv2J2lL+DxjmEGB3uQY2gbdkSVyobHmtHOttdqRegYecLZVEzOVynx/
         l5xPtI2Dpj1WkHYW1IJHARCE90zr+bYqsaEZCVYLpE25EAIMG91N4asY5rZxcItH1pt6
         LN5g13KQJA28LqrYmwXAzJBeP12WemsGHkDNB9LjmXW7ukeU+dJTLn0Sxm752+S6Sj95
         VmsI2ZC/GqruiiggrpbfafRp+ikXLIcI2Pdy3RFcXZSWsd/FhcJJiVeuYj8NdrU0/p7t
         kIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fXpty4qb9h6cFJUDFinUoJRezlVq3prHzJfmZWarJ+g=;
        b=jnyIdxbCAv+Wc2YyuY8PCC7vkGvkWpcWVkzdlKYR4q/6kaYKk1RIRLuu80TIg8eWFX
         48o/rVHnl9/wXxOgZyGa6nKjA8luVyf55hTA1ThWU/imNQUAaeSXYe+Q4Pfp7R3+DUko
         0MPuHg4CmhEAwXSu1JlyDfOsAwY9C9XW+Ht89vUemzdB4LrhO1OM70+s0yK8//6fGK5g
         JAnR2i8kvbbxYb7ekEd/3t73pwCNr7vpO0BjSREhPv4zr/cgq58Wdcn7ZpaKDgQ+RuyY
         l6IdSAVUMU4EvN+ElZiQKXi6e+cPaDbPjnLCMy/nNsO6uIqKMeGr85U631rfD/evvJtd
         FZGQ==
X-Gm-Message-State: AOAM5327pO/t+rPWgtM1Vc3YMrBeXIa3kvFkNaDXL1I3mezu5oPWnmIe
        xLMwUrg8Mc8EUuRC9/qtQq8=
X-Google-Smtp-Source: ABdhPJyGOmCWy9my9v03gDoM4kEvHnQHJHBA/2u7XRrdy8m7DRwGYqkaTyXn13j+nOZsmPYTgkCHBQ==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr441522pgk.96.1597957064467;
        Thu, 20 Aug 2020 13:57:44 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fv21sm2939513pjb.16.2020.08.20.13.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 13:57:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
To:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <20200806004631.8102-2-scott.branden@broadcom.com>
 <20200818135313.GB495837@kroah.com>
 <8894c3c4-4d5c-cb94-bc90-a26833ebf268@broadcom.com>
 <20200818174451.GA749919@kroah.com>
 <4adbd70e-c49b-c2d4-84c7-5e910f05e449@broadcom.com>
 <20200819070044.GA1004396@kroah.com>
 <fdbb7404-03c3-22b1-d409-5b6d8745ff2b@broadcom.com>
 <202008201353.F342E59EC@keescook>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <ec24beca-fad8-5591-f09d-b87c21a745b2@gmail.com>
Date:   Thu, 20 Aug 2020 13:57:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008201353.F342E59EC@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 1:55 PM, Kees Cook wrote:
> On Thu, Aug 20, 2020 at 09:37:46AM -0700, Scott Branden wrote:
>> On 2020-08-19 12:00 a.m., Greg Kroah-Hartman wrote:
>>> On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
>>>>
>>>> On 2020-08-18 10:44 a.m., Greg Kroah-Hartman wrote:
>>>>> On Tue, Aug 18, 2020 at 10:23:42AM -0700, Scott Branden wrote:
>>>>>>>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
>>>>>>> <snip>
>>>>>>>
>>>>>>> I thought BIT() was not allowed in uapi .h files, this really works
>>>>>>> properly???
>>>>>> I did some investigation and it looks like a few other header files in include/uapi also use the BIT() macro:
>>>>>> include/uapi/misc/uacce/uacce.h
>>>>>> include/uapi/linux/psci.h
>>>>>> include/uapi/linux/v4l2-subdev.h
>>>>> Does the header install test target now fail for these?
>>>> I do not understand the question above.  make headers_install works.
>>>> But I guess the above headers would have similar issue with the BIT macro.
>>> Try enabling CONFIG_UAPI_HEADER_TEST and see what happens :)
>> I enabled CONFIG_UAPI_HEADER_TEST and then
>> built using "make" and "make headers_install".
>>
>> There didn't appear to be any issue with the BIT macro in the headers.
> 
> FWIW, other subsystems have not been so lucky:
> 
> https://git.kernel.org/linus/23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba
> 
> It may just be better to avoid BIT(), even if it works "by accident"(?)
> for some header combinations...

Since we ship a copy of unifdef.c in tree, we could certainly teach it
to undo the BIT() definition and replace it with an appropriate constant
definition.
-- 
Florian
