Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF4C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A918214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X5Qy5s8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:30:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41932 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:30:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so15557283wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEl8jUnZuFW5r0KidanOV0L0J5aiBQysZy1SqMOD7Dk=;
        b=X5Qy5s8HkBsVtut7o9dGazFziqNgmv1gwGPZKqfQ58IXC+06hD/+aF6kIwmK3WHXkL
         KSB/2uZSJlwQfmyj8Loq4TbeWqd+woBaP2B2LAeKexUO2KyNOae/5+2snUqkT2PY+KHV
         sdSKjq9pCUfE+6qsEhYsLYAjJQxe/nIzYzGlEvACnr7TkohD8E66GZgbuV3P1M69r6N8
         I+iEZzi4HQuFS3Y8VUvmX5DLz5ltS7rcfoONywQ1Uhv8VDWnA1fKSdFkvj/FgO+ZjWqI
         polsVvEQvyHmeIiHZGQ8mFuhEoxxkX3FuUejmI6pWt0FC7BqCQo6SvNusQfN6pYG/Byj
         XL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rEl8jUnZuFW5r0KidanOV0L0J5aiBQysZy1SqMOD7Dk=;
        b=LqDC7WnlLePbMT7sGmD5bI0ZclxJMYjduCvMvSujBFGvtmKxSni8FY7erZQQPsETjU
         5SpbM9UstCLiiJn2pIacPXRo5jx6fo9plqbnmw8RjbOEz5LkvuKDkmQ7znUNnfyWCYpa
         DCVlAaJyw6JLBZASrn7VKP/Da4bU8mv1KuW4LwX085uBSCsLzGmWx0/mzBFSg1BmRBoR
         aNySGtw91GOp+dwHePU2K7ZoSIJsDYGhLpsBRPfHOJrSKi362/8eEAdtyHuF1N3cOXrI
         vch9gokSXtoJqWq8dBsdg/NxUIUEyFjnafT4197a0Bvrsp4HIVXZlbCyvF652ej2iZf4
         Vhrg==
X-Gm-Message-State: APjAAAV6bsJnJ/a2y7hKwObRTZaSwRazLquLSuF4sBnagZIUfsjG+0hR
        tZKxnKo5ZLdspHsUJByJgMmZJw==
X-Google-Smtp-Source: APXvYqwDtwirZGsetjQcMm8m83qcnGWqhHF27RaDs35V37AFgqw8O0KMWRp6+MrNNFlZNDQ/RAuaPg==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr31799521wrh.371.1579091408104;
        Wed, 15 Jan 2020 04:30:08 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a184sm23887935wmf.29.2020.01.15.04.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 04:30:07 -0800 (PST)
Subject: Re: [PATCH v4 7/7] PCI: amlogic: Use AXG PCIE and shared MIPI/PCIE
 PHYs
