Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D859BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A0F22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Xqv/Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgA1FGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:06:52 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54720 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:06:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so465506pjb.4;
        Mon, 27 Jan 2020 21:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EOkHPlApR03+KhenapKgHCCTfxWORvo9CWa7thX8FjQ=;
        b=Q7Xqv/Ibjua4Tt2a8EOs16LRmagni8jh3H0Cmuoli7nocDi388E7DfsZU+nCzL964V
         B5yJjQNSEDLXqoLUV4NtWg4ITl36qnKwWlOI+cH38K08zZunrEImrxtvJVJf6NERNIcu
         oE7v5RmNVWz45efpchd6T8Gbst86Kxe/V6oRAbDnORtMTaZhKw49QiE6wF5sKNFZp4dW
         P6JfMrb98Rk78ELB8PuOGCvJU+lCX9swioyzKHB1Tv79mmSN6e/mcD3rP8Q9sq8CLDcq
         VJPLFAmMUrAqStKU9ym6kDBj2WN73YgnPDznP4t7DoUo99qcIX+b64g5wL0EoydtKDmg
         k4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EOkHPlApR03+KhenapKgHCCTfxWORvo9CWa7thX8FjQ=;
        b=iXGKnD4YEKn6MvlL1Y1HmGEbld8bIUEa2Meds6QYXtqSw2bU0K7/C6Bx8lEZMv5Pbi
         ktzm8O6cl88G+z2UsujEqqMwt21zgiZ/fDTBjCkbsZOYTAZoL1ucXnJ0RYz9iFpf+lnI
         1Zr8VfLiPsg+OF3OxfJz9WgTwejDd1nBQr/b8GIA30yR1VnHgZwTMAGLpt+VeQqxRPcO
         9Wwm0nGvGpSwLVR+KEWJOV42b0wz8RhKhLYHudkSQM+fqvRVEqxeIjQSi5mg/O2Fc4W6
         yPoRe+4AzgPMWIjWRf0d85lFkqq1PhFQ1fzf6Hkvr7ubyWJ2E0I64pzCn04CLlehTbbq
         7nqQ==
X-Gm-Message-State: APjAAAXg2Sm68tZqfaKAcModchLHo8YhjjLJbIiOjqaWHAVmy/nqE6Z2
        3JWRa7hIbdXKHAECIGsg5KurNc3M
X-Google-Smtp-Source: APXvYqyq0chQkUfWzXQt0f00xhGVoq7nPt6jm/29yCitMbJQ4xtiepXpGnHxxZ475RfX+sQDgETshQ==
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr20148831pld.316.1580188010847;
        Mon, 27 Jan 2020 21:06:50 -0800 (PST)
Received: from localhost (216.24.177.237.16clouds.com. [216.24.177.237])
        by smtp.gmail.com with ESMTPSA id b1sm762486pjw.4.2020.01.27.21.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jan 2020 21:06:50 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:06:46 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: tegra: make the code simple by
 devm_platform_ioremap_resource()
Message-ID: <20200128050356.GA21357@nuc8i5>
References: <20200127135841.17935-1-zhengdejin5@gmail.com>
 <ebb395ec-89ef-12e9-b3a9-2fc35f764ee2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb395ec-89ef-12e9-b3a9-2fc35f764ee2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:47:36PM +0300, Dmitry Osipenko wrote:
> 27.01.2020 16:58, Dejin Zheng пишет:
> > make the code simple by use devm_platform_ioremap_resource() function
> > to replace platform_get_resource() and devm_ioremap().
> > 
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/usb/phy/phy-tegra-usb.c | 20 ++------------------
> >  1 file changed, 2 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> > index ea7ef1dc0b42..8220bb4ce1ed 100644
> > --- a/drivers/usb/phy/phy-tegra-usb.c
> > +++ b/drivers/usb/phy/phy-tegra-usb.c
> > @@ -944,20 +944,12 @@ static int read_utmi_param(struct platform_device *pdev, const char *param,
> >  static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
> >  			  struct platform_device *pdev)
> >  {
> > -	struct resource *res;
> >  	int err;
> >  	struct tegra_utmip_config *config;
> >  
> >  	tegra_phy->is_ulpi_phy = false;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "Failed to get UTMI pad regs\n");
> > -		return  -ENXIO;
> > -	}
> > -
> > -	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
> > -		resource_size(res));
> > +	tegra_phy->pad_regs = devm_platform_ioremap_resource(pdev, 1);
> >  	if (!tegra_phy->pad_regs) {
> >  		dev_err(&pdev->dev, "Failed to remap UTMI pad regs\n");
> >  		return -ENOMEM;
> > @@ -1054,7 +1046,6 @@ MODULE_DEVICE_TABLE(of, tegra_usb_phy_id_table);
> >  static int tegra_usb_phy_probe(struct platform_device *pdev)
> >  {
> >  	const struct of_device_id *match;
> > -	struct resource *res;
> >  	struct tegra_usb_phy *tegra_phy = NULL;
> >  	struct device_node *np = pdev->dev.of_node;
> >  	enum usb_phy_interface phy_type;
> > @@ -1071,14 +1062,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
> >  	}
> >  	tegra_phy->soc_config = match->data;
> >  
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "Failed to get I/O memory\n");
> > -		return  -ENXIO;
> > -	}
> > -
> > -	tegra_phy->regs = devm_ioremap(&pdev->dev, res->start,
> > -		resource_size(res));
> > +	tegra_phy->regs = devm_platform_ioremap_resource(pdev, 0);
> >  	if (!tegra_phy->regs) {
> >  		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> >  		return -ENOMEM;
> > 
> 
> Hello Dejin,
> 
> Unfortunately this is not a correct change because registers are shared
> by both PHY and USB controllers on Tegra SoCs. The
> devm_platform_ioremap_resource() can't be used here because it makes the
> mapping exclusive for a single driver, while it should be shared.

Dmitry, Thanks a lot for your comment! and abandon this commit.


