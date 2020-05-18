Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF34E20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECOMsx1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgERMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:16:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgERMQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:16:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IC7O8c136864;
        Mon, 18 May 2020 12:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PA11GNuXBy9RL/56rySqViCyV7Jpit5qeutUc8R5BlQ=;
 b=ECOMsx1cknIujnLn6wnq5hPh6xlnKhUC5Yzfntt94B954sJh4D20vgAtC2ROeWT0f0xo
 fkFP4RV+cWmQfi5sMeW976x5yv2rpDEWqIFkwJzm2UW42gbHB1kzCmZgTy6CIJbfQgvI
 L/nR7G4EZkrl++tuJb7R5J3rReIKOcl56vL39vsnvP6qogx+dQSG2f2dSpiZdqJQDOUr
 hleYp0DVvGeoXJZTrJQB122Nl7H60VbjkI6rbJ7WWcyjX6hkUDlNxOr8FsMTIaplbu4l
 i3J2SV+xr7egwqcMR2j2fMVAZ3bsdN3IiUhlvLjjZo0WpHFMKypRjYYRw552PLQtmvtA yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3128tn6a0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 12:16:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04ICCTUC069018;
        Mon, 18 May 2020 12:16:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 313ghyrdyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 12:16:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04ICGYEr023418;
        Mon, 18 May 2020 12:16:36 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 05:16:34 -0700
Date:   Mon, 18 May 2020 15:16:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: Re: [RFC PATCH] staging: rtl8192u: indicate_packets() can be static
Message-ID: <20200518121627.GG2078@kadam>
References: <20200517165819.136715-1-pterjan@google.com>
 <20200517202216.GA24634@8c544063f25c>
 <ec2fa70939ab20dc7c454897b0b8ed08570dca80.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2fa70939ab20dc7c454897b0b8ed08570dca80.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1011 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 01:49:50PM -0700, Joe Perches wrote:
> On Mon, 2020-05-18 at 04:22 +0800, kbuild test robot wrote:
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > ---
> 
> This doesn't apply on Linus' tree or -next so perhaps the
> robot should put what tree and branch patches like these
> are meant to be applied on after the --- line
> 

It's supposed to apply on top of the email which it is replying to.

regards,
dan carpenter

