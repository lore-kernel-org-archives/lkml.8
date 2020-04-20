Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56848C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3124E206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODWT+u1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDTMVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:21:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45894 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDTMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:21:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KCIXSG038800;
        Mon, 20 Apr 2020 12:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aD9qpxg5CHZYZYk+gzIw6K6GXAhalYWjG3cWxhGETdA=;
 b=ODWT+u1CrywSLEvva6onNWjNe+MVU4zFVNEqawZ0opl1BgvuePjLbHGxIQlnqYcJfIAg
 ZjQDB7mMyvRJ/FaoiSUiMCowzTpF4s4Qdnb28RQlOBD6vBWR+ICofcpXfF2m8OzVQ92E
 pcM39t7RtQlzhGrTmB3vFryHXvXvomN+angy0g9nWC0HsFQ7GWVAt54bAakNollIYIBf
 0YYTKbO/xFJRGqx3o5cIiBAttHFFmk8ePAhb2vJ9QGeA3UYmB235OuTi/k1JNf0thhE9
 wzIcrrHDVYQJLNb3febbpifMaAynkTJkkSiFpqUqhfw2QaB2SWwsCJtJCGLhR9coHcLk vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30ft6mxt7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 12:21:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KCDhGo108375;
        Mon, 20 Apr 2020 12:19:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30gb3qbnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 12:19:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03KCJAdh032644;
        Mon, 20 Apr 2020 12:19:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 05:19:09 -0700
Date:   Mon, 20 Apr 2020 15:19:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        nishkadg.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-pinctrl: Use correct pointer type
 argument for sizeof
Message-ID: <20200420121900.GD2659@kadam>
References: <20200420123755.4353-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420123755.4353-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:37:55PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:223:14-36: WARNING: Use
> correct pointer type argument for sizeof
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index d0f06790d38f..8883f2a8ea57 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -220,7 +220,7 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
>  	/* allocate our function and group mapping index buffers */
>  	f = p->func = devm_kcalloc(p->dev,
>  				   p->func_count,
> -				   sizeof(struct rt2880_pmx_func),
> +				   sizeof(struct rt2880_pmx_func *),

Yes.  This fixes a bug.  We were allocating too much data.  But the
prefered style is:

				sizeof(*p->func),

Please could you resend?

regards,
dan carpenter

