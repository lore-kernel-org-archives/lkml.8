Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8577EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D968208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGTJsQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGTJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:48:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:48:15 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxSP6-0006bt-2a; Mon, 20 Jul 2020 11:48:12 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jxSP5-0006ci-8k; Mon, 20 Jul 2020 11:48:11 +0200
Message-ID: <b1073a020623a5bda99c74d3b424a498d59b9ec3.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: reset-zynqmp: Added support for Versal
 platform
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        saikrishna12468@gmail.com
Date:   Mon, 20 Jul 2020 11:48:11 +0200
In-Reply-To: <1594708149-29944-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
         <1594708149-29944-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 11:59 +0530, Sai Krishna Potthuri wrote:
> Updated the reset driver to support Versal platform.
> As part of adding Versal support
> - Added Versal specific compatible string.
> - Reset Id and number of resets are different for Versal and ZynqMP,
> hence taken care of these two based on compatible string.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  drivers/reset/reset-zynqmp.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index 373ea8d4f7a1..17aa4532ec5e 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -12,9 +12,11 @@
>  
>  #define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
>  #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
> +#define VERSAL_NR_RESETS	95
>  
>  struct zynqmp_reset_data {
>  	struct reset_controller_dev rcdev;
> +	u32 reset_id;
>  };
>  
>  static inline struct zynqmp_reset_data *
> @@ -26,23 +28,28 @@ to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
>  static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> -	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +
> +	return zynqmp_pm_reset_assert(priv->reset_id + id,
>  				      PM_RESET_ACTION_ASSERT);
>  }
>  
>  static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
>  				 unsigned long id)
>  {
> -	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +
> +	return zynqmp_pm_reset_assert(priv->reset_id + id,
>  				      PM_RESET_ACTION_RELEASE);
>  }
>  
>  static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
>  	int val, err;
>  
> -	err = zynqmp_pm_reset_get_status(ZYNQMP_RESET_ID + id, &val);
> +	err = zynqmp_pm_reset_get_status(priv->reset_id + id, &val);
>  	if (err)
>  		return err;
>  
> @@ -52,7 +59,9 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
>  static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
>  			      unsigned long id)
>  {
> -	return zynqmp_pm_reset_assert(ZYNQMP_RESET_ID + id,
> +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> +
> +	return zynqmp_pm_reset_assert(priv->reset_id + id,
>  				      PM_RESET_ACTION_PULSE);
>  }
>  
> @@ -76,13 +85,20 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
>  	priv->rcdev.ops = &zynqmp_reset_ops;
>  	priv->rcdev.owner = THIS_MODULE;
>  	priv->rcdev.of_node = pdev->dev.of_node;
> +	priv->reset_id = ZYNQMP_RESET_ID;
>  	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "xlnx,versal-reset")) {

It would be better to use of_match_device and static const initalization
data for this.

> +		priv->reset_id = 0;
> +		priv->rcdev.nr_resets = VERSAL_NR_RESETS;

This won't work. All your reset ids are greater than 95, and this driver
is using the default of_xlate callback, so of_reset_simple_xlate will
fail all reset control requests with -EINVAL.

regards
Philipp
