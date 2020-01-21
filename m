Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA29C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91120882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SYFQZVv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAUVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:34:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38247 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:34:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so3598220lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Zn66Cy2aTWAijjZ/0GebtuhocaBUP6kt+zrFUq/wv8=;
        b=SYFQZVv8gCQrkHK4/E/8BOcwBl3dYIR3X+rEbA3hPB/QTQK3IO0uhLPdNuHjYdUvZR
         wifBvVlqUdBTuKG2mAmbQLWTwjSno6dZy1gXc0dbN4HlC1hD7PUquElsxQx2MUjXWMs+
         NvIFsFdRQwTxOt8iqMLPq5yoW5hFWKTUzZf1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Zn66Cy2aTWAijjZ/0GebtuhocaBUP6kt+zrFUq/wv8=;
        b=BbmliAtU3kccj5Gwe6rcncyPyxAWv9dl6gzlRLMj2VS/CUQKVYr9eSwy1X2AEV1lps
         gBcYbW0MzA20+SjIqsVNmDLwSzPkFd1SWNfIZpNGGFKsDvOOwza4uC46rSSa7lF0uJkP
         QYWhhCcx2FPRJFWu/DtqmTj3Qau5TyLg1L6wsfGTJ74FKmoPmDuTvK/hDQ87d2jZlRHc
         kziR5Piova8Zuj1wF6RCt2H+qBRGhVtXem2rgmq5+NvDm14JwSd9yC7/9alVEqe8sfCq
         kSVlPiDVtSIDyadAx/I4l4hYn05t9QSDE/mNkIF56T5vM23KP8pmcqLXoBMaIDYa2+tB
         /KbQ==
X-Gm-Message-State: APjAAAUgQj7F//TeMppVxiuHHBntmKyzGgZWFp0vX+JVtH4boFud1DFE
        9cX9jVYvJxBey+v0HGCKUIxo7Ttl8lg=
X-Google-Smtp-Source: APXvYqxLO2S5tdHYxWOloA4moTCaB7mD1bPnUfYTCua5E4n4XKBmcIo06vCieLCQeL6uYvfW1s+OsA==
X-Received: by 2002:a19:6445:: with SMTP id b5mr3706447lfj.187.1579642440783;
        Tue, 21 Jan 2020 13:34:00 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d22sm7006660lfi.49.2020.01.21.13.33.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:33:59 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id q8so4379793ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 13:33:59 -0800 (PST)
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr3707946ljj.253.1579642439010;
 Tue, 21 Jan 2020 13:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20200109211215.18930-1-sibis@codeaurora.org> <20200109211215.18930-3-sibis@codeaurora.org>
In-Reply-To: <20200109211215.18930-3-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 21 Jan 2020 13:33:22 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ZUTiGrvsaqfrVv-bH3w75as7G1UJRn3aJs3ECqodpQg@mail.gmail.com>
Message-ID: <CAE=gft7ZUTiGrvsaqfrVv-bH3w75as7G1UJRn3aJs3ECqodpQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] interconnect: qcom: Add OSM L3 interconnect
 provider support
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 1:12 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On some Qualcomm SoCs, Operating State Manager (OSM) controls the
> resources of scaling L3 caches. Add a driver to handle bandwidth
> requests to OSM L3 from CPU on SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |   7 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/osm-l3.c | 267 +++++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/osm-l3.c
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index a9bbbdf7400f9..b94d28e7bf700 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -14,6 +14,13 @@ config INTERCONNECT_QCOM_MSM8974
>          This is a driver for the Qualcomm Network-on-Chip on msm8974-based
>          platforms.
>
> +config INTERCONNECT_QCOM_OSM_L3
> +       tristate "Qualcomm OSM L3 interconnect driver"
> +       depends on INTERCONNECT_QCOM || COMPILE_TEST
> +       help
> +         Say y here to support the Operating State Manager (OSM) interconnect
> +         driver which controls the scaling of L3 caches on Qualcomm SoCs.
> +
>  config INTERCONNECT_QCOM_QCS404
>         tristate "Qualcomm QCS404 interconnect driver"
>         depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 55ec3c5c89dbd..89fecbd1257c7 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +icc-osm-l3-objs                                := osm-l3.o
>  qnoc-msm8974-objs                      := msm8974.o
>  qnoc-qcs404-objs                       := qcs404.o
>  qnoc-sc7180-objs                       := sc7180.o
> @@ -12,6 +13,7 @@ icc-smd-rpm-objs                      := smd-rpm.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> new file mode 100644
> index 0000000000000..7fde53c70081e
> --- /dev/null
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#define LUT_MAX_ENTRIES                        40U
> +#define LUT_SRC                                GENMASK(31, 30)
> +#define LUT_L_VAL                      GENMASK(7, 0)
> +#define LUT_ROW_SIZE                   32
> +#define CLK_HW_DIV                     2
> +
> +/* Register offsets */
> +#define REG_ENABLE                     0x0
> +#define REG_FREQ_LUT                   0x110
> +#define REG_PERF_STATE                 0x920
> +
> +#define OSM_L3_MAX_LINKS               1
> +#define SDM845_MAX_RSC_NODES           130

I'm nervous this define is going to fall out of date with
qcom,sdm845.h. I'm worried someone will end up adding a few more nodes
that were always there but previously hidden from Linux. Can we put
this define in include/dt-bindings/interconnect/qcom,sdm845.h, so at
least when that happens they'll come face to face with this define?
The same comment goes for the SC7180 define in patch 4.

On second thought, this trick only works once. Are we sure there
aren't going to be other drivers that might want to tag on
interconnect nodes as well? How about instead we just add the enum
values below in qcom,sdm845.h as defines?

-Evan
