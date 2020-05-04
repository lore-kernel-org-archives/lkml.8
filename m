Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ADC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC9A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEDTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:24:34 -0400
Received: from v6.sk ([167.172.42.174]:38354 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgEDTYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:24:32 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id E0456610B2;
        Mon,  4 May 2020 19:23:58 +0000 (UTC)
Date:   Mon, 4 May 2020 21:23:54 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: ene-kb3930: Add driver for ENE KB3930
 Embedded Controller
Message-ID: <20200504192354.GA414543@furthur.local>
References: <20200424221123.106527-1-lkundrak@v3.sk>
 <20200424221123.106527-3-lkundrak@v3.sk>
 <20200429060037.GT3559@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429060037.GT3559@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your review. There are some inline responses below. Where I'm not
responding it means that I'll be just fixing what you've pointed out.

On Wed, Apr 29, 2020 at 07:00:37AM +0100, Lee Jones wrote:
> On Sat, 25 Apr 2020, Lubomir Rintel wrote:
> 
> > This driver provides access to the EC RAM of said embedded controller
> > attached to the I2C bus as well as optionally supporting its slightly weird
> > power-off/restart protocol.
> > 
> > A particular implementation of the EC firmware can be identified by a
> > model byte. If this driver identifies the Dell Ariel platform, it
> > registers the appropriate cells.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/mfd/Kconfig      |  10 ++
> >  drivers/mfd/Makefile     |   1 +
> >  drivers/mfd/ene-kb3930.c | 209 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 drivers/mfd/ene-kb3930.c
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 0a59249198d3..dae18a2beab5 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -398,6 +398,16 @@ config MFD_DLN2
> >  	  etc. must be enabled in order to use the functionality of
> >  	  the device.
> >  
> > +config MFD_ENE_KB3930
> > +	tristate "ENE KB3930 Embedded Controller support"
> > +	depends on I2C
> > +	depends on MACH_MMP3_DT || COMPILE_TEST
> > +	select MFD_CORE
> > +	help
> > +	  This adds support for accessing the registers on ENE KB3930, Embedded
> > +	  Controller. Additional drivers such as LEDS_ARIEL must be enabled in
> > +	  order to use the functionality of the device.
> > +
> >  config MFD_EXYNOS_LPASS
> >  	tristate "Samsung Exynos SoC Low Power Audio Subsystem"
> >  	depends on ARCH_EXYNOS || COMPILE_TEST
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index f935d10cbf0f..2d2f5bc12841 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> >  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
> >  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> >  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
> > +obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
> >  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
> >  
> >  obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
> > diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
> > new file mode 100644
> > index 000000000000..1123f3a1c816
> > --- /dev/null
> > +++ b/drivers/mfd/ene-kb3930.c
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-or-later
> > +/*
> > + * ENE KB3930 Embedded Controller Driver
> > + *
> > + * Copyright (C) 2020 Lubomir Rintel
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/delay.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/core.h>
> 
> Alphabetical.
> 
> > +enum {
> > +	EC_DATA_IN	= 0x00,
> > +	EC_RAM_OUT	= 0x80,
> > +	EC_RAM_IN	= 0x81,
> > +};
> 
> Are these registers?

These are I2C registers that are multiplexing access to the EC RAM.
Should I add a comment or make it clearer in some other way?

> > +enum {
> > +	EC_MODEL_ID	= 0x30,
> > +	EC_VERSION_MAJ	= 0x31,
> > +	EC_VERSION_MIN	= 0x32,
> > +};
> 
> As above?

These are the locations in EC RAM, multiplexed via EC_DATA_IN and
EC_RAM_IN/OUT.

> > +struct kb3930 {
> > +	struct i2c_client *client;
> > +	struct regmap *ec_ram;
> 
> This is usually called 'regmap'.

Yes. But the device has a set of registers directly on the I2C bus as
well as another set of registers in the RAM access to which is
multiplexed via a pair of I2C registers.

This regmap is for the latter register block which is the only one
exposed currently. I believe it still makes sense to make it obvious
this is not the I2C registers in case the driver is extended to expose
those in future.

> > +	struct gpio_descs *off_gpios; 
> > +};
> > +
> > +struct kb3930 *global_kb3930;
> 
> Globals are massively frowned upon.  Please move it.

This is necessary for the pm_power_off hook that takes no argument. All
other MFD drivers that implement power off use a global:

  ab8500-sysctrl.c: static struct device *sysctrl_dev;
  axp20x.c:         static struct axp20x_dev *axp20x_pm_power_off;
  dm355evm_msp.c:   static struct i2c_client *msp430;
  max77620.c:       static struct max77620_chip *max77620_scratch;
  max8907.c:        static struct max8907 *max8907_pm_off;
  palmas.c:         static struct palmas *palmas_dev;
  retu-mfd.c:       static struct retu_dev *retu_pm_power_off;
  rk808.c:          static struct i2c_client *rk808_i2c_client;
  rn5t618.c:        static struct rn5t618 *rn5t618_pm_power_off;
  tps6586x.c:       static struct device *tps6586x_dev;
  tps65910.c:       static struct i2c_client *tps65910_i2c_client;
  tps80031.c:       static struct tps80031 *tps80031_power_off_dev;
  twl-core.c:       static struct twl_private *twl_priv;

> > +static void kb3930_off(struct kb3930 *priv, int poweroff)
> > +{
> > +	gpiod_direction_output(priv->off_gpios->desc[1], poweroff);
> > +
> > +	while (1) {
> > +		mdelay(50);
> 
> Why 50?

The EC's shutdown protocol requires a 10 MHz wave on one GPIO pin,
signalling the shutdown mode with the another one. I'll add a comment.

> > +		gpiod_direction_output(priv->off_gpios->desc[0], 0);
> > +		mdelay(50);
> > +		gpiod_direction_output(priv->off_gpios->desc[0], 1);
> > +	}
> > +}
> 
> Please define all of the magic numbers in this function.
> 
> > +static int kb3930_restart(struct notifier_block *this,
> > +			  unsigned long mode, void *cmd)
> > +{
> 
> Put 'struct kb3930_restart_nb' into 'struct kb3930' then use
> container_of to obtain a pointer to 'struct kb3930_restart_nb'.
> 
> See drivers/power/reset/gpio-restart.c for an example.

Is this still worth doing even if we couldn't get rid of the global?

> > +	kb3930_off(global_kb3930, 0);
> 
> Define the 0 please.
> 
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void kb3930_power_off(void)
> > +{
> > +	kb3930_off(global_kb3930, 1);
> 
> Define the 1 please.
> 
> > +}
> > +
> > +static struct notifier_block kb3930_restart_nb = {
> > +	.notifier_call = kb3930_restart,
> > +	.priority = 128,
> 
> Why 128?
> 
> > +};
> > +
> > +static const struct mfd_cell ariel_ec_cells[] = {
> > +	{ .name = "dell-wyse-ariel-led", },
> > +	{ .name = "dell-wyse-ariel-power", },
> > +};
> > +
> > +static int kb3930_ec_ram_reg_write(void *context, unsigned int reg,
> > +				   unsigned int val)
> > +{
> > +	struct kb3930 *priv = context;
> > +
> > +	return i2c_smbus_write_word_data(priv->client, EC_RAM_OUT,
> > +					 (val << 8) | reg);
> > +}
> > +
> > +static int kb3930_ec_ram_reg_read(void *context, unsigned int reg,
> > +				  unsigned int *val)
> > +{
> > +	struct kb3930 *priv = context;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_word_data(priv->client, EC_RAM_IN, reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = i2c_smbus_read_word_data(priv->client, EC_DATA_IN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = ret >> 8;
> > +	return 0;
> > +}
> > +
> > +static const struct regmap_config kb3930_ec_ram_regmap_config = {
> > +	.name = "ec_ram",
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.reg_stride = 1,
> > +	.max_register = 0xff,
> 
> Where are the list of register defines/enums?

EC_MODEL_ID, EC_VERSION_MAJ and EC_VERSION_MIN above.
The rest is in cell drivers that use them.

> > +	.reg_write = kb3930_ec_ram_reg_write,
> > +	.reg_read = kb3930_ec_ram_reg_read,
> > +	.fast_io = false,
> > +};
> > +
> > +static int kb3930_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct kb3930 *priv;
> 
> Not keen on 'info' or 'priv' for these.
> 
> Prefer it if you call this ddata (device/driver data).
> 
> > +	unsigned int model_id;
> 
> Just 'model' is fine.
> 
> > +	int ret;
> > +
> > +	if (global_kb3930)
> > +		return -EEXIST;
> 
> Please no!
> 
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	global_kb3930 = priv;
> > +	priv->client = client;
> > +	i2c_set_clientdata(client, priv);
> > +
> > +	priv->ec_ram = devm_regmap_init(dev, NULL, priv,
> > +					&kb3930_ec_ram_regmap_config);
> > +	if (IS_ERR(priv->ec_ram))
> > +		return PTR_ERR(priv->ec_ram);
> > +
> > +	ret = regmap_read(priv->ec_ram, EC_MODEL_ID, &model_id);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (model_id == 'J') {
> > +		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> 
> Why NONE over AUTO?
> 
> > +					   ariel_ec_cells,
> > +					   ARRAY_SIZE(ariel_ec_cells),
> > +					   NULL, 0, NULL);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		dev_err(dev, "unknown board model: %02x\n", model_id);
> > +		return -ENODEV;
> 
> If you reverse the logic here, you can put this in the if() and omit
> the else.

It is intentionally structured this way.

Though the driver currently only supports the 'J' version of the EC
firmware, other versions are possible, with different cells exposed via
the EC RAM registers.

> 
> > +	}
> > +
> > +	if (of_property_read_bool (np, "system-power-controller")) {
> 
> Remove the space before the '('.
> 
> > +		priv->off_gpios = devm_gpiod_get_array_optional(dev, "off",
> > +								GPIOD_IN);
> 
> Please try to split the line just after the '='.
> 
> > +	}
> > +	if (IS_ERR(priv->off_gpios))
> > +		return PTR_ERR(priv->off_gpios);
> 
> Shouldn't this be in the if() above?
> 
> > +	if (priv->off_gpios->ndescs < 2) {
> > +		dev_err(dev, "invalid off-gpios property\n");
> > +		return -EINVAL;
> > +	}
> 
> This doesn't seem right.  I thought they were optional?
> 
> > +	if (priv->off_gpios) {
> > +		register_restart_handler(&kb3930_restart_nb);
> > +		if (pm_power_off == NULL)
> > +			pm_power_off = kb3930_power_off;
> > +	}
> > +
> > +	dev_info(dev, "ENE KB3930 Embedded Controller\n");
> 
> Remove this line please.
> 
> > +	return 0;
> > +}
> > +
> > +static int kb3930_remove(struct i2c_client *client)
> > +{
> > +	struct kb3930 *priv = i2c_get_clientdata(client);
> > +
> > +	if (priv->off_gpios) {
> > +		if (pm_power_off == kb3930_power_off)
> > +			pm_power_off = NULL;
> > +		unregister_restart_handler(&kb3930_restart_nb);
> > +	}
> > +	global_kb3930 = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id kb3930_ids[] = {
> > +	{ "kb3930", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, kb3930_ids);
> 
> You can use .probe_new and omit this table.
> 
> > +static const struct of_device_id kb3930_dt_ids[] = {
> > +	{ .compatible = "ene,kb3930" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, kb3930_dt_ids);
> > +
> > +static struct i2c_driver kb3930_driver = {
> > +	.probe = kb3930_probe,
> > +	.remove = kb3930_remove,
> > +	.driver = {
> > +		.name = "ene-kb3930",
> > +		.of_match_table = of_match_ptr(kb3930_dt_ids),
> > +	},
> > +	.id_table = kb3930_ids,
> > +};
> > +
> > +module_i2c_driver(kb3930_driver);
> > +
> > +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
> > +MODULE_DESCRIPTION("ENE KB3930 Embedded Controller Driver");
> > +MODULE_LICENSE("Dual BSD/GPL");

Thanks
Lubo
