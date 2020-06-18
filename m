Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10992075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pUugeWrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgFRPWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:22:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFRPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:22:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IFLs3C065365;
        Thu, 18 Jun 2020 15:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7siOWtMnW9wq0JjrCezGCY1u1cWhmZsBCe02fyT6lLA=;
 b=pUugeWrMkLx5n843KOXWlWw4YwnoT88FeIheD9HTLJ0SYwBT5t3g9KSnnNNmJeXm3pMQ
 3URa9d7YvodGrTgY6f4yY72K9nOCvluxJ9g+idGfh4nGOLMDY+bEjHF2axfwTM8qGEGj
 +4CHA8Q9gBzk61lHyu8GP7VSPiCw62gAcYobgWwQ3SDEGAEfrXNpVG/n6kFgrJoTKjv2
 azazMyn1nDT0irU99tbgRvHwu/rI8whCvjVb9M9XehblcBTAACZUV6uG8fOn6dI/NMm4
 Yoo11SPWTXVmtJureZa9U5WQZDy97WzytgR/9yJgC1leZSWh0cpgoa/a7Y1bHEgn8dM7 +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31q6601uks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 15:22:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05IFJELR191509;
        Thu, 18 Jun 2020 15:22:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31q66pxekr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 15:22:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05IFMBYE010808;
        Thu, 18 Jun 2020 15:22:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jun 2020 08:22:11 -0700
Date:   Thu, 18 Jun 2020 18:22:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Garrit Franke <garritfranke@gmail.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/arm: fix unintentional integer overflow on left shift
Message-ID: <20200618152204.GU4151@kadam>
References: <20200618100400.11464-1-colin.king@canonical.com>
 <20200618121405.GJ159988@e110455-lin.cambridge.arm.com>
 <5d08fbec-75d8-d9a9-af61-e6ab98e77c80@canonical.com>
 <20200618142106.GK159988@e110455-lin.cambridge.arm.com>
 <CAD16O86ebsDkwbnuw2G04YZWfukqxJ=_Tex5OT07icEpfPdQNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD16O86ebsDkwbnuw2G04YZWfukqxJ=_Tex5OT07icEpfPdQNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006180117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:36:51PM +0200, Garrit Franke wrote:
> Hi all, newbie here.
> Can the BIT macro be safely used on other parts of the kernel as well?
> Just using git grep "1 <<" returns a ton of results where bit shifting
> is used the old fashioned way.

Yeah.  There is a checkpatch warning for it and everything.  :)

But I like the way you think.  Start with patches to staging though.
People don't necessarily like doing cleanups on ancient code.

regards,
dan carpenter

