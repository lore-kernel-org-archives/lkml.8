Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B397C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F5246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgB1G7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:59:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1G7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:59:14 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7Zc5-0006dq-Rr; Fri, 28 Feb 2020 07:59:09 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j7Zc4-0008Ii-Od; Fri, 28 Feb 2020 07:59:08 +0100
Date:   Fri, 28 Feb 2020 07:59:08 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     support.opensource@diasemi.com, linus.walleij@linaro.org,
        Adam.Thomson.Opensource@diasemi.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] pinctrl: da9062: Fix error gpiolib.h path
Message-ID: <20200228065908.q435lc5ql3bnwc2p@pengutronix.de>
References: <20200228040047.14808-1-yuehaibing@huawei.com>
 <20200228063429.47528-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228063429.47528-1-yuehaibing@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:43:16 up 104 days, 22:01, 130 users,  load average: 0.08, 0.04,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

thanks for covering that and sorry for that bug. Didn't covered that
because I'm using a newer toolchain.

On 20-02-28 14:34, YueHaibing wrote:
> gcc 7.4.0 build fails:
> 
> drivers/pinctrl/pinctrl-da9062.c:28:10: fatal error: ../gpio/gpiolib.h: No such file or directory
>  #include <../gpio/gpiolib.h>
>           ^~~~~~~~~~~~~~~~~~~
> 
> Fix this wrong include path.

nit, the path isn't wrong. Whats wrong is the syntax.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> Fixes: 56cc3af4e8c8 ("pinctrl: da9062: add driver support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: Fix wrong path
> ---
>  drivers/pinctrl/pinctrl-da9062.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
> index f704ee0b2fd9..c15eb6e99bc1 100644
> --- a/drivers/pinctrl/pinctrl-da9062.c
> +++ b/drivers/pinctrl/pinctrl-da9062.c
> @@ -25,7 +25,7 @@
>   * We need this get the gpio_desc from a <gpio_chip,offset> tuple to decide if
>   * the gpio is active low without a vendor specific dt-binding.
>   */
> -#include <../gpio/gpiolib.h>
> +#include "../gpio/gpiolib.h"
>  
>  #define DA9062_TYPE(offset)		(4 * (offset % 2))
>  #define DA9062_PIN_SHIFT(offset)	(4 * (offset % 2))
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
