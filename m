Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F22C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D383D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NMwUyTJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgEKI2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgEKI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:28:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F1C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:28:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z22so6765029lfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRvOsGODr2gBty44WMLBkyLF05Kazw7eweqK6vwx6G8=;
        b=NMwUyTJEcbx88njWIumKBmdXEPVUEg0mDKK5uVHZYtRcI2EsMUGm4RKTg3v8t+HImQ
         Dhe486gV9U3C4ZEk4KudoDojO6BjvFuqPrSrFdE4okuodgo/vKBO7N4q5xWUO/NMudOQ
         DTuEFJkPsULwl23xN7LXDN9fsCueSRXI+9f+sBdEpJRqHpcQGpC4PLuWVfhfKfb/7sEq
         uo3QClFkWonGW7vE54sEwFf8dNmqJ2+lehPnKgvPNk46g4jFIuFyFTqgzRFS2tMjLNth
         /shvpXWyz143uoEV7N4gcySD//s/ZbmhSw9s7vO1MyDWWtv9vcxSQ02NXPMObmMJpMiz
         BKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xRvOsGODr2gBty44WMLBkyLF05Kazw7eweqK6vwx6G8=;
        b=Dg4I7HnmkDq7/jI5SpXEn2DxUUVvEnF8zfIdzdNQra6oz+2CAjDXzfA7X8vwZxzBt+
         PEoZ6iomT/JTjSEeZAO/DAzAWf9L870NsOdQlcI9AJwiOGUx58ttFAZAzGbCGppY5vin
         XQ0XdZTh2MbRt63zWBW7usk2Ui4yWCl2dRXtU3WcFcDbGh/6zMicjDcoZfjXpu4Rputk
         FoJP8BYg68AXmWQ2OAUfFiYqFdAoiIgL3GdBIcuN0G0K15EWP0KHLcx+KVfoUXMOM6+f
         kxazi8S6P7J0/TCQYaAwJTN9shFzl/iYwMA9iM/s7uSU8ayOjSPMjokSRfbRfbdjh3EN
         2EeA==
X-Gm-Message-State: AOAM532JM3Exmybtk6esEzJ4RWmMXcnS6B58zMkq1mwxQeR3J/VGuhng
        GTwIBBfVJ3Rx4X9Hu66CM9B9qm2muQci3w==
X-Google-Smtp-Source: ABdhPJy9RJ6KQf/3Kl5eqQg+JUSwUL3ldNqhxlgS3bNEYoMSUpVKEawpvAY6S5rxYHjoPhvrWBixXw==
X-Received: by 2002:ac2:59ce:: with SMTP id x14mr10087337lfn.183.1589185685335;
        Mon, 11 May 2020 01:28:05 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:482:2677:ba:b682:3c24:214e? ([2a00:1fa0:482:2677:ba:b682:3c24:214e])
        by smtp.gmail.com with ESMTPSA id m13sm10297061lfk.12.2020.05.11.01.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 01:28:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt-bindings: watchdog: dw-wdt: Support devices
 with asynch clocks
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306132758.703FC8030704@mail.baikalelectronics.ru>
 <20200510105807.880-1-Sergey.Semin@baikalelectronics.ru>
 <20200510105807.880-3-Sergey.Semin@baikalelectronics.ru>
 <f065ff5f-af86-4293-b208-766e41699436@cogentembedded.com>
Message-ID: <477b9f75-485c-3208-b58c-56a5c13e15bb@cogentembedded.com>
Date:   Mon, 11 May 2020 11:28:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f065ff5f-af86-4293-b208-766e41699436@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2020 11:25, Sergei Shtylyov wrote:

>> DW Watchdog IP core can be synthesised with asynchronous timer/APB
>> clocks support (WDT_ASYNC_CLK_MODE_ENABLE == 1). In this case
>> a separate clock signal is supposed to be used to feed watchdog timer
>> and APB interface of the device. Lets along with the watchdog timer
>                                         ^ verb missing? or comma?

    Oh, and probably "Let's" too. :-)

> 
>> reference clock expect to have the optional APB3 bu interface clock
>> sepcified in a DW WDT dt node.
> 
>     Specified.
> 
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: Paul Burton <paulburton@kernel.org>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: linux-mips@vger.kernel.org
> [...]

MBR, Sergei
