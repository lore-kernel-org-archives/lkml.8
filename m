Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F0C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2A920748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jE2GHbQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgAQFEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:04:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgAQFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:04:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4wCkp099355;
        Fri, 17 Jan 2020 05:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=C7E4rn681XeGsLrdspXx5S23srOIn+BD9EH2JlLOmaE=;
 b=jE2GHbQ66yJlYqI9aR2paG/a63EAhcgEEsDn6YJcXT2E3NQ3D3YQkiaYOaUr5dOJleae
 PrD2fUsXzC1TJYrTp7TVVFrbbR5Z6IRJIFJUZ6sveihY7h3IZlguynathhBEulSUawld
 cAI91IakEI9WiNBoKm+n3eGFlC8//MKB8rWMiJegKQ80QzZV8REyXnNi+eT6i3e8w3jX
 ePIfiQ2jm8ByKCQ6gjXEFJyj7RKk++pt+60onw61fhF3h1+5+OFzaKcndGSygJaC3tO+
 ZxVmzd3Rz/BqN9GckXvM8pyK7+y6mxP4Rj2SRsZh9jXS2Pz1MK2vPqksa6vQaVRoLXdt yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73u6f42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:04:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4wHkF085171;
        Fri, 17 Jan 2020 05:04:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xjxm868nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 05:04:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00H54Qq6021453;
        Fri, 17 Jan 2020 05:04:26 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 21:04:26 -0800
Date:   Fri, 17 Jan 2020 08:06:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] driver core: platform: fix u32 greater or equal to
 zero comparison
Message-ID: <20200117050609.GD19765@kadam>
References: <20200116175758.88396-1-colin.king@canonical.com>
 <20200117044216.GC21151@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117044216.GC21151@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=860
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 07:42:16AM +0300, Dan Carpenter wrote:
> On Thu, Jan 16, 2020 at 05:57:58PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the check that a u32 variable i is >= 0 is always true because
> > the unsigned variable will never be negative, causing the loop to run
> > forever.  Fix this by changing the pre-decrement check to a zero check on
> > i followed by a decrement of i.
> > 
> > Addresses-Coverity: ("Unsigned compared against 0")
> > Fixes: 39cc539f90d0 ("driver core: platform: Prevent resouce overflow from causing infinite loops")
> 

Also by the way say you have:

	unsigned int limit = (unsigned)INT_MAX + 4;
	int i;

	for (i = 0; i < limit; i++)
		;
	printf("%d\n", i);


The loop will work the same way regardless of if int is signed or not
because of type promotion.

regards,
dan carpenter
