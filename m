Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C127C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3512074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFBEVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:21:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFBEVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:21:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BEC055D;
        Mon,  1 Jun 2020 21:21:34 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C92D3F52E;
        Mon,  1 Jun 2020 21:21:31 -0700 (PDT)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1e71d815-5359-3ebe-5d2b-5a3b54b63b51@arm.com>
Date:   Tue, 2 Jun 2020 09:50:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0a936ec7-f44f-1d72-915f-f5758d25fd72@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2020 08:50 AM, John Hubbard wrote:
> On 2020-06-01 09:57, Daniel Jordan wrote:
>> Hi Anshuman,
>>
>> On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
>>> This adds the following two new VM events which will help in validating PMD
>>> based THP migration without split. Statistics reported through these events
>>> will help in performance debugging.
>>>
>>> 1. THP_PMD_MIGRATION_SUCCESS
>>> 2. THP_PMD_MIGRATION_FAILURE
>>
>> The names suggest a binary event similar to the existing
>> pgmigrate_success/fail, but FAILURE only tracks one kind of migration error,
>> and then only when the thp is successfully split, so shouldn't it be called
>> SPLIT instead?
>>
> 
> So the full description of the situation, which we're trying to compress into
> a shorter name, is "THP pmd migration failure, due to successfully splitting
> the THP". From that, the beginning part is the real point here, while the last
> part is less important. In other words, the users of these events are people
> who are trying to quantify THP migrations, and these events are particularly
> relevant for that. The "THP migration failed" is more important here than
> the reason that it failed. Or so I believe so far.

Absolutely, these events really help in quantifying THP migration successes
or their failures that involve splitting.

> 
> So I still think that the names are really quite good, but your point is

Agreed.

> also important: maybe this patch should also be tracking other causes
> of THP PMD migration failure, in order to get a truer accounting of the
> situation.
Is there any other failure reasons which are only specific to THP migration.
Else, adding stats about generic migration failure reasons will just blur
the overall understanding about THP migration successes and failure cases
that results in splitting.
