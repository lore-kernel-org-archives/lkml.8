Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F63C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB0207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586269088;
	bh=wqhk/J974wrMnBr8AoFs9B8rawBF/JWsdYfnrQGuBHg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vEODYY8/RRt8+Hw3htry3mGfXh4m+8fYqSPB6f4B8xmeAPdJIRT5/7mgNrAzBpa0I
	 70fowzViF3kiDy52RD5zegOXlyQl+LeBTUr2suzrRxO7OOom28ZvvmmWAtTsPlDnHd
	 c2d/JcV0QJFuuqBilrCQEMI68OiMPK3cuBAiuFsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgDGOSH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:18:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58942 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728596AbgDGOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:18:07 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-6l2qDtB8Poe7U4226j9T-g-1; Tue, 07 Apr 2020 10:14:33 -0400
X-MC-Unique: 6l2qDtB8Poe7U4226j9T-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C36800D5C;
        Tue,  7 Apr 2020 14:14:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B74315DA60;
        Tue,  7 Apr 2020 14:14:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kan Liang <kan.liang@intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: Disable page faults when getting phys address
Date:   Tue,  7 Apr 2020 16:14:27 +0200
Message-Id: <20200407141427.3184722-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit following warning when running tests on kernel
compiled with CONFIG_DEBUG_ATOMIC_SLEEP:

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

While __get_user_pages_fast is IRQ-safe it calls access_ok,
which warns on:

  WARN_ON_ONCE(!in_task() && !pagefault_disabled())

Peter suggested disabling page faults around __get_user_pages_fast,
which gets rid of the warning in access_ok call.

Cc: Kan Liang <kan.liang@intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1569979c8912..ccbcb9049c70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6916,9 +6916,12 @@ static u64 perf_virt_to_phys(u64 virt)
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
2.18.2

