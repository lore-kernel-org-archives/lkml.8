Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB262208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbgGASc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:32:58 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37382 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732542AbgGASc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:32:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U1QNcAa_1593628370;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U1QNcAa_1593628370)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jul 2020 02:32:53 +0800
Subject: Re: [RFC][PATCH 2/8] mm/migrate: Defer allocating new page until
 needed
To:     Dave Hansen <dave.hansen@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kbusch@kernel.org, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <20200629234507.CA0FDE19@viggo.jf.intel.com>
 <xr93lfk38vw0.fsf@gthelen.svl.corp.google.com>
 <977d6482-58f8-c1c8-c54d-7c03a028c532@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9da66966-1f67-13ce-28c2-281b37147568@linux.alibaba.com>
Date:   Wed, 1 Jul 2020 11:32:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <977d6482-58f8-c1c8-c54d-7c03a028c532@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/20 7:46 AM, Dave Hansen wrote:
> On 7/1/20 1:47 AM, Greg Thelen wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>> Defer allocating the page until we are actually ready to make use of
>>> it, after locking the original page. This simplifies error handling,
>>> but should not have any functional change in behavior. This is just
>>> refactoring page migration so the main part can more easily be reused
>>> by other code.
>> Is there any concern that the src page is now held PG_locked over the
>> dst page allocation, which might wander into
>> reclaim/cond_resched/oom_kill?  I don't have a deadlock in mind.  I'm
>> just wondering about the additional latency imposed on unrelated threads
>> who want access src page.
> It's not great.  *But*, the alternative is to toss the page contents out
> and let users encounter a fault and an allocation.  They would be
> subject to all the latency associated with an allocation, just at a
> slightly later time.
>
> If it's a problem it seems like it would be pretty easy to fix, at least
> for non-cgroup reclaim.  We know which node we're reclaiming from and we
> know if it has a demotion path, so we could proactively allocate a
> single migration target page before doing the source lock_page().  That
> creates some other problems, but I think it would be straightforward.

If so this patch looks pointless if I read it correctly. The patch 
defers page allocation in __unmap_and_move() under page lock so that 
__unmap_and _move() can be called in reclaim path since the src page is 
locked in reclaim path before calling __unmap_and_move() otherwise it 
would deadlock itself.

Actually you always allocate target page with src page locked with this 
implementation unless you move the target page allocation before 
shrink_page_list(), but the problem is you don't know how many pages you 
need allocate.

The alternative may be to unlock the src page then allocate target page 
then lock src page again. But if so why not just call migrate_pages() 
directly as I did in my series? It put the src page on a separate list 
then unlock it, then migrate themn in batch later.

>>> #Signed-off-by: Keith Busch <keith.busch@intel.com>
>> Is commented Signed-off-by intentional?  Same applies to later patches.
> Yes, Keith is no longer at Intel, so that @intel.com mail would bounce.
>   I left the @intel.com SoB so it would be clear that the code originated
> from Keith while at Intel, but commented it out to avoid it being picked
> up by anyone's tooling.

