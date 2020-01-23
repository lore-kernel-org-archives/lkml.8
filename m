Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC0C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B13322522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uPSyNfe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAWJwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:52:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAWJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:52:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so2312802wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Pe5Rsg965fXFIVcO925e+LyvSUF+nmybt0TNNTcsyVw=;
        b=uPSyNfe/0xeA/qXiTcmG3RXI3AIZygm1++lzzIem3KlnWC/UzUARLQOWFRsDsdO5Qo
         KiLGofookzvRESLJ+sRPyplTi6sAffDpWMsPfVoyH8V/U2PtbXe2jXBknIkB9LTqQvGr
         tuN2cW7DlH8ObMw97Nj8ZrekgFAcSV2ddx57FqggGxTV0eV+PZPJ+CtoYUJXkvajnQfd
         vpcFE9e4v2hrKWwMZI/9MaxZt0jpbt7N9IHWED/5lNOUOXcDaIDu5PKVU2uVoh+DYths
         kTTmaCDQy/OdYnDfUkL2Sy4XQeGfiahDo6bEsFvupMMWXoSKGC6v/x/u6NMcp6ggtUjp
         vF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Pe5Rsg965fXFIVcO925e+LyvSUF+nmybt0TNNTcsyVw=;
        b=fLRqvF8/X2cWBkRtpIewyZnqAp5JPa8NvT/E4PIOVpYM6YCM0OpAqt9JS9jqgxEGuG
         gsSsObfNxwLwe+J99Ct0DsckBdveHKlbecw7kFlMAaU3/8vDFQ+3tLLL24sLKl30U6gI
         RrjoERU4ML2dZ4yJeG0OxVQ0vOiKFk/ECBHp6GkvE+VovDhfqXZQY30GhFDNsdJfsVyI
         6LvcurIyxJqSWWXdF4VdhOd2tnU2jCShC3u+j2vmJi9oB9QQHqydeAE7ftdLA3QbSEvN
         OeCfmOYF5C5dmtfUdqbjdsSptj8dyd7LGWeVVRqbSY0v8usUmYbyrhyyruwIJfTbGqjd
         E84A==
X-Gm-Message-State: APjAAAVpc2WAejRaLp6a5rBeTEHVdDLtMp5n8zcQPF50E0w6ulpfz4EG
        vnZ+QhSHH35o7S1QD9kvtPIUVQ==
X-Google-Smtp-Source: APXvYqwZwrqdt3zOKkehDNPgAuzvRs+Y++wPfZWKhZLkuBHMMzAE5La3vJ7ohaAZBPKEr8qujgpaYg==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr16778098wrt.208.1579773128590;
        Thu, 23 Jan 2020 01:52:08 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3sm2346985wrt.29.2020.01.23.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:52:08 -0800 (PST)
References: <20200116111850.23690-1-repk@triplefau.lt> <20200116111850.23690-8-repk@triplefau.lt>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 7/7] PCI: amlogic: Use AXG PCIE
In-reply-to: <20200116111850.23690-8-repk@triplefau.lt>
Date:   Thu, 23 Jan 2020 10:52:07 +0100
Message-ID: <1jy2tyv6t4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 16 Jan 2020 at 12:18, Remi Pommarel <repk@triplefau.lt> wrote:

> Now that PCIE PHY has been introduced for AXG, the whole has_shared_phy
> logic can be mutualized between AXG and G12A platforms.

This simply the driver and make it a lot easier to follow ! Thanks !

>
> This new PHY makes use of the optional shared MIPI/PCIE analog PHY
> found on AXG platforms, which need to be used in order to have reliable
> PCIE communications.

I'm a bit confused by the optional part ... from the probe of this
driver, it does not seems optional ?

