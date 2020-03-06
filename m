Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEBC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A173217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgCFHlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:41:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:41:46 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7c6-0000Vx-G3; Fri, 06 Mar 2020 08:41:42 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7c4-0004F5-4R; Fri, 06 Mar 2020 08:41:40 +0100
Date:   Fri, 6 Mar 2020 08:41:40 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/1] pwm: mediatek: add longer period support
Message-ID: <20200306074140.6oyxk6cn7m4qg25f@pengutronix.de>
References: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
 <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 06:19:15PM +0800, Sam Shih wrote:
> The pwm clock source could be divided by 1625 with PWM_CON
> BIT(3) setting in mediatek hardware.
> 
> This patch add support for longer pwm period configuration,
> which allowing blinking LEDs via pwm interface.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index b94e0d09c300..c64ecff6c550 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -121,8 +121,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			       int duty_ns, int period_ns)
>  {
>  	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
> -	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
> -	    reg_thres = PWMTHRES;
> +	/* The source clock is divided by 2^clkdiv or iff the clksel bit
> +	 * is set by (2^clkdiv*1625)
> +	 */

Please put the /* on it's own line. See
https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

> +	u32 clkdiv = 0, clksel = 0, cnt_period, cnt_duty,
> +	    reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
>  	u64 resolution;
>  	int ret;
>  
> @@ -133,12 +136,30 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	/* Using resolution in picosecond gets accuracy higher */
>  	resolution = (u64)NSEC_PER_SEC * 1000;
> +	/* Calculate resolution based on current clock frequency */
>  	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> -
> +	/* Using resolution to calculate cnt_period which represents
> +	 * the effective range of the PWM period counter
> +	 */
>  	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);

The existing code is rather bad. A better approach to calulate
cnt_period (with a single division and higher accuracy):

	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * clk_get_rate(..), NSEC_PER_SEC);


>  	while (cnt_period > 8191) {
> +		/* Using clkdiv to reduce clock frequency and calculate
> +		 * new resolution based on new clock speed
> +		 */
>  		resolution *= 2;
>  		clkdiv++;
> +		if (clkdiv > PWM_CLK_DIV_MAX && !clksel) {
> +			/* Using clksel to divide the pwm source clock by
> +			 * an additional 1625, and recalculate new clkdiv
> +			 * and resolution
> +			 */
> +			clksel = 1;
> +			clkdiv = 0;
> +			resolution = (u64)NSEC_PER_SEC * 1000 * 1625;
> +			do_div(resolution,
> +				clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
> +		}
> +		/* Calculate cnt_period based on resolution */
>  		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
>  						   resolution);
>  	}
> @@ -158,8 +179,13 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		reg_thres = PWM45THRES_FIXUP;
>  	}
>  
> +	/* Calculate cnt_duty based on resolution */
>  	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);

Using resolution as divisor is bad here, too, so the way to calculate
cnt_duty should be changed accordingly.

I think if the driver is simplified first, maybe even getting rid of the
while loop, your change will get considerably easier, too.

> -	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> +	if (clksel)
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) |
> +				    clkdiv);
> +	else
> +		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
>  	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
