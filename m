Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D612920748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nl3t6cYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGXKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:47:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:47:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OAlVP0035225;
        Fri, 24 Jul 2020 10:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=V7UTj6pGG4terJJFtG5oz1kiiwdHooz6JHEg0pNxRUA=;
 b=Nl3t6cYnYWP4Kq47QXM2ueSYx80KTMZlb3CIaZIzRxyVZEeY1wSt7C5NdiN48YwH34PH
 Zjqx7+LpBedvfrKxboy52mpRRzf6YGJdaKLD41SRgyxOX0byiM0z4TsDpnWhVVlg8ky9
 CzHnftHKUF9MzjoIz1g+B42UR0ZBVZubK4NeEa5V0F/I69zxuew5q0bTy/y3SFzVnpBq
 zW4uTznQHxJZ5VqXGGoUZbzRC5LJcVOEKgmyTZtYaKyxy9FNQagw9Bp4LbdOLC6WuryZ
 zqpL87PNTFY9nrpNg4RtRaiOcEM5r4YOHLjrHggm6s0xpamGSSaA5X16OGx4J2WugmVT 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1mxf8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 10:47:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OAgROR014698;
        Fri, 24 Jul 2020 10:45:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32fsr74pn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 10:45:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OAjUjr030696;
        Fri, 24 Jul 2020 10:45:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 10:45:29 +0000
Date:   Fri, 24 Jul 2020 13:45:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Indent with tabs instead of spaces
Message-ID: <20200724104524.GT2549@kadam>
References: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:19:50PM +0500, Muhammad Usama Anjum wrote:
> Remove a coding style error. It makes code more readable.
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---

This isn't a part of the official style guide so the original is fine.

regards,
dan carpenter

