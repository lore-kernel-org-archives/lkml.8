Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEFC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A17B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SlWK4bpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgBKOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:25:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgBKOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:25:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BE8TeY039237;
        Tue, 11 Feb 2020 14:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PpYYwjfoBRikygNpgflbPjeJfJ8t4TVGHGA07sm2hFQ=;
 b=SlWK4bpqL19iHWpiuiq87GCSLAHcSqOGrGwcA5O+frS+zQLvF/B/4Ij2N6vju1Zm1Epg
 gNySD+4SWyjAttwyeafLhsYDh54N43PICK2dGTdM9YakvYNsDoLrOAk8eqccAH9JtncN
 b+d8UI+tY/Tea90BZyjQkwi4TuyXp9IMQpUfCs6+MCn4V97YRxir69ovdUgVMlK6JVSQ
 5P1Wbt2G1197BSRrPQm5QItMNb2qahzD/k29NNm+kK2M/T8wMtQ6A8sJqT9oVqadwyiA
 OuJY7iqP9W30pfuq/WHS7cCCQE20K2qTXdWwb/XWn7xcKBApix13OY+43na3VL0nr9/2 Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y2jx63ugf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 14:24:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BE8Sxt108489;
        Tue, 11 Feb 2020 14:24:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y26sr7vp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 14:24:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01BEOgAu010402;
        Tue, 11 Feb 2020 14:24:42 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 06:24:41 -0800
Date:   Tue, 11 Feb 2020 17:24:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org,
        wahrenst@gmx.net, jamal.k.shareef@gmail.com,
        marcgonzalez@google.com, nishkadg.linux@gmail.com,
        nachukannan@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] staging: vc04_services: remove set but unused
 variable 'local_entity_uc'
Message-ID: <20200211142433.GG1778@kadam>
References: <20200211134356.59904-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211134356.59904-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:43:56PM +0800, YueHaibing wrote:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_use_internal:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2346:16:
>  warning: variable local_entity_uc set but not used [-Wunused-but-set-variable]
> 
> commit bd8aa2850f00 ("staging: vc04_services: Get of even more suspend/resume states")
> left behind this unused variable.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index c456ced..d30d24d 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -2343,7 +2343,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>  	enum vchiq_status ret = VCHIQ_SUCCESS;
>  	char entity[16];
>  	int *entity_uc;
> -	int local_uc, local_entity_uc;
> +	int local_uc;
>  
>  	if (!arm_state)
>  		goto out;
> @@ -2367,7 +2367,6 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>  
>  	write_lock_bh(&arm_state->susp_res_lock);
>  	local_uc = ++arm_state->videocore_use_count;
> -	local_entity_uc = ++(*entity_uc);
                          ^^
This ++ is required.

regards,
dan carpenter

