Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2DCC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CD208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599286288;
	bh=JRRgdgvYFCSpv+IGWAbk5TaaHbTZwTZ9SIFQuGQxZRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fvoBXKxS9TceKnozTA2/YTgvR2GflzWNBEu06Bz5b51oeG9wT6D8l9jk5EJW84KxP
	 vnuV9x2xRdHg6qqNE9g2yGDjfhX/xYHYUpX1pj8cCc+TglzYwVSmBXLwvQhzFJ0SZo
	 WuT/Qw7qcSwpeoUIeEZvO+ITK5UkGncQbcwKWbIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIEGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 02:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEGLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:11:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D6D208DB;
        Sat,  5 Sep 2020 06:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599286284;
        bh=JRRgdgvYFCSpv+IGWAbk5TaaHbTZwTZ9SIFQuGQxZRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPhb3VqZYDWoXpLL6IkYtVBiKZGnqoHI4hivWK/jZGUlFI0g21kDHBXRrp953yQ5o
         Sc5ihZpysd49pK3KN4xr43Q2dgITTuIv/u9zoRWr4/V1lLYb4rDMD0gcoN+hEs8acK
         sMX8/d9Lfek35x/3goH8L+PMud9s0EogYYQaIRMg=
Date:   Sat, 5 Sep 2020 14:11:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 06/19] arm64: dts: imx8mm-beacon: Align pin
 configuration group names with schema
Message-ID: <20200905061117.GA9261@dragon>
References: <20200828164750.10377-1-krzk@kernel.org>
 <20200828164750.10377-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828164750.10377-7-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:47:37PM +0200, Krzysztof Kozlowski wrote:
> Device tree schema expects pin configuration groups to end with 'grp'
> suffix.  This fixes dtbs_check warnings like:
> 
>   pinctrl@30330000: 'pcal6414-gpio', 'pmicirq', 'usdhc1grp100mhz', 'usdhc1grp200mhz', 'usdhc1grpgpio',
>     'usdhc2grp100mhz', 'usdhc2grp200mhz', 'usdhc2grpgpio', 'usdhc3grp100mhz', 'usdhc3grp200mhz'
>     do not match any of the regexes: 'grp$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
