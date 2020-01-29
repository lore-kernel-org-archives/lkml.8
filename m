Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2C6206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+tS/4in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgA2UyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:54:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39565 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgA2UyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:54:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so422769plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SetlGjcs2eimkiNhUaoJyp0+8Sb8F/WcsSc/6o4q4JM=;
        b=W+tS/4inI0hBlVLXrAKdrQwrth74N8YEjh/+d99SxGMrEmTr+fouT6MCeoFZWaS0Mg
         Oz1l622P3JCEeQsEioxBPTQBLgNR6lvrIBoMk3DBCMu9+UQKl0Csvz70bGrJNAfMczbC
         eIftku0gek1NVu5rgrT3A2rcIfXf8QowKek5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SetlGjcs2eimkiNhUaoJyp0+8Sb8F/WcsSc/6o4q4JM=;
        b=BGQ2cZeyCzJbiViExBuPZja02fChJs1CiiI43Go7Z1pBEGVAOG6B2q1+onI7ZHMWl4
         X2CEhUHqIAg/oobcaJcR3kTDnMHhcK4oif46HzA2JRhu3NnRo2GOeTNloIc0eeeLs66y
         uAiDV+GayHpaMECo3VDFZbiW+easdWYMpcC7Et9Jzv+PdnaIAH1/kKNtB4u3os4FZ4lb
         Wzj3XrCq0USAGsCR+An43eJVVZXOUNu2LhuYUBpEi0FUQf3ivnuwVctjUXS/ez+UwRhc
         7CFvCwIkoZvaxY/LpJn0CLgT5QLHojKSlyzvvTdnnPG6F46nxGbcdAj30k8qd5HUaxIF
         /aEA==
X-Gm-Message-State: APjAAAWq7Q3G+r+Wy7RVBbqJF4c1kKdntci2ocjcUAZCbIV+gP3DPK0a
        R6Dw5Q8JjcrE/6xz39fB7mQjIg==
X-Google-Smtp-Source: APXvYqwWkyXMTTU0cJo/KOulr9iATkubvmxpKoXAmZZF+YBhYzfzQ9Omzgoh8zO2Jx7NvSZ1KcVV5A==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr1820126pjo.58.1580331252256;
        Wed, 29 Jan 2020 12:54:12 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id x21sm3717782pfq.76.2020.01.29.12.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:54:11 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:54:10 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/8] phy: qcom-qusb2: Add support for overriding
 tuning parameters in QUSB2 V2 PHY
