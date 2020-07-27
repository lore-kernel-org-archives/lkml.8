Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A824C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 01:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062452070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 01:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZOrUNa8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgG0Bv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 21:51:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgG0Bv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 21:51:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06R1lgM5082485;
        Mon, 27 Jul 2020 01:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=v8j4co1+D3v+c4H3t/dkvw5oueyFcBk6iLjzS8BCI6Q=;
 b=ZOrUNa8VuS8u38ozXIpU653h6qI/25wA4nrXZoZNuSIo0LNZ3uCdJJ7+Kwu9kqXqVVu+
 o1l/zJCU/sBjARASyaMHEY3/DJDj0qtKVDmwfHlottld7epd3+h0CgEebcSwJWnlWs0+
 zqQrmoEwcD/XGGaees1JPb23EyaIsOqriRrKxfTpKow3omZsZldUIsWcmTPlNuLk5PYZ
 idoqqbLS6JfZU6O0SVQcHCDuiuRIzbssX6Wc7grz26EaWDETbPzr1vPydVwW9+FR7+S7
 bTwiinE9wJYfyzdUvt/y3HKvp71ph5PWIn96b7GusbEjo3DauN8ao8e7nlr9Znek4Sns mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32gx4rt58c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 01:51:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06R1mSo6014200;
        Mon, 27 Jul 2020 01:49:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32hj437dq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 01:49:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06R1nJcl027594;
        Mon, 27 Jul 2020 01:49:20 GMT
Received: from localhost (/10.159.225.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jul 2020 18:49:19 -0700
Date:   Sun, 26 Jul 2020 18:49:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Jonathan Corbet <corbet@lwn.net>, kernel-janitors@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: correct flag name
Message-ID: <20200727014920.GN7625@magnolia>
References: <1595789020-12941-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595789020-12941-1-git-send-email-Julia.Lawall@inria.fr>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=1 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 08:43:40PM +0200, Julia Lawall wrote:
> There is no flag REMAP_CAN_SHORTEN.  Commit eca3654e3cc7 ("vfs: enable
> remap callers that can handle short operations") that introduces this
> text also introduces the flag REMAP_FILE_CAN_SHORTEN.  Change the name
> in the documentation accordingly.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

D'oh.  Good catch!
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
>  Documentation/filesystems/vfs.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index da4b735..d08357d 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1116,7 +1116,7 @@ otherwise noted.
>  	before any bytes were remapped.  The remap_flags parameter
>  	accepts REMAP_FILE_* flags.  If REMAP_FILE_DEDUP is set then the
>  	implementation must only remap if the requested file ranges have
> -	identical contents.  If REMAP_CAN_SHORTEN is set, the caller is
> +	identical contents.  If REMAP_FILE_CAN_SHORTEN is set, the caller is
>  	ok with the implementation shortening the request length to
>  	satisfy alignment or EOF requirements (or any other reason).
>  
> 
