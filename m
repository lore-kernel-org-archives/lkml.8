Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C2B206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYEGa+3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440765AbgDPH6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440152AbgDPH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:58:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:58:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so3624622wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=onqY/CtMRFigtCCfVO7e339lsDqDqGLthH5BJTma0rc=;
        b=eYEGa+3eCJR4DRGzJ+angkNeB0LKiOsVHak3E9DHPhyvG7bIXmFY/12TfloYLmWAYI
         NWvLwUhSO6wJZBdXZI2i/CKe0uTL1rBs+ATNqdJBK8nzhwB5M7vXLP5Js6XFGvQluDkX
         1P/lge23Uir0eopOJuw6LGjPBOEy+6iKSg4N/lm1WUqxO1+Kh5qJtGEU8ECvoUrG3ytm
         YKgKiBkLPr/4e94dk6PIDn2YkcGP3IjeiyNjHTtmGnKLslHdpSd8CAuMg73d7yD9e5Ow
         VQATgnXBQovA+VcUxpyeD4ygHpc74d7p6v5r1eVGO8Yjf96AgXBMcGzIC5iJSzbrpwVr
         Wy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=onqY/CtMRFigtCCfVO7e339lsDqDqGLthH5BJTma0rc=;
        b=YIGsG99Pat/vOiD8tfAQpUAT7dVkFn5JW9un3ZAvqfspKo+j/qtsSXHtuMQhbnzqZN
         seEosLneFCOrfw5rX6DXvKF7i5NygcNXMZaoHIV2RpV/IT4ZRqnNKd3yKWGM4VucAueN
         IdB/GMoXXPdFclxEWPsSqEp3kHisrsp7RkwUNCdzL6pD+p+IQXROo9O+Rkpm2hic2Vsr
         wBRfDuY6t65+Na4Ujzni45TGkY33RA46Qwm1+OTuXxsfnPOAy0lWHZn26YwtUqfTHrsi
         xv1uZRYm0NmDkzKZPM4yIsaiNYPHD7ue5H2DpNC/q/zbBuAPALsZjr3rr43WqBbpiNSa
         zneg==
X-Gm-Message-State: AGi0PuaMpSUQAe4CEP6Am1Bd+/dx/RAbYVXRg+w8gQg+Bj2kSA/4mSLZ
        BrXP7FRU7qzRAh1tieRrSGJy4Q==
X-Google-Smtp-Source: APiQypJYrIILo0R+wBjJzaYJ3TT0fUJSgretKkeMDgVqqNLNFgxiyJ2VIrfCqbEAGLUd38g+5LLBRw==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr8739410wrw.207.1587023923702;
        Thu, 16 Apr 2020 00:58:43 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id v7sm2497908wmg.3.2020.04.16.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 00:58:43 -0700 (PDT)
Date:   Thu, 16 Apr 2020 08:59:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200416075944.GU2167633@dell>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Apr 2020, Adam Thomson wrote:

