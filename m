Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269F620771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zCw7BJTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDIKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:17:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:17:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039AD75n162883;
        Thu, 9 Apr 2020 10:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BQv+SFU9p0BAD68jJoZGU4GuYeJmyCacIu0TxHC5XrE=;
 b=zCw7BJTh6xHuF4KLGeTZOLnqIpZz43sntnvBpt26ZiOKmw2KhKwVxRVn7W+YXXYGZdu5
 +ZhUeDrec4ZKkm9AN/SiK4Orvstru5aSFF3o8tovRmAW8ZNkKzariO8xffXafpJ5UgNv
 XO1Qy4XVI+r5x3nKdOc/7DvAr8Xnk8uAGQ1rmDxS39XrCBDNCreD8RnfmNvlKdA2vyQm
 Mo7SSMqt/u/Qd8fAkWHG4i2qaMUlqpdkq7kNGAhQPp6OZa7pYhlVLElo4sPqjkGXeZaq
 Yf0SWAFRFlclEoz4/Q3Mh12H3X3/bBSUV5GRi8ZvbEvULiYajmBPjud25mgk+elCe4+U Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 309gw4chm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:17:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039AClOb148569;
        Thu, 9 Apr 2020 10:15:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 309ag478ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 10:15:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039AFPpT017318;
        Thu, 9 Apr 2020 10:15:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 03:15:24 -0700
Date:   Thu, 9 Apr 2020 13:15:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-ID: <20200409101517.GO2001@kadam>
References: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=667 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=745 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:24:05AM +0200, Oliver Graute wrote:
> From: Oliver Graute <oliver.graute@kococonnector.com>
> 
> Enable inversion mode

What the heck is an inversion mode and why would you want it?

regards,
dasn carpenter

