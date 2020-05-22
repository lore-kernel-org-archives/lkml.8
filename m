Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455242070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tLWSc+oU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgEVLGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:06:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgEVLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:06:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MAvWxd051474;
        Fri, 22 May 2020 11:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=h+IhCi8QC7aiB6PiDJQfHb4bxl8n8/F15j3Q6LkLP+I=;
 b=tLWSc+oUFd4uWsuo+lM/HJquZ33VFhTJYIWFrNsnMwOQVFlAeRjOSGVjx9M2hmikH+TC
 acdf+ONyST5Ky0EkQV5P1cpZ3WnHst6Wjprk8+ndVxcPV2SNuwpfwHX22mYTDKCenlZn
 nFLhHJLj5Mn1tWLFlDWlKfn+zh239YJ/pZ+AvBGExVN/Xrp/9PhOp5OiuZgU8yoaTPdD
 mZbTRBVHQFHXfYtUaRMZ22fBi47Pt5UMLe4T08PDOKxUxU0DkyhUpv+yToTi3dOqgVWf
 YhM6Re4gOs8/PUj9t52D5MwIodrqAVbeue8MOTYJfxlI5S98Dj1lYeQkEyXwOLlAKy4R lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501rkq8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 11:06:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MB2jmR094300;
        Fri, 22 May 2020 11:06:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 313gj79sxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 11:06:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04MB6Wfu000538;
        Fri, 22 May 2020 11:06:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 04:06:31 -0700
Date:   Fri, 22 May 2020 14:06:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mitchell Tasman <tasman@leaflabs.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vchiq_arm: cast with __force as needed
Message-ID: <20200522110623.GL30374@kadam>
References: <20200519004531.33158-1-tasman@leaflabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519004531.33158-1-tasman@leaflabs.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 08:45:31PM -0400, Mitchell Tasman wrote:
> In several cases where a pointer marked as __user is
> (intentionally) assigned or passed to a non-marked target,
> cast to the target pointer type with a __force directive
> to quiet warnings from sparse.
> 
> Signed-off-by: Mitchell Tasman <tasman@leaflabs.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c     | 7 ++++---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 +++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index c18c6ca0b6c0..38a13e4618a8 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -371,14 +371,15 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>  	pagelistinfo->scatterlist = scatterlist;
>  	pagelistinfo->scatterlist_mapped = 0;
>  
> -	if (is_vmalloc_addr(buf)) {
> +	if (is_vmalloc_addr((void __force *)buf)) {

Am I reading this correctly???

This is actually a user controlled pointer that comes from the
vchiq_ioctl() when we do VCHIQ_IOC_QUEUE_BULK_TRANSMIT/RECEIVE.  So we
take random pointer from user space and if it happens to point to kernel
space then we trust it and presumably start BULK_TRANSMITing data to
it???

LOL....  This doesn't seem safe at all.

regards,
dan carpenter

