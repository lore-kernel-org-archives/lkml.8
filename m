Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC5AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AF32065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgENJZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:25:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:25:04 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jZA6n-0000Wy-OI; Thu, 14 May 2020 11:24:53 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jZA6l-0005HH-SS; Thu, 14 May 2020 11:24:51 +0200
Date:   Thu, 14 May 2020 11:24:51 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] drivers: input: keyboard: Add mtk keypad driver
Message-ID: <20200514092451.3m4lmx3znlhmq6q4@pengutronix.de>
References: <20200514061747.25466-1-fengping.yu@mediatek.com>
 <20200514061747.25466-3-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514061747.25466-3-fengping.yu@mediatek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:57:27 up 181 days, 16 min, 196 users,  load average: 0.14, 0.50,
 0.35
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I like the evolution of this patch =)

On 20-05-14 14:17, Fengping Yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This adds matrix keypad support for Mediatek SoCs.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> ---
>  drivers/input/keyboard/Kconfig   |   8 ++
>  drivers/input/keyboard/Makefile  |   1 +
>  drivers/input/keyboard/mtk-kpd.c | 223 +++++++++++++++++++++++++++++++
>  3 files changed, 232 insertions(+)
>  create mode 100644 drivers/input/keyboard/mtk-kpd.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 28de965a08d5..6bae95a5f90b 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -782,6 +782,14 @@ config KEYBOARD_BCM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bcm-keypad.
>  
> +config KEYBOARD_MTK_KPD
> +	tristate "MediaTek Keypad Support"
> +	depends on OF && HAVE_CLK
> +	help
> +	  Say Y here if you want to use the keypad on MediaTek SoCs.
> +	  If unsure, say N.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mtk-kpd.
>  config KEYBOARD_MTK_PMIC
>  	tristate "MediaTek PMIC keys support"
>  	depends on MFD_MT6397
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 1d689fdd5c00..6c9d852c377e 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
>  obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
>  obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
>  obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
> +obj-$(CONFIG_KEYBOARD_MTK_KPD)		+= mtk-kpd.o
>  obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
>  obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
>  obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
> diff --git a/drivers/input/keyboard/mtk-kpd.c b/drivers/input/keyboard/mtk-kpd.c
> new file mode 100644
> index 000000000000..a538f89d6696
> --- /dev/null
> +++ b/drivers/input/keyboard/mtk-kpd.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + * Author Terry Chang <terry.chang@mediatek.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/bitops.h>

Please sort it alphabetical.

> +#define KPD_NAME	"mtk-kpd"
> +
> +#define KP_MEM		0x0004
> +#define KP_DEBOUNCE	0x0018
> +
> +#define KPD_DEBOUNCE_MASK	GENMASK(13, 0)
> +#define KPD_DEBOUNCE_MAX_US	256000 /*256ms */
> +#define KPD_NUM_MEMS	5
> +#define KPD_NUM_BITS	136	/* 4 * 32 + 8 MEM5 only use 8 BITS */

Pls align all define values. Nit, I would also make the names a bit more
uniform e.g.
  - MTK_KPD_NAME
  - MTK_KPD_MEM
  - MTK_KPD_DEBOUNCE
  - MTK_KPD_NUM_MEMS
  ...

> +struct mtk_keypad {
> +	struct regmap *regmap;
> +	struct input_dev *input_dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +	bool wakeup;
> +	u32 n_rows;
> +	u32 n_cols;
> +	DECLARE_BITMAP(keymap_state, KPD_NUM_BITS);
> +};
> +
> +static const struct regmap_config keypad_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = 0x0024,

IMHO we should specify max_register as decimal value.

