Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC3C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243C20715
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593972592;
	bh=c2a55McBd7AMkKjyMUYwDFgVECADqGqhXoBBFONf7hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uWydjHqdTCAo9eT1s7AmQCXrphonBRZIyiVlesyBWz7aXK+gGwXs8PHrAhXyjMnBR
	 uSXrzhc47WgrgADn3MvcBUALUqaJ3uH4aijEsfwkdeVEc4gO990mfA8UQlpPCgUHec
	 8f0dpPuPT1ceOSLflMy/bLM4UAPxHbn0iUqMvd/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGESJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:09:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgGESJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:09:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id j18so36795630wmi.3;
        Sun, 05 Jul 2020 11:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFXUuYLx9z7kdQD8cxQDN+qE9M0mmvVhR4YuFlGCggU=;
        b=NoUtpVLssoof5gl60JAvsz4GNZ29f6UcAsXBMBlrZEvz20f8GcF3M5OuwnXgNQB9/j
         grCfzFalzoad3IJ6e7B5YCyOsDueGnC6IwO5ED9OMG2VXaddy09098WdJ2Ugr7qBVErS
         3zh7k7aGv7XK8Ki3ZZjmukofZh1CsHgB3SfhBRdu0Lul+8uQGu+wQQWtou658MABtXam
         wM0td0+/si7vt8/hc8LjFumptI/UIcVhnpd5n/Bi2PdsHYFWwaioxZN7CON/aC7m6+HQ
         je3fq0J+PlTyDXBNN/c1S+6p65xtE2wRWRvCUum33AgoplKtHZDTiSed6FiYDGtsSnpz
         iipw==
X-Gm-Message-State: AOAM532RksK9adTQ4Zq8n8xDTYHSOpRTBUF8tASsf1HQr0aKXQkou8i1
        dCZVwnvd4Ej+monX9NRn6NA=
X-Google-Smtp-Source: ABdhPJxjI4yFt1EotH4VAiKnZjhxmDAOFtIsBKxuNGU1hyL2uOKUIKD6daN9NG2yCKPfXkNal/526Q==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr3373057wmb.140.1593972588223;
        Sun, 05 Jul 2020 11:09:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id 138sm15606042wmb.1.2020.07.05.11.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jul 2020 11:09:46 -0700 (PDT)
Date:   Sun, 5 Jul 2020 20:09:44 +0200
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: exynos: Add minimal bootargs
Message-ID: <20200705180944.GB2765@kozik-lap>
References: <CGME20200703184543epcas5p4adb3db7693094c72477b8469d9f205ba@epcas5p4.samsung.com>
 <20200703182536.9190-1-alim.akhtar@samsung.com>
 <000801d6516a$b6efcb40$24cf61c0$@samsung.com>
 <20200704102246.GA5975@kozik-lap>
 <004c01d6526d$18c365e0$4a4a31a0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004c01d6526d$18c365e0$4a4a31a0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 07:09:14AM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> > Also, why did you use different serial for console?
> > 
> Once UART driver gets probed then console changes to ttySAC0. In case I am using stdout-path only,
> after bootconsole is disabled, kernel logs re-start printing from beginning (which might be expected behaviour?)
> 
> [    0.012416] printk: console [tty0] enabled
> [    0.016491] printk: bootconsole [exynos4210] disabled
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd032]
> [    0.000000] Linux version 5.8.0-rc3-next-20200703-00008-g4af626444f4a-dirty (alim@alim) (aarch64-linux-gnu-gcc (Linaro GCC 7.4-2019.02) 7.4.1 20181213 [l0
> [    0.000000] Machine model: Samsung Exynos7 Espresso board based on Exynos7
> 

No, this is not desired. The fix for it should not be redefining the
console to wrong argument.

For example on Odroid MC1 this problem does not exist:

[    0.000000] earlycon: exynos4210 at MMIO 0x12c20000 (options '115200n8')
[    0.000000] printk: bootconsole [exynos4210] enabled
[    3.111883] printk: console [ttySAC2] enabled
[    3.111883] printk: console [ttySAC2] enabled
[    3.120102] printk: bootconsole [exynos4210] disabled
[    3.120102] printk: bootconsole [exynos4210] disabled


but your console for some reason is tty0... why? Is your console
ttySAC2? Maybe it is the effect of alias:
serial0 = &serial_2;

> > However the question is, are you sure you want earlycon on every, including
> > successful boot? On most of the boards we do not enable by default. If
> > developer needs, he can choose it for example via U-Boot "setenv opts
> > earlycon".
> > 
> Using U-Boot is not the case always, any bootload can be used to boot the Linux, currently I am Coreboot.
> And 'earlycon' is not setup by default.
> As Espresson board is development board, IMO it is ok to keep it enable all the time, this helps in quickly knowing what going on incase boot fails early.
> Let me know if it is ok to keep " console=ttySAC0,115200n8" or shell I just re-spin with only 'earlycon'? or any other suggestion?

It should be just earlycon.

Best regards,
Krzysztof

