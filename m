Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB8820786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JK5i/SLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGHSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:53:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42162 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGHSxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:53:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 068Ira9O091203;
        Wed, 8 Jul 2020 13:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594234416;
        bh=nTomrXYkwRqq3jOOoD6vejCRSDO6/MCjKo32/i01cXo=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=JK5i/SLoK5L69kSJpfRuE0tQwlUGgFvGwuO+jFTao6A5W7nxYKLWX+oEnek9yNHJd
         7qRX60T51Vh2f5hY4OYiTi5TKy+siLQS8sRvUAnBvrt2him5fM6fhvYIaVW+Ht8qFW
         h1WkezRfh7TGVVvpPkShxlHiYYNKyi5QFZq6SnDA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 068IraBB051835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jul 2020 13:53:36 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 13:53:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 13:53:36 -0500
Received: from [10.250.34.57] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 068IraWt111801;
        Wed, 8 Jul 2020 13:53:36 -0500
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: REMOTE PROCESSOR
 (REMOTEPROC) SUBSYSTEM
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200708153822.15031-1-grandmaster@al2klimov.de>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f41ac867-e653-940d-374a-41e27f2697c3@ti.com>
Date:   Wed, 8 Jul 2020 13:53:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708153822.15031-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 10:38 AM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Suggest a revision of patch title to
"remoteproc: Replace HTTP links with HTTPS ones"

With that,
Acked-by: Suman Anna <s-anna@ti.com>

> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>   (Actually letting a shell for loop submit all this stuff for me.)
> 
>   If there are any URLs to be removed completely or at least not HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
> 
> 
>   drivers/remoteproc/da8xx_remoteproc.c    | 2 +-
>   drivers/remoteproc/keystone_remoteproc.c | 2 +-
>   drivers/remoteproc/omap_remoteproc.c     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 98e0be9476a4..9a4938c3025f 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -27,7 +27,7 @@ MODULE_PARM_DESC(da8xx_fw_name,
>   
>   /*
>    * OMAP-L138 Technical References:
> - * http://www.ti.com/product/omap-l138
> + * https://www.ti.com/product/omap-l138
>    */
>   #define SYSCFG_CHIPSIG0 BIT(0)
>   #define SYSCFG_CHIPSIG1 BIT(1)
> diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
> index cd266163a65f..252ac6e2f653 100644
> --- a/drivers/remoteproc/keystone_remoteproc.c
> +++ b/drivers/remoteproc/keystone_remoteproc.c
> @@ -2,7 +2,7 @@
>   /*
>    * TI Keystone DSP remoteproc driver
>    *
> - * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 6955fab0a78b..d191610454d9 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -2,7 +2,7 @@
>   /*
>    * OMAP Remote Processor driver
>    *
> - * Copyright (C) 2011-2020 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2011-2020 Texas Instruments Incorporated - https://www.ti.com/
>    * Copyright (C) 2011 Google, Inc.
>    *
>    * Ohad Ben-Cohen <ohad@wizery.com>
> 

