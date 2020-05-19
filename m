Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CC3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1305207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWtb4SEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgESOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:14:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5B1C08C5C0;
        Tue, 19 May 2020 07:14:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so6587184pfl.9;
        Tue, 19 May 2020 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6nj99MT5VnMbYi4sa2axsK+PhJ/0czyZ6v4F5+mrN4=;
        b=RWtb4SEG8i0H0GB5ehrZhaZFULdBlGuy/FVGgAsK0UypYLvGekDBIPPnHiRlwdcy/o
         brYsQzMk7bk589ceCKORt3RjKKqkmUnia9bXTEGpJL8SQ78MnztdT2Hq8P2prxuZwYLY
         IyGUZNSliSPfNbB6HauCRIYXhx+/t3xzuEiBqi8hHBi8W3REm7UkcDY+A1LMEC4nPAgv
         2ikySlzx9+cMcbJIXt5bdzYXo1ogYprq/5kYzbd0sP6cBkwhH/xnOvNf6vDVKylM4k0I
         5ouLqGsCp1dawhG2jyoKQSsZurmvcvuIQBW+xgpRaLvIfUG2YdZ7vU1QoaDkNUFBGA6t
         BvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n6nj99MT5VnMbYi4sa2axsK+PhJ/0czyZ6v4F5+mrN4=;
        b=kL/coXYVahBqs1QjGGbmGIyFrYJzWo77T93EiA5sWLw1B7bhXDMTE+546Lup6Xng0j
         IBqR+nFh47AyKmax2nJKnTYMKRp06e+qqwDUNa+P8kZgrDeZZuFBUnkHSyqmVH1Yf5H5
         dxJd7QPeUnBVpjBwA33u7nYgWYABTlWdGjHlAmOEvI7SSS2CAlPoZNkScPvvaT+WPzwr
         Tur26OFmkpo9RJfSj9NumB3ZKvre4W+pVrNqtadJJCVDd5FXiB54PYggzJbWSZ5m2TZS
         MMwqaD43yaYXx3hNlRkbGCgx4cEjP4rFebtYQO0WCJDP5ux07pAhHbQ1JZP/7hbzDpVU
         4P4w==
X-Gm-Message-State: AOAM533iTfVDoE7o9lFWgYhm36z9pWz75fsu313gutzGFs6qi0tMqUNG
        m+yoObDoyyXREvkAzMGyI3OCIFX9
X-Google-Smtp-Source: ABdhPJw+/1fyKAecOwG0xlf74llbkA5RFHYrrZTT7Yh3CkRkUjWTQKL3et5fc/ZDAyV51S+581CK+A==
X-Received: by 2002:a05:6a00:d2:: with SMTP id e18mr12656822pfj.252.1589897664103;
        Tue, 19 May 2020 07:14:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t64sm10598398pgd.24.2020.05.19.07.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 07:14:22 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwmon: (ina2xx) Add support for ina260
To:     Michal Simek <michal.simek@xilinx.com>,
        Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
 <20200224232647.29213-3-forstmayr.franz@gmail.com>
 <a78bbb40-9a0c-8acc-841e-7a51447d4dbc@roeck-us.net>
 <bfa786b6-fe62-a5fb-718f-bb9e95b1f051@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <616f7b6e-0e11-7c76-3baa-5b90a0967a91@roeck-us.net>
Date:   Tue, 19 May 2020 07:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bfa786b6-fe62-a5fb-718f-bb9e95b1f051@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/20 10:21 PM, Michal Simek wrote:
> On 26. 02. 20 3:16, Guenter Roeck wrote:
>> On 2/24/20 3:26 PM, Franz Forstmayr wrote:
>>> Add initial support for INA260 power monitor with integrated shunt.
>>> Registers are different from other INA2xx devices, that's why a small
>>> translation table is used.
>>>
>>> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
>>
>> I think the chip is sufficiently different to other chips that a separate
>> driver would make much more sense than adding support to the existing
>> driver.
>> There is no calibration, registers are different, the retry logic is
>> not needed. A new driver could use the with_info API and would be much
>> simpler while at the same time not messing up the existing driver.
> 
> Isn't it also better to switch to IIO framework?
> As we discussed in past there are two ina226 drivers. One in hwmon and
> second based on IIO framework (more advance one?) and would be good to
> deprecate hwmon one.

"More advanced" is relative. The ina2xx driver in iio doesn't support
alert limits (which is queued in the hwmon driver for 5.8), and the
iio->hwmon bridge doesn't support it either. On top of that, there are
existing users of the hwmon driver, which would have to be converted
first. As for ina260, it would be up to the implementer to determine
if alert limit support is needed or not, and which API would be
appropriate for the intended use case.

Guenter
