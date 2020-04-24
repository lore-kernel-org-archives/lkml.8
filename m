Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B9C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820E120704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+DsWnfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:45:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D97C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:45:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so9540128wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SG53LOGVaYSrSbMxtiTrlXAzhLKqp75bh+EmCNg5dN0=;
        b=a+DsWnfI8BxEYpw24cMf1ubciUzpfQylo8DC8e2EEMjIGJAT5XO0tgJRc4zm/7UKFj
         yP+UatvpM1GtMmXPpD5t6YQ4MasDgMtoYBWExtSpG/3qslXrxpKJuKOxPK6aDwnRbbNW
         6yJkklIByWlX/orJ1QKHiLb1RV9hXPUxXRysqlf+BZvjvB7SyZ++FH1taB7SxqUTSMKd
         Mj7oXh41AlY1haAGy3/VSB+UViganSyx20+MVCqJlMMbYhZ1eBZnDu7arB/dsxjdJR9g
         cMWMghusSfqfUS/ZTQ+cVhwDE8raguIokO5x2X3TnwoyGJPxoQ5N3TuXUvUMUuXGQXsL
         2u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SG53LOGVaYSrSbMxtiTrlXAzhLKqp75bh+EmCNg5dN0=;
        b=GrJOZrrzqgCbGsfznoZoJvJG/6P2KUCCaZr0YMiA8jr24PmlIiiVTwejX3mZcnHuZd
         KBlwlwJRjB5PwFVtDs+L8FakyaKYoLzJ+KDuYkSn+UnWnnzwfZHM2jTeF5GksjLmjZRJ
         osZVsdMiE2POFAQR5X0L0ZR3YmUNc3DcnyeG93QXcNJYGlROJ4aFqwbLGUqCjAriLwG4
         LwQobdRxH3EH3MT74DQEX5UxtGemuebskW4g0+TQtj8MeOtLDkjAnaFUZvH+CXxYJu3F
         /B5Ezcokl7afS6bAGXPsSycfKL5/XReC7p7iFBKNoLh78jrxCTlGKGxrgtociiRXuEX6
         s4VQ==
X-Gm-Message-State: AGi0PuaQxWZvkntmfoaaZnRnDmkmyfVMFmevjovJHRgMF4o4nNX2Mfcc
        SRTeq9OSbP1VmbzklfLPXWTcvhhYF9c=
X-Google-Smtp-Source: APiQypJQnsAmYnrESuH25hDMC1DnFFclkWGp9gSfFlUxWpilxTxaT5ID13BjavkGNKAVWmlFxdLMmw==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr9200402wrc.43.1587714320260;
        Fri, 24 Apr 2020 00:45:20 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id o3sm7034174wru.68.2020.04.24.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 00:45:18 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:45:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH v2 02/12] mfd: stm32-fmc2: add STM32 FMC2 controller
 driver
Message-ID: <20200424074517.GN3612@dell>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586966256-29548-3-git-send-email-christophe.kerello@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Christophe Kerello wrote:

> The driver adds the support for the STMicroelectronics FMC2 controller
> found on STM32MP SOCs.
> 
> The FMC2 functional block makes the interface with: synchronous and
> asynchronous static memories (such as PSNOR, PSRAM or other
> memory-mapped peripherals) and NAND flash memories.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
> Changes in v2:
>  - remove ops from stm32_fmc2 structure
>  - add 2 APIs to manage FMC2 enable/disable
>  - add 2 APIs to manage FMC2 NWAIT shared signal
> 
>  drivers/mfd/Kconfig            |  12 +++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/stm32-fmc2.c       | 136 +++++++++++++++++++++++++
>  include/linux/mfd/stm32-fmc2.h | 225 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 374 insertions(+)
>  create mode 100644 drivers/mfd/stm32-fmc2.c
>  create mode 100644 include/linux/mfd/stm32-fmc2.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2b20329..5260582 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1922,6 +1922,18 @@ config MFD_ROHM_BD71828
>  	  Also included is a Coulomb counter, a real-time clock (RTC), and
>  	  a 32.768 kHz clock gate.
>  
> +config MFD_STM32_FMC2
> +	tristate "Support for FMC2 controllers on STM32MP SoCs"
> +	depends on MACH_STM32MP157 || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable STM32 FMC2 driver used for FMC2 External
> +	  Bus Interface controller and FMC2 NAND flash controller. This driver
> +	  provides core support for the STM32 FMC2 controllers, in order to use
> +	  the actual functionality of the device other drivers must be enabled.

Not sure how many times I have to say this before people stop
attempting to pass these kinds of relationships off as MFDs:

A memory device and its bus is not an MFD.  In a similar vain to the
thousands of USB, I2C, SPI, PCI and the like devices that aren't MFDs
either.

Please find another way to associate your device with its bus.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
