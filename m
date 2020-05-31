Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC585C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71992074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 09:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SJxejmms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgEaJBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 05:01:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:01:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04V8w74n170107;
        Sun, 31 May 2020 09:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=eYl+QXZgp6KQvHo6m8I5J+jGCIJ1MNQ7U+G+5K9bfRo=;
 b=SJxejmmsPgEo0kH+bi1wqQ2Jp/p1qXNSP9V8dkcABU/Yo7daEd1N2p1XmUmpBd6lZduo
 D+q/ApJfsmWGc/n1ISsxFaAHk8yKNSNkFFNGryOjuyWJpGInjN++5PIr1bd23cK9sLs3
 t6AmZIPsMY5zpa0wRkB5j8bnPZhiVXMqQA84LP3SvBTuqgpTUwVwvCUc6fliKjYIK96u
 F0xBRCYeiDg0nqYmnIWhbAFXBgvYDhnMffLf5vHep9Juw/xNjJwB5jSYgH9V6XoEkBga
 1V4tkmGMwNxCe8yril9gPmEcLvd29sLIFSbdThDCpzMircYM3ubg4GsAc2rhGllq5VIv sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31bg4mtwev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 31 May 2020 09:01:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04V8r5FT111385;
        Sun, 31 May 2020 08:59:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31c1dtwahc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 May 2020 08:59:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04V8xdP6022671;
        Sun, 31 May 2020 08:59:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 May 2020 01:59:39 -0700
Date:   Sun, 31 May 2020 11:59:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
Message-ID: <20200531085932.GP30374@kadam>
References: <1590909791-3871-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590909791-3871-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9637 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=4 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005310071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9637 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=1
 mlxlogscore=999 cotscore=-2147483648 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005310071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 12:53:11PM +0530, Souptick Joarder wrote:
> In 2019, we introduced pin_user_pages*() and now we are converting
> get_user_pages*() to the new API as appropriate. [1] & [2] could
> be referred for more information.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
> 	https://lwn.net/Articles/807108/
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


