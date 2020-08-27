Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF81C207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgH0QcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:32:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:21618 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0QcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:32:07 -0400
IronPort-SDR: JD67NoLMMXQq5n6FU8Xp0ZzunYrWtR2eaPlRcXJ+Zal8bko34OkiliYFjHAb1LJSNqriTu/+t5
 Qot9rkOUAm8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="156525104"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="156525104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 09:32:06 -0700
IronPort-SDR: JaJtwHwfoRlhD9oee9kQXytAxOSTYBgdDbi4tlP7xPM/0YWghmC88IKX/0kZoae7ObIr2hAh/y
 2yIB1G20MmCw==
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="444504866"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 09:32:05 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Youquan Song <youquan.song@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing the race to poison a page
Date:   Thu, 27 Aug 2020 09:32:05 -0700
Message-Id: <20200827163205.23096-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For discussion ... I'm 100% sure the patch below is the wrong way to
fix this ... for one thing it doesn't provide the virtual address of
the error to the user signal handler. For another it just looks like
a hack.  I'm just not sure whether to delve deep into the
memory_failure() path to make sure the signal is sent to the current
process in the SRAR case. Or just to do a better job at an error return
value and make the X86 specific code send the signal with the address.

I've also got a feeling that this issue has been discussed before, but
can't remember how that turned out.

First few paragraphs describe the problem (and I think are OK). Things
go off the rails with the fix.

-Tony

X86 hardware may provide two indications that a page has poison. First
the memory controller that detects the failed ECC check may log a UCNA
(uncorrected no action) signature in one machine check bank and signal
the OS with a CMCI (corrected machine check interrupt ... historical name
did not get updated for this case). Next the processor core may log a
SRAR (software recoverable action required) signature in another bank
and signal with #MC.

The #MC used to win that race and the page was taken offline and SIGBUS
sent to the task.

Changes to how Linux processes machine checks now mean that:
a) Linux will offline the page based on the UCNA siganture in the
   CMCI handler.
b) The machine check handler defers processing using task_work_add() which
   can happen after the CMCI is processed.

memory_failure() avoids races with multiple callers reporting the same
page with an atomic test and set operation to mark the page as poisoned.

The net result of all of the above is that when a task consumes poison
the page is taken offline by the UCNA/CMCI path, and the SRAR/#MC path
takes an early return without sending a SIGBUS.

Fix by changing memory_failure() to return -EEXIST in the case where
the page is already poisoned and make the machine check code path check
for this error and force a SIGBUS.

Note that -EBUSY might have been a more logical error code, but that is
already used for many other error cases from memory_failure().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 +++++--
 mm/memory-failure.c            | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fb6b5f64f7e6..8515809e0472 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1182,18 +1182,21 @@ static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
+	int ret;
 
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
+	if (!ret) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		return;
 	}
 
-	pr_err("Memory error not recovered");
+	if (ret != -EEXIST)
+		pr_err("Memory error not recovered");
 	kill_me_now(cb);
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f1aa6433f404..e0486c4e0130 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1298,7 +1298,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
-		return 0;
+		return -EEXIST;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.21.1

