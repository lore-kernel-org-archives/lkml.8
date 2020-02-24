Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A3C35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F46720836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582515759;
	bh=6d15W9/8t0f2BUQq/bxEpoTZNWBs5M53q2YcmBYzXJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KG39LNj4Tnb9yw2F3shA2ZghsdvUTUPjmFnNGYLZQLtmK2ePe1Z/kyDEzoyg9fAZO
	 VfUZ6+CcaQETJgOrTKtJwTbdK4pGL+3aIjKyNMEBAcd7NwhMACL6NI9R+fAIKB6Z2o
	 FWq3qjQnkb7Dk8FpJSxTB4PwRynUVK3AorlXPzhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBXDmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgBXDmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:42:37 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662B920828;
        Mon, 24 Feb 2020 03:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582515757;
        bh=6d15W9/8t0f2BUQq/bxEpoTZNWBs5M53q2YcmBYzXJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCB4N1aZ8GuKSjK3dMk5vpqqBqZJhK5/4GGhIskjcnuh1zXQ2LzPeSgWo6Pz2++tY
         XImGD8Jn5K4j3PL2J+JijVyd5prlNfr8JMYCaFHx08hyD34BsyJpjlpbY/N1AptujL
         Fx8yybQuWlpbCOGp4PcOxP6s9O6mPH2IqXuYqeiY=
Date:   Mon, 24 Feb 2020 11:42:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
Message-ID: <20200224034228.GI27688@dragon>
References: <20200219131121.3565738-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219131121.3565738-1-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:11:24PM +0000, Oleksandr Suvorov wrote:
> SD/MMC on Colibri iMX7S/D modules successfully support
> 200Mhz frequency in HS200 mode.
> 
> Removing the unnecessary max-frequency limit significantly
> increases the performance:
> 
> == before fix ====
> root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>  Timing buffered disk reads: 252 MB in  3.02 seconds =  83.54 MB/sec
> ==================
> 
> === after fix ====
> root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>  Timing buffered disk reads: 408 MB in  3.00 seconds = 135.94 MB/sec
> ==================
> 
> Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
