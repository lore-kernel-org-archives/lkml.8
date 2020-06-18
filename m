Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C47C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D28A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JP6cdM6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgFRIUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgFRIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:20:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329BC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:20:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t13so2620753wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4KcujSsS1jyjnsxMXRZfCGa39cS76YnVtoeGFVxCFgc=;
        b=JP6cdM6fRlsxkBS/oB90AVgYIES7VE8ArtqzXGZ8RnERg8aj8ytd++B2GEjbx3XJdh
         5fEtk7p/TKEXMSNfLVJ5haAGojW2NatyNxLjq36RasROlWCd+J0EsfKG/rZhX4F0cI+D
         o1sXVokcbprB6k95jboAGE/WYgr86lK24y7US+dgADQbL9YjPqJZzXgSy+Uf9eNOivmX
         GW8LmoFy1DiTHCgWKG1s3KlKKGKKLHRyHSJrvRMz4tLjVycxiexpvkzkFzfIwlod3Vm+
         8hV2AuaYNUhl1dsJMCHSPChuCldzgGma/AiWvTUgKnmcEP3YIaaC1df5xJt5QtCAFZAU
         rOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4KcujSsS1jyjnsxMXRZfCGa39cS76YnVtoeGFVxCFgc=;
        b=lPAcL8czH6eMkcekXwvXoGEcmRQ+bvAPn2qBq4RbzncDFHFFgIddJZ+HNVoYPbj6Db
         wj/8OCnoIKBQofpR1quv5mU6/vl3HviNJbblcUq/Q0Lm385rkdO0G8CkLnYj3dgwHRXP
         W2ijEy1nk32nKhMaYOk+99oSkJHWwefbsA+y4Zy35XtKY6xQa/tWTRSVkWcEIDRvw3fb
         3gDKLHm//r9gpYHez48cWrwHxNTUeD9GilTIFm4z5xxpOk+pBu1pBWpa+ZTJJDTalGkR
         sqInx0jSB+Tl2eon1Ca5c6AGvl/nTArnXv9nzrTAI0iASzRQnhmsWNMF3q/Q2+ffn4YZ
         u8Mg==
X-Gm-Message-State: AOAM5314Ri5CqEP4FDmZ/ZuvzNYHgug+duzjQcckLtBwyN5B647nmKe6
        2v/rsdHPkPTSZ4uc5TmcBEFOTg==
X-Google-Smtp-Source: ABdhPJzHjbMVQLF+FVct8ot/7YOMYRsMDLX1hN75mvGjfOq63MOC8UTFzu2niGdYKHrjduUo6iHLhw==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr3124134wrc.138.1592468399531;
        Thu, 18 Jun 2020 01:19:59 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id l17sm749882wmh.14.2020.06.18.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:19:58 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:19:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] mfd: Add support for Khadas Microcontroller
Message-ID: <20200618081957.GD2608702@dell>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, Neil Armstrong wrote:

> The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
> connected via I2C.
> 
> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
> 
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
> 
> Thie serie adds :
> - the bindings
> - the MFD driver
> - the Thermal Cooling cell driver
> - updates MAINTAINERS
> - add support into the Khadas VIM3/VIM3L DT
> 
> Changes since v2 at [3]:
> - Removed NVMEM driver for separate submission
> - fixed MFD driver, header and Kconfig
> - fixed Thermal Kconfig
> - fixed MAINTAINERS files and path
> 
> Changes since RFC v1 at [2]:
> - moved hwmon driver to thermal-only
> - moved the SM1 thermal nodes in a separate serie
> - added the bindings review tag from rob
> 
> [1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
> [2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com
> [3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre.com
> 
> Neil Armstrong (5):
>   dt-bindings: mfd: add Khadas Microcontroller bindings
>   mfd: add support for the Khadas System control Microcontroller
>   thermal: add support for the MCU controlled FAN on Khadas boards
>   MAINTAINERS: add myself as maintainer for Khadas MCU drivers
>   arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

I'm a bit concerned by the missing patches from my inbox.

Looks like you omitted to send me patch 3 and 5.

Hopefully the Thermal patch doesn't depend on the MFD one!

>  .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 +++++
>  MAINTAINERS                                   |   9 +
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
>  drivers/mfd/Kconfig                           |  21 +++
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/khadas-mcu.c                      | 142 ++++++++++++++
>  drivers/thermal/Kconfig                       |  11 ++
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
>  include/linux/mfd/khadas-mcu.h                |  91 +++++++++
>  10 files changed, 517 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>  create mode 100644 drivers/mfd/khadas-mcu.c
>  create mode 100644 drivers/thermal/khadas_mcu_fan.c
>  create mode 100644 include/linux/mfd/khadas-mcu.h
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
