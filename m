Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABEC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778B42137B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390970AbgDCN7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:59:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:50235 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgDCN7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:59:40 -0400
IronPort-SDR: doRDbxzMLXo9A9Er73exZGM/Jwqp41Z2dCDP8m2LIHO8/LgY64ySDHorTfmW2wwtf5oNcoiPyY
 umS85X6ekQNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 06:59:39 -0700
IronPort-SDR: /2xYoklzvbD7Z3OBiQji7Z/4+0GLMR0+8oACt8P+r/jxr/MscjgYt9dWLSNMoaqNCYglsm00yp
 iLcTkSF+7tOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="scan'208";a="423531409"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2020 06:59:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jKMrE-00FRbl-QL; Fri, 03 Apr 2020 16:59:40 +0300
Date:   Fri, 3 Apr 2020 16:59:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fengping yu <fengping.yu@mediatek.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3 2/2] add MediaTek keypad driver
Message-ID: <20200403135940.GN3676135@smile.fi.intel.com>
References: <20200403131419.6555-1-fengping.yu@mediatek.com>
 <20200403131419.6555-3-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403131419.6555-3-fengping.yu@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:14:23PM +0800, Fengping yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>

You have to give a proper commit message. Emptiness is not good enough.

> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>

...

> +#include <linux/fs.h>

This is for..?

> +#include <linux/gpio.h>

Wrong header.

> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>

I hardly found any user of these two.

...

> +#define BITS_TO_U32(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))

I believe this is in bits.h. But see below.

> +struct mtk_keypad {
> +	struct input_dev *input_dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +	unsigned int irqnr;
> +	bool wakeup;
> +	u32 key_debounce;
> +	u32 n_rows;
> +	u32 n_cols;

> +	DECLARE_BITMAP(keymap_state, KPD_NUM_BITS);

And where is bitmap.h?

> +};

...

> +	for_each_set_bit(bit_nr, change, KPD_NUM_BITS) {
> +		pressed = test_bit(bit_nr, new_state) == 0U;
> +		dev_dbg(&keypad->input_dev->dev, "%s",
> +			pressed ? "pressed" : "released");
> +

> +	/* per 32bit register only use low 16bit as keypad mem register */

Indentation issue.

> +		code = keycode[bit_nr - 16 * (BITS_TO_U32(bit_nr) - 1)];

For example,
	128 - 16 * (4 - 1) = 80
	135 - 16 * (5 - 1) = 71
Is this correct?

> +		input_report_key(keypad->input_dev, code, pressed);
> +		input_sync(keypad->input_dev);
> +
> +		dev_dbg(&keypad->input_dev->dev,
> +			"report Linux keycode = %d\n", code);
> +	}

...

> +	ret = of_property_read_u32(node, "mediatek,debounce-us",
> +				   &keypad->key_debounce);

Can't you use device property API instead?

> +	keypad->wakeup = of_property_read_bool(node, "wakeup-source");

Ditto.

...

> +	keypad_pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(keypad_pinctrl)) {

> +		dev_err(dev, "Cannot find keypad_pinctrl!\n");

Isn't it a duplicate and pin control actually does this for you?

> +		return PTR_ERR(keypad_pinctrl);
> +	}
> +
> +	kpd_default = pinctrl_lookup_state(keypad_pinctrl, "default");
> +	if (IS_ERR(kpd_default)) {

> +		dev_err(dev, "Cannot find ecall_state!\n");

Ditto.

> +		return PTR_ERR(kpd_default);
> +	}

> +	return pinctrl_select_state(keypad_pinctrl,	kpd_default);

Indentation issue.

> +}

...

> +	keypad->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(keypad->base)) {

> +		dev_err(&pdev->dev, "KP iomap failed\n");

Duplicate noise.

> +		return PTR_ERR(keypad->base);
> +	}

...

> +	keypad->irqnr = platform_get_irq(pdev, 0);
> +	if (keypad->irqnr < 0) {

> +		dev_err(&pdev->dev, "KP get irqnr failed\n");

Duplicate noise.


> +		ret = -keypad->irqnr;

Why -?

> +		goto disable_kpd_clk;
> +	}

-- 
With Best Regards,
Andy Shevchenko


