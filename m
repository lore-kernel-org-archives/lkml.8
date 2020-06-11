Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971CEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F37B206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFKPsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:48:17 -0400
Received: from outbound-smtp40.blacknight.com ([46.22.139.223]:42715 "EHLO
        outbound-smtp40.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbgFKPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:48:17 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 114AC1C3A4F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:48:16 +0100 (IST)
Received: (qmail 2398 invoked from network); 11 Jun 2020 15:48:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Jun 2020 15:48:15 -0000
Date:   Thu, 11 Jun 2020 16:43:51 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Li Wang <liwang@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: capture page in task context only
Message-ID: <20200611154351.GA3183@techsingularity.net>
References: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:48:59PM -0700, Hugh Dickins wrote:
> While stressing compaction, one run oopsed on NULL capc->cc in
> __free_one_page()'s task_capc(zone): compact_zone_order() had been
> interrupted, and a page was being freed in the return from interrupt.
> 
> Though you would not expect it from the source, both gccs I was using
> (a 4.8.1 and a 7.5.0) had chosen to compile compact_zone_order() with
> the ".cc = &cc" implemented by mov %rbx,-0xb0(%rbp) immediately before
> callq compact_zone - long after the "current->capture_control = &capc".
> An interrupt in between those finds capc->cc NULL (zeroed by an earlier
> rep stos).
> 
> This could presumably be fixed by a barrier() before setting
> current->capture_control in compact_zone_order(); but would also need
> more care on return from compact_zone(), in order not to risk leaking
> a page captured by interrupt just before capture_control is reset.
> 
> Maybe that is the preferable fix, but I felt safer for task_capc() to
> exclude the rather surprising possibility of capture at interrupt time.
> 
> Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
> Cc: stable@vger.kernel.org # 5.1+
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
