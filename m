Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953C20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djH9ocTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgCQKpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:45:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:45:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HAdjxc152500;
        Tue, 17 Mar 2020 10:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mSkMnLoVfT9tvOtdqIFWw9gr53HIM+8g9ieWNpJlYG8=;
 b=djH9ocToi04r4JjL/b8oIy9U34xHc3CnrGVoZ4qBtAOdBp7j2i7QjlSow7wAYnXy3SzI
 G4lHYzA8YaGYz+hZqaQVwX7Cl9fPsv0BaMcSrSyoV7gfLeORdAcb3CBVA+A/wH9GREWj
 M7k2Sc1vaVVYiEsrpZBbrnVGOLs6jpkAjaKVwS12Q936tXm/mjVX1mY504negNi9plCy
 Gy0sBZqDFkww4mzIqwcwaKEzaNbjEPLJV37jwah6ZIDGMOZmWHVsIYeztQYhEcjq8PXU
 jG4za59IFFmd7W0KW1C1MVskbDHDIsEcTxu2qoCbxp/FEiyRh0/BaPPfd2BOSXhLf7vm WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yrqwn3yga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 10:45:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HAVWvp070353;
        Tue, 17 Mar 2020 10:45:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ys92cm0ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 10:45:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02HAjFod003782;
        Tue, 17 Mar 2020 10:45:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Mar 2020 03:45:14 -0700
Date:   Tue, 17 Mar 2020 13:45:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use ARRAY_SIZE instead of hardcoded size
Message-ID: <20200317104506.GA4650@kadam>
References: <20200314164754.8531-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314164754.8531-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 05:47:54PM +0100, Oscar Carter wrote:
> Use ARRAY_SIZE to replace the hardcoded size so we will never have a
> mismatch.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/main_usb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5e48b3ddb94c..4370941ffc04 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -23,6 +23,7 @@
> 
>  #include <linux/etherdevice.h>
>  #include <linux/file.h>
> +#include <linux/kernel.h>
>  #include "device.h"
>  #include "card.h"
>  #include "baseband.h"
> @@ -116,6 +117,7 @@ static int vnt_init_registers(struct vnt_private *priv)
>  	int ii;
>  	u8 tmp;
>  	u8 calib_tx_iq = 0, calib_tx_dc = 0, calib_rx_iq = 0;
> +	const int n_cck_pwr_tbl = ARRAY_SIZE(priv->cck_pwr_tbl);

Please use ARRAY_SIZE(priv->cck_pwr_tbl) everywhere instead of
introducing this new variable.

regards,
dan carpenter

