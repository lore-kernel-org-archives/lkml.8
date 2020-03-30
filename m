Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54726C2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E1420578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgC3QoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:44:03 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48833 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgC3QoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:44:03 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1DC86240008;
        Mon, 30 Mar 2020 16:44:00 +0000 (UTC)
Date:   Mon, 30 Mar 2020 18:44:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     leoyang.li@nxp.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: rtc: fsl-ftm-alarm: add shutdown interface
Message-ID: <20200330164400.GE846876@piout.net>
References: <20200330122616.24044-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330122616.24044-1-biwen.li@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2020 20:26:16+0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add shutdown interface
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  drivers/rtc/rtc-fsl-ftm-alarm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
> index d7fa6c16f47b..118a775e8316 100644
> --- a/drivers/rtc/rtc-fsl-ftm-alarm.c
> +++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
> @@ -307,6 +307,15 @@ static int ftm_rtc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void ftm_rtc_shutdown(struct platform_device *pdev)
> +{
> +	struct ftm_rtc *rtc = platform_get_drvdata(pdev);
> +
> +	ftm_irq_acknowledge(rtc);
> +	ftm_irq_disable(rtc);
> +	ftm_clean_alarm(rtc);

If the alarm is able to start the platform, then you probably don't want
to disable the alarm on shutdown.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
