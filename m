Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC6C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09DD20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgCKR2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:28:16 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:42678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730363AbgCKR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:28:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 447CF182CED2A;
        Wed, 11 Mar 2020 17:28:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bird04_64cb9a8d21023
X-Filterd-Recvd-Size: 2329
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 17:28:12 +0000 (UTC)
Message-ID: <0fed25f914c6f39b024dd3bbc4f11892c40f4a60.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit:
 Remove unnecessary conditions
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Wed, 11 Mar 2020 10:26:29 -0700
In-Reply-To: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
References: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 19:08 +0530, Shreeya Patel wrote:
> Remove if and else conditions since both are leading to the
> initialization of "valueDMATimeout" and "valueDMAPageCount" with
> the same value.

You might consider removing the
	/* Timeout value is calculated by 34 / (2^n) */
comment entirely as it doesn't make much sense.

For what N is "(34 / (2 ^ N))" = 6 ?

> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
[]
> @@ -551,18 +551,11 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
>  
>  	pregistrypriv = &padapter->registrypriv;
>  
> -	if (pregistrypriv->wifi_spec) {
> -		/*  2010.04.27 hpfan */
> -		/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
> -		/*  Timeout value is calculated by 34 / (2^n) */
> -		valueDMATimeout = 0x06;
> -		valueDMAPageCount = 0x06;
> -	} else {
> -		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
> -		/*  TX/RX Balance */
> -		valueDMATimeout = 0x06;
> -		valueDMAPageCount = 0x06;
> -	}
> +	/*  2010.04.27 hpfan */
> +	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
> +	/*  Timeout value is calculated by 34 / (2^n) */
> +	valueDMATimeout = 0x06;
> +	valueDMAPageCount = 0x06;


