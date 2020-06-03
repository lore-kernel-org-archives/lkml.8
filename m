Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FAF205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CkSq+MeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFCQKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:10:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44180 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:10:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053G2ZaW174548;
        Wed, 3 Jun 2020 16:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7IsA5VW1Zg1DgEuhycSVbfO4BwikUQw+wlbXCIQb/7Y=;
 b=CkSq+MePI0NOwIfe34RP6fn/SRURzkGbFrYQcpsLHhQKw21ivXkE0CEk3sDOkbiJP9Zc
 7KUALeVsIcnppHdE6cHfjt6L34fjrF86cABJWh5k2X1dFU44Bq+f+RnGjDnVn6RJvL7j
 CtlImTVgphHSm5fuiVfX4ZlZmiKnxaCREW4YhiTqP9j5tLi47iTlBtp7oxvSKgOx7soT
 G7ER8ycztdchPehc8Gk3pclN4XSUFHr0oJYcZu2et/1PYuP5Ov9Hxc7rmhf12+D5bSqt
 iLudbgrOv/YqbZlmGhTK6YVuTzNrrLj38vwKrJnf8qBAlYpLT8kMPOBybDpLnXcmHrCJ Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31ef1ng177-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 16:10:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053G7S2M078237;
        Wed, 3 Jun 2020 16:08:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31c12r3yh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 16:08:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 053G83k9027868;
        Wed, 3 Jun 2020 16:08:03 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 09:08:03 -0700
Date:   Wed, 3 Jun 2020 12:08:28 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        hughd@google.com, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration
 without split
Message-ID: <20200603160828.2sfuyjpyyc2bpuan@ca-dmjordan1.us.oracle.com>
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
 <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
 <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
 <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
 <20200602145208.qucum52lwslhiqff@ca-dmjordan1.us.oracle.com>
 <db50792c-ced5-a59d-0d94-e1520cf53715@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db50792c-ced5-a59d-0d94-e1520cf53715@arm.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:06:31AM +0530, Anshuman Khandual wrote:
> Does this look okay and sufficient ?
> 
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -253,5 +253,20 @@ which are function pointers of struct address_space_operations.
>       PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
>       for own purpose.
>  
> +Quantifying Migration
> +=====================
> +Following events can be used to quantify page migration.
> +
> +- PGMIGRATE_SUCCESS
> +- PGMIGRATE_FAIL
> +- THP_MIGRATION_SUCCESS
> +- THP_MIGRATION_FAILURE
> +
> +THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
> +migrated as a single entity following an allocation failure and ended up getting
> +split into constituent normal pages before being retried. This event, along with
> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
> +migration events including both success and failure cases.

Looks great!

> Sure, will update the commit message accordingly.

Thanks.  Hopefully these will help someone in the future.
