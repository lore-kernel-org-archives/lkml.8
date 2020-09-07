Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FA42080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="ZlFYWNzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgIGRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbgIGOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:06:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC101C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 07:06:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so12751348qkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+uPVxGhTzkdDfUd9wvr+ZuNFUnz8aixgYzEQqrA4MY=;
        b=ZlFYWNzHSoL0j1+55BOdgwsdhE4/eQ+f5eAIcVhoP8m16P2JaJ+kEJaWXQmU/asTan
         +FNSTR+7/u2RvbrlmI4pPJvW73nmPOb2MxuCuE6NH6yWwFmfTNC7wNpeLXKlM9tuTmnK
         CIXvcIk9Qq+lKbbq1o0YV4kQaoy15EP4nk2vQ5zNBoerHdy/Bx7zP3dTJfpmPvqXF1ZO
         7bXdQXp0kzghs2BDVVQClnumXEmZKLB2D9oeHdc9mY8+3PC4Ztd3GEw1eljJOOtZ+CTE
         tCZxuSBZ0KcjypKSTgj9lv/qq4OcUzzDAxuYJNFf/+EBzGxThQKd8qwYFubYSRoOcrMp
         DLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+uPVxGhTzkdDfUd9wvr+ZuNFUnz8aixgYzEQqrA4MY=;
        b=dl8yinpzY5yphbq1VLjAF3p74Jhp9wFMw1Z0dflPBy2XuB7dhe27tbq8Nh+ZBppvM8
         NpviNTXXoTVUIbMhFmN4FGa2OhC4HZZQAGk/fV7lMHiAmTxm/7xXaABdJuMG4uNs0kP3
         PtEUASwZjPjd5cHPEvDl2tiOavV+kp2hHw32yBulIqGJUXkcVq9ToldPDt5JPTDWHgbK
         4dVMge3ilV4vAq3SplkeBigjFaJ0fEcLL7hcLz5SVR9pR3i6fILK4qTNreq5DuGPLfBl
         DB6muIXDDq9nwL1vOYyVOsfcGWNbo3GfKyYWavJH/ONNztbhIFPmVigIBIQhe55jI+/8
         mNYA==
X-Gm-Message-State: AOAM531lA/py4s+gprjyAPptE0VCZ+jxL19jfbCwtNBio6fHWyvB/XK3
        +FoFYWp9Qio25CegWP+/MPCrtxnDXJJJk7yHoP0=
X-Google-Smtp-Source: ABdhPJxhfyBfbzBJNaomyjjA3ICbD0lV5tfufEImskKOSDvkQXT8skDYxgZXb3Qgc3ZCK9uKhlPkew==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr14311080qkc.18.1599487561928;
        Mon, 07 Sep 2020 07:06:01 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id u15sm11951003qtj.3.2020.09.07.07.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:06:01 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
 <fa436d55-b986-944f-e90f-b81cb32eeb0e@linaro.org>
 <3f1f8ff1-cf23-ae2c-4cff-cdcce0b11e2e@marek.ca>
 <f2faa7b2-1e7d-2f39-ef36-a3790cedfab9@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <682b2972-2762-bb4c-b31b-025ab78aba1f@marek.ca>
Date:   Mon, 7 Sep 2020 10:05:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f2faa7b2-1e7d-2f39-ef36-a3790cedfab9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 10:01 AM, Srinivas Kandagatla wrote:
> 
> 
> On 07/09/2020 14:47, Jonathan Marek wrote:
>> On 9/7/20 8:36 AM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 01/09/2020 01:32, Jonathan Marek wrote:
>>>> -#define FASTRPC_IOCTL_MMAP              _IOWR('R', 6, struct 
>>>> fastrpc_req_mmap)
>>>> -#define FASTRPC_IOCTL_MUNMAP            _IOWR('R', 7, struct 
>>>> fastrpc_req_munmap)
>>>> +#define FASTRPC_IOCTL_MMAP        _IOWR('R', 6, struct 
>>>> fastrpc_req_mmap)
>>>> +#define FASTRPC_IOCTL_MUNMAP        _IOWR('R', 7, struct 
>>>> fastrpc_req_munmap)
>>>
>>> Looks like changes that do not belong to this patch!
>>>
>>> I wanted to try this patch on SM8250.
>>> How do you test attaching fastrpc to sensor core?, I mean which 
>>> userspace lib/tool do you use?
>>>
>>> --srini
>>>
>>
>> I pushed my sdsprpcd implementation to github, which is responsible 
>> for initializing the sensors, and uses this ioctl:
>>
>> https://github.com/flto/fastrpc
> 
> Thanks!, I can take a look and see if I can try it out with linaro 
> fastrpc library!

You don't need linaro fastrpc library to try it, everything you need is 
in that repo.

>>
>> Note: it uses my own WIP fastrpc "library" instead of the one from 
>> linaro, I also have other related code, like a sensor client, and 
>> cDSP/aDSP compute examples, but need to confirm that I can share them
>>
>> Also, the corresponding dts patch I sent has a problem, the label = 
>> "dsps"; should be label = "sdsp"; (copied the "dsps" from downstream, 
>> but upstream expects "sdsp"), will send a v2 later today.
> Also the dts patch will fail to apply as it is, as it seems me that you 
> have based the patch after adding audio dts patch!
> 

Thanks for pointing it out, will make sure the v2 applies cleanly 
without audio dts patches applied.

> 
> --srini
>>
>>>> +#define FASTRPC_IOCTL_INIT_ATTACH_SNS    _IO('R', 8)
