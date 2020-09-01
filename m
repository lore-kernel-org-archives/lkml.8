Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE14206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dtxeQRgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIANfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:35:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgIANds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:33:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081D0l24055238;
        Tue, 1 Sep 2020 13:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tncZGQIWIEZ4FEAe9DcScrIAwrizsiWeexR76yy0IIQ=;
 b=dtxeQRglYiDPtopyn3Vtf+9DrDAhfWhdGROhVxPHqIwJhl+iHvMOw0pEd8HhECQCZWQF
 ho4IaMLRqiDXC6tIsrmGKz45zY/OoxfynnwsJ2jFY3TxlzPhZWJ4hgj2bEKVH7ynT69T
 tp4XrQYEsma2BgVzqbj90NbaxBhEOsMvNQUfkZ4arjiiMd66kmIAyM/p4apARficfUaI
 T6MWYgOJyD9uG3nmfiZ76C77214aLORN7A+cyXw68GgBX0s1urhSl0ooCbN248CIpcfY
 5vIl2Y00jNd42ORP/PuXcCl/rq42c3YoRGVpekc3tzSlt8Js/wXWn5YGdI6kw0FfYV+R vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eym4960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 13:33:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081D0eqO076616;
        Tue, 1 Sep 2020 13:33:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380x3bv2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 13:33:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081DXciR002439;
        Tue, 1 Sep 2020 13:33:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 06:33:38 -0700
Date:   Tue, 1 Sep 2020 16:33:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     antoniprzybylik <antoni.przybylik@wp.pl>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: corrected macro by adding
 brackets
Message-ID: <20200901133332.GY8299@kadam>
References: <20200901104311.17270-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901104311.17270-1-antoni.przybylik@wp.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:43:11PM +0200, antoniprzybylik wrote:
                                          ^^^^^^^^^^^^^^^
Please, fix your From: header so that it says "Antoni Przybylik".

> Such macros are dangerous. Consider following example:
> 	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> 	GDM_TTY_READY(a + b)
> This macro will be expanded in such a way:
> 	(a + b && a + b->tty_dev && a + b->port.count)
> And it will lead to errors.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 6e813693a766..eab5c75ee5b1 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,7 +27,7 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +#define GDM_TTY_READY(gdm) ((gdm) && (gdm)->tty_dev && (gdm)->port.count)

I cannot imagine a real life example where adding these parentheses will
prevent a bug.  One idea it to silence this by making dereference ops
like this a special case where checkpatch.pl doesn't suggest adding
parentheses.

regards,
dan carpenter