> The current implementation performs checking in the i2c_probe()
> function of the variant_code but does this immediately after the
> containing struct has been initialised as all zero. This means the
> check for variant code will always default to using the BB tables
> and will never select AD. The variant code is subsequently set
> by device_init() and later used by the RTC so really it's a little
> fortunate this mismatch works.
> 
> This update adds raw I2C read access functionality to read the chip
> and variant/revision information (common to all revisions) so that
> it can subsequently correctly choose the proper regmap tables for
> real initialisation.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/mfd/da9063-core.c            |  31 -------
>  drivers/mfd/da9063-i2c.c             | 162 +++++++++++++++++++++++++++++++----
>  include/linux/mfd/da9063/registers.h |  15 ++--
>  3 files changed, 155 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index b125f90d..a353d52 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -160,7 +160,6 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
>  
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
> -	int model, variant_id, variant_code;
>  	int ret;
>  
>  	ret = da9063_clear_fault_log(da9063);
> @@ -171,36 +170,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  	da9063->irq_base = -1;
>  	da9063->chip_irq = irq;
>  
> -	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_ID, &model);
> -	if (ret < 0) {
> -		dev_err(da9063->dev, "Cannot read chip model id.\n");
> -		return -EIO;
> -	}
> -	if (model != PMIC_CHIP_ID_DA9063) {
> -		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
> -		return -ENODEV;
> -	}
> -
> -	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_VARIANT, &variant_id);
> -	if (ret < 0) {
> -		dev_err(da9063->dev, "Cannot read chip variant id.\n");
> -		return -EIO;
> -	}
> -
> -	variant_code = variant_id >> DA9063_CHIP_VARIANT_SHIFT;
> -
> -	dev_info(da9063->dev,
> -		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
> -		 model, variant_id);
> -
> -	if (variant_code < PMIC_DA9063_BB && variant_code != PMIC_DA9063_AD) {
> -		dev_err(da9063->dev,
> -			"Cannot support variant code: 0x%02X\n", variant_code);
> -		return -ENODEV;
> -	}
> -
> -	da9063->variant_code = variant_code;
> -
>  	ret = da9063_irq_init(da9063);
>  	if (ret) {
>  		dev_err(da9063->dev, "Cannot initialize interrupts.\n");
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 455de74..2654b49 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -22,12 +22,102 @@
>  #include <linux/of.h>
>  #include <linux/regulator/of_regulator.h>
>  
> +/*
> + * Raw I2C access required for just accessing chip and variant info before we
> + * know which device is present. The info read from the device using this
> + * approach is then used to select the correct regmap tables.
> + */
> +static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
> +				    u8 *buf, int count)
> +{
> +	struct i2c_msg xfer[3];
> +	u8 page_num, paged_addr;
> +	u8 page_buf[2];
> +	int ret;
> +
> +	/* Determine page info based on register address */
> +	page_num = (addr / 0x100);

Please define magic numbers.

> +	if (page_num > 1)

Please define magic numbers.

> +		return -EINVAL;

Do you want to fail silently here?

> +	paged_addr = (addr % 0x100) & 0xFF;
> +	page_buf[0] = DA9063_REG_PAGE_CON;
> +	page_buf[1] = (page_num << DA9063_I2C_PAGE_SEL_SHIFT) &
> +		      DA9063_REG_PAGE_MASK;
> +
> +	/* Write reg address, page selection */
> +	xfer[0].addr = client->addr;
> +	xfer[0].flags = 0;
> +	xfer[0].len = 2;
> +	xfer[0].buf = page_buf;
> +
> +	/* Select register address */
> +	xfer[1].addr = client->addr;
> +	xfer[1].flags = 0;
> +	xfer[1].len = 1;
> +	xfer[1].buf = &paged_addr;
> +
> +	/* Read data */
> +	xfer[2].addr = client->addr;
> +	xfer[2].flags = I2C_M_RD;
> +	xfer[2].len = count;
> +	xfer[2].buf = buf;
> +
> +	ret = i2c_transfer(client->adapter, xfer, 3);

Why is this 3?  'count' and a NULL char?

> +	if (ret == 3)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;

I think the following makes it slightly clearer.

	if (ret < 0)
		return ret;

	if (ret == 3)
		return 0;
	else
		return -EIO;

> +}
> +
> +enum {
> +	DA9063_DEV_ID_REG = 0,
> +	DA9063_VAR_ID_REG,
> +	DA9063_CHIP_ID_REGS,
> +};
> +
> +static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
> +{
> +	int ret;
> +	u8 buf[DA9063_CHIP_ID_REGS];

Really small nit: Could you reverse these please.

> +	ret = da9063_i2c_blockreg_read(i2c, DA9063_REG_DEVICE_ID, buf,
> +				       DA9063_CHIP_ID_REGS);
> +	if (ret < 0) {

if (ret)

Or better yet, as this is a read function, you could just return
i2c_transfer() and do the appropriate error checking here *instead*.

> +		dev_err(da9063->dev, "Cannot read chip id info.\n");
> +		return ret;
> +	}
> +
> +	if (buf[DA9063_DEV_ID_REG] != PMIC_CHIP_ID_DA9063) {
> +		dev_err(da9063->dev,
> +			"Invalid chip device id: 0x%02x\n",

s/id/ID/

> +			buf[DA9063_DEV_ID_REG]);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(da9063->dev,
> +		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
> +		 buf[DA9063_DEV_ID_REG], buf[DA9063_VAR_ID_REG]);
> +
> +	da9063->variant_code =
> +		(buf[DA9063_VAR_ID_REG] & DA9063_VARIANT_ID_MRC_MASK)
> +		>> DA9063_VARIANT_ID_MRC_SHIFT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Variant specific regmap configs
> + */
> +
>  static const struct regmap_range da9063_ad_readable_ranges[] = {
>  	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
>  	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
>  	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
>  	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
> -	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
> +	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
>  };
>  
>  static const struct regmap_range da9063_ad_writeable_ranges[] = {
> @@ -72,7 +162,7 @@
>  	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
>  	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
>  	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
> -	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
> +	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
>  };
>  
>  static const struct regmap_range da9063_bb_writeable_ranges[] = {
> @@ -117,7 +207,7 @@
>  	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
>  	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
>  	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
> -	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
> +	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
>  };
>  
>  static const struct regmap_range da9063l_bb_writeable_ranges[] = {
> @@ -159,7 +249,7 @@
>  static const struct regmap_range_cfg da9063_range_cfg[] = {
>  	{
>  		.range_min = DA9063_REG_PAGE_CON,
> -		.range_max = DA9063_REG_CHIP_VARIANT,
> +		.range_max = DA9063_REG_CONFIG_ID,
>  		.selector_reg = DA9063_REG_PAGE_CON,
>  		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
>  		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
> @@ -173,7 +263,7 @@
>  	.val_bits = 8,
>  	.ranges = da9063_range_cfg,
>  	.num_ranges = ARRAY_SIZE(da9063_range_cfg),
> -	.max_register = DA9063_REG_CHIP_VARIANT,
> +	.max_register = DA9063_REG_CONFIG_ID,
>  
>  	.cache_type = REGCACHE_RBTREE,
>  };
> @@ -199,18 +289,56 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  	da9063->chip_irq = i2c->irq;
>  	da9063->type = id->driver_data;
>  
> -	if (da9063->variant_code == PMIC_DA9063_AD) {
> -		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
> -		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
> -		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
> -	} else if (da9063->type == PMIC_TYPE_DA9063L) {
> -		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
> -		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
> -		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
> -	} else {
> -		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
> -		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
> -		da9063_regmap_config.volatile_table = &da9063_bb_volatile_table;
> +	ret = da9063_get_device_type(i2c, da9063);
> +	if (ret < 0)

Is a positive return value valid?

If not: if (ret)

> +		return ret;
> +
> +	switch (da9063->type) {
> +	case PMIC_TYPE_DA9063:
> +		switch (da9063->variant_code) {
> +		case PMIC_DA9063_AD:
> +			da9063_regmap_config.rd_table =
> +				&da9063_ad_readable_table;
> +			da9063_regmap_config.wr_table =
> +				&da9063_ad_writeable_table;
> +			da9063_regmap_config.volatile_table =
> +				&da9063_ad_volatile_table;
> +			break;
> +		case PMIC_DA9063_BB:
> +		case PMIC_DA9063_CA:
> +			da9063_regmap_config.rd_table =
> +				&da9063_bb_readable_table;
> +			da9063_regmap_config.wr_table =
> +				&da9063_bb_writeable_table;
> +			da9063_regmap_config.volatile_table =
> +				&da9063_bb_volatile_table;
> +			break;
> +		default:
> +			dev_err(da9063->dev,
> +				"Chip variant not supported for DA9063\n");
> +			return -ENODEV;
> +		}
> +		break;
> +	case PMIC_TYPE_DA9063L:
> +		switch (da9063->variant_code) {
> +		case PMIC_DA9063_BB:
> +		case PMIC_DA9063_CA:
> +			da9063_regmap_config.rd_table =
> +				&da9063l_bb_readable_table;
> +			da9063_regmap_config.wr_table =
> +				&da9063l_bb_writeable_table;
> +			da9063_regmap_config.volatile_table =
> +				&da9063l_bb_volatile_table;
> +			break;
> +		default:
> +			dev_err(da9063->dev,
> +				"Chip variant not supported for DA9063L\n");
> +			return -ENODEV;
> +		}
> +		break;
> +	default:
> +		dev_err(da9063->dev, "Chip type not supported\n");
> +		return -ENODEV;
>  	}
>  
>  	da9063->regmap = devm_regmap_init_i2c(i2c, &da9063_regmap_config);
> diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
> index ba706b0..1dbabf1 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -292,8 +292,10 @@
>  #define	DA9063_BB_REG_GP_ID_19		0x134
>  
>  /* Chip ID and variant */
> -#define	DA9063_REG_CHIP_ID		0x181
> -#define	DA9063_REG_CHIP_VARIANT		0x182
> +#define	DA9063_REG_DEVICE_ID		0x181
> +#define	DA9063_REG_VARIANT_ID		0x182
> +#define	DA9063_REG_CUSTOMER_ID		0x183
> +#define	DA9063_REG_CONFIG_ID		0x184
>  
>  /*
>   * PMIC registers bits
> @@ -929,9 +931,6 @@
>  #define	DA9063_RTC_CLOCK			0x40
>  #define	DA9063_OUT_32K_EN			0x80
>  
> -/* DA9063_REG_CHIP_VARIANT */
> -#define	DA9063_CHIP_VARIANT_SHIFT		4
> -
>  /* DA9063_REG_BUCK_ILIM_A (addr=0x9A) */
>  #define DA9063_BIO_ILIM_MASK			0x0F
>  #define DA9063_BMEM_ILIM_MASK			0xF0
> @@ -1065,4 +1064,10 @@
>  #define		DA9063_MON_A10_IDX_LDO9		0x04
>  #define		DA9063_MON_A10_IDX_LDO10	0x05
>  
> +/* DA9063_REG_VARIANT_ID (addr=0x182) */
> +#define	DA9063_VARIANT_ID_VRC_SHIFT		0
> +#define DA9063_VARIANT_ID_VRC_MASK		0x0F
> +#define	DA9063_VARIANT_ID_MRC_SHIFT		4
> +#define DA9063_VARIANT_ID_MRC_MASK		0xF0
> +
>  #endif /* _DA9063_REG_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