Message-ID: <20200129205410.GF71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-6-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-6-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Wed, Jan 29, 2020 at 07:21:56PM +0530, Sandeep Maheswaram wrote:
> Added new structure for overriding tuning parameters in QUSB2 V2 PHY as the
> override params are increased due to usage of generic QUSB2 V2 phy table.
> Also added bias-ctrl-value,charge-ctrl-value and hsdisc-trim-value params.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 125 +++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 70c9da6..f45fda3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -66,6 +66,14 @@
>  #define IMP_RES_OFFSET_MASK			GENMASK(5, 0)
>  #define IMP_RES_OFFSET_SHIFT			0x0
>  
> +/* QUSB2PHY_PLL_BIAS_CONTROL_2 register bits */
> +#define BIAS_CTRL2_RES_OFFSET_MASK		GENMASK(5, 0)
> +#define BIAS_CTRL2_RES_OFFSET_SHIFT		0x0
> +
> +/* QUSB2PHY_CHG_CONTROL_2 register bits */
> +#define CHG_CTRL2_OFFSET_MASK			GENMASK(5, 4)
> +#define CHG_CTRL2_OFFSET_SHIFT			0x4
> +
>  /* QUSB2PHY_PORT_TUNE1 register bits */
>  #define HSTX_TRIM_MASK				GENMASK(7, 4)
>  #define HSTX_TRIM_SHIFT				0x4
> @@ -73,6 +81,10 @@
>  #define PREEMPHASIS_EN_MASK			GENMASK(1, 0)
>  #define PREEMPHASIS_EN_SHIFT			0x0
>  
> +/* QUSB2PHY_PORT_TUNE2 register bits */
> +#define HSDISC_TRIM_MASK			GENMASK(1, 0)
> +#define HSDISC_TRIM_SHIFT			0x0
> +
>  #define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO	0x04
>  #define QUSB2PHY_PLL_CLOCK_INVERTERS		0x18c
>  #define QUSB2PHY_PLL_CMODE			0x2c
> @@ -277,6 +289,34 @@ static const char * const qusb2_phy_vreg_names[] = {
>  
>  #define QUSB2_NUM_VREGS		ARRAY_SIZE(qusb2_phy_vreg_names)
>  
> +/* struct override_param - structure holding qusb2 v2 phy overriding param
> + * set override true if the  device tree property exists and read and assign
> + * to value
> + */
> +struct override_param {
> +	bool override;
> +	u8 value;
> +};
> +
> +/*struct override_params - structure holding qusb2 v2 phy overriding params
> + * @imp_res_offset: rescode offset to be updated in IMP_CTRL1 register
> + * @hstx_trim: HSTX_TRIM to be updated in TUNE1 register
> + * @preemphasis: Amplitude Pre-Emphasis to be updated in TUNE1 register
> + * @preemphasis_width: half/full-width Pre-Emphasis updated via TUNE1
> + * @bias_ctrl: bias ctrl to be updated in BIAS_CONTROL_2 register
> + * @charge_ctrl: charge ctrl to be updated in CHG_CTRL2 register
> + * @hsdisc_trim: disconnect threshold to be updated in TUNE2 register
> + */
> +struct override_params {
> +	struct override_param imp_res_offset;
> +	struct override_param hstx_trim;
> +	struct override_param preemphasis;
> +	struct override_param preemphasis_width;

ideally the refactoring (struct override_param(s)) and the support for
the new override paramters would be in two separate patches, which would
make it easier to review the different steps.

> +	struct override_param bias_ctrl;
> +	struct override_param charge_ctrl;
> +	struct override_param hsdisc_trim;
> +};
> +
>  /**
>   * struct qusb2_phy - structure holding qusb2 phy attributes
>   *
> @@ -292,20 +332,15 @@ static const char * const qusb2_phy_vreg_names[] = {
>   * @tcsr: TCSR syscon register map
>   * @cell: nvmem cell containing phy tuning value
>   *
> - * @override_imp_res_offset: PHY should use different rescode offset
> - * @imp_res_offset_value: rescode offset to be updated in IMP_CTRL1 register
> - * @override_hstx_trim: PHY should use different HSTX o/p current value
> - * @hstx_trim_value: HSTX_TRIM value to be updated in TUNE1 register
> - * @override_preemphasis: PHY should use different pre-amphasis amplitude
> - * @preemphasis_level: Amplitude Pre-Emphasis to be updated in TUNE1 register
> - * @override_preemphasis_width: PHY should use different pre-emphasis duration
> - * @preemphasis_width: half/full-width Pre-Emphasis updated via TUNE1
> + * @overrides: pointer to structure for all overriding tuning params
>   *
>   * @cfg: phy config data
>   * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
>   * @phy_initialized: indicate if PHY has been initialized
>   * @mode: current PHY mode
>   */
> +
> +
>  struct qusb2_phy {
>  	struct phy *phy;
>  	void __iomem *base;
> @@ -319,14 +354,7 @@ struct qusb2_phy {
>  	struct regmap *tcsr;
>  	struct nvmem_cell *cell;
>  
> -	bool override_imp_res_offset;
> -	u8 imp_res_offset_value;
> -	bool override_hstx_trim;
> -	u8 hstx_trim_value;
> -	bool override_preemphasis;
> -	u8 preemphasis_level;
> -	bool override_preemphasis_width;
> -	u8 preemphasis_width;
> +	struct override_params overrides;
>  
>  	const struct qusb2_phy_cfg *cfg;
>  	bool has_se_clk_scheme;
> @@ -395,23 +423,33 @@ static void qusb2_phy_override_phy_params(struct qusb2_phy *qphy)
>  {
>  	const struct qusb2_phy_cfg *cfg = qphy->cfg;
>  
> -	if (qphy->override_imp_res_offset)
> +	if (qphy->overrides.imp_res_offset.override)

you could consider introducing a local variable 'struct override_params
overrides *or' and assign it to &qphy->overrides, which would make
accessing the overrides slightly less clunky.

>  		qusb2_write_mask(qphy->base, QUSB2PHY_IMP_CTRL1,
> -			     qphy->imp_res_offset_value << IMP_RES_OFFSET_SHIFT,
> +		qphy->overrides.imp_res_offset.value << IMP_RES_OFFSET_SHIFT,
>  			     IMP_RES_OFFSET_MASK);
>  
> -	if (qphy->override_hstx_trim)
> +	if (qphy->overrides.bias_ctrl.override)
> +		qusb2_write_mask(qphy->base, QUSB2PHY_PLL_BIAS_CONTROL_2,
> +		qphy->overrides.bias_ctrl.value << BIAS_CTRL2_RES_OFFSET_SHIFT,
> +			   BIAS_CTRL2_RES_OFFSET_MASK);
> +
> +	if (qphy->overrides.charge_ctrl.override)
> +		qusb2_write_mask(qphy->base, QUSB2PHY_CHG_CTRL2,
> +		qphy->overrides.charge_ctrl.value << CHG_CTRL2_OFFSET_SHIFT,
> +			     CHG_CTRL2_OFFSET_MASK);
> +
> +	if (qphy->overrides.hstx_trim.override)
>  		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> -				 qphy->hstx_trim_value << HSTX_TRIM_SHIFT,
> +		qphy->overrides.hstx_trim.value << HSTX_TRIM_SHIFT,
>  				 HSTX_TRIM_MASK);
>  
> -	if (qphy->override_preemphasis)
> +	if (qphy->overrides.preemphasis.override)
>  		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> -				qphy->preemphasis_level << PREEMPHASIS_EN_SHIFT,
> +		qphy->overrides.preemphasis.value << PREEMPHASIS_EN_SHIFT,
>  				PREEMPHASIS_EN_MASK);
>  
> -	if (qphy->override_preemphasis_width) {
> -		if (qphy->preemphasis_width ==
> +	if (qphy->overrides.preemphasis_width.override) {
> +		if (qphy->overrides.preemphasis_width.value ==
>  		    QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT)
>  			qusb2_setbits(qphy->base,
>  				      cfg->regs[QUSB2PHY_PORT_TUNE1],
> @@ -421,6 +459,11 @@ static void qusb2_phy_override_phy_params(struct qusb2_phy *qphy)
>  				      cfg->regs[QUSB2PHY_PORT_TUNE1],
>  				      PREEMPH_WIDTH_HALF_BIT);
>  	}
> +
> +	if (qphy->overrides.hsdisc_trim.override)
> +		qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
> +		qphy->overrides.hsdisc_trim.value << HSDISC_TRIM_SHIFT,
> +				 HSDISC_TRIM_MASK);
>  }
>  
>  /*
> @@ -864,26 +907,44 @@ static int qusb2_phy_probe(struct platform_device *pdev)
>  
>  	if (!of_property_read_u32(dev->of_node, "qcom,imp-res-offset-value",
>  				  &value)) {
> -		qphy->imp_res_offset_value = (u8)value;
> -		qphy->override_imp_res_offset = true;
> +		qphy->overrides.imp_res_offset.value = (u8)value;

same as above, consider whether 'or->imp_res_offset.value' is an improvement.

> +		qphy->overrides.imp_res_offset.override = true;
> +	}
> +
> +	if (!of_property_read_u32(dev->of_node, "qcom,bias-ctrl-value",
> +				  &value)) {
> +		qphy->overrides.bias_ctrl.value = (u8)value;
> +		qphy->overrides.bias_ctrl.override = true;
> +	}
> +
> +	if (!of_property_read_u32(dev->of_node, "qcom,charge-ctrl-value",
> +				  &value)) {
> +		qphy->overrides.charge_ctrl.value = (u8)value;
> +		qphy->overrides.charge_ctrl.override = true;
>  	}
>  
>  	if (!of_property_read_u32(dev->of_node, "qcom,hstx-trim-value",
>  				  &value)) {
> -		qphy->hstx_trim_value = (u8)value;
> -		qphy->override_hstx_trim = true;
> +		qphy->overrides.hstx_trim.value = (u8)value;
> +		qphy->overrides.hstx_trim.override = true;
>  	}
>  
>  	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-level",
>  				     &value)) {
> -		qphy->preemphasis_level = (u8)value;
> -		qphy->override_preemphasis = true;
> +		qphy->overrides.preemphasis.value = (u8)value;
> +		qphy->overrides.preemphasis.override = true;
>  	}
>  
>  	if (!of_property_read_u32(dev->of_node, "qcom,preemphasis-width",
>  				     &value)) {
> -		qphy->preemphasis_width = (u8)value;
> -		qphy->override_preemphasis_width = true;
> +		qphy->overrides.preemphasis_width.value = (u8)value;
> +		qphy->overrides.preemphasis_width.override = true;
> +	}
> +
> +	if (!of_property_read_u32(dev->of_node, "qcom,hsdisc-trim-value",
> +				  &value)) {
> +		qphy->overrides.hsdisc_trim.value = (u8)value;
> +		qphy->overrides.hsdisc_trim.override = true;
>  	}
>  
>  	pm_runtime_set_active(dev);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
