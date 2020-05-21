Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82990C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547DA20678
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgEUEKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:10:47 -0400
Received: from foss.arm.com ([217.140.110.172]:39934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgEUEKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:10:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E7C30E;
        Wed, 20 May 2020 21:10:46 -0700 (PDT)
Received: from [10.163.75.69] (unknown [10.163.75.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D623F68F;
        Wed, 20 May 2020 21:10:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
 <20200520071521.GA29616@hori.linux.bs1.fc.nec.co.jp>
Message-ID: <d20494ac-5039-6956-c70b-f78e51b4f6eb@arm.com>
Date:   Thu, 21 May 2020 09:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200520071521.GA29616@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/20/2020 12:45 PM, HORIGUCHI NAOYA(堀口　直也) wrote:
> On Mon, May 18, 2020 at 12:12:36PM +0530, Anshuman Khandual wrote:
>> This adds the following two new VM events which will help in validating PMD
>> based THP migration without split. Statistics reported through these events
>> will help in performance debugging.
>>
>> 1. THP_PMD_MIGRATION_SUCCESS
>> 2. THP_PMD_MIGRATION_FAILURE
>>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hi Anshuman,

Hi Naoya,

> 
> I'm neutral for additinal lines in /proc/vmstat. It's a classic (so widely
> used) but inflexible interface. Users disabling thp are not happy with many
> thp-related lines, but judging from the fact that we already have many

Right, for similar reason, I am not too keen on enabling these counters
without migration being enabled with ARCH_ENABLE_THP_MIGRATION.

> thp-related lines some users really need them. So I feel hard to decide to
> agree or disagree with additional lines.

Currently these are conditional on ARCH_ENABLE_THP_MIGRATION. So we are
not adding these new lines unless it migration is available and enabled.

> 
> I think that tracepoints are the more flexible interfaces for monitoring,
> so I'm interested more in whether thp migration could be monitorable via
> tracepoint. Do you have any idea/plan on it?

Sure, we can add some trace points as well which can give more granular
details regarding THP migration mechanism itself e.g setting and removing
PMD migration entries etc probably with (vaddr, pmdp, pmd) details.

But we will still need /proc/vmstat entries that will be available right
away without requiring additional steps. This simplicity is essential for
folks to consider using these events more often.

Sure, will look into what trace points can be added for THP migration but
in a subsequent patch.

- Anshuman
