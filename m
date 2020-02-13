Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AECC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627D220873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581561589;
	bh=7njdiHZdpjT/lY2sGX+b1AjE8LpOct8cmEhxr86H+H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BJvHKXF/MMriH4YMeBvJ3h8X+s51RDOeWf4sx0bP04uEE4uHNT+Y1v+x0yi5a4byQ
	 CWFYPkiHKHsctbIt10+tlCevX2mqVsM1YVLxMNL0v/4cZhBXEUi52YC6mSZEG4N85l
	 knj7+W6FGAysry4rXZEDW1JieWqJ9RcHRjbz8Lck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgBMCjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:39:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgBMCjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:39:48 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2595220675;
        Thu, 13 Feb 2020 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581561587;
        bh=7njdiHZdpjT/lY2sGX+b1AjE8LpOct8cmEhxr86H+H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdbfpW4cX8rjgZx83+WfTpViLrn4dTfOaEDb9b9FzB9JAx+TlY22M3DcgLZcDwsxI
         o4GgcTT+kBK6W79scynMcewukOj70s451PUNDrFOOt1gEzExCe6YjYEC4fJW7bBPlD
         FvBznO8Q269xQWKNVchNybuyoPrJ6mgJK/xbK/Ds=
Date:   Thu, 13 Feb 2020 10:39:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx: use generic name bus
Message-ID: <20200213023330.GK11096@dragon>
References: <1579156408-23739-1-git-send-email-peng.fan@nxp.com>
 <1579156408-23739-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579156408-23739-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:37:57AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per devicetree specification, generic names
> are recommended to be used, such as bus.
> 
> i.MX AIPS is a AHB - IP bridge bus, so
> we could use bus as node name.
> 
> Script:
> sed -i "s/\<aips@/bus@/" arch/arm/boot/dts/imx*.dtsi
> sed -i "s/\<aips-bus@/bus@/" arch/arm/boot/dts/imx*.dtsi
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/boot/dts/imx25.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx31.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx35.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx50.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx51.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx53.dtsi   | 4 ++--
>  arch/arm/boot/dts/imx6dl.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6q.dtsi   | 2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
>  arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6sll.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
>  arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
>  arch/arm/boot/dts/imx6ull.dtsi | 2 +-
>  arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
>  16 files changed, 31 insertions(+), 31 deletions(-)

We may want to cover Vybrid family (see vf500.dtsi, vfxxx.dtsi) as well.

Shawn
