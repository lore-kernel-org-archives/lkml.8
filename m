Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431EFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574A206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F58+0VBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgDBMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:23:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgDBMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:23:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032CMh9N054207;
        Thu, 2 Apr 2020 12:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wjPa325Z3IV06jAmrRHNcUJXKnsUHgOW0tGCxhUva8k=;
 b=F58+0VBWEdhx898J5cgm3FeHG2fbyZcLUVIn+gsdigqtxTpYYBUqCp3y+KAYd8D7M1ix
 EMBzfmBWUyn4FU9nF26A7g6rpmlPHetcG1mb6Qmb3AplJC1GSlYXi3Pc3mSCnjHFzTI+
 TyGym3pG9j7ON7ce1m0ZlYT569vaP0Li03AIybR6ZudYXipt18R+uic5gLvb2jwEeXGs
 ynHhvaD9221S9t6FQmX63NP1bYDI1AwdhF4f/kCJW2RjO2khFQLHGWgOTFXDHTl8JeyJ
 /6N/cn/AFX0xb2+AJjPYM3NcsdL9MCi+rITP+FtZoXTPBqXTF405uaGklSk3yHiXqJrk SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqhug3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 12:22:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032CM8r1135759;
        Thu, 2 Apr 2020 12:22:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga2b2tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 12:22:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032CMeXK029118;
        Thu, 2 Apr 2020 12:22:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 05:22:39 -0700
Date:   Thu, 2 Apr 2020 15:22:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     rmfrfs@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] staging: greybus: fix a missing-check bug in
 gb_lights_light_config()
Message-ID: <20200402122228.GP2001@kadam>
References: <20200401030017.100274-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401030017.100274-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:00:17AM +0800, Chen Zhou wrote:
> In gb_lights_light_config(), 'light->name' is allocated by kstrndup().
> It returns NULL when fails, add check for it.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/staging/greybus/light.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d6ba25f..d2672b6 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -1026,7 +1026,8 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
>  
>  	light->channels_count = conf.channel_count;
>  	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
> -
> +	if (!light->name)
> +		return -ENOMEM;
>  	light->channels = kcalloc(light->channels_count,
>  				  sizeof(struct gb_channel), GFP_KERNEL);
>  	if (!light->channels)

The clean up in this function is non-existant.  :(

regards,
dan carpenter

