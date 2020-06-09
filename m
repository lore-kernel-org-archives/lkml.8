Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB591C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863ED2076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pQZKl04R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgFIW3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:29:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgFIW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:29:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059MSlQd006862;
        Tue, 9 Jun 2020 22:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Iz9AprZJCB7o1dInUVOMFCgzyuZ5WLIAm1eEtjf9omc=;
 b=pQZKl04RFtSOW3EC5FgA8akaJYs71gh9EZeNew/uDBxucFzzznEhidzi8gQxeNMZRu2K
 i1HQyZW/oi/7VAe0ofF9n3u6cCAcL2JTiSqt3HhoJNi9kUUomxlcDvnEKU3FvUXZkvV3
 gnC7rjWw56FLM6or0Wb+ncg1Fb0ihfjTLzeoucxEpkLGdXaFSbLawqiqFPFT1gCgw8Ft
 eiyftpkdCJFOXIjlPwV5JveYhQYf9ZD2jF2pqymzR1gIZCUKCziP1g5E9/MUl3F1s1YH
 8NZG5fk3iQIH02dn0cutecd2KGLPzXEs7u5GkCytQcdZQAtylbcrJolmRKGGdqZB7Co1 Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smy9cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 22:28:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059MRhbk169125;
        Tue, 9 Jun 2020 22:28:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31gn2xct8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 22:28:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 059MSexf028838;
        Tue, 9 Jun 2020 22:28:40 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 15:28:39 -0700
Date:   Tue, 9 Jun 2020 18:29:05 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, hughd@google.com, daniel.m.jordan@oracle.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Message-ID: <20200609222905.vgh3x7i2d5wzmtzh@ca-dmjordan1.us.oracle.com>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
 <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
 <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
 <890AA27D-29BA-45A9-B868-5533645D73D5@nvidia.com>
 <6401ee03-e6b3-c8f5-58b5-4f615c1b7bfc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6401ee03-e6b3-c8f5-58b5-4f615c1b7bfc@arm.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:05:45PM +0530, Anshuman Khandual wrote:
> On 06/05/2020 07:54 PM, Zi Yan wrote:
> > On 4 Jun 2020, at 23:35, Anshuman Khandual wrote:
> >> Thanks Zi, for such a detailed explanation. Ideally, we should separate THP
> >> migration from base page migration in terms of statistics. PGMIGRATE_SUCCESS
> >> and PGMIGRATE_FAIL should continue to track statistics when migration starts
> >> with base pages. But for THP, we should track the following events.
> > 
> > You mean PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will not track the number of migrated subpages
> > from split THPs? Will it cause userspace issues since their semantics are changed?
> 
> Yeah, basic idea is to carve out all THP migration related statistics from
> the normal page migration. Not sure if that might cause any issue for user
> space as you have mentioned. Does /proc/vmstat indicate some sort of an ABI
> whose semantics can not really change ? Some more opinions here from others
> would be helpful.

vmstats have had their implementations changed for THP before, so there's at
least some precedent.

https://lore.kernel.org/linux-mm/1559025859-72759-2-git-send-email-yang.shi@linux.alibaba.com/

Others know better than I do.

> The current situation is definitely bit problematic where PGMIGRATE_SUCCESS
> increments (+1) both for normal and successful THP migration. Same situation
> for PGMIGRATE_FAILURE as well.

Yeah, that's suboptimal.  Maybe a separate patch to get thps accounted properly
in those stats?

> Hence, there are two clear choices available.
> 
> 1. THP and normal page migration stats are separate and mutually exclusive
> 
> OR
> 
> 2. THP migration has specific counters but normal page migration counters
>    still account for everything in THP migration in terms of normal pages

FWIW, 2 makes more sense to me because it suits the existing names (it's
PGMIGRATE_SUCCESS not PGMIGRATE_SMALL_PAGES_SUCCESS) and it's less surprising
than leaving thp out of them.

> But IIUC, either way the current PGMIGRATE_SUCCESS or PGMIGRATE_FAIL stats
> will change for the user as visible from /proc/vmstat.
> 
> > 
> >>
> >> 1. THP_MIGRATION_SUCCESS 	- THP migration is successful, without split
> >> 2. THP_MIGRATION_FAILURE 	- THP could neither be migrated, nor be split
> > 
> > They make sense to me.> 
> >> 3. THP_MIGRATION_SPLIT_SUCCESS  - THP got split and all sub pages migrated
> >> 4. THP_MIGRATION_SPLIT_FAILURE  - THP got split but all sub pages could not be migrated
> >>
> >> THP_MIGRATION_SPLIT_FAILURE could either increment once for a single THP or
> >> number of subpages that did not get migrated after split. As you mentioned,
> >> this will need some extra code in the core migration. Nonetheless, if these
> >> new events look good, will be happy to make required changes.
> > 
> > Maybe THP_MIGRATION_SPLIT would be simpler? My concern is that whether we need such
> 
> Also, it will not require a new migration queue tracking the split THP sub pages.
> 
> > detailed information or not. Maybe trace points would be good enough for 3 and 4.

I share the concern about whether that many new stats are necessary.  The
changelog says this is for performance debugging, so it seems THP success and
THP split would cover that.

The split stat becomes redundant if the other information is needed in the
future, but it can presumably be removed in that case.
