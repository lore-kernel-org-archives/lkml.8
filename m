Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4144BC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F5F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgBCLF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:05:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34991 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgBCLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:05:57 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iyZY5-00046n-Hb; Mon, 03 Feb 2020 12:05:49 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iyZY1-00028x-QW; Mon, 03 Feb 2020 12:05:45 +0100
Date:   Mon, 3 Feb 2020 12:05:45 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: librem5-devkit: add lsm9ds1 mount matrix
Message-ID: <20200203110545.GB24291@pengutronix.de>
References: <20200120100722.30359-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120100722.30359-1-martin.kepplinger@puri.sm>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:57:57 up 157 days, 23:12, 161 users,  load average: 0.07, 0.17,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 20-01-20 11:07, Martin Kepplinger wrote:
> The IMU chip on the librem5-devkit is not mounted at the "natural" place
> that would match normal phone orientation (see the documentation for the
> details about what that is).
> 
> Since the lsm9ds1 driver supports providing a mount matrix, we can describe
> the orientation on the board in the dts:

I didn't found the patch which adds the iio_read_mount_matrix()
support. Appart of that your patch looks good so feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de> 

Regards,
  Marco

> Create a right-handed coordinate system (x * -1; see the datasheet for the
> axis) and rotate 180 degrees around the y axis because the device sits on
> the back side from the display.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> tested on the librem5-devkit of course, finally fixing the orientation problem
> for the accelerometer :)
> 
> thanks,
> 
>                             martin
> 
> 
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 703254282b96..6c8ab009081b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -457,6 +457,9 @@
>  		reg = <0x6a>;
>  		vdd-supply = <&reg_3v3_p>;
>  		vddio-supply = <&reg_3v3_p>;
> +		mount-matrix =  "1",  "0",  "0",
> +				"0",  "1",  "0",
> +				"0",  "0", "-1";
>  	};
>  };
>  
> -- 
> 2.20.1
