Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8BFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 20:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4894720787
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgEWUBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgEWUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 16:01:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC986C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 13:01:43 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcaKt-0007U9-AD; Sat, 23 May 2020 22:01:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jcaKj-0002Ig-7H; Sat, 23 May 2020 22:01:25 +0200
Date:   Sat, 23 May 2020 22:01:25 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     David Wu <david.wu@rock-chips.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Message-ID: <20200523200125.khdw3eau5eakxqy6@pengutronix.de>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
 <20190919111115.5oraof2bdl4627xv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919111115.5oraof2bdl4627xv@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Thu, Sep 19, 2019 at 01:11:15PM +0200, oUwe Kleine-König wrote:
> On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> > The way state->enabled is computed is rather convoluted and hard to
> > read - both branches of the if() actually do the exact same thing. So
> > remove the if(), and further simplify "<boolean condition> ? true :
> > false" to "<boolean condition>".
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> > I stumbled on this while trying to understand how the pwm subsystem
> > works. This patch is a semantic no-op, but it's also possible that,
> > say, the first branch simply contains a "double negative" so either
> > the != should be == or the "false : true" should be "true : false".
> 
> The change looks obviously right, it's a noop.
> 
> I share your doubts however. The construct was introduced in commit 
> 831b2790507b ("pwm: rockchip: Use same PWM ops for each IP") by David
> Wu.
> 
> Before there were rockchip_pwm_get_state_v1 for the supports_polarity =
> false case and rockchip_pwm_get_state_v2 for supports_polarity = true.
> 
> In both state->enabled was assigned true if ((val & enable_conf) ==
> enable_conf). So I assume everything is fine.
> 
> A confirmation by David would be great though.

This is still open. Can you please have a look at
https://patchwork.ozlabs.org/project/linux-pwm/patch/20190919091728.24756-1-linux@rasmusvillemoes.dk/
and verify it's correct?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
