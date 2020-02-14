Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0765AC3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A8B22314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581669473;
	bh=7LZAS7jeROudOg5e0Lub+F4d7L4Epk65wF+VuWSPC4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1tbepTbb052Nrlty2olMEPrWhZvRZTdrqpq5ttxKpjw3fvqgvCTzhk5Mnh1l4GH1H
	 nZ14lqJxfZib41qlaqw4APxLc1hn9vnwuc52xw3uwGAyGYl4VqvkANX2mKNIy4eFyJ
	 ZEabuAKoNN/ZYIsf/WuxctX9WXH1NC+wRaxKDMiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNIhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:37:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgBNIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:37:53 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA8D217F4;
        Fri, 14 Feb 2020 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581669472;
        bh=7LZAS7jeROudOg5e0Lub+F4d7L4Epk65wF+VuWSPC4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/YJSBRgs9oH2T2s75u86tZ3M8jcOtGDcEch5HJlFalkuRPsLC0HPXUbDsgEDsIan
         NeJF98CC0rX6DdFVjpfBdxT8+AnW/GNGMOMkhFI1gGmCqew99MWdUuv23/rsmmOfZI
         tiqjmUe6Qs2NrcdN9VR0iiDUc8LCt478l1huXCDo=
Date:   Fri, 14 Feb 2020 16:37:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Adam Ford <aford173@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ARM: imx_v6_v7_defconfig: Enable
 TOUCHSCREEN_ATMEL_MXT
Message-ID: <20200214083736.GC25543@dragon>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
 <20200204111151.3426090-5-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204111151.3426090-5-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:11:49PM +0200, Oleksandr Suvorov wrote:
> Toradex iMX6/iMX7-based modules and boards support LCDs
> with an MicroChip ATMXT1066T2 touchscreen controller.
> 
> This patch enables the TOUCHSCREEN_ATMEL_MXT which supports
> MXT-series controllers, including the ATMXT1066T2.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Applied, thanks.
