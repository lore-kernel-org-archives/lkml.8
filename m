Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F92C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423F2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDHMU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49623 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgDHMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gt-00062k-F9; Wed, 08 Apr 2020 14:20:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 773D01C0131;
        Wed,  8 Apr 2020 14:20:21 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:21 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Disable page faults when getting phys address
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200407141427.3184722-1-jolsa@kernel.org>
References: <20200407141427.3184722-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158634842102.28353.10574957272961464103.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d3296fb372bf7497b0e5d0478c4e7a677ec6f6e9
Gitweb:        https://git.kernel.org/tip/d3296fb372bf7497b0e5d0478c4e7a677ec6f6e9
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Tue, 07 Apr 2020 16:14:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:33:46 +02:00

perf/core: Disable page faults when getting phys address

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
---
 kernel/events/core.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 26de0a5..bc9b98a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6934,9 +6934,12 @@ static u64 perf_virt_to_phys(u64 virt)
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