> +};
> +
> +static irqreturn_t kpd_irq_handler(int irq, void *dev_id)
> +{
> +	struct mtk_keypad *keypad = dev_id;
> +	unsigned short *keycode = keypad->input_dev->keycode;
> +	DECLARE_BITMAP(new_state, KPD_NUM_BITS);
> +	DECLARE_BITMAP(change, KPD_NUM_BITS);
> +	int bit_nr;
> +	int pressed;
> +	unsigned short code;
> +
> +	regmap_raw_read(keypad->regmap, KP_MEM, new_state, KPD_NUM_MEMS);
> +
> +	bitmap_xor(change, new_state, keypad->keymap_state, KPD_NUM_BITS);
> +
> +	for_each_set_bit(bit_nr, change, KPD_NUM_BITS) {
> +		/* 1: not pressed, 0: pressed */
> +		pressed = !test_bit(bit_nr, new_state);
> +		dev_dbg(&keypad->input_dev->dev, "%s",
> +			pressed ? "pressed" : "released");
> +
> +		/* 32bit register only use low 16bit as keypad mem register */
> +		code = keycode[bit_nr - 16 * (BITS_TO_U32(bit_nr) - 1)];
> +
> +		input_report_key(keypad->input_dev, code, pressed);
> +		input_sync(keypad->input_dev);
> +
> +		dev_dbg(&keypad->input_dev->dev,
> +			"report Linux keycode = %d\n", code);
> +	}
> +
> +	bitmap_copy(keypad->keymap_state, new_state, KPD_NUM_BITS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int kpd_pdrv_probe(struct platform_device *pdev)
> +{
> +	struct mtk_keypad *keypad;
> +	struct pinctrl *keypad_pinctrl;
> +	struct pinctrl_state *kpd_default;
> +	unsigned int irqnr;
> +	u32 debounce;
> +	int ret;
> +
> +	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
> +	if (!keypad)
> +		return -ENOMEM;

Missing newline ?

> +	keypad->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(keypad->base))
> +		return PTR_ERR(keypad->base);
> +
> +	keypad->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL,
> +				keypad->base, &keypad_regmap_cfg);

Pls align it and make use of devm_regmap_init_mmio().

> +	if (IS_ERR(keypad->regmap)) {
> +		dev_err(&pdev->dev,
> +			"regmap init failed:%ld\n", PTR_ERR(keypad->regmap));
> +		return PTR_ERR(keypad->regmap);
> +	}
> +
> +	bitmap_fill(keypad->keymap_state, KPD_NUM_BITS);
> +
> +	keypad->input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!keypad->input_dev) {
> +		dev_err(&pdev->dev, "Failed to allocate input dev\n");
> +		return -ENOMEM;
> +	}
> +
> +	keypad->input_dev->name = KPD_NAME;
> +	keypad->input_dev->id.bustype = BUS_HOST;
> +
> +	ret = matrix_keypad_parse_properties(&pdev->dev, &keypad->n_rows,
> +					     &keypad->n_cols);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to parse keypad params\n");
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(&pdev->dev, "mediatek,debounce-us",
> +					&debounce);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to read mediatek debounce time\n");
> +		return ret;
> +	}

Nit, I would make it optional and use a default if no value is
specified.

> +
> +	if (debounce > KPD_DEBOUNCE_MAX_US) {
> +		dev_err(&pdev->dev, "Debounce time exceeds the maximum allowed time 256ms\n");
> +		return -EINVAL;
> +	}
> +
> +	keypad->wakeup = device_property_read_bool(&pdev->dev, "wakeup-source");
> +
> +	dev_dbg(&pdev->dev, "n_row=%d n_col=%d debounce=%d\n",
> +		keypad->n_rows, keypad->n_cols, debounce);
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL,
> +					keypad->n_rows,
> +					keypad->n_cols,
> +					NULL,
> +					keypad->input_dev);

Pls align it correctly.

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to build keymap\n");
> +		return ret;
> +	}
> +
> +	input_set_drvdata(keypad->input_dev, keypad);
> +
> +	regmap_write(keypad->regmap, KP_DEBOUNCE,
> +			debounce * 32 / 1000 & KPD_DEBOUNCE_MASK);

Pls align this also.

> +
> +	keypad->clk = devm_clk_get(&pdev->dev, "kpd");
> +	if (IS_ERR(keypad->clk)) {
> +		return PTR_ERR(keypad->clk);
> +	}

Not needed braces.

> +
> +	ret = clk_prepare_enable(keypad->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot prepare/enable keypad clock\n");
> +		return ret;
> +	}
> +
> +	devm_add_action_or_reset(&pdev->dev,
> +				(void (*)(void *))clk_disable_unprepare,
> +				keypad->clk);

Pls don't do that and instead add a internal driver function.

> +
> +	keypad_pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(keypad_pinctrl)) {
> +		return PTR_ERR(keypad_pinctrl);
> +	}

Not needed braces.

> +
> +	kpd_default = pinctrl_lookup_state(keypad_pinctrl, "default");
> +	if (IS_ERR(kpd_default)) {
> +		dev_err(&pdev->dev, "No default pinctrl state\n");
> +		return PTR_ERR(kpd_default);
> +	}
> +
> +	pinctrl_select_state(keypad_pinctrl, kpd_default);
> +
> +	irqnr = platform_get_irq(pdev, 0);
> +	if (irqnr < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq\n");
> +		return -irqnr;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irqnr,
> +				NULL, kpd_irq_handler, 0,
> +				KPD_NAME, keypad);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request IRQ#%d:%d\n",
> +						irqnr, ret);
> +		return ret;
> +	}
> +
> +	ret = input_register_device(keypad->input_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register device\n");
> +		return ret;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, keypad->wakeup);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id kpd_of_match[] = {
> +	{.compatible = "mediatek,kp"},

I would also add the specific compatible which you list in the
dt-bindings patch.

> +	{/*sentinel*/}
> +};
> +
> +static struct platform_driver kpd_pdrv = {
> +	.probe = kpd_pdrv_probe,
> +	.driver = {
> +		   .name = KPD_NAME,
> +		   .of_match_table = kpd_of_match,
> +	},
> +};
> +module_platform_driver(kpd_pdrv);
> +
> +MODULE_AUTHOR("Mediatek Corporation");
> +MODULE_DESCRIPTION("MTK Keypad (KPD) Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.18.0

Pls use checkpatch the next time, there are several style issues. Also
it is quite common to use a vendor prefix for funtions e.g.
mtk_kpd_probe() and mtk_kpd_irq_handler() but this is up to you.

Regards,
  Marco
