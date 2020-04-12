Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B58C2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A92072D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586685634;
	bh=DiVkzZNd9n/tfy3LeFZlnUenRZDPc3lnjjjY+IbeVWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cOxjdlmWt5hzJZ0HgKGG6W+Ke/abqfdihWe4yjm7QlCTLlhjMWp18x0wpTJwRuq9n
	 HVzWLrFdb5dZr0dE6BBjf/JK7eZ7tCaWfYM/KXax8xASwD6Fv11vt+Pm9PWuhZGaNY
	 bBFt3TdcePy8tYyuh2c4Zf0koYdx3paLbm8he428=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgDLKAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLKAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 06:00:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BBB206DA;
        Sun, 12 Apr 2020 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586685633;
        bh=DiVkzZNd9n/tfy3LeFZlnUenRZDPc3lnjjjY+IbeVWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0yglTGFxm5cYzae5V2eVokB6x2GZMQQMrbKhiRufFvQJeizSt/taN30+NtbnzLJRk
         hGgrPmc/LDW5rVEH4/pGUZNKaaTPu+b0A+ReIybpgpFPn1Hql5puaYF9/rTewCVf37
         8geZ+aGOf08pW0ziqu6eK6ESbY/e9G0zBjKfyXM8=
Date:   Sun, 12 Apr 2020 11:00:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alexandru.ardelean@analog.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis: Add a missing '\n' in a log message
Message-ID: <20200412110005.79af5069@archlinux>
In-Reply-To: <20200410171224.4633-1-christophe.jaillet@wanadoo.fr>
References: <20200410171224.4633-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 19:12:24 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Fixes: 1fd456702692 ("iio: imu: adis: add support product ID check in adis_initial_startup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index a8afd01de4f3..2e7d0d337f8f 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -419,7 +419,7 @@ int __adis_initial_startup(struct adis *adis)
>  
>  	if (prod_id != adis->data->prod_id)
>  		dev_warn(&adis->spi->dev,
> -			 "Device ID(%u) and product ID(%u) do not match.",
> +			 "Device ID(%u) and product ID(%u) do not match.\n",
>  			 adis->data->prod_id, prod_id);
>  
>  	return 0;

