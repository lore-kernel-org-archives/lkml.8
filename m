Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7133FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904D22077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFCE7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:59:44 -0400
Received: from foss.arm.com ([217.140.110.172]:57114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCE7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 00:59:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB27155D;
        Tue,  2 Jun 2020 21:59:43 -0700 (PDT)
Received: from [10.163.77.218] (unknown [10.163.77.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BC6C3F6CF;
        Tue,  2 Jun 2020 21:59:40 -0700 (PDT)
Subject: Re: [PATCH] mm/vmstat: Add events for PMD based THP migration without
 split
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, hughd@google.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1590118444-21601-1-git-send-email-anshuman.khandual@arm.com>
 <20200602150141.GN19604@bombadil.infradead.org>
 <2d4634ce-9167-6ca6-fb91-f3c671fff672@arm.com>
 <20200603025729.GO19604@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <280304c7-882b-cb2f-55bf-87b2e2f28711@arm.com>
Date:   Wed, 3 Jun 2020 10:28:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200603025729.GO19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/03/2020 08:27 AM, Matthew Wilcox wrote:
> On Wed, Jun 03, 2020 at 06:56:57AM +0530, Anshuman Khandual wrote:
>> On 06/02/2020 08:31 PM, Matthew Wilcox wrote:
>>> On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
>>>> This adds the following two new VM events which will help in validating PMD
>>>> based THP migration without split. Statistics reported through these events
>>>> will help in performance debugging.
>>>>
>>>> 1. THP_PMD_MIGRATION_SUCCESS
>>>> 2. THP_PMD_MIGRATION_FAILURE
>>>
>>> There's nothing actually PMD specific about these events, is there?
>>> If we have a THP of a non-PMD size, you'd want that reported through the
>>> same statistic, wouldn't you?
>>
>> Yes, there is nothing PMD specific here and we would use the same statistics
>> for non-PMD size THP migration (if any) as well. But is THP migration really
>> supported for non-PMD sizes ? CONFIG_ARCH_ENABLE_THP_MIGRATION depends upon
>> CONFIG_TRANSPARENT_HUGEPAGE without being specific or denying about possible
>> PUD level support. Fair enough, will drop the PMD from the events and their
>> functions.
> 
> I guess you haven't read my large pages patchset?

I believe you are referring this "[PATCH v5 00/39] Large pages in the page cache"
(https://lkml.org/lkml/2020/5/28/1755). Unfortunately, I have not been following
the series. But is there something else in particular that needs to be taken care
of as well ?