To:     Remi Pommarel <repk@triplefau.lt>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20200115122908.16954-1-repk@triplefau.lt>
 <20200115122908.16954-8-repk@triplefau.lt>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwU0EVid/pAEQAND7AFhr
 5faf/EhDP9FSgYd/zgmb7JOpFPje3uw7jz9wFb28Cf0Y3CcncdElYoBNbRlesKvjQRL8mozV
 9RN+IUMHdUx1akR/A4BPXNdL7StfzKWOCxZHVS+rIQ/fE3Qz/jRmT6t2ZkpplLxVBpdu95qJ
 YwSZjuwFXdC+A7MHtQXYi3UfCgKiflj4+/ITcKC6EF32KrmIRqamQwiRsDcUUKlAUjkCLcHL
 CQvNsDdm2cxdHxC32AVm3Je8VCsH7/qEPMQ+cEZk47HOR3+Ihfn1LEG5LfwsyWE8/JxsU2a1
 q44LQM2lcK/0AKAL20XDd7ERH/FCBKkNVzi+svYJpyvCZCnWT0TRb72mT+XxLWNwfHTeGALE
 +1As4jIS72IglvbtONxc2OIid3tR5rX3k2V0iud0P7Hnz/JTdfvSpVj55ZurOl2XAXUpGbq5
 XRk5CESFuLQV8oqCxgWAEgFyEapI4GwJsvfl/2Er8kLoucYO1Id4mz6N33+omPhaoXfHyLSy
 dxD+CzNJqN2GdavGtobdvv/2V0wukqj86iKF8toLG2/Fia3DxMaGUxqI7GMOuiGZjXPt/et/
 qeOySghdQ7Sdpu6fWc8CJXV2mOV6DrSzc6ZVB4SmvdoruBHWWOR6YnMz01ShFE49pPucyU1h
 Av4jC62El3pdCrDOnWNFMYbbon3vABEBAAHCwn4EGAECAAkFAlYnf6QCGwICKQkQFpq3saTP
 +K7BXSAEGQECAAYFAlYnf6QACgkQd9zb2sjISdGToxAAkOjSfGxp0ulgHboUAtmxaU3viucV
 e2Hl1BVDtKSKmbIVZmEUvx9D06IijFaEzqtKD34LXD6fjl4HIyDZvwfeaZCbJbO10j3k7FJE
 QrBtpdVqkJxme/nYlGOVzcOiKIepNkwvnHVnuVDVPcXyj2wqtsU7VZDDX41z3X4xTQwY3SO1
 9nRO+f+i4RmtJcITgregMa2PcB0LvrjJlWroI+KAKCzoTHzSTpCXMJ1U/dEqyc87bFBdc+DI
 k8mWkPxsccdbs4t+hH0NoE3Kal9xtAl56RCtO/KgBLAQ5M8oToJVatxAjO1SnRYVN1EaAwrR
 xkHdd97qw6nbg9BMcAoa2NMc0/9MeiaQfbgW6b0reIz/haHhXZ6oYSCl15Knkr4t1o3I2Bqr
 Mw623gdiTzotgtId8VfLB2Vsatj35OqIn5lVbi2ua6I0gkI6S7xJhqeyrfhDNgzTHdQVHB9/
 7jnM0ERXNy1Ket6aDWZWCvM59dTyu37g3VvYzGis8XzrX1oLBU/tTXqo1IFqqIAmvh7lI0Se
 gCrXz7UanxCwUbQBFjzGn6pooEHJYRLuVGLdBuoApl/I4dLqCZij2AGa4CFzrn9W0cwm3HCO
 lR43gFyz0dSkMwNUd195FrvfAz7Bjmmi19DnORKnQmlvGe/9xEEfr5zjey1N9+mt3//geDP6
 clwKBkq0JggA+RTEAELzkgPYKJ3NutoStUAKZGiLOFMpHY6KpItbbHjF2ZKIU1whaRYkHpB2
 uLQXOzZ0d7x60PUdhqG3VmFnzXSztA4vsnDKk7x2xw0pMSTKhMafpxaPQJf494/jGnwBHyi3
 h3QGG1RjfhQ/OMTX/HKtAUB2ct3Q8/jBfF0hS5GzT6dYtj0Ci7+8LUsB2VoayhNXMnaBfh+Q
 pAhaFfRZWTjUFIV4MpDdFDame7PB50s73gF/pfQbjw5Wxtes/0FnqydfId95s+eej+17ldGp
 lMv1ok7K0H/WJSdr7UwDAHEYU++p4RRTJP6DHWXcByVlpNQ4SSAiivmWiwOt490+Ac7ATQRN
 WQbPAQgAvIoM384ZRFocFXPCOBir5m2J+96R2tI2XxMgMfyDXGJwFilBNs+fpttJlt2995A8
 0JwPj8SFdm6FBcxygmxBBCc7i/BVQuY8aC0Z/w9Vzt3Eo561r6pSHr5JGHe8hwBQUcNPd/9l
 2ynP57YTSE9XaGJK8gIuTXWo7pzIkTXfN40Wh5jeCCspj4jNsWiYhljjIbrEj300g8RUT2U0
 FcEoiV7AjJWWQ5pi8lZJX6nmB0lc69Jw03V6mblgeZ/1oTZmOepkagwy2zLDXxihf0GowUif
 GphBDeP8elWBNK+ajl5rmpAMNRoKxpN/xR4NzBg62AjyIvigdywa1RehSTfccQARAQABwsBf
 BBgBAgAJBQJNWQbPAhsMAAoJEBaat7Gkz/iuteIH+wZuRDqK0ysAh+czshtG6JJlLW6eXJJR
 Vi7dIPpgFic2LcbkSlvB8E25Pcfz/+tW+04Urg4PxxFiTFdFCZO+prfd4Mge7/OvUcwoSub7
 ZIPo8726ZF5/xXzajahoIu9/hZ4iywWPAHRvprXaim5E/vKjcTeBMJIqZtS4u/UK3EpAX59R
 XVxVpM8zJPbk535ELUr6I5HQXnihQm8l6rt9TNuf8p2WEDxc8bPAZHLjNyw9a/CdeB97m2Tr
 zR8QplXA5kogS4kLe/7/JmlDMO8Zgm9vKLHSUeesLOrjdZ59EcjldNNBszRZQgEhwaarfz46
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <e86e613b-0811-bbed-1999-260b83351957@baylibre.com>
Date:   Wed, 15 Jan 2020 13:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115122908.16954-8-repk@triplefau.lt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2020 13:29, Remi Pommarel wrote:
> Now that PCIE PHY has been introduced for AXG, the whole has_shared_phy
> logic can be mutualized between AXG and G12A platforms.
> 
> This also makes use of the optional MIPI/PCIE shared fonctionality PHY
> found on AXG platforms, which need to be used in order to have reliable
> PCIE communications.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 140 ++++++++-----------------
>  1 file changed, 46 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 3772b02a5c55..309e75f554ac 100644
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
> @@ -108,7 +100,7 @@ struct meson_pcie {
>  	struct meson_pcie_rc_reset mrst;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
> -	const struct meson_pcie_param *param;
> +	struct phy *shared_phy;
>  };
>  
>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
> @@ -130,13 +122,6 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
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
> @@ -162,22 +147,6 @@ static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
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
> @@ -189,14 +158,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
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
> @@ -204,20 +165,40 @@ static int meson_pcie_power_on(struct meson_pcie *mp)
>  {
>  	int ret = 0;
>  
> -	if (mp->param->has_shared_phy) {
> -		ret = phy_init(mp->phy);
> -		if (ret)
> -			return ret;
> +	ret = phy_init(mp->phy);
> +	if (ret)
> +		goto err;
>  
> -		ret = phy_power_on(mp->phy);
> -		if (ret) {
> -			phy_exit(mp->phy);
> -			return ret;
> -		}
> -	} else
> -		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> +	ret = phy_init(mp->shared_phy);
> +	if (ret)
> +		goto exit;
> +
> +	ret = phy_power_on(mp->phy);
> +	if (ret)
> +		goto shared_exit;
> +
> +	ret = phy_power_on(mp->shared_phy);
> +	if (ret)
> +		goto power_off;
>  
>  	return 0;
> +
> +power_off:
> +	phy_power_off(mp->phy);
> +shared_exit:
> +	phy_exit(mp->shared_phy);
> +exit:
> +	phy_exit(mp->phy);
> +err:
> +	return ret;
> +}
> +
> +static void meson_pcie_power_off(struct meson_pcie *mp)
> +{
> +	phy_power_off(mp->shared_phy);
> +	phy_power_off(mp->phy);
> +	phy_exit(mp->shared_phy);
> +	phy_exit(mp->phy);
>  }
>  
>  static int meson_pcie_reset(struct meson_pcie *mp)
> @@ -225,16 +206,13 @@ static int meson_pcie_reset(struct meson_pcie *mp)
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
> +
> +	ret = phy_reset(mp->shared_phy);
> +	if (ret)
> +		return ret;
>  
>  	reset_control_assert(mrst->port);
>  	reset_control_assert(mrst->apb);
> @@ -286,12 +264,6 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
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
> @@ -562,7 +534,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  
>  static int meson_pcie_probe(struct platform_device *pdev)
>  {
> -	const struct meson_pcie_param *match_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct meson_pcie *mp;
> @@ -576,18 +547,13 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> -	match_data = of_device_get_match_data(dev);
> -	if (!match_data) {
> -		dev_err(dev, "failed to get match data\n");
> -		return -ENODEV;
> -	}
> -	mp->param = match_data;
> +	mp->phy = devm_phy_get(dev, "pcie");
> +	if (IS_ERR(mp->phy))
> +		return PTR_ERR(mp->phy);
>  
> -	if (mp->param->has_shared_phy) {
> -		mp->phy = devm_phy_get(dev, "pcie");
> -		if (IS_ERR(mp->phy))
> -			return PTR_ERR(mp->phy);
> -	}
> +	mp->shared_phy = devm_phy_optional_get(dev, "shared");
> +	if (IS_ERR(mp->shared_phy))
> +		return PTR_ERR(mp->shared_phy);

This "shared" phy doesn't appear in patch 3 (bindings) !

Not sure it's the best way to do this, maybe you could chain the MIPI
phy from the PCIE phy instead, so it's the PCIE phy to enable/power/reset the
MIPI PHY instead of the PCIe driver.

But still, here you don't really model the MIPI PHY, it uses way more than
a register in HHI... so at least you should add all the resources needed
if you wanted to model a true MIPI PHY. i.e. MIPI PHY registers, clocks, resets
& co if you want to model the MIPI PHY as is.

Neil

>  
>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(mp->reset_gpio)) {
> @@ -636,30 +602,16 @@ static int meson_pcie_probe(struct platform_device *pdev)
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
> 

