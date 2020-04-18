Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B5C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C91621BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219119;
	bh=H2MY8soOyk43ch8vGH9lyVRRB9DtpX3GtnZXCTTvzWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TwIbI5am7D3HCUjdE9A2HEXjjdWLf4VNvnhWkq2DS6dVKRvFQTtkYOrzw0KHlUfme
	 laILcB3emn34NSU/Yj64Lc5X2aGvRjj7gzPI3Iq46f/CqekCLUnzAlohibEezlQJ3Z
	 uk/sxJ8/XvxGX3Ab2+b5w5fwm1Fx6A/1ARTjLZvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDROL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgDROKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B010921D7E;
        Sat, 18 Apr 2020 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219019;
        bh=H2MY8soOyk43ch8vGH9lyVRRB9DtpX3GtnZXCTTvzWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ho2CV54g56i5P8+PP6syeo1L7z6w+oqx5Je0mRThfBI4dTr42xVqm93FmxewPTc8c
         x2gCxdVBHvDMlxH7w8JM5l0pSWSkeyVEwn9s6WWtseIW6UOxawglpYXEmLF8mhhPAs
         gOY3iYlmnlK1mwBAdqkFUg018XEqEpLjrS+yE37M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 55/75] perf/core: Disable page faults when getting phys address
Date:   Sat, 18 Apr 2020 10:08:50 -0400
Message-Id: <20200418140910.8280-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit d3296fb372bf7497b0e5d0478c4e7a677ec6f6e9 ]

We hit following warning when running tests on kernel
compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y:

 WARNING: CPU: 19 PID: 4472 at mm/gup.c:2381 __get_user_pages_fast+0x1a4/0x200
 CPU: 19 PID: 4472 Comm: dummy Not tainted 5.6.0-rc6+ #3
 RIP: 0010:__get_user_pages_fast+0x1a4/0x200
 ...
 Call Trace:
  perf_prepare_sample+0xff1/0x1d90
  perf_event_output_forward+0xe8/0x210
  __perf_event_overflow+0x11a/0x310
  __intel_pmu_pebs_event+0x657/0x850
  intel_pmu_drain_pebs_nhm+0x7de/0x11d0
  handle_pmi_common+0x1b2/0x650
  intel_pmu_handle_irq+0x17b/0x370
  perf_event_nmi_handler+0x40/0x60
  nmi_handle+0x192/0x590
  default_do_nmi+0x6d/0x150
  do_nmi+0x2f9/0x3c0
  nmi+0x8e/0xd7

While __get_user_pages_fast() is IRQ-safe, it calls access_ok(),
which warns on:

  WARN_ON_ONCE(!in_task() && !pagefault_disabled())

Peter suggested disabling page faults around __get_user_pages_fast(),
which gets rid of the warning in access_ok() call.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200407141427.3184722-1-jolsa@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fdb7f7ef380c4..8cc11af391c8a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6748,9 +6748,12 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe __get_user_pages_fast first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if ((current->mm != NULL) &&
-		    (__get_user_pages_fast(virt, 1, 0, &p) == 1))
-			phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
+		if (current->mm != NULL) {
+			pagefault_disable();
+			if (__get_user_pages_fast(virt, 1, 0, &p) == 1)
+				phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
+			pagefault_enable();
+		}
 
 		if (p)
 			put_page(p);
-- 
2.20.1

