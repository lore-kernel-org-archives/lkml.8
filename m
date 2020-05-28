Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581A9208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590628376;
	bh=hBO4N/AXK+LB2rPfZlEp7PblZQvv+rHSIrH7lefK8pk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=mHJlylYItHqBXtWciZF+CMp1zZCenZK0G2BP1Ez3ferpudvwnqIzeP+LvvGzAmVUz
	 tDnZ6GH+XHjANRvHcu3dhFPlPkF+9iDhFtF9ZXWs88ASB7DA+VGP6k5Tql1P5GeEn0
	 Q6CCNd8gjSlpGXzfS0kEw4oPnSZpq5UewctZdeME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgE1BMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgE1BMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:12:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 297B22078C;
        Thu, 28 May 2020 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590628374;
        bh=hBO4N/AXK+LB2rPfZlEp7PblZQvv+rHSIrH7lefK8pk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CNcMPAQnQ31fGrhuIAtzs5ukAtItClWFFzUAQFYoWiCft0d6vkBMTJCj4jB529FDr
         NR4XGjAX0Zz3uNKVuK+K3L4DNMWJPIpWlk/sW9WpjJbIFu7sIkbKBLGZDcO9oYN9Ff
         hGeBrcEhwDgLsTzSJEZF3R181Gvb6saMepcNpy1s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527175635.5558-8-zhouyanjie@wanyeetech.com>
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com> <20200527175635.5558-8-zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH v12 7/7] clk: X1000: Add FIXDIV for SSI clock of X1000.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
To:     linux-clk@vger.kernel.org, Zhou Yanjie <zhouyanjie@wanyeetech.com>
Date:   Wed, 27 May 2020 18:12:53 -0700
Message-ID: <159062837338.69627.14365746093599072888@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhou Yanjie (2020-05-27 10:56:35)
> @@ -40,8 +43,47 @@
>  #define OPCR_SPENDN0           BIT(7)
>  #define OPCR_SPENDN1           BIT(6)
> =20
> +/* bits within the USBPCR register */
> +#define USBPCR_SIDDQ           BIT(21)
> +#define USBPCR_OTG_DISABLE     BIT(20)
> +
>  static struct ingenic_cgu *cgu;
> =20
> +static int x1000_usb_phy_enable(struct clk_hw *hw)
> +{
> +       void __iomem *reg_opcr          =3D cgu->base + CGU_REG_OPCR;
> +       void __iomem *reg_usbpcr        =3D cgu->base + CGU_REG_USBPCR;
> +
> +       writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);

Please include linux/io.h for writel/readl.

> +       writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, r=
eg_usbpcr);
> +       return 0;
> +}
> +
> +static void x1000_usb_phy_disable(struct clk_hw *hw)
> +{
> +       void __iomem *reg_opcr          =3D cgu->base + CGU_REG_OPCR;
> +       void __iomem *reg_usbpcr        =3D cgu->base + CGU_REG_USBPCR;
> +
> +       writel(readl(reg_opcr) & ~OPCR_SPENDN0, reg_opcr);
> +       writel(readl(reg_usbpcr) | USBPCR_OTG_DISABLE | USBPCR_SIDDQ, reg=
_usbpcr);
> +}
> +
> +static int x1000_usb_phy_is_enabled(struct clk_hw *hw)
> +{
> +       void __iomem *reg_opcr          =3D cgu->base + CGU_REG_OPCR;
> +       void __iomem *reg_usbpcr        =3D cgu->base + CGU_REG_USBPCR;
> +
> +       return (readl(reg_opcr) & OPCR_SPENDN0) &&
> +               !(readl(reg_usbpcr) & USBPCR_SIDDQ) &&
> +               !(readl(reg_usbpcr) & USBPCR_OTG_DISABLE);
> +}
> +
> +static const struct clk_ops x1000_otg_phy_ops =3D {
> +       .enable         =3D x1000_usb_phy_enable,
> +       .disable        =3D x1000_usb_phy_disable,
> +       .is_enabled     =3D x1000_usb_phy_is_enabled,
> +};
> +
>  static const s8 pll_od_encoding[8] =3D {
>         0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
>  };
> @@ -277,4 +377,4 @@ static void __init x1000_cgu_init(struct device_node =
*np)
> =20
>         ingenic_cgu_register_syscore_ops(cgu);
>  }
> -CLK_OF_DECLARE(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
> +CLK_OF_DECLARE_DRIVER(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);

Why does this change to DECLARE_DRIVER? Can you please add a comment
here in the code indicating what other driver is probing this compatible
string?
