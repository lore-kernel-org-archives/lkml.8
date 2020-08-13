Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D39D20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMHd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:33:28 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49787 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMHd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:33:28 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 62C16C0005;
        Thu, 13 Aug 2020 07:33:25 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:33:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Victor Ding <victording@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: initialize rtc time when reading alarm
Message-ID: <20200813073325.GK3480@piout.net>
References: <20200813154020.1.Iaf7638a2f2a87ff68d85fcb8dec615e41340c97f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813154020.1.Iaf7638a2f2a87ff68d85fcb8dec615e41340c97f@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/08/2020 15:41:34+1000, Victor Ding wrote:
> cmos_read_alarm() may leave certain fields of a struct rtc_time
> untouched; therefore, these fields contain garbage if not properly
> initialized, leading to inconsistent values when converting into
> time64_t.
> This patch to set all fields of a struct rtc_time to -1 before calling
> cmos_read_alarm().
> 

I don't think this actually helps with the conversion as mktime64
is taking unsigned int so I would think you need the whole logic that is
in __rtc_read_alarm

> Signed-off-by: Victor Ding <victording@google.com>
> ---
> 
>  drivers/rtc/rtc-cmos.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index bcc96ab7793f..c99af567780d 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -1006,6 +1006,7 @@ static int cmos_suspend(struct device *dev)
>  			enable_irq_wake(cmos->irq);
>  	}
>  
> +	memset(&cmos->saved_wkalrm.time, -1, sizeof(struct rtc_time));
>  	cmos_read_alarm(dev, &cmos->saved_wkalrm);
>  
>  	dev_dbg(dev, "suspend%s, ctrl %02x\n",
> @@ -1054,6 +1055,7 @@ static void cmos_check_wkalrm(struct device *dev)
>  		return;
>  	}
>  
> +	memset(&current_alarm.time, -1, sizeof(struct rtc_time));
>  	cmos_read_alarm(dev, &current_alarm);
>  	t_current_expires = rtc_tm_to_time64(&current_alarm.time);
>  	t_saved_expires = rtc_tm_to_time64(&cmos->saved_wkalrm.time);
> -- 
> 2.28.0.236.gb10cc79966-goog
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
