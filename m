Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9746EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FC821BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nP9sv9HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgGNIad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:30:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:30:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E8S3W8158519;
        Tue, 14 Jul 2020 08:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bmrC3uO0hL9mY59/ViKJ+rhM/g+cSn+ihe2iBW1t2lA=;
 b=nP9sv9HQLvr50sCLZVHB8NUFvJJPfh8ZULE2AUPbZhuSmQdwVh+AgYKI4alEJOfKBf9o
 37mU7E5wIGriv4Ye0p7eL8PIFtuXTjzsqZfLgwoitfx84Zgtqx5Lu8WfTPIJpTHs+cmg
 EoyhyJu0OhAGfjwW/PZN+XyJ++lgVv6+YWKrWeQuQM7aAQ50Br9hQPm7G/EZRZ2QGLiJ
 P2GoTv6a7i1cPSIszxN59j716BMLTx1/g2nYmxBJfWZvdP/7tw5ShlcYO3vY+ub3zYQa
 0cFrj0td3c9hGD8jf8WN3CkSfCK4gTkONWPvR02NY2iGoHxllUPsrw9X893nm7Qrh2Mk cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3274ur3yj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 08:30:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06E8Hmsw084482;
        Tue, 14 Jul 2020 08:28:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 327qb3a5qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 08:28:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06E8SNPG009448;
        Tue, 14 Jul 2020 08:28:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 01:28:22 -0700
Date:   Tue, 14 Jul 2020 11:28:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/6] staging: qlge: qlge_main: Simplify while statements.
Message-ID: <20200714082816.GA2571@kadam>
References: <cover.1594642213.git.usuraj35@gmail.com>
 <1bb472c5595d832221fd142dddb68907feeeecbe.1594642213.git.usuraj35@gmail.com>
 <20200713141235.GT2549@kadam>
 <20200714064022.GA12651@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714064022.GA12651@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:10:22PM +0530, Suraj Upadhyay wrote:
> On Mon, Jul 13, 2020 at 05:12:35PM +0300, Dan Carpenter wrote:
> > On Mon, Jul 13, 2020 at 05:50:14PM +0530, Suraj Upadhyay wrote:
> > > Simplify while loops into more readable and simple for loops.
> > > 
> > 
> > I don't think either is more clear that the other.  Walter Harms hates
> > count down loops and he's not entirely wrong...
> > 
> > regards,
> > dan carpenter
> 
> Hi Dan,
> 	Thanks for your response.
> Should I send a v2 of this patch or not ??
> Also do you have any problems with the other two patches doing the same
> thing in different files ??
> I am all ears.

I would just resend patch 6/6.  If this is your driver and you're going
to be working on it extensively then you do what makes you feel
comfortable.  But to me the original code seems fine with while count
down loops.

regards,
dan carpenter

