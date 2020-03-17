Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB20C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCA320738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCQVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:10:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57651 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCQVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:10:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jEJTi-0004El-4i; Tue, 17 Mar 2020 22:10:22 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jEJTg-0004Ji-Mt; Tue, 17 Mar 2020 22:10:20 +0100
Date:   Tue, 17 Mar 2020 22:10:20 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: da9062: Fix include path
Message-ID: <20200317211020.4ozletmpvz67jytb@pengutronix.de>
References: <773115.1584420899@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <773115.1584420899@turing-police>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 22:06:02 up 123 days, 12:24, 152 users,  load average: 0.25, 0.16,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-17 00:54, Valdis Klētnieks wrote:
> Found during a allmodconfig build on ARM on an RPi4:
> 
>   CC      drivers/pinctrl/pinctrl-da9062.o
> drivers/pinctrl/pinctrl-da9062.c:28:10: fatal error: ../gpio/gpiolib.h: No such file or directory
>  #include <../gpio/gpiolib.h>
>           ^~~~~~~~~~~~~~~~~~~
> compilation terminated.

this should be fixed already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/pinctrl/pinctrl-da9062.c?id=2353810dac9ab72d3f835e3fb015c6819a0ef6c2

Regards,
  Marco

> 
> So... fix the errant include.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Fixes: 56cc3af4e8c8e ("pinctrl: da9062: add driver support")
> 
> diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
> index f704ee0b2fd9..cfbe529e66c3 100644
> --- a/drivers/pinctrl/pinctrl-da9062.c
> +++ b/drivers/pinctrl/pinctrl-da9062.c
> @@ -25,7 +25,7 @@
>   * We need this get the gpio_desc from a <gpio_chip,offset> tuple to decide if
>   * the gpio is active low without a vendor specific dt-binding.
>   */
> -#include <../gpio/gpiolib.h>
> +#include <../drivers/gpio/gpiolib.h>
>  
>  #define DA9062_TYPE(offset)		(4 * (offset % 2))
>  #define DA9062_PIN_SHIFT(offset)	(4 * (offset % 2))
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
