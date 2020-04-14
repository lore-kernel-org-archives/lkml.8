Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4367DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168BA20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MIWAs/yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502643AbgDNNMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:12:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45110 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDNNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:12:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ED9Xal011159;
        Tue, 14 Apr 2020 13:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=e7ZC9eF80V3HjAabjgEI+dUq9TU4s7TJqhKZXh3sEoM=;
 b=MIWAs/yQSRGjq+QFCOzkTAoi+OY1McNWJPC2BkXuO9D+U4aFugujrFVVm+1qHpsHfgrB
 ZS6ekk3X06ZYjCpeIpaFCPYfiJkcP47RJSoO/shrFFBHbnC2ek9F2ZxK1S0k5eDnXYfx
 MTE97611O8W9Ie79lO9cXZxskvrBEyCz0qlpMeNsQoDbRONeeSSrx/LSNDU0I0v1mVGg
 ptWTwjjIPOxjcuZCsVSKf5VlQOnndGexYFpWn/9EA4SDWBk6aQcUejTrvr1c4Dm2ptLB
 hf1o4GTq/QOLUN1EDEHrAszhyhBZnDoLGOrL8hdyB+nuF0LxZa0lhcFCn6RoHsSGSBtS CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30b6hpmgu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:12:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ED7FlX017508;
        Tue, 14 Apr 2020 13:12:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30ctaa58tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:12:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EDCLUl011000;
        Tue, 14 Apr 2020 13:12:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 06:12:20 -0700
Date:   Tue, 14 Apr 2020 16:12:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] staging: vt6656: Add formula to the vnt_rf_addpower
 function
Message-ID: <20200414131214.GI1163@kadam>
References: <20200413140209.4520-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413140209.4520-1-oscar.carter@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:02:09PM +0200, Oscar Carter wrote:
> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> index 4f9aba0f21b0..3b200d7290a5 100644
> --- a/drivers/staging/vt6656/rf.c
> +++ b/drivers/staging/vt6656/rf.c
> @@ -575,28 +575,14 @@ int vnt_rf_setpower(struct vnt_private *priv, u32 rate, u32 channel)
> 
>  static u8 vnt_rf_addpower(struct vnt_private *priv)
>  {
> +	s32 base;

Just use "int".  s32 is for when signed 32 bit is specified in the
hardware.  I realize that it's done in this file, but if all your
friends jumped off a bridge doesn't mean you should drink their kool-aid.

>  	s32 rssi = -priv->current_rssi;
> 
>  	if (!rssi)
>  		return 7;
> 
> -	if (priv->rf_type == RF_VT3226D0) {
> -		if (rssi < -70)
> -			return 9;
> -		else if (rssi < -65)
> -			return 7;
> -		else if (rssi < -60)
> -			return 5;
> -	} else {
> -		if (rssi < -80)
> -			return 9;
> -		else if (rssi < -75)
> -			return 7;
> -		else if (rssi < -70)
> -			return 5;
> -	}
> -
> -	return 0;
> +	base = (priv->rf_type == RF_VT3226D0) ? -60 : -70;
> +	return (rssi < base--) ? ((rssi - base) / -5) * 2 + 5 : 0;
                       ^^^^^^
I quite hate this postop.  It would have been cleaner to write it like:

	return (rssi < base) ? ((rssi - (base - 1)) / -5) * 2 + 5 : 0

I'm sorry, I'm not clever enough to figure out the potential values of
"rssi".  How did you work out this formula?  It feels like it came from
a standard or something?  Do we not have a function already which
implements the standard?

regards,
dan carpenter

