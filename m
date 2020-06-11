Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B92C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE852078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgFKLou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:44:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48294 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgFKLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:44:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 606B727FDD4
Subject: Re: [PATCH v5 2/2] regulator: Add driver for cros-ec-regulator
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200611082542.219516-1-pihsun@chromium.org>
 <20200611082542.219516-3-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e0a04440-bb15-921d-16e3-1b7ebd76b652@collabora.com>
Date:   Thu, 11 Jun 2020 13:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200611082542.219516-3-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

Thank you for your patch, one last change, sorry to not request it before.

On 11/6/20 10:25, Pi-Hsun Shih wrote:
> Add driver for cros-ec-regulator, representing a voltage regulator that
> is connected and controlled by ChromeOS EC, and is controlled by kernel
> with EC host commands.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v4:
> * Change compatible name from regulator-cros-ec to cros-ec-regulator.
> 
> Changes from v3:
> * Remove check around CONFIG_OF.
> * Add new host commands to cros_ec_trace.
> * Use devm_kstrdup for duping regulator name.
> * Change license header and add MODULE_AUTHOR.
> * Address review comments.
> 
> Changes from v2:
> * Add 'depends on OF' to Kconfig.
> * Add Kconfig description about compiling as module.
> 
> Changes from v1:
> * Change compatible string to google,regulator-cros-ec.
> * Use reg property in device tree.
> * Address comments on code styles.
> 
> This patch contains function cros_ec_cmd that is copied from the series:
> https://lore.kernel.org/patchwork/project/lkml/list/?series=428457.
> 
> I can't find the first patch in that v2 series, so the function is
> modified from v1 of that series according to reviewers comment:
> https://lore.kernel.org/patchwork/patch/1188110/
> 
> I copied the function instead of depending on that series since I feel
> the function is small enough, and the series has stalled for some time.
> ---
>  drivers/platform/chrome/cros_ec_trace.c       |   5 +

Could you split this patch in two, one for chrome-platform that introduces the
new commands (cros_ec_commands and cros_ec_trace) and another one with the
regulator driver.

>  drivers/regulator/Kconfig                     |  10 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/cros-ec-regulator.c         | 256 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  82 ++++++
>  5 files changed, 354 insertions(+)
>  create mode 100644 drivers/regulator/cros-ec-regulator.c
> 
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 523a39bd0ff6..425e9441b7ca 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -161,6 +161,11 @@
>  	TRACE_SYMBOL(EC_CMD_ADC_READ), \
>  	TRACE_SYMBOL(EC_CMD_ROLLBACK_INFO), \
>  	TRACE_SYMBOL(EC_CMD_AP_RESET), \
> +	TRACE_SYMBOL(EC_CMD_REGULATOR_GET_INFO), \
> +	TRACE_SYMBOL(EC_CMD_REGULATOR_ENABLE), \
> +	TRACE_SYMBOL(EC_CMD_REGULATOR_IS_ENABLED), \
> +	TRACE_SYMBOL(EC_CMD_REGULATOR_SET_VOLTAGE), \
> +	TRACE_SYMBOL(EC_CMD_REGULATOR_GET_VOLTAGE), \


Also make sure this is following the order generated by the command

  sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p'  \
          include/linux/platform_data/cros_ec_commands.h

after introduce the EC commands.

With that fixed you can add:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

on both patches.

Thanks,
 Enric


