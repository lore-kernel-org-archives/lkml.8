Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5A21473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Z4pE4+0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgIGNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgIGNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:48:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:48:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so9811656qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RpRB6iljb2M31wwzZybgy6AB4+l8J65CnWPoS2cjpPY=;
        b=Z4pE4+0zsGUqaenaa9Sotx3GjcxpCYEKHj5+k2JcptyuVQQuV4lpcx9TiwEJjrDsuu
         wFVJKo4XIWj01ZJfOQNxvUYP5rPBkQJZIgIdWkznFKvhYMNihLKn/LHPZ4SgUpAno2fA
         Uv0HZNF0qpkPRjerw+6nwTPRDLba7k+jViBz+ERSCn5hfvfGMkWsHdmLrEt2nqE+Sb9H
         vbCHqrrABx3w3RziRDbF2r3dIosDXjRSbR1JdXhb1TOEULn1+kobjk/xXQbYLcyd+yxt
         3aOjDrbwMv7qkcZEoz8KMnvHyGWS2dVsKwnzAdyoHuZobi0D7ShbOzEyQDI/STgCpSiU
         yakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpRB6iljb2M31wwzZybgy6AB4+l8J65CnWPoS2cjpPY=;
        b=TVxui0c5tITI2viP9o/fs3QivXPM0hAsGiRodDsBMhnTfHgOEcOX17dD/vd268qbXo
         UPi/Ilz7DZ4vb5YbOcLsv5dVPq20PRnAKIX0BhCDhOZLOBApY71XJY4BlPo9/nlNfgef
         Mtmj51cxfQ6GzZr5Wn0UFA/G2dAyWSfPK7lqQu1+Gf2FyHd3TATu2xJ5R0C+S5pcpZn9
         KiD4/4ZY6bmjl/8zJlLHyyH5RTonwNlUnl4BTI0A77muOnmiiGUAN2AZWyp7brD2QOA2
         fJoTT9B1BOa6VGGxM96gw1s5gv2ZTzjJGC/AsX6tGUe7gk2uRp7Thuu1IZR8woDe5RLZ
         Rr4Q==
X-Gm-Message-State: AOAM532ziPoQYlFE9om4kUkuqfvnlPlip2yQzyGK6sEiO5la4mXzSBAd
        4w+364M7mfAaxttYnicjg2EjZNeLOqC5PQVvBNY=
X-Google-Smtp-Source: ABdhPJyxkTrirT9I13DtZi1g3rHs4BUopE1qzFqaeXf+do879hoQZ6UGYPDN/a/4a8gotkwuRtVB/Q==
X-Received: by 2002:ac8:1c43:: with SMTP id j3mr20742825qtk.302.1599486481577;
        Mon, 07 Sep 2020 06:48:01 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id r34sm12164513qtr.18.2020.09.07.06.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 06:48:01 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
 <fa436d55-b986-944f-e90f-b81cb32eeb0e@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <3f1f8ff1-cf23-ae2c-4cff-cdcce0b11e2e@marek.ca>
Date:   Mon, 7 Sep 2020 09:47:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fa436d55-b986-944f-e90f-b81cb32eeb0e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 8:36 AM, Srinivas Kandagatla wrote:
> 
> 
> On 01/09/2020 01:32, Jonathan Marek wrote:
>> -#define FASTRPC_IOCTL_MMAP              _IOWR('R', 6, struct 
>> fastrpc_req_mmap)
>> -#define FASTRPC_IOCTL_MUNMAP            _IOWR('R', 7, struct 
>> fastrpc_req_munmap)
>> +#define FASTRPC_IOCTL_MMAP        _IOWR('R', 6, struct fastrpc_req_mmap)
>> +#define FASTRPC_IOCTL_MUNMAP        _IOWR('R', 7, struct 
>> fastrpc_req_munmap)
> 
> Looks like changes that do not belong to this patch!
> 
> I wanted to try this patch on SM8250.
> How do you test attaching fastrpc to sensor core?, I mean which 
> userspace lib/tool do you use?
> 
> --srini
> 

I pushed my sdsprpcd implementation to github, which is responsible for 
initializing the sensors, and uses this ioctl:

https://github.com/flto/fastrpc

Note: it uses my own WIP fastrpc "library" instead of the one from 
linaro, I also have other related code, like a sensor client, and 
cDSP/aDSP compute examples, but need to confirm that I can share them

Also, the corresponding dts patch I sent has a problem, the label = 
"dsps"; should be label = "sdsp"; (copied the "dsps" from downstream, 
but upstream expects "sdsp"), will send a v2 later today.

>> +#define FASTRPC_IOCTL_INIT_ATTACH_SNS    _IO('R', 8)
