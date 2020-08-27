Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C90C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47BA22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598509909;
	bh=6r8scz/B4zJ+eab3C0oFgJGJYu2HR8tzI8ccby4galo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=2Gusl3sderzd+Ng4TRoYTv5ylJIYLboKaGQRhU6l/zF+3rTD2QhsAq/A9SsaGjz8I
	 LQIxMwa89AgDsYkD6MjTwW4mmQe12Wk0ogL9MuEm+KQO+V7K1DGrMpPtAtk/x0e0WJ
	 xCDM/Dh6cUCekt/ob9ciI1kdKcgAToR9UtAb/TLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH0Gbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Gbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:31:47 -0400
Received: from saruman (unknown [194.34.132.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C491207BC;
        Thu, 27 Aug 2020 06:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598509906;
        bh=6r8scz/B4zJ+eab3C0oFgJGJYu2HR8tzI8ccby4galo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jYYI2ZSk7iOYLAxd22HsPL+zquEeKyYYBQZ952id006X10brzyYc/rhTS4+5gOO8z
         v42Rv0l4AkH+BlKcqWlXNtQwsq/xwHI6sF3JTATDZWSVnDRM0+i/FYfGIW7bj21L6E
         j7Tw2jsaYb05kLmiywawoZBIh07oNcPrpb0nadx8=
From:   Felipe Balbi <balbi@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
In-Reply-To: <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
Date:   Thu, 27 Aug 2020 09:31:30 +0300
Message-ID: <87y2m0ioql.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Manish Narani <manish.narani@xilinx.com> writes:

> Add a new driver for supporting Xilinx platforms. This driver handles
> the USB 3.0 PHY initialization and PIPE control & reset operations for

PHY initialization should be done as part of a drivers/phy driver.

> ZynqMP platforms. This also handles the USB 2.0 PHY initialization and
> reset operations for Versal platforms.

similarly for USB2 PHYs

> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilin=
x.c
> new file mode 100644
> index 000000000000..272906797a7a
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> + *
> + * Authors: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> + *          Manish Narani <manish.narani@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/of_address.h>
> +#include <linux/delay.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/io.h>
> +
> +#include <linux/phy/phy.h>
> +
> +/* USB phy reset mask register */
> +#define XLNX_USB_PHY_RST		0x001C
> +#define XLNX_PHY_RST_MASK		0x1
> +
> +/* Xilinx USB 3.0 IP Register */
> +#define XLNX_USB_COHERENCY		0x005C
> +#define XLNX_USB_COHERENCY_ENABLE	0x1
> +
> +/* Versal USB Reset ID */
> +#define VERSAL_USB_RESET_ID		0xC104036
> +
> +#define PIPE_CLK_OFFSET			0x7c
> +#define PIPE_CLK_ON			1
> +#define PIPE_CLK_OFF			0
> +#define PIPE_POWER_OFFSET		0x80
> +#define PIPE_POWER_ON			1
> +#define PIPE_POWER_OFF			0
> +
> +#define RST_TIMEOUT			1000
> +
> +struct dwc3_xlnx {
> +	int				num_clocks;
> +	struct clk_bulk_data		*clks;
> +	struct device			*dev;
> +	void __iomem			*regs;
> +	struct dwc3			*dwc;
> +	struct phy			*phy;
> +	struct phy			*usb3_phy;
> +	struct reset_control		*crst;
> +	struct reset_control		*hibrst;
> +	struct reset_control		*apbrst;
> +};
> +
> +static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mas=
k)
> +{
> +	u32 reg;
> +
> +	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST);
> +
> +	if (mask)
> +		/*
> +		 * Mask the phy reset signal from comtroller

s/comtroller/controller

But really, the comments don't bring any extra information. I'd say
remove the comments as the code speaks for itself very clearly in this
case.

> +static int dwc3_xlnx_rst_assert(struct reset_control *rstc)

this looks like it should be an actual reset controller driver.

> +static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> +{
> +	struct device *dev =3D priv_data->dev;
> +	int ret;
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, false);
> +
> +	/* Assert and De-assert reset */
> +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_ASSERT);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to assert Reset\n");
> +		return ret;
> +	}
> +
> +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
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
> +	struct device *dev =3D priv_data->dev;
> +	int ret;
> +	u32 reg;
> +
> +	priv_data->crst =3D devm_reset_control_get(dev, "usb_crst");
> +	if (IS_ERR(priv_data->crst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_crst");
> +		ret =3D PTR_ERR(priv_data->crst);
> +		goto err;
> +	}
> +
> +	priv_data->hibrst =3D devm_reset_control_get(dev, "usb_hibrst");
> +	if (IS_ERR(priv_data->hibrst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_hibrst");
> +		ret =3D PTR_ERR(priv_data->hibrst);
> +		goto err;
> +	}
> +
> +	priv_data->apbrst =3D devm_reset_control_get(dev, "usb_apbrst");
> +	if (IS_ERR(priv_data->apbrst)) {
> +		dev_err(dev, "failed to get %s reset signal\n", "usb_apbrst");
> +		ret =3D PTR_ERR(priv_data->apbrst);
> +		goto err;
> +	}
> +
> +	priv_data->usb3_phy =3D devm_phy_get(dev, "usb3-phy");
> +
> +	ret =3D dwc3_xlnx_rst_assert(priv_data->crst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);

you don't need the function name or the line number here. Just improve
your error message a bit:

		dev_err(dev, "Failed to assert usb3-phy reset\n");

> +		goto err;
> +	}
> +
> +	ret =3D dwc3_xlnx_rst_assert(priv_data->hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);

		dev_err(dev, "Failed to assert hibernation reset\n");

> +		goto err;
> +	}
> +
> +	ret =3D dwc3_xlnx_rst_assert(priv_data->apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> +			__func__, __LINE__);

		dev_err(dev, "Failed to assert APB reset\n");

