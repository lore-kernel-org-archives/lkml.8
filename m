Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B35C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7811C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GEpYBUwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHTVJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgHTVJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:09:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD7C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:09:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so1619808plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WMTxNX7lmAJ9yWThRRrmuIVMfN0DOjDQgr+kVPyIsqA=;
        b=GEpYBUwpYQwB4ronXtys68da9XpQ0GxEFzaTdVfs1XfZ4NeHg+9Sr87dVZv+zwwYOK
         H03Uo4ID6IUAkVtXMm7Yhp9bfbti06TagAgg9E/LVdiLSo2o+B6+7rT0VRyyG8+fjzJP
         FUOcgfLxahqZNwrXA1mTd4Qyk34dUTRrNC0lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WMTxNX7lmAJ9yWThRRrmuIVMfN0DOjDQgr+kVPyIsqA=;
        b=oe6lvCk7i7DMrVeGFXWpepTukAV0ly0u/JY9iTC5DOMyIDnmW8/0uwBfsh9+O2mNYT
         lZ4tRPN1QqTuqcyEbLOR3b+pgBnIYAKmxKgkmO/FZu0w8mW/6LLXIr6o+GcHeTp9bMD6
         5Q7tSyANrcDWOXDv1igsLL/c/9+efH65i+FML3wmyQ9keuIL9aKY5ONXIO4gNe2BKtzB
         G7U8KzzNJwkgKVL8jGPQd1YQzPP2R4FcxoobYvxKgXnUILP+guWTQE8n2j8xMGtTbxtc
         VpZsoMGqRGaF3p7j6t15NshFl3fati53ErAdZhyCdlm8iKR95m/xVVqPATFMD0UmVT4h
         n1IA==
X-Gm-Message-State: AOAM531WBBZG+hCCS1jsHOv+WjIkiQezRxuc1Tfl5axGsaJmAFumIw1c
        3+UFqvJFTIL7Q6kLvrI7GGjfMvgi4VOh+/R7
X-Google-Smtp-Source: ABdhPJyRKS57ZuMwrZMagUQJcA81kcrTMXFPePAsBsrQWQ+WtE+ccnsifS7qXHkFHHeeB2g9kb7lgA==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr180286pll.303.1597957776246;
        Thu, 20 Aug 2020 14:09:36 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q5sm3463778pgv.1.2020.08.20.14.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 14:09:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] bcm-vk: add bcm_vk UAPI
To:     Kees Cook <keescook@chromium.org>
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <97f8cc2f-02ec-4350-60fe-7f8b412ac7ee@broadcom.com>
Date:   Thu, 20 Aug 2020 14:09:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008201353.F342E59EC@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-08-20 1:55 p.m., Kees Cook wrote:
> On Thu, Aug 20, 2020 at 09:37:46AM -0700, Scott Branden wrote:
>> On 2020-08-19 12:00 a.m., Greg Kroah-Hartman wrote:
>>> On Tue, Aug 18, 2020 at 05:35:04PM -0700, Scott Branden wrote:
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
> FWIW, other subsystems have not been so lucky:
>
> https://git.kernel.org/linus/23b2c96fad21886c53f5e1a4ffedd45ddd2e85ba
>
> It may just be better to avoid BIT(), even if it works "by accident"(?)
> for some header combinations...
>
Yes, I was going to avoid the BIT macro but was just testing what Greg asked me too.
It would be nice if checkpatch reported the BIT macro shouldn't be used in the uapi headers....