>  	TRACE_SYMBOL(EC_CMD_CR51_BASE), \
>  	TRACE_SYMBOL(EC_CMD_CR51_LAST), \
>  	TRACE_SYMBOL(EC_CMD_FP_PASSTHRU), \
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 8f677f5d79b4..c398e90e0e73 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -238,6 +238,16 @@ config REGULATOR_CPCAP
>  	  Say y here for CPCAP regulator found on some Motorola phones
>  	  and tablets such as Droid 4.
>  
> +config REGULATOR_CROS_EC
> +	tristate "ChromeOS EC regulators"
> +	depends on CROS_EC && OF
> +	help
> +	  This driver supports voltage regulators that is connected to ChromeOS
> +	  EC and controlled through EC host commands.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called cros-ec-regulator.
> +
>  config REGULATOR_DA903X
>  	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
>  	depends on PMIC_DA903X
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index e8f163371071..46592c160d22 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
>  obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
>  obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
>  obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
> +obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
>  obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
>  obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
>  obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
> diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
> new file mode 100644
> index 000000000000..830ceefc704a
> --- /dev/null
> +++ b/drivers/regulator/cros-ec-regulator.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright 2020 Google LLC.
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/slab.h>
> +
> +struct cros_ec_regulator_data {
> +	struct regulator_desc desc;
> +	struct regulator_dev *dev;
> +	struct cros_ec_device *ec_dev;
> +
> +	u32 index;
> +
> +	u16 *voltages_mV;
> +	u16 num_voltages;
> +};
> +
> +static int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
> +		       void *outdata, u32 outsize, void *indata, u32 insize)
> +{
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = version;
> +	msg->command = command;
> +	msg->outsize = outsize;
> +	msg->insize = insize;
> +
> +	if (outdata && outsize > 0)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret = cros_ec_cmd_xfer_status(ec, msg);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	if (insize)
> +		memcpy(indata, msg->data, insize);
> +
> +cleanup:
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int cros_ec_regulator_enable(struct regulator_dev *dev)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	struct ec_params_regulator_enable cmd = {
> +		.index = data->index,
> +		.enable = 1,
> +	};
> +
> +	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> +			  sizeof(cmd), NULL, 0);
> +}
> +
> +static int cros_ec_regulator_disable(struct regulator_dev *dev)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	struct ec_params_regulator_enable cmd = {
> +		.index = data->index,
> +		.enable = 0,
> +	};
> +
> +	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
> +			  sizeof(cmd), NULL, 0);
> +}
> +
> +static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	struct ec_params_regulator_is_enabled cmd = {
> +		.index = data->index,
> +	};
> +	struct ec_response_regulator_is_enabled resp;
> +	int ret;
> +
> +	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
> +			  sizeof(cmd), &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +	return resp.enabled;
> +}
> +
> +static int cros_ec_regulator_list_voltage(struct regulator_dev *dev,
> +					  unsigned int selector)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +
> +	if (selector >= data->num_voltages)
> +		return -EINVAL;
> +
> +	return data->voltages_mV[selector] * 1000;
> +}
> +
> +static int cros_ec_regulator_get_voltage(struct regulator_dev *dev)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	struct ec_params_regulator_get_voltage cmd = {
> +		.index = data->index,
> +	};
> +	struct ec_response_regulator_get_voltage resp;
> +	int ret;
> +
> +	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
> +			  sizeof(cmd), &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +	return resp.voltage_mv * 1000;
> +}
> +
> +static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
> +					 int max_uV, unsigned int *selector)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	int min_mV = DIV_ROUND_UP(min_uV, 1000);
> +	int max_mV = max_uV / 1000;
> +	struct ec_params_regulator_set_voltage cmd = {
> +		.index = data->index,
> +		.min_mv = min_mV,
> +		.max_mv = max_mV,
> +	};
> +
> +	/*
> +	 * This can happen when the given range [min_uV, max_uV] doesn't
> +	 * contain any voltage that can be represented exactly in mV.
> +	 */
> +	if (min_mV > max_mV)
> +		return -EINVAL;
> +	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
> +			   sizeof(cmd), NULL, 0);
> +}
> +
> +static struct regulator_ops cros_ec_regulator_voltage_ops = {
> +	.enable = cros_ec_regulator_enable,
> +	.disable = cros_ec_regulator_disable,
> +	.is_enabled = cros_ec_regulator_is_enabled,
> +	.list_voltage = cros_ec_regulator_list_voltage,
> +	.get_voltage = cros_ec_regulator_get_voltage,
> +	.set_voltage = cros_ec_regulator_set_voltage,
> +};
> +
> +static int cros_ec_regulator_init_info(struct device *dev,
> +				       struct cros_ec_regulator_data *data)
> +{
> +	struct ec_params_regulator_get_info cmd = {
> +		.index = data->index,
> +	};
> +	struct ec_response_regulator_get_info resp;
> +	int ret;
> +
> +	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
> +			   sizeof(cmd), &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	data->num_voltages =
> +		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
> +	data->voltages_mV =
> +		devm_kmemdup(dev, resp.voltages_mv,
> +			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
> +	data->desc.n_voltages = data->num_voltages;
> +
> +	/* Make sure the returned name is always a valid string */
> +	resp.name[sizeof(resp.name) - 1] = '\0';
> +	data->desc.name = devm_kstrdup(dev, resp.name, GFP_KERNEL);
> +	if (!data->desc.name)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int cros_ec_regulator_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct cros_ec_regulator_data *drvdata;
> +	struct regulator_init_data *init_data;
> +	struct regulator_config cfg = {};
> +	struct regulator_desc *desc;
> +	int ret;
> +
> +	drvdata = devm_kzalloc(
> +		&pdev->dev, sizeof(struct cros_ec_regulator_data), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->ec_dev = dev_get_drvdata(dev->parent);
> +	desc = &drvdata->desc;
> +
> +	init_data = of_get_regulator_init_data(dev, np, desc);
> +	if (!init_data)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "reg", &drvdata->index);
> +	if (ret < 0)
> +		return ret;
> +
> +	desc->owner = THIS_MODULE;
> +	desc->type = REGULATOR_VOLTAGE;
> +	desc->ops = &cros_ec_regulator_voltage_ops;
> +
> +	ret = cros_ec_regulator_init_info(dev, drvdata);
> +	if (ret < 0)
> +		return ret;
> +
> +	cfg.dev = &pdev->dev;
> +	cfg.init_data = init_data;
> +	cfg.driver_data = drvdata;
> +	cfg.of_node = np;
> +
> +	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
> +	if (IS_ERR(drvdata->dev)) {
> +		ret = PTR_ERR(drvdata->dev);
> +		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
> +		goto free_name;
> +	}
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	return 0;
> +
> +free_name:
> +	kfree(desc->name);
> +	return ret;
> +}
> +
> +static const struct of_device_id regulator_cros_ec_of_match[] = {
> +	{ .compatible = "google,cros-ec-regulator", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, regulator_cros_ec_of_match);
> +
> +static struct platform_driver cros_ec_regulator_driver = {
> +	.probe		= cros_ec_regulator_probe,
> +	.driver		= {
> +		.name		= "cros-ec-regulator",
> +		.of_match_table = regulator_cros_ec_of_match,
> +	},
> +};
> +
> +module_platform_driver(cros_ec_regulator_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC controlled regulator");
> +MODULE_AUTHOR("Pi-Hsun Shih <pihsun@chromium.org>");
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 69210881ebac..a417b51b5764 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5430,6 +5430,88 @@ struct ec_response_rollback_info {
>  /* Issue AP reset */
>  #define EC_CMD_AP_RESET 0x0125
>  
> +/*****************************************************************************/
> +/* Voltage regulator controls */
> +
> +/*
> + * Get basic info of voltage regulator for given index.
> + *
> + * Returns the regulator name and supported voltage list in mV.
> + */
> +#define EC_CMD_REGULATOR_GET_INFO 0x012B
> +
> +/* Maximum length of regulator name */
> +#define EC_REGULATOR_NAME_MAX_LEN 16
> +
> +/* Maximum length of the supported voltage list. */
> +#define EC_REGULATOR_VOLTAGE_MAX_COUNT 16
> +
> +struct ec_params_regulator_get_info {
> +	uint32_t index;
> +} __ec_align4;
> +
> +struct ec_response_regulator_get_info {
> +	char name[EC_REGULATOR_NAME_MAX_LEN];
> +	uint16_t num_voltages;
> +	uint16_t voltages_mv[EC_REGULATOR_VOLTAGE_MAX_COUNT];
> +} __ec_align1;
> +
> +/*
> + * Configure the regulator as enabled / disabled.
> + */
> +#define EC_CMD_REGULATOR_ENABLE 0x012C
> +
> +struct ec_params_regulator_enable {
> +	uint32_t index;
> +	uint8_t enable;
> +} __ec_align4;
> +
> +/*
> + * Query if the regulator is enabled.
> + *
> + * Returns 1 if the regulator is enabled, 0 if not.
> + */
> +#define EC_CMD_REGULATOR_IS_ENABLED 0x012D
> +
> +struct ec_params_regulator_is_enabled {
> +	uint32_t index;
> +} __ec_align4;
> +
> +struct ec_response_regulator_is_enabled {
> +	uint8_t enabled;
> +} __ec_align1;
> +
> +/*
> + * Set voltage for the voltage regulator within the range specified.
> + *
> + * The driver should select the voltage in range closest to min_mv.
> + *
> + * Also note that this might be called before the regulator is enabled, and the
> + * setting should be in effect after the regulator is enabled.
> + */
> +#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012E
> +
> +struct ec_params_regulator_set_voltage {
> +	uint32_t index;
> +	uint32_t min_mv;
> +	uint32_t max_mv;
> +} __ec_align4;
> +
> +/*
> + * Get the currently configured voltage for the voltage regulator.
> + *
> + * Note that this might be called before the regulator is enabled.
> + */
> +#define EC_CMD_REGULATOR_GET_VOLTAGE 0x012F
> +
> +struct ec_params_regulator_get_voltage {
> +	uint32_t index;
> +} __ec_align4;
> +
> +struct ec_response_regulator_get_voltage {
> +	uint32_t voltage_mv;
> +} __ec_align4;
> +
>  /*****************************************************************************/
>  /* The command range 0x200-0x2FF is reserved for Rotor. */
>  
> 
