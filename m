Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B420716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WIYmU0En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgA2PQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:16:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46526 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgA2PQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:16:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TFDJXg152160;
        Wed, 29 Jan 2020 15:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=AUHscgmUga0TtBYeVkbnnpKK+M7Sw+pMq45avp9+6iU=;
 b=WIYmU0EnZ2PDeYYj/uBUPVnBElQB0hzKUlvOMu60sBK3tlsORcfKny7Z7f5oV614/8MZ
 e/LQyT7RdaQBcWnGUo2Nf4CytynPC1hzyU5p/bleGOxG1fiFtKmyIvev5znKZbZALiji
 yBzAK6XPiJl9BuZFv7ZnwY/t0L+vGWt7nTw13zaNcKt12hZq2olNunmCcNwQMZKL4UZE
 5WNJDWF/LLC8u/ba5MwxQzsrykCrHxsXXvpgiLX93/hJ98/FX6TdH2kM/kG3XiTZAoaH
 YyphCBYAEA34Zz28Oc62aIPEjhdAl2j+FyrhUAv5QJEvPpt3cp0eb50m8HcQejw3mSYY nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xrdmqp4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 15:15:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TFDoeo062067;
        Wed, 29 Jan 2020 15:15:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xth5kdyy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 15:15:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00TFFnYA028842;
        Wed, 29 Jan 2020 15:15:51 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 07:15:48 -0800
Date:   Wed, 29 Jan 2020 18:15:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH] staging: exfat: remove 'vol_type' variable.
Message-ID: <20200129151541.GB1778@kadam>
References: <20200129111232.78539-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129111232.78539-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 08:12:32PM +0900, Tetsuhiro Kohada wrote:
> @@ -2085,7 +2069,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
>  
>  	cpos = ctx->pos;
>  	/* Fake . and .. for the root directory. */
> -	if ((p_fs->vol_type == EXFAT) || (inode->i_ino == EXFAT_ROOT_INO)) {
> +	if (inode->i_ino == EXFAT_ROOT_INO) {

This isn't right.  The first condition is always true so in the original
code we never bothered to check the second condition.

>  		while (cpos < 2) {
>  			if (inode->i_ino == EXFAT_ROOT_INO)
>  				inum = EXFAT_ROOT_INO;

regards,
dan carpenter

