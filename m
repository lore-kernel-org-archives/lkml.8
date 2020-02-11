Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ECC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B84E20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kc0nANLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBKJYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:24:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBKJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:24:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B9ELRu104881;
        Tue, 11 Feb 2020 09:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=0qUVxjzf2QqnC2Y7oVbJJ3KMjgd8797fWBccis9x61w=;
 b=kc0nANLb+izqhEptDHGMlYYuxdxolAJ/DvY/OSdG8TZ8z6TnhnJ6CPIJOY1oIqDTlRaR
 dIOhiEEfnRk85Kro+jXJaLpgOzT8pc5QhwZ/A2n5XZgkiNohgtgKSvKNpnJG96qfQsV7
 E7Xlp+R4MHyx5NkaV0bLA5f1n5vwuBjFo9rmNcvF42rwed+9HFEpIH0VKnS23GElMMqw
 MLFfzVol/iT/X8MpGFZjvuXz8MCm/ARxTewfXNWqv16hSZjaiD7Fz991/C6xo3qAdyWK
 Kj5zCt2XU6BfcK4tQpH3jU2WOBmltXGUnoxZxY1MSlEQupyvqW9voP4hNKCRt0i10v3X mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k881xjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 09:24:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B9CxIx033252;
        Tue, 11 Feb 2020 09:24:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y26fgtxju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 09:24:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01B9O3a3008057;
        Tue, 11 Feb 2020 09:24:03 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 01:24:02 -0800
Date:   Tue, 11 Feb 2020 12:23:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [[PATCH staging] 3/7] staging: wfx: fix init/remove vs IRQ race
Message-ID: <20200211092354.GE1778@kadam>
References: <cover.1581410026.git.mirq-linux@rere.qmqm.pl>
 <8f0c51acc3b98fc55d6960036daef7556445cd0a.1581410026.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f0c51acc3b98fc55d6960036daef7556445cd0a.1581410026.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=8
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=8 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:46:54AM +0100, Michał Mirosław wrote:
> @@ -218,9 +218,9 @@ static int wfx_sdio_probe(struct sdio_func *func,
>  	return 0;
>  
>  err3:
> -	wfx_free_common(bus->core);
> +	wfx_sdio_irq_unsubscribe(bus);
>  err2:
> -	wfx_sdio_irq_unsubscribe(bus);
> +	wfx_free_common(bus->core);
>  err1:
>  	sdio_claim_host(func);
>  	sdio_disable_func(func);
> @@ -234,8 +234,8 @@ static void wfx_sdio_remove(struct sdio_func *func)
>  	struct wfx_sdio_priv *bus = sdio_get_drvdata(func);
>  
>  	wfx_release(bus->core);
> -	wfx_free_common(bus->core);
>  	wfx_sdio_irq_unsubscribe(bus);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This calls sdio_release_host(func);

> +	wfx_free_common(bus->core);
>  	sdio_claim_host(func);
>  	sdio_disable_func(func);
>  	sdio_release_host(func);
        ^^^^^^^^^^^^^^^^^^^^^^^^
so is this a double free?

> diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
> index 3ba705477ca8..2b108a9fa5ae 100644
> --- a/drivers/staging/wfx/bus_spi.c
> +++ b/drivers/staging/wfx/bus_spi.c
> @@ -211,20 +211,22 @@ static int wfx_spi_probe(struct spi_device *func)
>  		udelay(2000);
>  	}
>  
> -	ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
> -			       IRQF_TRIGGER_RISING, "wfx", bus);
> -	if (ret)
> -		return ret;
> -
>  	INIT_WORK(&bus->request_rx, wfx_spi_request_rx);
>  	bus->core = wfx_init_common(&func->dev, &wfx_spi_pdata,
>  				    &wfx_spi_hwbus_ops, bus);
>  	if (!bus->core)
>  		return -EIO;
>  
> +	ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
> +			       IRQF_TRIGGER_RISING, "wfx", bus);
> +	if (ret)
> +		return ret;

Shouldn't this call wfx_free_common(bus->core); before returning?

> +
>  	ret = wfx_probe(bus->core);
> -	if (ret)
> +	if (ret) {
> +		devm_free_irq(&func->dev, func->irq, bus);

We shouldn't have to free devm_ resource.

>  		wfx_free_common(bus->core);
> +	}
>  
>  	return ret;
>  }
> @@ -234,11 +236,11 @@ static int wfx_spi_remove(struct spi_device *func)
>  	struct wfx_spi_priv *bus = spi_get_drvdata(func);
>  
>  	wfx_release(bus->core);
> -	wfx_free_common(bus->core);
>  	// A few IRQ will be sent during device release. Hopefully, no IRQ
>  	// should happen after wdev/wvif are released.
>  	devm_free_irq(&func->dev, func->irq, bus);

Is this devm_ free required?

>  	flush_work(&bus->request_rx);
> +	wfx_free_common(bus->core);
>  	return 0;
>  }

regards,
dan carpenter

