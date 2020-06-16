Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F4D206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFPBLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:11:32 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC2C061A0E;
        Mon, 15 Jun 2020 18:11:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AE61E12322A03;
        Mon, 15 Jun 2020 18:11:30 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:11:29 -0700 (PDT)
Message-Id: <20200615.181129.570239999533845176.davem@davemloft.net>
To:     heiko@sntech.de
Cc:     kuba@kernel.org, robh+dt@kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        heiko.stuebner@theobroma-systems.com
Subject: Re: [PATCH v3 1/3] net: phy: mscc: move shared probe code into a
 helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200615144501.1140870-1-heiko@sntech.de>
References: <20200615144501.1140870-1-heiko@sntech.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Jun 2020 18:11:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>
Date: Mon, 15 Jun 2020 16:44:59 +0200

>  static int vsc8584_probe(struct phy_device *phydev)
>  {
>  	struct vsc8531_private *vsc8531;
> +	int rc;
>  	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
>  	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
>  	   VSC8531_DUPLEX_COLLISION};
> @@ -2005,32 +2015,24 @@ static int vsc8584_probe(struct phy_device *phydev)
>  		return -ENOTSUPP;
>  	}
>  
> -	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
> -	if (!vsc8531)
> -		return -ENOMEM;

Because you removed this devm_kzalloc() code, vsc8531 is never initialized.

> +	return devm_phy_package_join(&phydev->mdio.dev, phydev,
> +				     vsc8531->base_addr, 0);

But it is still dereferenced here.

Did the compiler really not warn you about this when you test built
these changes?
