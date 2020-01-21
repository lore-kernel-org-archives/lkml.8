Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F32C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41421734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAUGHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:07:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUGHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:07:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89B0131B;
        Mon, 20 Jan 2020 22:07:08 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC8A73F52E;
        Mon, 20 Jan 2020 22:07:06 -0800 (PST)
Subject: Re: [Patch v2 3/4] mm/page_alloc.c: pass all bad reasons to
 bad_page()
To:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-4-richardw.yang@linux.intel.com>
 <20200120102200.GW18451@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2288c80c-42f7-a161-58cf-47cf07699202@arm.com>
Date:   Tue, 21 Jan 2020 11:38:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120102200.GW18451@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/20/2020 03:52 PM, Michal Hocko wrote:
> On Mon 20-01-20 11:04:14, Wei Yang wrote:
>> Now we can pass all bad reasons to __dump_page().
> And we do we want to do that? The dump of the page will tell us the
> whole story so a single and the most important reason sounds like a
> better implementation. The code is also more subtle because each caller
> of the function has to be aware of how many reasons there might be.
> Not to mention that you need a room for 5 pointers on the stack and this
> and page allocator might be called from deeper call chains.
> 

Two paths which lead to __dump_page(), dump_page() and bad_page().
Callers of dump_page() can give a single reason what they consider the
most important which leads to page dumping. This makes sense but gets
trickier in bad_page() path. At present, free_pages_check_bad() and
check_new_page_bad() has a sequence of 'if' statements which decides
"most important" reason for __dump_page() without much rationale and
similar in case of free_tail_pages_check() as well. As all information
about the page for corresponding reasons are printed with __dump_page()
anyways, do free_pages_check_bad() or check_new_page_bad() really need
to provide any particular single reason ?
