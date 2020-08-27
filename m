Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF0AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2566620738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgH0JDJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0JDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:03:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430FC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:03:08 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kBDoC-0002xt-8J; Thu, 27 Aug 2020 11:03:00 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kBDoA-0006g5-NR; Thu, 27 Aug 2020 11:02:58 +0200
Message-ID: <8d3045b22bf9524eba9dddf1ff470858d4b748be.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Date:   Thu, 27 Aug 2020 11:02:58 +0200
In-Reply-To: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
         <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

On Thu, 2020-08-27 at 00:14 +0530, Manish Narani wrote:
> Add a new driver for supporting Xilinx platforms. This driver handles
> the USB 3.0 PHY initialization and PIPE control & reset operations for
> ZynqMP platforms. This also handles the USB 2.0 PHY initialization and
> reset operations for Versal platforms.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
[...]
> +static int dwc3_xlnx_rst_assert(struct reset_control *rstc)
> +{
> +	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT);
> +	unsigned long timeout;
> +
> +	reset_control_assert(rstc);
> +
> +	/* wait until reset is asserted or timeout */
> +	timeout = jiffies + loop_time;
> +
> +	while (!time_after_eq(jiffies, timeout)) {
> +		if (reset_control_status(rstc) > 0)
> +			return 0;
> +
> +		cpu_relax();
> +	}
> +
> +	return -ETIMEDOUT;
> +}

I think this should be done in the reset controller driver instead.

When reset_control_assert() is called with an exclusive reset control,
the reset line should be already asserted when the function returns.

> +
> +static int dwc3_xlnx_rst_deassert(struct reset_control *rstc)
> +{
> +	unsigned long loop_time = msecs_to_jiffies(RST_TIMEOUT);
> +	unsigned long timeout;
> +
> +	reset_control_deassert(rstc);
> +
> +	/* wait until reset is de-asserted or timeout */
> +	timeout = jiffies + loop_time;
> +	while (!time_after_eq(jiffies, timeout)) {
> +		if (!reset_control_status(rstc))
> +			return 0;
> +
> +		cpu_relax();
> +	}
> +
> +	return -ETIMEDOUT;
> +}

Same as above, this belongs in the reset controller driver.

> +static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> +{
> +	struct device *dev = priv_data->dev;
> +	int ret;
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, false);
> +
> +	/* Assert and De-assert reset */
> +	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_ASSERT);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to assert Reset\n");
> +		return ret;
> +	}
> +
> +	ret = zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_RELEASE);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to De-assert Reset\n");
> +		return ret;
> +	}
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, true);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> +{
> +	struct device *dev = priv_data->dev;
> +	int ret;
> +	u32 reg;
> +
> +	priv_data->crst = devm_reset_control_get(dev, "usb_crst");

Please use devm_reset_control_get_exclusive() instead.

> +	if (IS_ERR(priv_data->crst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_crst");

Consider using dev_err_probe() to hide -EPROBE_DEFER error values.

> +		ret = PTR_ERR(priv_data->crst);
> +		goto err;
> +	}
> +
> +	priv_data->hibrst = devm_reset_control_get(dev, "usb_hibrst");
> +	if (IS_ERR(priv_data->hibrst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_hibrst");
> +		ret = PTR_ERR(priv_data->hibrst);
> +		goto err;
> +	}
> +
> +	priv_data->apbrst = devm_reset_control_get(dev, "usb_apbrst");
> +	if (IS_ERR(priv_data->apbrst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_apbrst");
> +		ret = PTR_ERR(priv_data->apbrst);
> +		goto err;
> +	}

Same as above for the other two reset controls.

> +	priv_data->usb3_phy = devm_phy_get(dev, "usb3-phy");
> +
> +	ret = dwc3_xlnx_rst_assert(priv_data->crst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret = dwc3_xlnx_rst_assert(priv_data->hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret = dwc3_xlnx_rst_assert(priv_data->apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret = phy_init(priv_data->usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(priv_data->usb3_phy);
> +		goto err;
> +	}
> +
> +	ret = dwc3_xlnx_rst_deassert(priv_data->apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to release reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	/* Set PIPE power present signal */
> +	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
> +
> +	/* Clear PIPE CLK signal */
> +	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
> +
> +	ret = dwc3_xlnx_rst_deassert(priv_data->crst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to release reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret = dwc3_xlnx_rst_deassert(priv_data->hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to release reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret = phy_power_on(priv_data->usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(priv_data->usb3_phy);
> +		goto err;
> +	}
> +
> +	/*
> +	 * This routes the usb dma traffic to go through CCI path instead
> +	 * of reaching DDR directly. This traffic routing is needed to
> +	 * make SMMU and CCI work with USB dma.
> +	 */
> +	if (of_dma_is_coherent(dev->of_node) || dev->iommu_group) {
> +		reg = readl(priv_data->regs + XLNX_USB_COHERENCY);
> +		reg |= XLNX_USB_COHERENCY_ENABLE;
> +		writel(reg, priv_data->regs + XLNX_USB_COHERENCY);
> +	}
> +
> +err:
> +	return ret;
> +}
> +
> +static int dwc3_xlnx_probe(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx	*priv_data;
> +	struct device		*dev = &pdev->dev;
> +	struct device_node	*np = dev->of_node;
> +	struct resource		*res;
> +	void __iomem		*regs;
> +	int			ret;
> +
> +	priv_data = devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing memory resource\n");
> +		return -ENODEV;
> +	}
> +
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	/* Store the usb control regs into priv_data for further usage */
> +	priv_data->regs = regs;
> +
> +	priv_data->dev = dev;
> +
> +	platform_set_drvdata(pdev, priv_data);
> +
> +	ret = clk_bulk_get_all(priv_data->dev, &priv_data->clks);

Why not use devm_clk_bulk_get_all()?

regards
Philipp
