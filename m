Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A04C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299F1217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFHoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:44:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38919 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCFHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:44:45 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7ez-0000q2-1k; Fri, 06 Mar 2020 08:44:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7ey-0004Fd-KA; Fri, 06 Mar 2020 08:44:40 +0100
Date:   Fri, 6 Mar 2020 08:44:40 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RESEND v6 1/2] pwm: Convert drivers to use 64-bit period and
 duty cycle
Message-ID: <20200306074440.ykekwwlvnbodxkjc@pengutronix.de>
References: <cover.1583177501.git.gurus@codeaurora.org>
 <28090aef9900ad483cbfbe77883e5ffcd8745907.1583177501.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28090aef9900ad483cbfbe77883e5ffcd8745907.1583177501.git.gurus@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 02, 2020 at 11:34:22AM -0800, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
> 
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by making the relevant fixes to those drivers that use the
> period and duty_cycle pwm struct members in division operations, viz.
> replacing the division operations with 64-bit division macros as
> appropriate. The actual switch to u64 period and duty_cycle follows as a
> separate patch.
> 
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
> 
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64
> 
> The kbuild test robot helped to improve this patch by catching a couple
> of code sites that had to be adapted.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/clk/clk-pwm.c                      | 2 +-
>  drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
>  drivers/hwmon/pwm-fan.c                    | 2 +-
>  drivers/media/rc/ir-rx51.c                 | 3 ++-
>  drivers/pwm/pwm-clps711x.c                 | 2 +-
>  drivers/pwm/pwm-imx-tpm.c                  | 2 +-
>  drivers/pwm/pwm-imx27.c                    | 5 ++---
>  drivers/pwm/pwm-sifive.c                   | 2 +-
>  drivers/pwm/pwm-sti.c                      | 5 +++--
>  drivers/pwm/pwm-stm32-lp.c                 | 2 +-
>  drivers/pwm/pwm-sun4i.c                    | 2 +-
>  drivers/video/backlight/pwm_bl.c           | 3 ++-

I guess we need acks from the affected maintainers. While I think the
changes are fine I think you won't evade having to expand the audience
of your patch and (depending on feedback) maybe split this patch up
further.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
