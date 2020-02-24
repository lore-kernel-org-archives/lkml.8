Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DEC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53322082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IURSZ7Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:27:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXL15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:27:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OBRZBm049053;
        Mon, 24 Feb 2020 11:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qaLjDAIw6mSX2sA4FzFmvfhX3ybm6asvNIXeCFRRclQ=;
 b=IURSZ7DxCuLj7ateYVeAPowimphunG2NcuDv8JhvS9K+KT4VIjSQqihH2SuWtlumEA67
 OdGrFPFn72SUR1XpqaRQNlfpmf1oJUeQ3TLAlFGahGZ9ZBaCmaj69rHRKp2SwwnsFF3d
 0q0B4tvXZ2a7bkrh3h6M0Ue6Iu1iie5SAZAl+PSccntosGx0FYK8KBy9rv0gv1PaCznL
 5KMcpPtzT7APSVdgExiAvBkopTRbPw6j+a03uIARSGwoaJPev0wiUUQXycJBsQ3yErqI
 12SSKIs9BRxUO2AERQLrJIgYnpAnGzOmg4+q4Qw73kZpzNHc61AVvi1Mly9XH98o9KQm aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4k0ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 11:27:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OBLsUx066158;
        Mon, 24 Feb 2020 11:27:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ybe111758-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 11:27:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OBRimX031221;
        Mon, 24 Feb 2020 11:27:44 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 03:27:43 -0800
Date:   Mon, 24 Feb 2020 14:27:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: core: remove redundant zero'ing of
 counter variable k
Message-ID: <20200224112735.GC3286@kadam>
References: <20200223152840.418439-1-colin.king@canonical.com>
 <5f875f84e6014d2bb5b78f71dc2831a2@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f875f84e6014d2bb5b78f71dc2831a2@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:07:55AM +0000, Walter Harms wrote:
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index 3b8848182221..bdb6ff8aab7d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -244,10 +244,8 @@ u16        Address)
>                 while (!(Bytetemp & 0x80)) {
>                         Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
>                         k++;
> -                       if (k == 1000) {
> -                               k = 0;
> +                       if (k == 1000)
>                                 break;
> -                       }
> 
> IMHO this is confusing to read, i suggest:
> 
>  for(k=0;k<1000;k++) {
>       Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
>       if ( Bytetemp & 0x80 )
>                break;
>       }
> 

The problem with the original code is that the variable is named "k"
instead of "retry".  It should be:

	do {
		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
	} while (!(Bytetemp & 0x80)) && ++retry < 1000);


>  NTL is am wondering what will happen if k==1000
>  and Bytetemp is still invalid. Will rtw_read8() fail or
>  simply return invalid data ?

Yeah.  That was my thought reviewing this patch as well.

It should probably return 0xff on failure.

	if (retry >= 1000)
		return 0xff;

regards,
dan carpenter

