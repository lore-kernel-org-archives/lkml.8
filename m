Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0325EC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE1821D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unhcIQ9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBSH7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:59:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49900 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=d2h7Hjg5NeUkN0zqsxuDL8hCed7EaXHpJcg40URIgGc=; b=unhcIQ9SV2IoiGA3l5wj4aTMMP
        RUvmwIA4vyLRk6+iiWP1g7Ti/gK6hxO8wv1abAwX//kQjRpSzVxzTMKKPZ95tszkPypQkuAobhl8d
        N3Dhz4xo7VAvSS2YNd+oYJgy9mXfDtvEmS3xiSXOCxwHax5MLAAKEL+Kb+j4KgSErdNnNw5XQ2bIb
        IQdVLg6G9sNSoVrSdXqiG0L92YAYZ22OZnDLDChr3lTNWQ8Z3k8gUcz/8kb1TWAEophJlR4x8gmLS
        tN/Ndo2AJmC4rlYtmWr8slAuSEK2D5dbYXQmDD2scrYZ58n3X97KX6Nz7+uJTlKhn7yn3ZO5iH6In
        pyPT3VZA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4KGJ-0006SD-TK; Wed, 19 Feb 2020 07:59:15 +0000
Subject: Re: [PATCH v5 2/2] clk: intel: Add CGU clock driver for a new SoC
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
References: <cover.1582096982.git.rahul.tanwar@linux.intel.com>
 <6148b5b25d4a6833f0a72801d569ed97ac6ca55b.1582096982.git.rahul.tanwar@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8259928-cb2a-a453-8f2a-1b57c8abdb8c@infradead.org>
Date:   Tue, 18 Feb 2020 23:59:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6148b5b25d4a6833f0a72801d569ed97ac6ca55b.1582096982.git.rahul.tanwar@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/20 11:40 PM, Rahul Tanwar wrote:
> From: rtanwar <rahul.tanwar@intel.com>
> 
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
> Intel network processor SoC named Lightning Mountain(LGM). It provides
> programming interfaces to control & configure all CPU & peripheral clocks.
> Add common clock framework based clock controller driver for CGU.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/clk/Kconfig           |   1 +
>  drivers/clk/x86/Kconfig       |   8 +
>  drivers/clk/x86/Makefile      |   1 +
>  drivers/clk/x86/clk-cgu-pll.c | 156 +++++++++++
>  drivers/clk/x86/clk-cgu.c     | 636 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/x86/clk-cgu.h     | 335 ++++++++++++++++++++++
>  drivers/clk/x86/clk-lgm.c     | 492 ++++++++++++++++++++++++++++++++
>  7 files changed, 1629 insertions(+)
>  create mode 100644 drivers/clk/x86/Kconfig
>  create mode 100644 drivers/clk/x86/clk-cgu-pll.c
>  create mode 100644 drivers/clk/x86/clk-cgu.c
>  create mode 100644 drivers/clk/x86/clk-cgu.h
>  create mode 100644 drivers/clk/x86/clk-lgm.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index bcb257baed06..43dab257e7aa 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -360,6 +360,7 @@ source "drivers/clk/sunxi-ng/Kconfig"
>  source "drivers/clk/tegra/Kconfig"
>  source "drivers/clk/ti/Kconfig"
>  source "drivers/clk/uniphier/Kconfig"
> +source "drivers/clk/x86/Kconfig"
>  source "drivers/clk/zynqmp/Kconfig"
>  
>  endmenu

Hi,

> diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
> new file mode 100644
> index 000000000000..2e2b9730541f
> --- /dev/null
> +++ b/drivers/clk/x86/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CLK_LGM_CGU
> +	depends on (OF && HAS_IOMEM) || COMPILE_TEST

This "depends on" looks problematic to me. I guess we shall see when
all the build bots get to it.

> +	select OF_EARLY_FLATTREE

If OF is not set and HAS_IOMEM is not set, but COMPILE_TEST is set,
I expect that this should not be attempting to select OF_EARLY_FLATTREE.

Have you tried such a config combination?

> +	bool "Clock driver for Lightning Mountain(LGM) platform"
> +	help
> +	  Clock Generation Unit(CGU) driver for Intel Lightning Mountain(LGM)
> +	  network processor SoC.
thanks.
-- 
~Randy

