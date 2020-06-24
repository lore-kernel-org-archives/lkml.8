Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E47EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A90A20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xSoC32Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbgFXOMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:12:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389874AbgFXOMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:12:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OEBwC7006530;
        Wed, 24 Jun 2020 14:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tZbJARBoBOEe+Fn51mD/p0NNYyeLkR1+TWw+J8vnbyY=;
 b=xSoC32Tmdso9FbJx1huDnOr2Z4vUsuBkNth1U43gz/XWKNUfMobufb7CGtQP1Z3s6bOV
 ZsezNNN99SbGhLlDsfaNPYZo3sHLNzMGe8XCiq+fmt/+b5r9vRgV+aAcILVYxgQK80vJ
 OJQc1Hau2Tos1Y8KhkTBm1z5V0nodK2OLb4FsxL4ZnYqmG7mUMTdCQtihCHNu0nPkovb
 qocZX70G533YHQm5xHjuZgG+qoqsb1cRRf9l17A7xLfTL2Jav8IRt7KvjbaYd+UXDYgz
 G3AMYATZ3Wr4Lz2ISma63y6biRwrMH/Pwknzzsnjuo3TRaJEfYmQET1V+bpfmqyNH8Xt Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31uustu3gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 14:12:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OE8IiG098287;
        Wed, 24 Jun 2020 14:12:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31uur7e5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 14:12:00 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05OEBqRE021959;
        Wed, 24 Jun 2020 14:11:53 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 14:11:52 +0000
Date:   Wed, 24 Jun 2020 17:11:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 15/50] staging: vchi: Unify struct shim_service and
 struct vchi_service_handle
Message-ID: <20200624141141.GA30990@kadam>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
 <20200623164235.29566-16-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623164235.29566-16-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:42:01PM +0200, Nicolas Saenz Julienne wrote:
> @@ -437,12 +432,10 @@ static void service_free(struct shim_service *service)
>  
>  int32_t vchi_service_open(struct vchiq_instance *instance,
>  	struct service_creation *setup,
> -	struct vchi_service_handle **handle)
> +	struct vchi_service **service)
>  {
> -	struct shim_service *service = service_alloc(instance, setup);
> -
> -	*handle = (struct vchi_service_handle *)service;
>  
> +	*service = service_alloc(instance, setup);
>  	if (service) {

This should be checking "*service".

>  		struct vchiq_service_params params;
>  		enum vchiq_status status;
> @@ -450,27 +443,25 @@ int32_t vchi_service_open(struct vchiq_instance *instance,
>  		memset(&params, 0, sizeof(params));
>  		params.fourcc = setup->service_id;
>  		params.callback = shim_callback;
> -		params.userdata = service;
> +		params.userdata = *service;
>  		params.version = setup->version.version;
>  		params.version_min = setup->version.version_min;
>  
>  		status = vchiq_open_service(instance, &params,
> -			&service->handle);
> +			&((*service)->handle));
>  		if (status != VCHIQ_SUCCESS) {
> -			service_free(service);
> -			service = NULL;
> -			*handle = NULL;
> +			service_free(*service);
> +			*service = NULL;
>  		}
>  	}
>  
> -	return service ? 0 : -1;
> +	return *service ? 0 : -1;
>  }
>  EXPORT_SYMBOL(vchi_service_open);
>  

regards,
dan carpenter
