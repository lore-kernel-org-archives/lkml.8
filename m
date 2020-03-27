Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF96A2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgw5NWu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0UyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:54:20 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44016 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0UyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:54:20 -0400
Received: by mail-pg1-f172.google.com with SMTP id u12so5138420pgb.10;
        Fri, 27 Mar 2020 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cwj5nmQrvJ47lutQGRvx1/s1DCNTUI3vVQnQClxBJzM=;
        b=Sgw5NWu6pmsTYTlZYH0XVVImOSwL98/+5241dCZNjsx/PFpM91E+5nygcDnsoJAWOg
         qb7PdEIRVlOT7016BWdpGfCrFZwRAtYhmjcVCwLLf/rnifFgaDfC8OxAgTDfCwpgCTqQ
         0T35S2ip8u/azlSK1dqnr80OG4E8XfbglSkIm6uUMNi1d8Oag8HxZLIVyGPV3A2c9zyp
         WFrPpaR+9ysT/4vllfQm8V7r3PFHgVqF8G2e/ebyo22DHZVFuhV6JLjbkMMu5AYS5RQX
         rACZOWgLRdof4HB/5CdvDGmW802w9207dRDA3U+Vkfj2G0kSODr6lNZ8pecG/zqwLhsQ
         8kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cwj5nmQrvJ47lutQGRvx1/s1DCNTUI3vVQnQClxBJzM=;
        b=tJcU9n9hNO7nMju7d8rzVINjKvxzAB823i6FvRIkC9gZJwQBrQug8iGDq/6x1FceFh
         xB7EVkuc0BqyDidJR+UZGvSUIH4z954Gx7W27DihgYdGrdARtaaFmsXmwORpQtyIUx2J
         i8v7ojCrrHncX2MBfzWNa0cOfwPwF3Gx58B/vt2e69AlAYgSfM5rHaqlFPVWRnlQ0tyw
         w6XoHZKjfDWZ6Bt/4lRTYWH1j6w+cVXaiXJY05iOxcNyb7J2tZZ5kyEJxmIBpQaR+M3r
         E07J8A77naKtAfFsPVnmQ2KC3D/gZV6Sz8KBGU9RbA5067TpQCxFxCtzMuJTpAcx3FBl
         T4vA==
X-Gm-Message-State: ANhLgQ1yuX/uF9lYoaCG5e+4ZT5P4MXAoDDLEyDelKhEsYgR3Gj0f5QL
        7t7v58f+pOAU+y7cvdnRjWo=
X-Google-Smtp-Source: ADFU+vuOp3lwPPL/ouFp7v+rkgVXurqEZcA4SMA2DXg3vC9ap4sPYtgWcREa0J3VOhldpLpYMgjHLA==
X-Received: by 2002:aa7:9af7:: with SMTP id y23mr1169648pfp.1.1585342458401;
        Fri, 27 Mar 2020 13:54:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iq14sm1838930pjb.43.2020.03.27.13.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 13:54:17 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW3YyLDEvMV0gaHdtb246IChuY3Q3OTA0KSBBZGQg?=
 =?UTF-8?Q?watchdog_function?=
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        =?UTF-8?B?c2hlbmdrdWkubGVuZyjlhrfog5zprYEp?= 
        <shengkui.leng@advantech.com.cn>,
        =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>
References: <20200325082237.7002-1-yuechao.zhao@advantech.com.cn>
 <20200325224733.GA27706@roeck-us.net>
 <37833c60d7df45109897dcf35fb1b102@ACNMB2.ACN.ADVANTECH.CORP>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c8dd611e-3ff4-a041-6800-8396dd517e7b@roeck-us.net>
Date:   Fri, 27 Mar 2020 13:54:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <37833c60d7df45109897dcf35fb1b102@ACNMB2.ACN.ADVANTECH.CORP>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 7:39 PM, yuechao.zhao(ÕÔÔ½³¬) wrote:
> Hi Guenter
> Thank you very much for the suggestion
> 
> But, I wish to consult you on a few questions.
> The NCT7904 is very special in watchdog function. Its minimum unit is minutes.
> So, what unit do we use for setting the timeout in user space. Minutes or seconds?
> Does the kernel document specify it?
> 
Documentation/watchdog/watchdog-api.rst very clearly specifies that
the timeout is set in seconds.

> Also, about this suggestion:
> 	> +	data->wdt.timeout = timeout * 60; /* in seconds */
> 	> +	data->wdt.min_timeout = 1;
> 	> +	data->wdt.max_timeout = 15300;
> 	Please make it 60 * 255 (or use a respective define) to clarify where the number comes from.
> 
> The reason for not use 60 * 255(or use a respective define ) is that we will set the default timeout with 
> "timeout" parameter when "insmod nct7904.ko".

This is not an argument for
	data->wdt.max_timeout = 15300;
instead of
	data->wdt.max_timeout = 60 * 255;
or

#define MAX_TIMEOUT	(60 * 255)
...
	data->wdt.max_timeout = MAX_TIMEOUT;

> The relevant code as follows:
> 	> +static int timeout = WATCHDOG_TIMEOUT; module_param(timeout, int, 0); 
> 	> +MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
> 	> +			__MODULE_STRING(WATCHODOG_TIMEOUT) ".");
> 

I accepted that you want to have a module parameter which specifies
the timeout in minutes instead of seconds (as would be customary).
However, I completely fail to understand what that has to do with
using an unexplained constant of "15300" when setting the maximum
timeout variable instead of "60 * 255" or, as I had suggested, a
define.

Thanks,
Guenter
