Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2EC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D932075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQRt95pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAYJZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:25:57 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42119 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:25:57 -0500
Received: by mail-yb1-f195.google.com with SMTP id z125so177425ybf.9;
        Sat, 25 Jan 2020 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TbDmpXdsQrJ1+u/hZpDv1oA7dMuFxiqW9h6yg9W6LOI=;
        b=ZQRt95pSW3ltuNAxemIkMNH/ZSMN952wa+YPliqYs5zBrtos5LkcbGGmVpVyS6vZwW
         0h0S5UnPY1SzvzSed7ax8nDx16nkfLpr5etrqPuYmpdk7y10DNF8F0muMCyXKxCOQard
         DYutc9ALYGSYLMYHQ2znxmPhsPdsoI6H+Il/8e9LxGvbmYl1pjJUbfYwHtJ/KTw+9tNS
         o6XRI4EkGHzRMv2/dOZmiRACiWbZAbJkRb3z7Thg5A0izYCf3eupKD01tlCf38p2qCv0
         NIjxszS6LGSYViNwF13NojINYpgRGxb7RlaZ3n94PZUtngXjeOQKiRA0mhgdfQU8OGeR
         wwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbDmpXdsQrJ1+u/hZpDv1oA7dMuFxiqW9h6yg9W6LOI=;
        b=pGCGCwNfUKdRQJw2kB7bn2mE2SjqA1gnuyBdiQvvhG49//QPmLIZP+OUX9+EREKpX6
         CLJRELg/hyXTWFqvaPiJ8b/xQFdP+v9K0fB9SRWZnverO7Ww+Ylez9mugiGcMB9lz1vS
         JqEjXvsNuRjCNi/5g9tzKazO30wa3KuP2yc1I1RfJc3/PF4PY+wHO88kVBOzeOfycmp2
         YTaZYhzRx+GQI7M29P+eH7v3rsipSISHR3RQY+32P3fPw82E8Kg3Le/jGelrehUiqkct
         IENCl0/c2sv5uxYUPhBmU2jzD7CIZxrknzCV/a7DYBV98XA+ZzeKe2IvGHrwmKT6qDfV
         ecYg==
X-Gm-Message-State: APjAAAUFTnYTIhar3vHO9YseYJ1B8df39gtMapSCS31viJLrgpkJG2xf
        jeAIIgGF5K95qRVUArVRE0vLnN+/
X-Google-Smtp-Source: APXvYqx/XebOcjuA9odNA0Tt525GRzSy6WBd45MJR79UcYmt1TYB/LjK6IlEhbwldAWySKjysKYVWA==
X-Received: by 2002:a25:e045:: with SMTP id x66mr6086740ybg.442.1579944356130;
        Sat, 25 Jan 2020 01:25:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x84sm3598535ywg.47.2020.01.25.01.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:25:55 -0800 (PST)
Subject: Re: [PATCH 4.19 000/639] 4.19.99-stable review
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200124093047.008739095@linuxfoundation.org>
 <20200124235537.GB3467@roeck-us.net>
 <cd504bb5-44b1-415b-edc7-21ee69e9d1fa@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f634b705-a561-33ee-0b6f-e3f5c1164b38@roeck-us.net>
Date:   Sat, 25 Jan 2020 01:25:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cd504bb5-44b1-415b-edc7-21ee69e9d1fa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/20 12:24 AM, Jon Hunter wrote:
> Hi Guenter,
> 
> On 24/01/2020 23:55, Guenter Roeck wrote:
>> On Fri, Jan 24, 2020 at 10:22:50AM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.19.99 release.
>>> There are 639 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun, 26 Jan 2020 09:26:29 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> For v4.19.98-638-g24832ad2c623:
> 
> This does not appear to be the correct tag/version for this review.
> 

It is the tip of v4.19.y.queue in my test system.

$ git describe local-stable/linux-4.19.y.queue
v4.19.98-638-g24832ad2c623

and the tip of the stable-queue repository as of right now.

$ git describe stable-queue/linux-4.19.y
v4.19.98-638-g24832ad2c623
$ git remote -v | grep stable-queue
stable-queue	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git (fetch)
stable-queue	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git (push)

What is wrong with it ?

Guenter