> +		goto err;
> +	}
> +
> +	ret =3D phy_init(priv_data->usb3_phy);

dwc3 core should be handling this already

> +	if (ret < 0) {
> +		phy_exit(priv_data->usb3_phy);
> +		goto err;
> +	}
> +
> +	ret =3D dwc3_xlnx_rst_deassert(priv_data->apbrst);
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

shouldn't this be hidden under clk_enable()?

> +	ret =3D dwc3_xlnx_rst_deassert(priv_data->crst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to release reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret =3D dwc3_xlnx_rst_deassert(priv_data->hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: %d: Failed to release reset\n",
> +			__func__, __LINE__);
> +		goto err;
> +	}
> +
> +	ret =3D phy_power_on(priv_data->usb3_phy);
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
> +		reg =3D readl(priv_data->regs + XLNX_USB_COHERENCY);
> +		reg |=3D XLNX_USB_COHERENCY_ENABLE;
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
> +	struct device		*dev =3D &pdev->dev;
> +	struct device_node	*np =3D dev->of_node;
> +	struct resource		*res;
> +	void __iomem		*regs;
> +	int			ret;
> +
> +	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing memory resource\n");
> +		return -ENODEV;
> +	}

you don't need to check res here. devm_ioremap_resource() already does
that for you.

> +	regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);

this looks like it could use an error message.

> +	/* Store the usb control regs into priv_data for further usage */

pointless comment.

> +	priv_data->regs =3D regs;
> +

unnecessary blank line.

> +	priv_data->dev =3D dev;
> +
> +	platform_set_drvdata(pdev, priv_data);
> +
> +	ret =3D clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv_data->num_clocks =3D ret;
> +
> +	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data->clks);
> +	if (ret)
> +		return ret;
> +
> +	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-dwc3")) {
> +		ret =3D dwc3_xlnx_init_zynqmp(priv_data);
> +		if (ret)
> +			goto err_clk_put;
> +	}

instead, you could pass a pointer to dwc3_xlnx_init_zynqmp() as driver
data and just call it unconditionally. It would avoid the compatible
check here.

> +	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,versal-dwc3")) {
> +		ret =3D dwc3_xlnx_init_versal(priv_data);
> +		if (ret)
> +			goto err_clk_put;
> +	}

same as above

> +	ret =3D of_platform_populate(np, NULL, NULL, dev);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_suspend_ignore_children(dev, false);
> +	pm_runtime_get_sync(dev);
> +
> +	pm_runtime_forbid(dev);

why forbid? You already have a get_sync()

> +	return 0;
> +
> +err_clk_put:
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +
> +	return ret;
> +}
> +
> +static int dwc3_xlnx_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
> +	struct device		*dev =3D &pdev->dev;
> +
> +	of_platform_depopulate(dev);
> +
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +	priv_data->num_clocks =3D 0;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int dwc3_xlnx_runtime_suspend(struct device *dev)
> +{
> +	struct dwc3_xlnx	*priv_data =3D dev_get_drvdata(dev);
> +
> +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_runtime_resume(struct device *dev)
> +{
> +	struct dwc3_xlnx	*priv_data =3D dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> +}
> +#endif /* CONFIG_PM */
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dwc3_xlnx_suspend(struct device *dev)
> +{
> +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> +
> +	/* Disable the clocks */
> +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_resume(struct device *dev)
> +{
> +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> +}

you have the same implementation for both types of suspend/resume. Maybe
extract dwc3_xlnx_{suspend,resume}_common() and just call it from both
callbacks?

> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_xlnx_suspend, dwc3_xlnx_resume)
> +	SET_RUNTIME_PM_OPS(dwc3_xlnx_runtime_suspend, dwc3_xlnx_runtime_resume,
> +			   dwc3_xlnx_runtime_idle)

seems like it could be replaced with UNIVERSAL_PM_OPS with minor
modifications.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9HU0IRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZwGBAAgOXrLzr9wj6IfAa73abK514uNY95Fme3
oMrQGR65rUY6Uv5u3G0tbb24Ohw+u+U3cHv12NjPt186eJ6kLbpJIgL3vCWzs3NY
dI1rXfKwjBrjzRSTlUIeTk1ziLIq/JLO4y1p2FEIkmppie/oxnRHQ28abZvYvrI4
EgWho/ZwJjrUtFEtBKlRCJ3qLLHXkUSgE0DaKijptKcc/xvLOPwwDX7pISV/npvH
+EuS17fSPYIK6i0/WF1CB8sEn+oXmUVG3dkH6OpIqrNnLkWdFEvcnutdD0k441jC
qK9YWBTHTc0eLFFTU/gT9+hyZRv1T2AkCepQdXglz6EMvNrnPIoXphgf4Oqmgn4V
fP+XXaKO/2A/JK2FuUIFXzkJ2ggvqTI6VqYDhu8dEIxaHpR5Gl27VljlQtFXijC3
y+zUXYJXK3Afdvg37bOKJt6+Kdi/NjY59AFrW7U089uSZtF2cr6l9Lv0mBuTqSZe
eQpW9rEhy1klNnB64bDrT5whsVEwzkgbEZX1E4IRSq4DYMsHEkrDj1Kt+ydlIpmb
cIkrPT9qZA2hyMnO8YjOTXQtCSJm+BIgtSBQtGXfe3bztTcOVT/ixrhE6OybTlVz
nysvZLWCtRsUoMAtwXu76B9ncSN5BkQGGgSE5DcMpf7VrJW2bUVc5rzHJnH/Muz5
/qlzakHJvik=
=BK8a
-----END PGP SIGNATURE-----
--=-=-=--
