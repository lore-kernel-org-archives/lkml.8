Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F7C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295F22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583905887;
	bh=JMw0bXDLKiXhYXlmtGhDqds53SFA6ey+KYKXbsdMB80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pBe7ZQLZcyIxQyqKgvaqD8iKdSzIG5y9w4ZTtLHpsss+SdopkhhUMwIuiIPicscMv
	 9nJ+sgkJtvAD69YystVgeZRFdGQUjSoo1rS6YZcbT1ZJM1r6f0Wi2oTOBwbEn6SEuF
	 fG8tvW+3GOd5zDTRiczWlBOSjEvNNrUO3GDCoT68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCKFv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgCKFvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:51:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C163B208E4;
        Wed, 11 Mar 2020 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583905885;
        bh=JMw0bXDLKiXhYXlmtGhDqds53SFA6ey+KYKXbsdMB80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5xz8Rk1MeGvXdvXZUa199u7ziQcJfNFgHYNrh5MAuASrrpR3FR0xzqEqNZoGZgxc
         ojC1+ZdK6C/LuQnEfc93ltGkAOYhL+rBZf5HhIPNK1Zybn3QSULkDVcW6hEL3aNay/
         QFtp6sbxrdwhJi1cURpXcqYVmUntA1PLBy6m6640=
Date:   Wed, 11 Mar 2020 13:51:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm64: defconfig: Enable NXP/FSL SPI controller
 drivers
Message-ID: <20200311055104.GA29269@dragon>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-7-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582585690-463-7-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:08:01PM -0600, Li Yang wrote:
> Enables SPI controller drivers used in various NXP/FSL SoCs.
> 
> Enabled as built-in to load RFS from SPI flash without requiring
> initramfs.

RootFS on SPI flash?  On which platforms?

Shawn

> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7390c8f3838d..e97ef8b944b8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -398,8 +398,11 @@ CONFIG_SPI=y
>  CONFIG_SPI_ARMADA_3700=y
>  CONFIG_SPI_BCM2835=m
>  CONFIG_SPI_BCM2835AUX=m
> +CONFIG_SPI_FSL_LPSPI=y
> +CONFIG_SPI_FSL_QUADSPI=y
>  CONFIG_SPI_NXP_FLEXSPI=y
>  CONFIG_SPI_IMX=m
> +CONFIG_SPI_FSL_DSPI=y
>  CONFIG_SPI_MESON_SPICC=m
>  CONFIG_SPI_MESON_SPIFC=m
>  CONFIG_SPI_ORION=y
> -- 
> 2.17.1
> 
