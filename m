Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2131320663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594226368;
	bh=RPyn0V5dNOAZ8tWh1nuDesE9uq/SIa5Zq+ZfS63UAMs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hxr2ozJ579OKRCE8UbTIILmKyLuHc9IE+rAAtBsqwAoRIsbmnfvOj7Z0oF197W7XS
	 jOdOQcCJlukWpK9d8orTuAhJ1APlwu7qhNFkeW8E72Tzo6bsLhYB/zGhBImW4xsnrx
	 JXM+zfCLEbvRl3Nc5UmRb/kqZpz5viXTMMCsr7RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgGHQj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgGHQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:39:26 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:39:25 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so39664375ila.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qa9LxZ/Xp7LSUBALu/srE8cRDf8Prb/D5kd949P1QlM=;
        b=U6erRdYaii7klc7yOP94p3/uPbGGnpncN/oc7Vqx0R5MDbJQ7folwjhamHzQffg03K
         TtT1P+8bnIx/8y3HgfyWpy6B6ykQmJIb6orrM0Wsa7wtad9sG/zAF0QOTGowWTZGWaR3
         JxpdGi2Qv2IMyEjhHBeP39h+XiFuYSCL3Jq90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qa9LxZ/Xp7LSUBALu/srE8cRDf8Prb/D5kd949P1QlM=;
        b=bnw6v1CIJt8hBRgcBKbqFw2WT+OYQQpBBvOWtnIF5Ebo/58xNLbJj68hgNBYhpzRe9
         lGH/2UISH0146PB1GPkDPd+Ts2B0I7xqT3NvhYSpPCStMRNwRLFOm40Do9Jg/Q4bTRx3
         qLVdl5eJESxtNe4cHy+5gCDfKqDnpNbUHkkLd8iqA3ATwkcBGYOf30hPmuYc+uac2Rjy
         jbYBh7xgnk5LbkiDelihGOP7SX9pEmDWRq37sO78a3MDQoYqDj6tlUzIvueq9rUHGE/z
         083kUUwL/2n62rJePUqHUiLv4ijC9em2qFPAxZWCPJsf9zL0MCu+c5MAMRaT500p1COT
         JtNQ==
X-Gm-Message-State: AOAM532MYMBMyCiGkWegAR7znwIUxOM7iLorCR3ULnXst3QjB02F3MJn
        H+4mGWEzjYQ+l9A8rcLDwbvwdX73HaI=
X-Google-Smtp-Source: ABdhPJx8X2O1CogKcVn+rBwEE7qVExBLojkb/kbvaNGcLF7zCON1nxAI7Upk+AtfhsZ5gRv+EepLfg==
X-Received: by 2002:a92:8b51:: with SMTP id i78mr29409737ild.179.1594226364571;
        Wed, 08 Jul 2020 09:39:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm143942ilj.31.2020.07.08.09.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 09:39:23 -0700 (PDT)
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
 <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
 <1b6b83f7-c749-6e0a-0001-2febbf01b603@linuxfoundation.org>
 <dd532813cc28b6f27b2d0ed6bd3529f2@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0459d720-b2f5-c604-9356-c022fa3d37c8@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 10:39:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <dd532813cc28b6f27b2d0ed6bd3529f2@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 9:39 AM, Joe Perches wrote:
> On 2020-07-08 07:35, Shuah Khan wrote:
>> On 7/7/20 7:56 PM, Joe Perches wrote:
>>> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
>>>> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
>>>>> Replace the existing /* fall through */ comments and its variants with
>>>>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>>>>> fall-through markings when it is the case.
>>>>>
>>>>> [1] 
>>>>> https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through 
>>>>>
>>>>>
>>>>
>>>> Is fallthrough syntax supported on our min gcc version?
>>>
>>> No.  Introduced in gcc 7.
>>>
>>
>> Gustavo,
>>
>> In which case, this patch would break usbip build on older gcc
>> revisions.
> 
> No it will not.  Comment fall through was introduced in gcc 7 and this 
> devolved into a do while 0

Ah thanks. I didn't know that. No concerns of patch to go in.

thanks,
--- Shuah

