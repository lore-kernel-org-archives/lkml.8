Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C9C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7452072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZC2DR7zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgAQEo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:44:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgAQEo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:44:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4cu8W123496;
        Fri, 17 Jan 2020 04:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kei4/bh5MHiyU6Xb1JUCnPX298eNmKPXG3KGKMXdG2U=;
 b=ZC2DR7zHE/Z6E+kKSHYV3aSz6EfolElzN6YKOI3lzNNWoYFc68PweWCZP3oRkdx/PWs5
 OZDL2668kyrUWwbwYlPjPgfHZEJH2URlqPu9I9DgNgyKEE0BQC2OdtwtNdF1ynOFzgq/
 4rbO+lthATkTFLpGdrHzmcZIWeewh8PEuinjRY/6kJK5tggZ7Wn493rwrbNfbyIoiM5s
 AzVbIZJleoS8BkcbraIAkLqlRO2EV8QmnsoL54gu+xB/odbZYFIv4yIzKYBusIWx1L5c
 JbaZmY9F5eZbQFmHDTtDLm5HALVxWOeo/2GxQf0gD+JWQjn8nTvnHH1XvkZt+TLfVnI0 vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74spexn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 04:44:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H4d1Ss050604;
        Fri, 17 Jan 2020 04:44:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xjxm85c5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 04:44:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00H4il8S027494;
        Fri, 17 Jan 2020 04:44:47 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 20:44:47 -0800
Date:   Fri, 17 Jan 2020 07:46:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Simon Schwartz <kern.simon@theschwartz.xyz>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] driver core: platform: fix u32 greater or equal to
 zero comparison
Message-ID: <20200117044629.GC19765@kadam>
References: <20200116175758.88396-1-colin.king@canonical.com>
 <20200117044216.GC21151@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117044216.GC21151@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=477
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=537 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170035
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
> A better fix would be to revert this patch.  It doesn't fix a real bug.
> The ->num_resources is typically under 5.  It's not going to overflow
> INT_MAX any time soon.  There are "architectures with smaller ints."

I left out a word.  There are *no* "architectures with smaller ints."...

I mean there used to be systems with 16 bit int but that was before I
was born.  You could never run linux on them.

regards,
dan carpenter

