Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16104C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9A220756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ALlj+W21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgEVQzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:55:44 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60420 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730306AbgEVQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:55:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04MGnfhZ002268;
        Fri, 22 May 2020 11:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=bWWdOf71DtZlvCAAxkPNTXnAH8vqYy+Ku/DszCAGbUk=;
 b=ALlj+W212CIqS1OzXH/LZPqi5RbUmk6ruPKe5g61hRm69msmtzU8bn9ZB+tgImY3PQNP
 0GLUslufWuZz1zeQPbkXAl2KI9VvGVZKanVJzQKKhhZ1WqK+fUofVkcP5VVPcVZvooJ4
 Q8PRIPBCgYIDASiuB8qM0SkGSx5RmiD8nx72DuEOHeUC+FLSgAy3SHxFy+BFLcqiMe+0
 +05Gx//41rZOnadP4OZDd5+H85Tzdbg2DweFVsOaC5pkjqkXWtbMKbdPlEKMnraZmbJn
 4Vsj4ZtU8d/g6e+/buWyoGTxu5UHfTR1L2ZFXaOBCP7Rw2kIlQbsWgxi6I70yZOqStc7 9g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 315ejkuf5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 11:55:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 May
 2020 17:55:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 May 2020 17:55:31 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9CA352AB;
        Fri, 22 May 2020 16:55:30 +0000 (UTC)
Date:   Fri, 22 May 2020 16:55:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extcon: arizona: Fix runtime PM imbalance on error
Message-ID: <20200522165530.GH71940@ediswmail.ad.cirrus.com>
References: <20200522110732.874-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200522110732.874-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 cotscore=-2147483648
 clxscore=1011 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 suspectscore=48 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 07:07:31PM +0800, Dinghao Liu wrote:
> When arizona_request_irq() returns an error code, a
> pairing runtime PM usage counter decrement is needed
> to keep the counter balanced. For error paths after
> this function, things are the same.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---

Good spot on the bug thank you.

>  drivers/extcon/extcon-arizona.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 7401733db08b..470bbc8e5089 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1744,6 +1744,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  err_rise:
>  	arizona_free_irq(arizona, jack_irq_rise, info);
>  err_gpio:
> +	pm_runtime_put(&pdev->dev);

However, I don't think this works as a fix. Firstly, the err_gpio
label is used before the call to pm_runtime_get_sync, this might
be ok since pm_runtime_enable hasn't been called yet but probably
better to add a new label for it.

Secondly, following the err_hpdet error path will also result in
a double put. In that case I don't think there is any reason why
we need to put before calling input_device_register so it might
just be simplest to move that put until after registering the
input device.

Thanks,
Charles

>  	gpiod_put(info->micd_pol_gpio);
>  err_register:
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 2.17.1
> 
