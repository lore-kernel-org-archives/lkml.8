Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C976206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgENK1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:27:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:60421 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgENK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:27:01 -0400
IronPort-SDR: KbNHZ4A6jPEzPOVXKCjMp3AWFq+hFgM0m8rahbMeAsn4XxbQ7E3G+vf19GT0nNHXQxPMYCTcTn
 /+Cnh1oAlULA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 03:27:00 -0700
IronPort-SDR: ymorzh9D6tyJUiY1NZyMGZdZr21vY0fBLO0VxaoMYUWGlnndU2jiSDZEpDx7s3bQXPKuZgmJaE
 DwNIiA8WrgFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="464480735"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2020 03:26:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZB4v-006bVM-KU; Thu, 14 May 2020 13:27:01 +0300
Date:   Thu, 14 May 2020 13:27:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] drivers: input: keyboard: Add mtk keypad driver
Message-ID: <20200514102701.GZ185537@smile.fi.intel.com>
References: <20200514061747.25466-1-fengping.yu@mediatek.com>
 <20200514061747.25466-3-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514061747.25466-3-fengping.yu@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 02:17:48PM +0800, Fengping Yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This adds matrix keypad support for Mediatek SoCs.

...

> +config KEYBOARD_MTK_KPD
> +	tristate "MediaTek Keypad Support"

> +	depends on OF && HAVE_CLK

What makes it OF dependent?

> +	help
> +	  Say Y here if you want to use the keypad on MediaTek SoCs.
> +	  If unsure, say N.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mtk-kpd.

...

> +#define KPD_DEBOUNCE_MAX_US	256000 /*256ms */

Comment, besides missed space, is redundant. That's how we use unit suffixes in
the definitions.

...

> +static const struct regmap_config keypad_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),

> +	.max_register = 0x0024,

Can it be definition?

> +};

...

> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> +	if (!keypad)
> +		return -ENOMEM;

+ blank line here.

> +	keypad->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(keypad->base))
> +		return PTR_ERR(keypad->base);

...

> +	if (debounce > KPD_DEBOUNCE_MAX_US) {
> +		dev_err(&pdev->dev, "Debounce time exceeds the maximum allowed time 256ms\n");

	...%dus\n", KPD_DEBOUNCE_MAX_US);
or
	...%dms\n", KPD_DEBOUNCE_MAX_US / USEC_PER_MSEC);

> +		return -EINVAL;
> +	}

...

> +	keypad_pinctrl = devm_pinctrl_get(&pdev->dev);

> +	if (IS_ERR(keypad_pinctrl)) {
> +		return PTR_ERR(keypad_pinctrl);
> +	}

Extra {}.

...

> +	kpd_default = pinctrl_lookup_state(keypad_pinctrl, "default");
> +	if (IS_ERR(kpd_default)) {

> +		dev_err(&pdev->dev, "No default pinctrl state\n");

Isn't it done by pin control core?

> +		return PTR_ERR(kpd_default);
> +	}
> +
> +	pinctrl_select_state(keypad_pinctrl, kpd_default);

And basically entire part is duplicating device core part? (Look at dd.c)

...

> +	irqnr = platform_get_irq(pdev, 0);
> +	if (irqnr < 0) {

> +		dev_err(&pdev->dev, "Failed to get irq\n");

This duplicates what platform core does.

> +		return -irqnr;

- ?!

> +	}

-- 
With Best Regards,
Andy Shevchenko


