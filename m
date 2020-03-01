Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F69C3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556402468D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583077912;
	bh=0ECRyP8P+2X0wVBMmme9Nxf2Jw6MqATtTdznUZ/M/gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CX6BTsSI1yU9m7FefOWmDvNJYp0sWgBy4d6biued9dvXdogAA5lxZQ5vRv6JYcc+8
	 znZzeUUBGLOBvh3/tjFPl3T6T1VOBgK0i8bsdRBVdHPkNcXw8Zz5epNXyPtpFto0kX
	 m+k6mvY4ystbkZWMmwWiQDoB/8qPwAK5JvKPD4lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCAPvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAPvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:51:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F9024677;
        Sun,  1 Mar 2020 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583077910;
        bh=0ECRyP8P+2X0wVBMmme9Nxf2Jw6MqATtTdznUZ/M/gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=keMmWRrDdNZAgTEqGFo7Vy3pVDORPAH00Dx0GKWEhR/y/ZPoXARYdEfP0gUHKrKgF
         cY5PdprfxgIJbn8+Upd4TAwNDl0Xv00AQAQAeo7J4mFx3bLWfsyXSvcGVSdkIiFTOS
         r1XzXFr9fgWDlXqqgjaVUn7YB5QF086fT4q9aF+k=
Date:   Sun, 1 Mar 2020 15:51:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <info@metux.net>, <allison@lohutok.net>, <tglx@linutronix.de>
Subject: Re: [PATCH] iio: adc: ti-tlc4541: Use new structure for SPI
 transfer delays
Message-ID: <20200301155143.538be150@archlinux>
In-Reply-To: <20200227123427.20249-1-sergiu.cuciurean@analog.com>
References: <20200227123427.20249-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 14:34:27 +0200
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-tlc4541.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
> index 4965246808bd..77620359b54c 100644
> --- a/drivers/iio/adc/ti-tlc4541.c
> +++ b/drivers/iio/adc/ti-tlc4541.c
> @@ -189,7 +189,8 @@ static int tlc4541_probe(struct spi_device *spi)
>  	/* Setup default message */
>  	st->scan_single_xfer[0].rx_buf = &st->rx_buf[0];
>  	st->scan_single_xfer[0].len = 3;
> -	st->scan_single_xfer[1].delay_usecs = 3;
> +	st->scan_single_xfer[1].delay.value = 3;
> +	st->scan_single_xfer[1].delay.unit = SPI_DELAY_UNIT_NSECS;
>  	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
>  	st->scan_single_xfer[2].len = 2;
>  

