Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91674C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C29C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDGSSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:18:13 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:44012 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:18:13 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6FAD8804D5;
        Tue,  7 Apr 2020 20:18:06 +0200 (CEST)
Date:   Tue, 7 Apr 2020 20:18:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     b.zolnierkie@samsung.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: fbdev: don't print error message on
 platform_get_irq() failure
Message-ID: <20200407181805.GC6356@ravnborg.org>
References: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=R5C9hjxsAAAA:8
        a=X_j5bIVzEBSOzoI8NEYA:9 a=CjuIK1q_8ugA:10 a=KpS7wOGxO9l4JKx0McS0:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tang Bin

On Mon, Apr 06, 2020 at 01:34:50PM +0800, Tang Bin wrote:
> The platform_get_irq() can print error message,so remove the redundant
> dev_err() here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index d567f5d56..1e2521925 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  
>  	sinfo->irq_base = platform_get_irq(pdev, 0);
>  	if (sinfo->irq_base < 0) {
> -		dev_err(dev, "unable to get irq\n");
>  		ret = sinfo->irq_base;
>  		goto stop_clk;
>  	}

Thanks, applied to drm-misc-next. The fix will appear in kernel 5.8

	Sam
