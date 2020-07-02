Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811F420CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jCOfj4zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGBSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgGBSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:30:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A79C08C5C1;
        Thu,  2 Jul 2020 11:30:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D7EB293;
        Thu,  2 Jul 2020 20:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593714601;
        bh=hhendKEal8NhhQf3aUbKRjlfcErlw7igeXhBWipDuG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCOfj4zDiHBDwNN4YtuHiyOXemcvHQ6phNqKHA2+0ZvuvT8wCAlnADNrl8NBYjcAz
         9KVYZ56IFnRZPQKK+myOFrlB7G/y1N0ondBlFK6qkXmaKsPbxva9a5l/+7qfrbErHi
         tXvI8xLo7JtXi6KMg7BWMcDf01aHZ3fVJZbFU7tk=
Date:   Thu, 2 Jul 2020 21:29:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, j.remmet@phytec.de, sfr@canb.auug.org.au,
        georg.waibel@wiedemann-group.de, Georg.Waibel@wiedemann-group.com,
        chen.fang@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, horia.geanta@nxp.com,
        andrew.smirnov@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V5 0/6] Support building i.MX ARMv7/ARMv8 platforms clock
 driver as module
Message-ID: <20200702182957.GO12562@pendragon.ideasonboard.com>
References: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593703441-16944-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Jul 02, 2020 at 11:23:55PM +0800, Anson Huang wrote:
> Nowdays, there are more and more requirements of building SoC specific
> drivers as modules, such as Android GKI (generic kernel image), this
> patch set supports building i.MX ARMv6/ARMv7 SoCs clock drivers as modules,

I'm curious, how does the system boot to userspace to be able to load
modules without clock support in the kernel ? What if the driver for the
device storing the rootfs cope with clocks not being available ? Does
this require an initramfs with the clock module ? Even then, how does
the serial port driver cope with not having clocks ?

> The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to support
> various build options, and i.MX1/2/3 platforms now still ONLY support built-in
> as they are rarely used now.
> 
> Changes since V4:
> 	- add empty function of imx_register_uart_clocks() for MODULE build, then
> 	  all earlycon related clock handler can be built-out for MODULE;
> 	- add module build support for ARMv7 platforms, also add COMPILE_TEST for them;
> 	- add COMPILE_TEST for ARMv8 platforms;
> 	- keep using builtin_platform_driver() for i.MX8QXP clock driver.
> 
> Anson Huang (6):
>   clk: composite: Export clk_hw_register_composite()
>   clk: imx: Support module build for i.MX5/6/7 and vf610
>   clk: imx: Support building i.MX common clock driver as module
>   clk: imx: Add clock configuration for ARMv7 platforms
>   clk: imx8m: Support module build
>   clk: imx8qxp: Support building i.MX8QXP clock driver as module
> 
>  drivers/clk/clk-composite.c        |   1 +
>  drivers/clk/imx/Kconfig            | 101 ++++++++++++++++++++++++++++++++-----
>  drivers/clk/imx/Makefile           |  79 ++++++++++++++---------------
>  drivers/clk/imx/clk-composite-8m.c |   2 +
>  drivers/clk/imx/clk-cpu.c          |   2 +
>  drivers/clk/imx/clk-frac-pll.c     |   2 +
>  drivers/clk/imx/clk-gate2.c        |   2 +
>  drivers/clk/imx/clk-imx5.c         |   5 ++
>  drivers/clk/imx/clk-imx6q.c        |   5 ++
>  drivers/clk/imx/clk-imx6sl.c       |   5 ++
>  drivers/clk/imx/clk-imx6sll.c      |   5 ++
>  drivers/clk/imx/clk-imx6sx.c       |   5 ++
>  drivers/clk/imx/clk-imx6ul.c       |   5 ++
>  drivers/clk/imx/clk-imx7d.c        |   5 ++
>  drivers/clk/imx/clk-imx7ulp.c      |   5 ++
>  drivers/clk/imx/clk-imx8mm.c       |   4 ++
>  drivers/clk/imx/clk-imx8mn.c       |   4 ++
>  drivers/clk/imx/clk-imx8mp.c       |   4 ++
>  drivers/clk/imx/clk-imx8mq.c       |   4 ++
>  drivers/clk/imx/clk-imx8qxp-lpcg.c |   4 ++
>  drivers/clk/imx/clk-imx8qxp.c      |   4 ++
>  drivers/clk/imx/clk-pll14xx.c      |   5 ++
>  drivers/clk/imx/clk-sscg-pll.c     |   2 +
>  drivers/clk/imx/clk-vf610.c        |   5 ++
>  drivers/clk/imx/clk.c              |  17 +++++--
>  drivers/clk/imx/clk.h              |   6 +++
>  26 files changed, 231 insertions(+), 57 deletions(-)

-- 
Regards,

Laurent Pinchart
