Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F5FC34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E82176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0Tvaf4rB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBRIEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:04:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51264 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgBRIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:04:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I83C1Q148980;
        Tue, 18 Feb 2020 08:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JIy5Z2HZRCmB1QEMokHkoy5yA8AFvEmYRmMgpfVn3G8=;
 b=0Tvaf4rB08mQ4HQ4po4qpJQ31rP5ZOIIt4dC+dgOBu0ap6BkUU3k3ZMouVwfYpGrOmFF
 LWG0fUX7nVIZAdeTDcI9jp/98K66ALF22bYKZsl6Kjpxi02sRf6lwgabYEj6cZOjmDtU
 KLGTamci2cLB8jWPDbj6ZTBDi7k/MwM7cRuuv/1/PuSatQ83C1GUo0NZROPfRR4XRzFz
 k0cnh56RO6S62gvTRVkM5SRiwxvTqzAr9kuXzf6cPlEmaCXrlXwQ2jlmv9Gqfpx82dPL
 Keo8YUa9IwUUVKGC4SME+lva+HDYzT344gMlEgyS1c8po/aoEKVtflMVncUFxR1EdXAw 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y68kquvhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 08:04:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I81iDf094572;
        Tue, 18 Feb 2020 08:04:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y6t4hq0p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 08:04:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01I84YO8009804;
        Tue, 18 Feb 2020 08:04:34 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 00:04:29 -0800
Date:   Tue, 18 Feb 2020 11:04:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     sunnypranay <mpranay2017@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: drivers: fixed errors warning coding
 style issue
Message-ID: <20200218080419.GD19641@kadam>
References: <20200216081518.3516-1-mpranay2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216081518.3516-1-mpranay2017@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 01:45:18PM +0530, sunnypranay wrote:
> Fixed a coding style issue.

What issue is that?

> 
> Signed-off-by: sunnypranay <mpranay2017@gmail.com>

This doesn't seem like a Formal Name that you would use to sign legal
documents.

> ---
>  drivers/staging/comedi/drivers.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
> index 750a6ff3c03c..76395de100a6 100644
> --- a/drivers/staging/comedi/drivers.c
> +++ b/drivers/staging/comedi/drivers.c
> @@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(comedi_alloc_subdevices);
>   * On success, @s->readback points to the first element of the array, which
>   * is zero-filled.  The low-level driver is responsible for updating its
>   * contents.  @s->insn_read will be set to comedi_readback_insn_read()
> - * unless it is already non-NULL.
> + * Unless it is already non-NULL.

The original capitalization was correct.  It should be lower case.

>   *
>   * Returns 0 on success, -EINVAL if the subdevice has no channels, or
>   * -ENOMEM on allocation failure.
> @@ -282,8 +282,20 @@ EXPORT_SYMBOL_GPL(comedi_readback_insn_read);
>   * continue waiting or some other value to stop waiting (generally 0 if the
>   * condition occurred, or some error value).
>   *
> - * Returns -ETIMEDOUT if timed out, otherwise the return value from the
> - * callback function.
> + * Redback_insn_read() - A generic (*insn_read) for subdevice readback.
      ^^^^^^^^^^^^^^^^^
What is this???

regards,
dan carpenter

