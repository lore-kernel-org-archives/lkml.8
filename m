Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC15A2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFCEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:37:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCEhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 00:37:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B630231B;
        Tue,  2 Jun 2020 21:37:34 -0700 (PDT)
Received: from [10.163.77.218] (unknown [10.163.77.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92843F305;
        Tue,  2 Jun 2020 21:37:31 -0700 (PDT)
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration without
 split
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, hughd@google.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200601165736.qw5kwwknxltk7bv6@ca-dmjordan1.us.oracle.com>
 <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
 <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
 <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
 <20200602145208.qucum52lwslhiqff@ca-dmjordan1.us.oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <db50792c-ced5-a59d-0d94-e1520cf53715@arm.com>
Date:   Wed, 3 Jun 2020 10:06:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200602145208.qucum52lwslhiqff@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2020 08:22 PM, Daniel Jordan wrote:
> On Mon, Jun 01, 2020 at 09:48:09PM -0700, John Hubbard wrote:
>> However, the fact that this is under discussion hints at the need for a
>> bit of documentation help. What do you think about adding some notes about
>> all of this to, say, Documentation/vm/page_migration.rst ?
> 
> Yes, that would be good.  I understand the intent better now but still think
> the 'failure' event could be misinterpreted as outright failure instead of
> splitting followed by successfully moving the constituent pages.

Does this look okay and sufficient ?

--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -253,5 +253,20 @@ which are function pointers of struct address_space_operations.
      PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
      for own purpose.
 
+Quantifying Migration
+=====================
+Following events can be used to quantify page migration.
+
+- PGMIGRATE_SUCCESS
+- PGMIGRATE_FAIL
+- THP_MIGRATION_SUCCESS
+- THP_MIGRATION_FAILURE
+
+THP_MIGRATION_FAILURE in particular represents an event when a THP could not be
+migrated as a single entity following an allocation failure and ended up getting
+split into constituent normal pages before being retried. This event, along with
+PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and analyzing THP
+migration events including both success and failure cases.
+


> 
> It might help to clarify in the changelog as well.
> 

Sure, will update the commit message accordingly.
