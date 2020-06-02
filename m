Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE9206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFBFbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:31:45 -0400
Received: from foss.arm.com ([217.140.110.172]:46398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgFBFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:31:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E511FB;
        Mon,  1 Jun 2020 22:31:44 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DDDA3F52E;
        Mon,  1 Jun 2020 22:31:41 -0700 (PDT)
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration without
 split
To:     John Hubbard <jhubbard@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f88603c5-f9ce-115d-1976-3b0e7558777e@arm.com>
Date:   Tue, 2 Jun 2020 11:00:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <274be3bf-2206-5e98-8114-1d91fac472c9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2020 10:18 AM, John Hubbard wrote:
> On 2020-06-01 21:20, Anshuman Khandual wrote:
> ...
>>> also important: maybe this patch should also be tracking other causes
>>> of THP PMD migration failure, in order to get a truer accounting of the
>>> situation.
> 
> I hope one of the experts here can weigh in on that...
> 
>> Is there any other failure reasons which are only specific to THP migration.
>> Else, adding stats about generic migration failure reasons will just blur
>> the overall understanding about THP migration successes and failure cases
>> that results in splitting.
>>
> 
> Thinking about that: we do have PGMIGRATE_SUCCESS and PGMIGRATE_FAIL, so I
> suppose comparing those numbers with the new THP_PMD_MIGRATION_SUCCESS and
> THP_PMD_MIGRATION_FAILURE events should cover it.

That is right.

> 
> However, the fact that this is under discussion hints at the need for a
> bit of documentation help. What do you think about adding some notes about
> all of this to, say, Documentation/vm/page_migration.rst ?

Sure but probably bit later. Because I am also planning to add couple of
trace events for THP migration, hence will update the documentation part
for both VM stat and trace events together.
