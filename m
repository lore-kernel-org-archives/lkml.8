Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C34C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8391C206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwP8otAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgIGRTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgIGN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:58:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04923C061757
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:58:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so14325744wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KSoj6sKRWwSf9PriSO+wN8e6qNhuzgGj+fP6vt6TsCI=;
        b=DwP8otAS0fcugQQgYAWDkANCxP0JcAwtKGF2dn0yUwAGnhGaaq3zEs9RzmpIavjPdg
         HidmYtxqR1IFP/lpxnVQEHEw4kpZYuCqg/xq2Pmozm59zYdHM61GwwW3u3uc5c27oeT+
         0kOWZOwR7H+ZMJManpi8o/v0Iv3ztE51PH96Nzv3sapCoesJvnfuMVYgCtwT3KFyvuYz
         tP+NxwzIk+sOO0Wgg+PtCKRHMa96pixRgQDkfapy1hE0rXQGlUSF584of52GSG0s46JX
         qwnzmeCpxizGyaS+jia1nCnX8GIJg3LBKuQwWLkU9GK6btKvCKUA/Qum8u9vJNsQ1Xri
         trwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSoj6sKRWwSf9PriSO+wN8e6qNhuzgGj+fP6vt6TsCI=;
        b=RViLF0PpepZozWMpQMXvOGrXRgghfyDH8PFb1ZGu4iAerVvEONnaPNQ10xgWt/cfDN
         IZauTWzF44M6s9etznxHfHtqqTj0A+H5BiwzDdTOlU/6J1VuL45TDr6cA0mctZNrdWMB
         qlqMF1BF00F9Ty+ZFCTkSbVDIducFJCYDTz4zwjfqf6GLqq602kMGsJ2mAsjTJ/yOm9K
         aeO2gidUqGEUVbiQPMGd8IUOh2EgEdChecQ+ODEUumG5oBfpKwdRau4Y2NghY2s7Up8v
         Z6YOOkKkGsIWGIk393JG8jMNiSZLlS2Yp6mHnlJynuHhikWB78lu2RJjl+FdTs1UN9Xh
         1qyw==
X-Gm-Message-State: AOAM533ihJJa/h7G/uIlJXs5noAR4T+ABuyGTrhwGBH7DSUA39r0kPjS
        cmChngXaeDo0lgdv0eYrSoqzHBKrWG+gQg==
X-Google-Smtp-Source: ABdhPJy5VU1DOVDqVdHvBGvU+6zu9otJ00OEZVZ67AfNGf7jmEo1JrN3hn4hNW11pU2KZKRJanq3qg==
X-Received: by 2002:a1c:67d4:: with SMTP id b203mr8910409wmc.120.1599487085253;
        Mon, 07 Sep 2020 06:58:05 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 11sm26388804wmi.14.2020.09.07.06.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 06:58:04 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Jonathan Marek <jonathan@marek.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
 <20200907123344.GA2371705@kroah.com>
 <a9d142c9-8a61-ee59-d849-393af1b3eaec@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e0db9beb-bbd2-8f20-d7f4-675b62acf782@linaro.org>
Date:   Mon, 7 Sep 2020 14:58:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a9d142c9-8a61-ee59-d849-393af1b3eaec@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2020 14:51, Jonathan Marek wrote:
>>> @@ -1477,7 +1477,10 @@ static long fastrpc_device_ioctl(struct file 
>>> *file, unsigned int cmd,
>>>           err = fastrpc_invoke(fl, argp);
>>>           break;
>>>       case FASTRPC_IOCTL_INIT_ATTACH:
>>> -        err = fastrpc_init_attach(fl);
>>> +        err = fastrpc_init_attach(fl, 0);
>>> +        break;
>>> +    case FASTRPC_IOCTL_INIT_ATTACH_SNS:
>>> +        err = fastrpc_init_attach(fl, 2);
>>
>> Shouldn't you have #defines for those magic numbers somewhere?  What
>> does 0 and 2 mean?
>>
> 
> This is based off a downstream driver which also uses magic numbers, 
> although I can make an educated guess about the meaning.
> 
> Srini do you have any suggestions for how to name these values?

These are domain id corresponding to each core.
you can use SDSP_DOMAIN_ID in here!
these are already defined in the file as:

#define ADSP_DOMAIN_ID (0)
#define MDSP_DOMAIN_ID (1)
#define SDSP_DOMAIN_ID (2)
#define CDSP_DOMAIN_ID (3)


--srini
