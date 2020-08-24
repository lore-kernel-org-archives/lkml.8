Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F049C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABA820706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgHXWMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:12:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:3448 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgHXWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:12:39 -0400
IronPort-SDR: wAl+ZIMXW9en4/d/cUJCTos3EvSWmp4nmZY62R5FiRUk81RlE8gsORn1f9LFnPa8B8dRga8x0M
 NoRsbEMCVybA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136062341"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136062341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 15:12:38 -0700
IronPort-SDR: lgrhczaWqd6JCh539gfdqjZ8/Jc022Fq7wThT/t1fmhusRoQW1eFJKTiC72mq7++zOQ2cmy5SY
 tlHE0xjEK0jg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474093508"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 15:12:38 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/mce: Delay clearing IA32_MCG_STATUS to the end of do_machine_check()
Date:   Mon, 24 Aug 2020 15:12:37 -0700
Message-Id: <20200824221237.5397-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A long time ago, Linux cleared IA32_MCG_STATUS at the very end of machine
check processing.

Then we added some fancy recovery and IST manipulation in:

commit d4812e169de4 ("x86, mce: Get rid of TIF_MCE_NOTIFY and associated mce tricks")

and clearing IA32_MCG_STATUS was pulled earlier in the function.

Next change moved the actual recovery out of do_machine_check() and just
used task_work_add() to schedule it later (before returning to the user):

commit 5567d11c21a1 ("x86/mce: Send #MC singal from task work")

Most recently the fancy IST footwork was removed as no longer needed:

commit b052df3da821 ("x86/entry: Get rid of ist_begin/end_non_atomic()")

At this point there is no reason remaining to clear IA32_MCG_STATUS early.
It can move back to the very end of the function.

Also moved sync_core(). The comments for this function say that it should
only be called when instructions have been changed/re-mapped. Recovery for
an instruction fetch may change the physical address. But that doesn't happen
until the scheduled work runs (which could be on another CPU).

Reported-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..0ba24dfffdb2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1190,6 +1190,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		sync_core();
 		return;
 	}
 
@@ -1330,12 +1331,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
 
-	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-
-	sync_core();
-
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-		return;
+		goto out;
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
@@ -1364,6 +1361,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 	}
+out:
+	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 
-- 
2.21.1

