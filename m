Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0FDC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54EA72078E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISAhvdYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgEFM5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:57:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46142 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgEFM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:57:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CroAF135400;
        Wed, 6 May 2020 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zzEcQ/51XYDrGSbwzQDwu8TmaSZIn9vYqGi8rV4KNfo=;
 b=ISAhvdYTU9CODzTkB6KZ9NLgH1FtH7zgIKQ4hTAdRmW6MacoRUUUIZhhKiGiq3aMz9RU
 Qhm40P9+79CdpL2FQKJhtzKS+CcWOJktniecLe4n/cyll5zrIGjQ8jIVSsQOimYkxS/v
 uiq1IX0Vgv/PztLaLPBWDJNBNe7x/If7O35h/RcrjpQsAViQ5IRvzMPq4a9FmNsKNnsW
 DTA6C5hTYcHWBWTKGKgdCbxAD+Z2e42rhDiNcEBMRvwNS303oY3fZAr1VlKY8xwuzeRF
 P3PhP/Nfx4k6YiEJt2BYJ974w9A3q6ySiyXV8ggbz8PCafMWeO/ydiuo6/C3nYwZNKMn Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq18fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:57:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Cpl7V195095;
        Wed, 6 May 2020 12:57:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r7s6hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:57:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046CvXMM010468;
        Wed, 6 May 2020 12:57:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 05:57:33 -0700
Date:   Wed, 6 May 2020 15:57:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, simon@nikanor.nu, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] staging: kpc2000: fix error return code in
 kp2000_pcie_probe()
Message-ID: <20200506125723.GL1992@kadam>
References: <20200506125255.90336-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506125255.90336-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:52:55PM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function. Also
> removed var 'rv' since we can use 'err' instead.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Also could you add a Fixes tag?  This goes all the way back to the
original commit:

Fixes: 7dc7967fc39a ("staging: kpc2000: add initial set of Daktronics drivers")

regards,
dan carpenter

