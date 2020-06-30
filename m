Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62939C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456DB206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgF3Tss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:48:48 -0400
Received: from foss.arm.com ([217.140.110.172]:32904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgF3Tsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:48:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925C3106F;
        Tue, 30 Jun 2020 12:48:45 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45CE3F73C;
        Tue, 30 Jun 2020 12:48:44 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] arm64: kprobes: Drop open-coded exception fixup
Date:   Tue, 30 Jun 2020 19:48:10 +0000
Message-Id: <20200630194822.1082-3-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

The short-circuit call to fixup_exception() from kprobe_fault_handler()
poses a problem now that the former wants to consume the fault address
too, since the common kprobes API offers us no way to pass it through.
Fortunately, however, it works out to be unnecessary:

- uaccess instructions themselves are not probeable, so at most we
  should only ever expect to take a fixable fault from the pre or post
  handlers.
- the pre and post handler run with preemption disabled, thus for any
  fault they may cause, an unhandled return from kprobe_page_fault()
  will proceed directly to __do_kernel_fault() thanks to the
  faulthandler_disabled() check.
- __do_kernel_fault() will immediately call fixup_exception() unless
  we're in an EL1 instruction abort, and if we've somehow taken one of
  those on what we think is the middle of a uaccess routine, then the
  world is already very on fire.

Thus we can reasonably drop the call from kprobe_fault_handler() and
leave uaccess fixups to the regular flow.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1c95dcf1d78..771635360110 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -334,13 +334,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 */
 		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
 			return 1;
-
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs))
-			return 1;
 	}
 	return 0;
 }
-- 
2.17.1

