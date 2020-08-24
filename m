Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687482177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwVNv6Mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHXLRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:17:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgHXLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:15:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OBA7dh152978;
        Mon, 24 Aug 2020 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=eFV/tzJHUiWR01wtSAFq5smZdfBTl/8vkC+vijcylE8=;
 b=AwVNv6MgCx7lpxEuBVZFPmQ59fKCLet2Fwl+5Xek03zXt1Vy1ORaw9svz4FaiwJ6bMij
 ozVWLn+5GavB8+gMXrpwWpt9Zra6YIarQY6tfFox9m6wgzkg1dao+X50/Y8c/NfNkfEO
 H1brZcekawqDKpd3YJOS1QpMUOAl3UaGBQg9G62zVryTmqriy4dmnA5qhsVAGXU2NfiR
 lZE6hZanEl78J+JMzJyfdkJ9AGShMQ2BNVBEmX4hfVymLuUxNwYEb//9IxtuhS3X8EU1
 gjL/hHIKFKauB/aXxMxc1ujGKanCIfZGjMjEMgUa4Vv5LXtjf6waO7SlcimbHAvjRbPq 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 333dbrkxbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 11:13:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OB6VFg094091;
        Mon, 24 Aug 2020 11:13:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 333rtw9pea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 11:13:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07OBD7DA018832;
        Mon, 24 Aug 2020 11:13:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 04:13:06 -0700
Date:   Mon, 24 Aug 2020 14:12:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        wlanfae <wlanfae@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Mike McCormack <mikem@ring3k.org>, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix missing failure check on a call
 to dev_alloc_name
Message-ID: <20200824111258.GE1793@kadam>
References: <20200821131512.348775-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131512.348775-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:15:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the second call to dev_alloc_name is not checking if this
> failed.  Add the check and perform necessary cleanup on an error.
> 
> Addresses-Coverity: ("Unchecked return value")
> Fixes: 94a799425eee ("rtl8192e: Import new version of driver from realtek")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index fac58eebf263..7b15faeefff2 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -2489,7 +2489,8 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
>  	if (dev_alloc_name(dev, ifname) < 0) {
                                ^^^^^^

>  		RT_TRACE(COMP_INIT,
>  			 "Oops: devname already taken! Trying wlan%%d...\n");
                                                              ^^^^^^^

> -		dev_alloc_name(dev, ifname);
                                    ^^^^^^
> +		if (dev_alloc_name(dev, ifname) < 0)

The "ifname" is wrong.  It was intended to be "wlan%d" or something like
the comment says.  It will always fail.  One potential is to just delete
this retest and assume that the user will fix their mistake and try
again.  That's probably the best solution in fact.

> +			goto err_unmap;
>  	}

	if (dev_alloc_name(dev, ifname) < 0) {
		RT_TRACE(COMP_INIT, "Oops: devname failed '%s'!\n", ifname);
		goto err_unmap;
	}

>  
>  	RT_TRACE(COMP_INIT, "Driver probe completed1\n");

regards,
dan carpenter

