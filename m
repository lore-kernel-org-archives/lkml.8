Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADC6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F8020775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgFZKiS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgFZKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:38:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E170FC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 03:38:17 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jolkN-00052u-M3; Fri, 26 Jun 2020 12:38:15 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jolkL-0000fO-FW; Fri, 26 Jun 2020 12:38:13 +0200
Message-ID: <69be7e39936ced4501107aeff6a93ca930e62f49.camel@pengutronix.de>
Subject: Re: [PATCH v1] reset: intel: fix a compile warning about REG_OFFSET
 redefined
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dejin Zheng <zhengdejin5@gmail.com>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Fri, 26 Jun 2020 12:38:13 +0200
In-Reply-To: <20200604153039.22957-1-zhengdejin5@gmail.com>
References: <20200604153039.22957-1-zhengdejin5@gmail.com>
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

Hi Dejin,

On Thu, 2020-06-04 at 23:30 +0800, Dejin Zheng wrote:
> kernel test robot reports a compile warning about REG_OFFSET redefined
> in the reset-intel-gw.c after merging commit e44ab4e14d6f4 ("regmap:
> Simplify implementation of the regmap_read_poll_timeout() macro"). the
> warning is like that:
> 
> drivers/reset/reset-intel-gw.c:18:0: warning: "REG_OFFSET" redefined
>  #define REG_OFFSET GENMASK(31, 16)
> 
> In file included from ./arch/arm/mach-ixp4xx/include/mach/hardware.h:30:0,
>                  from ./arch/arm/mach-ixp4xx/include/mach/io.h:15,
>                  from ./arch/arm/include/asm/io.h:198,
>                  from ./include/linux/io.h:13,
>                  from ./include/linux/iopoll.h:14,
>                  from ./include/linux/regmap.h:20,
>                  from drivers/reset/reset-intel-gw.c:12:
> ./arch/arm/mach-ixp4xx/include/mach/platform.h:25:0: note: this is the location of the previous definition
>  #define REG_OFFSET 3
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e44ab4e14d6f4 ("regmap: Simplify implementation of the regmap_read_poll_timeout() macro")

Hm, shouldn't this rather be:

Fixes: c9aef213e38c ("reset: intel: Add system reset controller driver")

even though e44ab4e14d6f4 triggered the issue by including iopoll.h?

> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/reset/reset-intel-gw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
> index 854238444616..5cfb4892b399 100644
> --- a/drivers/reset/reset-intel-gw.c
> +++ b/drivers/reset/reset-intel-gw.c
> @@ -15,7 +15,7 @@
>  #define RCU_RST_STAT	0x0024
>  #define RCU_RST_REQ	0x0048
>  
> -#define REG_OFFSET	GENMASK(31, 16)
> +#define REG_OFFSET_MASK	GENMASK(31, 16)
>  #define BIT_OFFSET	GENMASK(15, 8)
>  #define STAT_BIT_OFFSET	GENMASK(7, 0)

Could you add the _MASK suffix to BIT_OFFSET and STAT_BIT_OFFSET as
well, for consistency?

regards
Philipp
