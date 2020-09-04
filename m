Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A20BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708A42074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIDPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:41:53 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3015 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgIDPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:41:47 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 98CE8240002;
        Fri,  4 Sep 2020 15:41:44 +0000 (UTC)
Date:   Fri, 4 Sep 2020 17:41:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 7/8] rtc: rx8010: fix indentation in probe()
Message-ID: <20200904154144.GL230586@piout.net>
References: <20200904152116.2157-1-brgl@bgdev.pl>
 <20200904152116.2157-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904152116.2157-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2020 17:21:15+0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Align the arguments passed to devm_rtc_device_register() with the upper
> line.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/rtc/rtc-rx8010.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
> index 181fc21cefa8..ed8ba38b4991 100644
> --- a/drivers/rtc/rtc-rx8010.c
> +++ b/drivers/rtc/rtc-rx8010.c
> @@ -450,7 +450,7 @@ static int rx8010_probe(struct i2c_client *client,
>  	}
>  
>  	rx8010->rtc = devm_rtc_device_register(&client->dev, client->name,
> -		&rx8010_rtc_ops, THIS_MODULE);
> +					       &rx8010_rtc_ops, THIS_MODULE);
>  

You have bonus points if you replace that patch by switching from
devm_rtc_device_register to devm_rtc_allocate_device and
rtc_register_device.

More bonus points if you also set range_min and range_max and then get
rid of the range checking in set_time.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
