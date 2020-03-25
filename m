Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7191C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762462077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yId6fXen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:08:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgCYKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:08:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so2175452wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7i0lgx1efrwuhv3liq90SCT+x9GZzc7GsJIbhHue7U8=;
        b=yId6fXenjtaX6s2WBP6WfAKpiDHz0AFuAgACON3PKPA8siavm/xmttnquxGfAQ9JG0
         gKo74nFkFmKTA+bBxifdkvfiHcNQFpqlcbTDLIu3Fo0+C34vf4ePE05w1D1Ke+wsYHG/
         jYw0nH8VpSIg40XljRzXZwDhipRk5mu90oyF9Hs+JYw1JuqTxAnmaU/alU4M0PlzS06o
         xMB6behE/o+UEb1/3iRYM8DSUgxo1KvNo3qJ1bPam3sSgsXSnWhnTtdZa8D65Sivh28+
         2Y1eMReChSf9862c9zzI6rBSEY1dJidgsGNg0cIFH8faRS1gSmQfrrOwvOGC465OyAsA
         jvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7i0lgx1efrwuhv3liq90SCT+x9GZzc7GsJIbhHue7U8=;
        b=I4WBzZt7QIuR7/K/wt6ZN8X3VVbODCFw3aeLanLWWVrbixTHrc7xNXkaeyZ63iEu10
         N/K01Cc9SPDjYkIgIa7EeO8RLqzDNesUkAhRQM65gPb/5z68sqEeHibg2asdGTdBCv40
         zQyApYabYpu8pXS3vvlvgDMhjETOHqOjCMHK7d+Io2yzIOaSLs5exBBH8jXUCXAHBRD/
         wldiozxYy3WZNL7DKsuJjKBG/K6awfa80z11ED1BRpfrNDHRlWGzFd8tXlzn8M31vRT7
         9PC7O5bP96OibnlzO1YXAJqRI39CcyKjoLhFW2Z9AuglpVd6lbeZaadI9+A0cLsHpKph
         pyrg==
X-Gm-Message-State: ANhLgQ1BDtXEgOvZdcSihixb0hzIfjWm0av8CZ2K77IY47RImt9eMrYe
        eoYDzRzJMjq9BcF1Fd32hFvs8A==
X-Google-Smtp-Source: ADFU+vvgbkaVu8ZzmYck55r4wEQB2IFzKMILavnHZVOU/9YtlxqSabwyzhJQ+Tpgo3ckxU24SCDTqQ==
X-Received: by 2002:adf:e948:: with SMTP id m8mr2543948wrn.193.1585130930998;
        Wed, 25 Mar 2020 03:08:50 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id m3sm2746888wmm.3.2020.03.25.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:08:50 -0700 (PDT)
Date:   Wed, 25 Mar 2020 10:09:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Message-ID: <20200325100940.GI442973@dell>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130614.696EF8030704@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306130614.696EF8030704@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:

> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Baikal-T1 Boot Controller is an IP block embedded into the SoC and
> responsible for the chip proper pre-initialization and further
> booting up from some memory device. From the Linux kernel point of view
> it's just a multi-functional device, which exports three physically mapped
> ROMs and a single SPI controller.
> 
> Primarily the ROMs are intended to be used for transparent access of
> the memory devices with system bootup code. First ROM device is an
> embedded into the SoC firmware, which is supposed to be used just for
> the chip debug and tests. Second ROM device provides a MMIO-based
> access to an external SPI flash. Third ROM mirrors either the Internal
> or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
> chip pins selecting the system boot device.
> 
> External SPI flash can be also accessed by the DW APB SSI SPI controller
> embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
> SPI flash region shouldn't be accessed.
> 
> Taking into account all the peculiarities described above, we created
> an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
> OF-based sub-device registration it also provides a simple API to
> serialize an access to the external SPI flash from either the MMIO-based
> SPI interface or embedded SPI controller.

Not sure why this is being classified as an MFD.

This is clearly 'just' a memory device.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  drivers/mfd/Kconfig              |  13 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/bt1-boot-ctl.c       | 345 +++++++++++++++++++++++++++++++
>  include/linux/mfd/bt1-boot-ctl.h |  46 +++++
>  4 files changed, 405 insertions(+)
>  create mode 100644 drivers/mfd/bt1-boot-ctl.c
>  create mode 100644 include/linux/mfd/bt1-boot-ctl.h

[...]

> diff --git a/drivers/mfd/bt1-boot-ctl.c b/drivers/mfd/bt1-boot-ctl.c
> new file mode 100644
> index 000000000000..9e3cd47a2e7a
> --- /dev/null
> +++ b/drivers/mfd/bt1-boot-ctl.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *
> + * Baikal-T1 Boot Controller driver.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <linux/mfd/core.h>

Despite including the MFD API, I don't see it being used at all.

> +#include <linux/mfd/bt1-boot-ctl.h>

[...]

> +static inline u32 bc_read(void __iomem *reg)
> +{
> +	return readl(reg);
> +}
> +
> +static inline void bc_write(void __iomem *reg, u32 data)
> +{
> +	writel(data, reg);
> +}

Abstraction for the sake of abstraction is generally discouraged.

[...]

> +static int bc_register_devices(struct bt1_bc *bc)
> +{
> +	int ret;
> +
> +	ret = devm_of_platform_populate(bc->dev);
> +	if (ret)
> +		dev_err(bc->dev, "Failed to add sub-devices\n");
> +
> +	return ret;
> +}

You can call devm_of_platform_populate() from anywhere.

Doesn't have to be an MFD.

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
