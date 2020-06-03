Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C15C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F70207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFCB2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:28:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFCB2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:28:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F88255D;
        Tue,  2 Jun 2020 18:28:01 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DF4E3F6CF;
        Tue,  2 Jun 2020 18:27:57 -0700 (PDT)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2d4634ce-9167-6ca6-fb91-f3c671fff672@arm.com>
Date:   Wed, 3 Jun 2020 06:56:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200602150141.GN19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2020 08:31 PM, Matthew Wilcox wrote:
> On Fri, May 22, 2020 at 09:04:04AM +0530, Anshuman Khandual wrote:
>> This adds the following two new VM events which will help in validating PMD
>> based THP migration without split. Statistics reported through these events
>> will help in performance debugging.
>>
>> 1. THP_PMD_MIGRATION_SUCCESS
>> 2. THP_PMD_MIGRATION_FAILURE
> 
> There's nothing actually PMD specific about these events, is there?
> If we have a THP of a non-PMD size, you'd want that reported through the
> same statistic, wouldn't you?

Yes, there is nothing PMD specific here and we would use the same statistics
for non-PMD size THP migration (if any) as well. But is THP migration really
supported for non-PMD sizes ? CONFIG_ARCH_ENABLE_THP_MIGRATION depends upon
CONFIG_TRANSPARENT_HUGEPAGE without being specific or denying about possible
PUD level support. Fair enough, will drop the PMD from the events and their
functions.
