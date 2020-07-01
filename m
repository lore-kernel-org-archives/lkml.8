Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB34206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGAVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGAVZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB761AAE8;
        Wed,  1 Jul 2020 21:25:14 +0000 (UTC)
Subject: Re: [PATCH v6 3/6] mm/workingset: extend the workingset detection for
 anon LRU
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-4-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8d12fc23-8731-c5f5-e38c-f40bfecb067f@suse.cz>
Date:   Wed, 1 Jul 2020 23:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592371583-30672-4-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hi,

I would adjust the subject, as it sounds like the patch does the whole
workingset detection, not just preparation.
How about:

mm/workingset: prepare the workingset infrastructure for anon LRU

> In the following patch, workingset detection will be applied to
> anonymous LRU. To prepare it, this patch adds some code to
> distinguish/handle the both LRUs.

How about:
To prepare for this, this patch splits workingset event counters for refault,
activate and restore into anon and file variants, as well as the refaults
counter in struct lruvec.

> v6: do not introduce a new nonresident_age for anon LRU since
> we need to use *unified* nonresident_age to implement workingset
> detection for anon LRU.

Again, v6 update info shouldn't go to changelog. In this case I think it doesn't
need mentioning at all, at least not in this patch.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
