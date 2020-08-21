Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF8820738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pOXTBKj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUIPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:15:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:15:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L8CJTG114576;
        Fri, 21 Aug 2020 08:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=virkOKZ2n5oKm9Yasu1MHN0bo07T4qM9mrntv5iiZx8=;
 b=pOXTBKj94ywtNURN/e/oKgSyZNdwfTIoXUWns83Bmhn2ASYO9gl+pi3Or4OMJAvyJwjp
 9v4vfu8lftUOfjpSXI+pdRZNkGL94hrOdvdHZDSIeJuZyygktkPBVWwqXFDxwV9XH00V
 B4vipGG6OGBDTwWawplPx67wSrjnm6z1DMj+7V0CDO1GO4U2vPVWqxlsk4pWVN0MQw+b
 KJNeimuIaWEY0pbnUHzeGx1j7YVnvvn96Aq3O0nBnNiUndG1MZ/SVs6m0jcYCc1ux4qQ
 /omtNNxVvsHBulptxh2sUuDF4N4KdLihB3abcYMEcQt4WAEJQ43NusbTGGxzjt7sroJb bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74rmuvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 08:15:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07L8D4K7041903;
        Fri, 21 Aug 2020 08:15:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32xsn2b0bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 08:15:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07L8EvD0019439;
        Fri, 21 Aug 2020 08:14:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 08:14:56 +0000
Date:   Fri, 21 Aug 2020 11:14:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     George Acosta <acostag.ubuntu@gmail.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix get device imbalance on error
Message-ID: <20200821081449.GI5493@kadam>
References: <20200821034458.22472-1-acostag.ubuntu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034458.22472-1-acostag.ubuntu@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=2 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:44:57PM -0500, George Acosta wrote:
> Fix the imbalance in mport_cdev_open.
> Call put_device in error path to balance the
> refcount that increased by the get_device.
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Signed-off-by: George Acosta <acostag.ubuntu@gmail.com>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index c07ceec3c6d4..3b68e00eb40f 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1908,6 +1908,7 @@ static int mport_cdev_open(struct inode *inode, struct file *filp)
>  			  sizeof(struct rio_event) * MPORT_EVENT_DEPTH,
>  			  GFP_KERNEL);
>  	if (ret < 0) {
> +		put_device(&chdev->dev);
>  		dev_err(&chdev->dev, DRV_NAME ": kfifo_alloc failed\n");
>  		ret = -ENOMEM;
>  		goto err_fifo;
> -- 

If we ever hit this error path then the:

	list_add_tail(&priv->list, &chdev->file_list);

needs to be removed from the list as well or it lead to a use after
free.  Probably just move the list_add_tail() after the kfifo_alloc()
has succeeded. We need to remove it from the list in mport_cdev_release()
as well...

The error handling in this function is kind of rubbish.
1) Get rid of the out label and return directly (more readable).
1b) Use "return 0;" instead of "retur ret;" for the success path.
2) Name the labels after what they do not where they "come from".  In
other words do.

err_priv:
	kfree(priv);

3) Create a label to call put_device:

err_device:
	put_device(&chdev->dev);

Change all the error paths to use the goto instead of calling
put_device() before the goto.

regards,
dan carpenter
