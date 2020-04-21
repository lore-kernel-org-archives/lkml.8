Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A9920857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDUJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:12:21 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60719 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:12:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDlbOU_1587460334;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDlbOU_1587460334)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:12:17 +0800
Subject: Re: [PATCH 03/18] mm: memcontrol: drop @compound parameter from memcg
 charging API
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-4-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <73c1a95f-fee9-716d-c72f-85585de13f2f@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:11:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> The memcg charging API carries a boolean @compound parameter that
> tells whether the page we're dealing with is a hugepage.
> mem_cgroup_commit_charge() has another boolean @lrucare that indicates
> whether the page needs LRU locking or not while charging. The majority
> of callsites know those parameters at compile time, which results in a
> lot of naked "false, false" argument lists. This makes for cryptic
> code and is a breeding ground for subtle mistakes.
> 
> Thankfully, the huge page state can be inferred from the page itself
> and doesn't need to be passed along. This is safe because charging
> completes before the page is published and somebody may split it.
> 
> Simplify the callsites by removing @compound, and let memcg infer the
> state by using hpage_nr_pages() unconditionally. That function does
> PageTransHuge() to identify huge pages, which also helpfully asserts
> that nobody passes in tail pages by accident.
> 
> The following patches will introduce a new charging API, best not to
> carry over unnecessary weight.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
