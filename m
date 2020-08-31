Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889342068F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHaKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:53:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C87C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:53:14 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kChQv-0005Ks-5w; Mon, 31 Aug 2020 12:53:05 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1kChQu-0005Or-Ia; Mon, 31 Aug 2020 12:53:04 +0200
Date:   Mon, 31 Aug 2020 12:53:04 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Message-ID: <20200831105304.6qcpjfmranay6q4y@pengutronix.de>
References: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:45:32 up 290 days,  2:04, 282 users,  load average: 0.13, 0.09,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 20-09-01 00:48, Robin Gong wrote:
> BuckX enable mode
> 00b = OFF
> 01b = ON by PMIC_ON_REQ = H
> 10b = ON by PMIC_ON_REQ = H && PMIC_STBY_REQ = L
> 11b = Always ON
> 
> For such enable mode, enable_value should be clearly set in requlator desc,
> 00/11 is not enough, correct it now for different bucks. For example, buck2
> is designed for vddarm which could be off in 'PMIC_STBY_REQ = H' after kernel
> enter suspend, so should be set '10b' as ON, while others is '01b' as ON.
> All are the same as the default setting which means bucks no need to be
> enabled again during kernel boot even if they have been enabled already after
> pmic on.

I wouldn't hard-code the regulator behaviour because the behaviour comes
from the system design which in most cases are comming from our hw-guys.
Till now I saw a few intelligent designs don't following the pmic user
recommendations to save money. I would love to specify the regulator
behaviour/mode within the dt or acpi.

> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/regulator/pca9450-regulator.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> index eb5822b..79f2a5a 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -249,6 +249,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_mask = BUCK1OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK1CTRL,
>  			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  			.of_parse_cb = pca9450_set_dvs_levels,
>  		},
> @@ -273,7 +274,8 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
>  			.vsel_mask = BUCK2OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK2CTRL,
> -			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_mask = BUCK2_ENMODE_MASK,

Unrelated change?

> +			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
>  			.owner = THIS_MODULE,
>  			.of_parse_cb = pca9450_set_dvs_levels,
>  		},
> @@ -299,6 +301,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_mask = BUCK3OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK3CTRL,
>  			.enable_mask = BUCK3_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  			.of_parse_cb = pca9450_set_dvs_levels,
>  		},
> @@ -324,6 +327,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_mask = BUCK4OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK4CTRL,
>  			.enable_mask = BUCK4_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> @@ -342,6 +346,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_mask = BUCK5OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK5CTRL,
>  			.enable_mask = BUCK5_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> @@ -360,6 +365,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
>  			.vsel_mask = BUCK6OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK6CTRL,
>  			.enable_mask = BUCK6_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> @@ -475,6 +481,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_mask = BUCK1OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK1CTRL,
>  			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  			.of_parse_cb = pca9450_set_dvs_levels,
>  		},
> @@ -499,7 +506,8 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
>  			.vsel_mask = BUCK2OUT_DVS0_MASK,
>  			.enable_reg = PCA9450_REG_BUCK2CTRL,
> -			.enable_mask = BUCK1_ENMODE_MASK,
> +			.enable_mask = BUCK2_ENMODE_MASK,

Unrelated change?

Regards,
  Marco
> +			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
>  			.owner = THIS_MODULE,
>  			.of_parse_cb = pca9450_set_dvs_levels,
>  		},
> @@ -525,6 +533,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_mask = BUCK4OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK4CTRL,
>  			.enable_mask = BUCK4_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> @@ -543,6 +552,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_mask = BUCK5OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK5CTRL,
>  			.enable_mask = BUCK5_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> @@ -561,6 +571,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
>  			.vsel_mask = BUCK6OUT_MASK,
>  			.enable_reg = PCA9450_REG_BUCK6CTRL,
>  			.enable_mask = BUCK6_ENMODE_MASK,
> +			.enable_val = BUCK_ENMODE_ONREQ,
>  			.owner = THIS_MODULE,
>  		},
>  	},
> -- 
> 2.7.4
> 
