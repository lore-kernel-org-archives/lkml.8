Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E4C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BEA206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBQHlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:41:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52811 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgBQHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:41:40 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost.discworld.emantor.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1j3b2B-0007Cj-4F; Mon, 17 Feb 2020 08:41:39 +0100
Message-ID: <d7298ea03ab71c414aabc7cac13a7a7511e00ceb.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: imx: build v7_cpu_resume() unconditionally
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Date:   Mon, 17 Feb 2020 08:41:37 +0100
In-Reply-To: <20200116141849.73955-1-r.czerwinski@pengutronix.de>
References: <20200116141849.73955-1-r.czerwinski@pengutronix.de>
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Thu, 2020-01-16 at 15:18 +0100, Rouven Czerwinski wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> This function is not only needed by the platform suspend code, but is
> also
> reused as the CPU resume function when the ARM cores can be powered
> down
> completely in deep idle, which is the case on i.MX6SX and i.MX6UL(L).
> 
> Providing the static inline stub whenever CONFIG_SUSPEND is disabled
> means
> that those platforms will hang on resume from cpuidle if suspend is
> disabled.
> 
> So there are two problems:
> 
>   - The static inline stub masks the linker error
>   - The function is not available where needed
> 
> Fix both by just building the function unconditionally, when
> CONFIG_SOC_IMX6 is enabled. The actual code is three instructions
> long,
> so it's arguably ok to just leave it in for all i.MX6 kernel
> configurations.
> 
> Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for
> i.mx6sx")
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  arch/arm/mach-imx/Makefile       |  2 ++
>  arch/arm/mach-imx/common.h       |  4 ++--
>  arch/arm/mach-imx/resume-imx6.S  | 24 ++++++++++++++++++++++++
>  arch/arm/mach-imx/suspend-imx6.S | 14 --------------
>  4 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm/mach-imx/resume-imx6.S

Gentle ping.

Can be found on patchwork: https://patchwork.kernel.org/patch/11337147/

Thanks,
Rouven Czerwinski

