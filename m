Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55084C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDCE206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9IFHoc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgD1L50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:57:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgD1L50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:57:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SBrfwl005143;
        Tue, 28 Apr 2020 11:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KHi6fvaD2uJvu2rcnQ4wc0VGBk37Fi+D8Jgv6syjzbg=;
 b=R9IFHoc2PgFLX0WlZrlJPbJRE/DD/bv+X/Oom16IvazmwUOPi4oO+JLHh8g+2jLJnMUm
 XkeisqmUIH4RsAyj7eP6bDkrgO2+L/cNJuOnjdbWwiQkCeYQLImpn/nO2J9vnOVPL7JS
 kdnZSSzWQMVL3jHpb/Bt0Ekg9CXK6PZEQnlpq9otssivt5536CzG5H09rhnZVEx7Wl2j
 LdQkOVk2JQfW0wNRxuhaFfJzcvWC58dNNikE+bmRVR4gDagTV5uXMtjdjU88iiQhMpwX
 /65eF3Mi9Jf4zg1VsqUUuKWkOfEhCAcmjc3n1eBuUTKPA9yZIfuG9sPa8k4j3X0+f0za Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30p2p04p6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 11:57:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SBgxLQ153203;
        Tue, 28 Apr 2020 11:55:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30my0cvxv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 11:55:20 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SBtHQ3011532;
        Tue, 28 Apr 2020 11:55:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 04:55:17 -0700
Date:   Tue, 28 Apr 2020 14:55:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: stratix10-svc: Fix some error handling paths
 in 'stratix10_svc_drv_probe()'
Message-ID: <20200428115510.GA2014@kadam>
References: <20200426190307.40840-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426190307.40840-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=2 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=2 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 09:03:07PM +0200, Christophe JAILLET wrote:
> If an error occurs after calling 'kfifo_alloc()', the allocated memory
> should be freed with 'kfifo_free()', as already done in the remove
> function.
> 
> Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/firmware/stratix10-svc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index d5f0769f3761..cc9df9589195 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1043,24 +1043,31 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>  
>  	/* add svc client device(s) */
>  	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
> -	if (!svc)
> -		return -ENOMEM;
> +	if (!svc) {
> +		ret = -ENOMEM;
> +		goto err_free_kfifo;
> +	}
>  
>  	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
>  	if (!svc->stratix10_svc_rsu) {
>  		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_free_kfifo;
>  	}
>  
>  	ret = platform_device_add(svc->stratix10_svc_rsu);
>  	if (ret) {
>  		platform_device_put(svc->stratix10_svc_rsu);

Why not move this to the unwind code as well and do "goto put_platform;"?

regards,
dan carpenter

> -		return ret;
> +		goto err_free_kfifo;
>  	}
>  	dev_set_drvdata(dev, svc);
>  
>  	pr_info("Intel Service Layer Driver Initialized\n");
>  
> +	return 0;
> +
> +err_free_kfifo:
> +	kfifo_free(&controller->svc_fifo);
>  	return ret;
>  }

