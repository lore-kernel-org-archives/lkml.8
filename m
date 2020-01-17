Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC0C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC582072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EB6s402d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAQEkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:40:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgAQEku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:40:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4c4Hg103375;
        Fri, 17 Jan 2020 04:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ZNoDZGTs5MN5mqdjzRI8VthtCVTAFKhbESVBbF49hQI=;
 b=EB6s402dYSXX8kIwdeN6p2HhcjQVMC4CDPV1BDxLH935pe14fnAeA4VNWSkXbXBbyiB7
 twizGoK9NXpD2KscodNxzYqoHrqnCJi1GqF0YVO5uuaeEjcWPIy8DW0hDLi0G25HWRxf
 7ar9ag5Ewe5c4HkO+e1NPmpbo+1w1uLKcgCI98Mhg0xst9lU/kyQGH3ZorAwk5Md4KGm
 off851CU3vIshB4JOcv8UNgtZdtlkewAFXVFaThN9rlnOzc+MBdgJ1sb+cY9vOeZc1cS
 Z1osOrhW3nOu4FdMrZ56am/AC3WCAaQkAsh5k0JMnRJAUq0gCoZRJli1Ab14h3eZGb9z 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73yxg2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 04:40:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4d2M6050758;
        Fri, 17 Jan 2020 04:40:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xjxm856fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 04:40:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00H4eYus014071;
        Fri, 17 Jan 2020 04:40:34 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 20:40:34 -0800
Date:   Fri, 17 Jan 2020 07:42:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] driver core: platform: fix u32 greater or equal to
 zero comparison
Message-ID: <20200117044216.GC21151@kadam>
References: <20200116175758.88396-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116175758.88396-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=515
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=1 spamscore=0 clxscore=1011
 lowpriorityscore=1 mlxscore=0 impostorscore=0 mlxlogscore=574 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 05:57:58PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the check that a u32 variable i is >= 0 is always true because
> the unsigned variable will never be negative, causing the loop to run
> forever.  Fix this by changing the pre-decrement check to a zero check on
> i followed by a decrement of i.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 39cc539f90d0 ("driver core: platform: Prevent resouce overflow from causing infinite loops")

A better fix would be to revert this patch.  It doesn't fix a real bug.
The ->num_resources is typically under 5.  It's not going to overflow
INT_MAX any time soon.  There are "architectures with smaller ints."

It should always be "int i" unless there is a valid real life reason.
People think that declaring everything as u32 will fix bugs but it
normally just introduces bugs as it does here.  u32 makes the code
harder to read.

This is a sore spot for me because apparently there is a static
analysis tool which tells people to use "u32 i;" everywhere.  It's bad
advice.  I have asked around but I haven't found which tool it is, but
which  we should find the tool and delete it to prevent this kind of
stuff in the future.

regards,
dan carpenter

