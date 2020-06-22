Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB260C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C248920708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFVI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:58:12 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:44972 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgFVI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:58:11 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id D29F0BECB9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:58:09 +0100 (IST)
Received: (qmail 27448 invoked from network); 22 Jun 2020 08:58:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jun 2020 08:58:09 -0000
Date:   Mon, 22 Jun 2020 09:58:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        alex.shi@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, liwang@redhat.com
Subject: Re: [PATCH 2/2] mm, page_alloc: use unlikely() in task_capc()
Message-ID: <20200622085808.GP3183@techsingularity.net>
References: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz>
 <20200616082649.27173-1-vbabka@suse.cz>
 <20200616082649.27173-2-vbabka@suse.cz>
 <alpine.LSU.2.11.2006161319030.1119@eggly.anvils>
 <4a24f7af-3aa5-6e80-4ae6-8f253b562039@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4a24f7af-3aa5-6e80-4ae6-8f253b562039@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:55:07AM +0200, Vlastimil Babka wrote:
> <SNIP>
>
> It makes no difference, at least on my gcc10 which seems to be smart enough to
> do the right thing. But yeah, your suggestion is more readable and precise and
> maybe can work better with a less smart compiler. Thanks.
> 
> ----8<----
> From 615eea6f6abe288ffb708aa0d1bdfbeaf30a4cbd Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 16 Jun 2020 10:14:47 +0200
> Subject: [PATCH] mm, page_alloc: use unlikely() in task_capc()
> 
> Hugh noted that task_capc() could use unlikely(), as most of the time there is
> no capture in progress and we are in page freeing hot path. Indeed adding
> unlikely() produces assembly that better matches the assumption and moves
> all the tests away from the hot path.
> 
> I have also noticed that we don't need to test for cc->direct_compaction as the
> only place we set current->task_capture is compact_zone_order() which also
> always sets cc->direct_compaction true.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Hugh Dickins <hughd@googlecom>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
