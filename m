Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5932C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51FC2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="kaFjl6ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2Itb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2Ita (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:49:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9928C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:49:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z18so1584767lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1l4xtGOxhqqlxgIkGPyKhx55xNwxZ5usjoQR3ai/dCs=;
        b=kaFjl6haj8O8E8+DmE686PPUoSGeVZy1HTTpnNUDRBpxA/k+lKvri2wRisWgT2iT2y
         FVKLgHhA10JSdaHrsa+l2lQXc9FLLoHrOqQ0zr5/4PL+ZemuzIFMFMe7aYdCnLSIIH9w
         UuceE594b7VMWDsCtVStURZka3tsH9a4a64zzX9Cw2fizZalzwZnQhFwrnuGla08HZV+
         2TxIq4Zmk5oq2Y7/UPSUkPKe2A7rHEV7qxIuz2z7gS+xakAlKAsi/vqsq28SyAgPSHjF
         KqTlfO7kMhzOBOBgxvy4KyFKzshw/66MYuiLhXcsYo2Hds8lD9tN+I3Hdl3t3ORl9dOt
         a80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1l4xtGOxhqqlxgIkGPyKhx55xNwxZ5usjoQR3ai/dCs=;
        b=HImquBJb7e6UCAZPY/5vkIsBOCP9DBBzQLn4Jh9FWtMVo38y7oiabqmksukKvlj+q1
         aM7A3VvpK3kHku+96jEgKB+RlG6Vgge3g4o/62BDx3Ol3d4C4dCv7zYlJOLLBWdNrrLn
         cfpwpC9WPaeRNOOzFivMXEqClAH4rJOAVPG5X/HvXKmeIuBsqobuKbnaZJiqk1VzP79b
         paNtNQ1Hzuumo+WcmPjYsVHuZcMLJ+FdBznLPrBfFghZBDEPSR/r4/jrtO463ZfLMWX8
         dqoJ3Qi2cls7xWFD+xs1vbqIfRh+Th0uNo7fi0cA8vFR8HuQLK4/XpyIpM1U/a5qa2l3
         J0kA==
X-Gm-Message-State: AOAM531Y1rz7x4b2QYRRhufSZZn3Ih9KiVwX9GOCD4MbfPbGJSteWcaL
        QKFzpLWruiK8I4AXXKhiENON0SIPTgwOAA==
X-Google-Smtp-Source: ABdhPJzXUde5z0UiZwHiMG/jkD4n9ZihV6t4jN0gXDun6HT126YSr0NDTPIAn28I3N14iaTVHdMcYg==
X-Received: by 2002:a2e:7f08:: with SMTP id a8mr3840705ljd.332.1590742168088;
        Fri, 29 May 2020 01:49:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2d5:373e:50fc:221d:1226:f18a? ([2a00:1fa0:2d5:373e:50fc:221d:1226:f18a])
        by smtp.gmail.com with ESMTPSA id l16sm2119454lfg.2.2020.05.29.01.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:49:27 -0700 (PDT)
Subject: Re: [PATCH v5 01/16] spi: dw: Set xfer effective_speed_hz
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <afdf414a-df95-b130-85e8-cda5bf4e9405@cogentembedded.com>
Date:   Fri, 29 May 2020 11:49:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 29.05.2020 6:58, Serge Semin wrote:

> Seeing DW APB SSI controller doesn't support setting the exactly
> requested SPI bus frequency, but only a rounded frequency determined
> by means of the odd-numbered half-worded reference clock divider,
> it would be good tune the SPI core up and initialize the current
                   ^ to?

> transfer effective_speed_hz. By doing so the core will be able to
> execute the xfer-related delays with better accuracy.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
[...]

MBR, Sergei
