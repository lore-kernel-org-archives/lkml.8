Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0146C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756A82076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394063AbgDOObr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394037AbgDOObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9279FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:31:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOj4i-0001Jj-5x; Wed, 15 Apr 2020 16:31:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOj4f-0000B7-TU; Wed, 15 Apr 2020 16:31:33 +0200
Date:   Wed, 15 Apr 2020 16:31:33 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     wsa@the-dreams.de, o.rempel@pengutronix.de, ardb@kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] i2c: drivers: Avoid unnecessary check in
 efm32_i2c_probe()
Message-ID: <20200415143133.qwbes5whbqx5jf2j@pengutronix.de>
References: <20200415140640.19948-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415140640.19948-1-tangbin@cmss.chinamobile.com>
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

On Wed, Apr 15, 2020 at 10:06:40PM +0800, Tang Bin wrote:
> The function efm32_i2c_probe() is only called with an
> openfirmware platform device.Therefore there is no need
> to check that it has an openfirmware node.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>

Same things apply as in the previous patch. (space after punctuation,
Sob of sender should be last)

> ---
>  drivers/i2c/busses/i2c-efm32.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
> index 4de31fae7..4786ef6b2 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -312,9 +312,6 @@ static int efm32_i2c_probe(struct platform_device *pdev)
>  	int ret;
>  	u32 clkdiv;
>  
> -	if (!np)
> -		return -EINVAL;
> -

I don't care much about this change. While the statement that this
driver is only instantiated on dt platforms is probably right,
explicitly checking for it might still prevent surprises later, serves
as explicit statement for the driver reader that non-dt isn't supposed
to work and given that the check is cheap I tend slightly to just keep
it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
