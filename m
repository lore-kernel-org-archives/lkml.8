Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B3FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A425F20772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHSH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:57:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgHSH5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:57:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85314101E;
        Wed, 19 Aug 2020 00:57:37 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4051E3F6CF;
        Wed, 19 Aug 2020 00:57:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
Date:   Wed, 19 Aug 2020 13:27:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/19/2020 11:17 AM, Alex Shi wrote:
> Current pageblock_flags is only 4 bits, so it has to share a char size
> in cmpxchg when get set, the false sharing cause perf drop.
> 
> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
> the only cost is half char per pageblock, which is half char per 128MB
> on x86, 4 chars in 1 GB.

Agreed that increase in memory utilization is negligible here but does
this really improve performance ?
