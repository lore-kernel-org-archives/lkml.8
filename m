Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74582C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1623B44
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MsNi9wpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgDFOOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:14:00 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24086 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDFOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586182440; x=1617718440;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VxBfFZSMnzPlZNHz2TtxxRNY5T+Ta8nxtKmyydIYbJ8=;
  b=MsNi9wpVJ4LPhBvYoZhg6lnl58RjzTiawO2AS6+GZpB+CUIfYkREpqwf
   R7DPgqIaWtPjoUpSnkGEmNeT/f1Zlr00MlXCEWGXMLbnqPvO/U+/K1mCa
   nrPQUmqH1cV9YDwllJzVMptx5mLD349jQnHBx0bkYKjPOrWnsQw++DSad
   h6xdZNaUGZcq94f8sBgfXR+nUuYH9Wee5qzB+MHavDUaue7GYR+UEM/q+
   kdG8Unx9vMZhEEfDeniBR638acPt91jx1+5BrMPxJuli3r2Tov084axhE
   T5U0o8gAxipYCqI5Q0fcUPlSH9g4VDdYBSYGn95jdOMK9yqGfEBNGT9+/
   w==;
IronPort-SDR: 3dhHBhElSxHQC59mGMY0HVh7OBNkgad/SlfGf8LOeUnqPpr8jm+FFOjg8EX/1MI5BisywgXgYc
 pdPi4XsnSPa3UOej5f/VB5P14Sv9FOvnpQ6byLPegzF5YxnjLX3CwErHzBFsaCBJk1PRz6kL03
 l4Kgs29BkGfq6w4xZ+OapMJJDSJHi1IFkVcvlpIEymygXGyUROheYBIq8bgUuu4pNxuXib6TRp
 9AF9NC1IutFhGz1I5nyb0CDM41BulqXLEWvVxc6Jg/cDzE82ULYI7cOdKTuwQHC7swyYNfoTZd
 Ejc=
X-IronPort-AV: E=Sophos;i="5.72,351,1580799600"; 
   d="scan'208";a="71546329"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2020 07:13:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Apr 2020 07:13:57 -0700
Received: from [10.205.29.84] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 6 Apr 2020 07:14:05 -0700
Subject: Re: [PATCH] video: fbdev: don't print error message on
 platform_get_irq() failure
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        <b.zolnierkie@samsung.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d6c8f07c-a57e-45ef-429a-d627ba7d7ce0@microchip.com>
Date:   Mon, 6 Apr 2020 16:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2020 at 07:34, Tang Bin wrote:
> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>   drivers/video/fbdev/atmel_lcdfb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index d567f5d56..1e2521925 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
> 
>          sinfo->irq_base = platform_get_irq(pdev, 0);
>          if (sinfo->irq_base < 0) {
> -               dev_err(dev, "unable to get irq\n");
>                  ret = sinfo->irq_base;
>                  goto stop_clk;
>          }
> --
> 2.20.1.windows.1
> 
> 
> 


-- 
Nicolas Ferre
