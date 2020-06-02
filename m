Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2951C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF6206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591086085;
	bh=JDWjXKU3EpHzZx1Tu9HxV6CBJiWZdmfZjOq6H7wg38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6rrzQc0NFWdZFXB14V73lmrrgKHk3q6I1VGtoRtKAyhG8e1b3OHBcnQ9zlBaKUFr
	 nxL9KYXPdyXKaq4Hv9BVI7zMNJM5on6Rlvf4RzG9hG3NQSoQIz7JE2lzL6JmGPQb1Z
	 mbwizaNIWlUbSgeJAm+eOIrsjoPieUTdRBd4OD7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgFBIVY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:21:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44611 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:21:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id l1so8515072ede.11;
        Tue, 02 Jun 2020 01:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bMqx/K8qt6ZuFGVbxPaYyyZ1KHtt21Gc7xSEXh3TFqc=;
        b=O9G5ZLFuDdvQSTa7n8opXyKzFW3mNKGWhkRR2z4WWDayhKOUunT2bWgTNScBSwlg59
         hDECMWxJ/RyssG35Urv4P5ggcvPH6Dga9RX5Rro2C45vZhfeCJQP5VUKJc0h+J8xa1vn
         VxYW/VR1LyBGbgh9b1xWWf87B3iXUahgC4UGFsRvTOFFOJbHJ3OLxXPa7xSpUiRC1KFA
         /3QacDI+fltcU1yaxCSFnat0MWARv0EtfZ1SEbuPhds6R/4fS/tKtBqf1tSKj6ABYFzs
         MkAjX+1p+Eb4d/+LQBBDEE7fvVzTeJv5E+zJ0sra76PSurtc/uYqw+smddUPghxl9n2i
         iS+A==
X-Gm-Message-State: AOAM530cNkWr50N7XTUmXULQiqi+KU2/rk0HYF6WBu9LtJ1KnlWzLX3u
        oByl1kXBnhumSOMXBf8ZXY8=
X-Google-Smtp-Source: ABdhPJz0s1Yv0craKTmc1+MBA9Wpl8/dfLu81EyEQULFcLKG2SD43M0HslPqhrDnEtV41wdc2KCt7w==
X-Received: by 2002:aa7:d283:: with SMTP id w3mr13300946edq.262.1591086081042;
        Tue, 02 Jun 2020 01:21:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id h10sm1340569ejb.2.2020.06.02.01.21.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 01:21:20 -0700 (PDT)
Date:   Tue, 2 Jun 2020 10:21:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v5 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
Message-ID: <20200602082118.GB8216@kozik-lap>
References: <20200529163200.18031-1-s.nawrocki@samsung.com>
 <CGME20200529163223eucas1p2f663280abb499b4114b2f2930b43a4e5@eucas1p2.samsung.com>
 <20200529163200.18031-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200529163200.18031-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:31:56PM +0200, Sylwester Nawrocki wrote:
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
> 
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are specified using the 'samsung,interconnect-parent' in the
> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
> 
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hardcoded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
> 
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - use automatically generated platform device id as the interconect
>    node id instead of a now unavailable devfreq->id field,
>  - add icc_ prefix to some variables to make the code more self-commenting,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> ---
>  drivers/interconnect/Kconfig         |   1 +
>  drivers/interconnect/Makefile        |   1 +
>  drivers/interconnect/exynos/Kconfig  |   6 ++
>  drivers/interconnect/exynos/Makefile |   4 +
>  drivers/interconnect/exynos/exynos.c | 185 +++++++++++++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
> 
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5b7204e..eca6eda 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -11,6 +11,7 @@ menuconfig INTERCONNECT
>  
>  if INTERCONNECT
>  
> +source "drivers/interconnect/exynos/Kconfig"
>  source "drivers/interconnect/imx/Kconfig"
>  source "drivers/interconnect/qcom/Kconfig"
>  
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 4825c28..2ba1de6 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -4,5 +4,6 @@ CFLAGS_core.o				:= -I$(src)
>  icc-core-objs				:= core.o
>  
>  obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos/
>  obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
>  obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
> diff --git a/drivers/interconnect/exynos/Kconfig b/drivers/interconnect/exynos/Kconfig
> new file mode 100644
> index 0000000..e51e52e
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_EXYNOS
> +	tristate "Exynos generic interconnect driver"
> +	depends on ARCH_EXYNOS || COMPILE_TEST
> +	help
> +	  Generic interconnect driver for Exynos SoCs.
> diff --git a/drivers/interconnect/exynos/Makefile b/drivers/interconnect/exynos/Makefile
> new file mode 100644
> index 0000000..e19d1df
> --- /dev/null
> +++ b/drivers/interconnect/exynos/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +exynos-interconnect-objs		:= exynos.o
> +
> +obj-$(CONFIG_INTERCONNECT_EXYNOS)	+= exynos-interconnect.o
> diff --git a/drivers/interconnect/exynos/exynos.c b/drivers/interconnect/exynos/exynos.c
> new file mode 100644
> index 0000000..8278194
> --- /dev/null
> +++ b/drivers/interconnect/exynos/exynos.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Exynos generic interconnect provider driver
> + *
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Artur Świgoń <a.swigon@samsung.com>
> + *          Sylwester Nawrocki <s.nawrocki@samsung.com>
> + */
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +
> +#define kbps_to_khz(x) ((x) / 8)
> +
> +struct exynos_icc_priv {
> +	struct device *dev;
> +
> +	/* One interconnect node per provider */
> +	struct icc_provider provider;
> +	struct icc_node *node;
> +
> +	struct dev_pm_qos_request qos_req;
> +};
> +
> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> +{
> +	struct of_phandle_args args;
> +	int num, ret;
> +
> +	num = of_count_phandle_with_args(np, "samsung,interconnect-parent",
> +					"#interconnect-cells");
> +	if (num != 1)
> +		return NULL; /* parent nodes are optional */
> +
> +	ret = of_parse_phandle_with_args(np, "samsung,interconnect-parent",
> +					"#interconnect-cells", 0, &args);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	of_node_put(args.np);
> +
> +	return of_icc_get_from_provider(&args);

I think of_node_put() should happen after of_icc_get_from_provider().

Best regards,
Krzysztof