>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 116 +++++--------------------
>  1 file changed, 22 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 3772b02a5c55..3715dceca1bf 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -66,7 +66,6 @@
>  #define PORT_CLK_RATE			100000000UL
>  #define MAX_PAYLOAD_SIZE		256
>  #define MAX_READ_REQ_SIZE		256
> -#define MESON_PCIE_PHY_POWERUP		0x1c
>  #define PCIE_RESET_DELAY		500
>  #define PCIE_SHARED_RESET		1
>  #define PCIE_NORMAL_RESET		0
> @@ -81,26 +80,19 @@ enum pcie_data_rate {
>  struct meson_pcie_mem_res {
>  	void __iomem *elbi_base;
>  	void __iomem *cfg_base;
> -	void __iomem *phy_base;
>  };
>  
>  struct meson_pcie_clk_res {
>  	struct clk *clk;
> -	struct clk *mipi_gate;
>  	struct clk *port_clk;
>  	struct clk *general_clk;
>  };
>  
>  struct meson_pcie_rc_reset {
> -	struct reset_control *phy;
>  	struct reset_control *port;
>  	struct reset_control *apb;
>  };
>  
> -struct meson_pcie_param {
> -	bool has_shared_phy;
> -};
> -
>  struct meson_pcie {
>  	struct dw_pcie pci;
>  	struct meson_pcie_mem_res mem_res;
> @@ -108,7 +100,6 @@ struct meson_pcie {
>  	struct meson_pcie_rc_reset mrst;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
> -	const struct meson_pcie_param *param;
>  };
>  
>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
> @@ -130,13 +121,6 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>  
> -	if (!mp->param->has_shared_phy) {
> -		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> -		if (IS_ERR(mrst->phy))
> -			return PTR_ERR(mrst->phy);
> -		reset_control_deassert(mrst->phy);
> -	}
> -
>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>  	if (IS_ERR(mrst->port))
>  		return PTR_ERR(mrst->port);
> @@ -162,22 +146,6 @@ static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
>  	return devm_ioremap_resource(dev, res);
>  }
>  
> -static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
> -					       struct meson_pcie *mp,
> -					       const char *id)
> -{
> -	struct device *dev = mp->pci.dev;
> -	struct resource *res;
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
> -	if (!res) {
> -		dev_err(dev, "No REG resource %s\n", id);
> -		return ERR_PTR(-ENXIO);
> -	}
> -
> -	return devm_ioremap(dev, res->start, resource_size(res));
> -}
> -
>  static int meson_pcie_get_mems(struct platform_device *pdev,
>  			       struct meson_pcie *mp)
>  {
> @@ -189,14 +157,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>  	if (IS_ERR(mp->mem_res.cfg_base))
>  		return PTR_ERR(mp->mem_res.cfg_base);
>  
> -	/* Meson AXG SoC has two PCI controllers use same phy register */
> -	if (!mp->param->has_shared_phy) {
> -		mp->mem_res.phy_base =
> -			meson_pcie_get_mem_shared(pdev, mp, "phy");
> -		if (IS_ERR(mp->mem_res.phy_base))
> -			return PTR_ERR(mp->mem_res.phy_base);
> -	}
> -
>  	return 0;
>  }
>  
> @@ -204,37 +164,33 @@ static int meson_pcie_power_on(struct meson_pcie *mp)
>  {
>  	int ret = 0;
>  
> -	if (mp->param->has_shared_phy) {
> -		ret = phy_init(mp->phy);
> -		if (ret)
> -			return ret;
> +	ret = phy_init(mp->phy);
> +	if (ret)
> +		return ret;
>  
> -		ret = phy_power_on(mp->phy);
> -		if (ret) {
> -			phy_exit(mp->phy);
> -			return ret;
> -		}
> -	} else
> -		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> +	ret = phy_power_on(mp->phy);
> +	if (ret) {
> +		phy_exit(mp->phy);
> +		return ret;
> +	}
>  
>  	return 0;
>  }
>  
> +static void meson_pcie_power_off(struct meson_pcie *mp)
> +{
> +	phy_power_off(mp->phy);
> +	phy_exit(mp->phy);
> +}
> +
>  static int meson_pcie_reset(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>  	int ret = 0;
>  
> -	if (mp->param->has_shared_phy) {
> -		ret = phy_reset(mp->phy);
> -		if (ret)
> -			return ret;
> -	} else {
> -		reset_control_assert(mrst->phy);
> -		udelay(PCIE_RESET_DELAY);
> -		reset_control_deassert(mrst->phy);
> -		udelay(PCIE_RESET_DELAY);
> -	}
> +	ret = phy_reset(mp->phy);
> +	if (ret)
> +		return ret;
>  
>  	reset_control_assert(mrst->port);
>  	reset_control_assert(mrst->apb);
> @@ -286,12 +242,6 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  	if (IS_ERR(res->port_clk))
>  		return PTR_ERR(res->port_clk);
>  
> -	if (!mp->param->has_shared_phy) {
> -		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> -		if (IS_ERR(res->mipi_gate))
> -			return PTR_ERR(res->mipi_gate);
> -	}
> -
>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
>  	if (IS_ERR(res->general_clk))
>  		return PTR_ERR(res->general_clk);
> @@ -562,7 +512,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  
>  static int meson_pcie_probe(struct platform_device *pdev)
>  {
> -	const struct meson_pcie_param *match_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct meson_pcie *mp;
> @@ -576,17 +525,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> -	match_data = of_device_get_match_data(dev);
> -	if (!match_data) {
> -		dev_err(dev, "failed to get match data\n");
> -		return -ENODEV;
> -	}
> -	mp->param = match_data;
> -
> -	if (mp->param->has_shared_phy) {
> -		mp->phy = devm_phy_get(dev, "pcie");
> -		if (IS_ERR(mp->phy))
> -			return PTR_ERR(mp->phy);
> +	mp->phy = devm_phy_get(dev, "pcie");
> +	if (IS_ERR(mp->phy)) {
> +		dev_err(dev, "get phy failed, %ld\n", PTR_ERR(mp->phy));
> +		return PTR_ERR(mp->phy);
>  	}
>  
>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> @@ -636,30 +578,16 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_phy:
> -	if (mp->param->has_shared_phy) {
> -		phy_power_off(mp->phy);
> -		phy_exit(mp->phy);
> -	}
> -
> +	meson_pcie_power_off(mp);
>  	return ret;
>  }
>  
> -static struct meson_pcie_param meson_pcie_axg_param = {
> -	.has_shared_phy = false,
> -};
> -
> -static struct meson_pcie_param meson_pcie_g12a_param = {
> -	.has_shared_phy = true,
> -};
> -
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> -		.data = &meson_pcie_axg_param,
>  	},
>  	{
>  		.compatible = "amlogic,g12a-pcie",
> -		.data = &meson_pcie_g12a_param,
>  	},
>  	{},
>  };

