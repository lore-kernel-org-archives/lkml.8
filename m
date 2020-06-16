Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B6D20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgFPMWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgFPMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C0C08C5C2;
        Tue, 16 Jun 2020 05:21:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb5-0004bA-MM; Tue, 16 Jun 2020 14:21:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4856C1C0095;
        Tue, 16 Jun 2020 14:21:47 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:47 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix oops when counting IMC
 uncore events on some TGL
Cc:     Ammy Yi <ammy.yi@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chao Qin <chao.qin@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
References: <1590679169-61823-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010702.16989.16517537495111095749.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2af834f1faab3f1e218fcbcab70a399121620d62
Gitweb:        https://git.kernel.org/tip/2af834f1faab3f1e218fcbcab70a399121620d62
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 May 2020 08:19:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:50 +02:00

perf/x86/intel/uncore: Fix oops when counting IMC uncore events on some TGL

When counting IMC uncore events on some TGL machines, an oops will be
triggered.
  [ 393.101262] BUG: unable to handle page fault for address:
  ffffb45200e15858
  [ 393.101269] #PF: supervisor read access in kernel mode
  [ 393.101271] #PF: error_code(0x0000) - not-present page

Current perf uncore driver still use the IMC MAP SIZE inherited from
SNB, which is 0x6000.
However, the offset of IMC uncore counters is larger than 0x6000,
e.g. 0xd8a0.

Enlarge the IMC MAP SIZE for TGL to 0xe000.

Fixes: fdb64822443e ("perf/x86: Add Intel Tiger Lake uncore support")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Tested-by: Chao Qin <chao.qin@intel.com>
Link: https://lkml.kernel.org/r/1590679169-61823-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 5c40367..d5ae3a8 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1151,6 +1151,7 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 }
 
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
+#define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
 static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
@@ -1178,7 +1179,7 @@ static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 	addr |= ((resource_size_t)mch_bar << 32);
 #endif
 
-	box->io_addr = ioremap(addr, SNB_UNCORE_PCI_IMC_MAP_SIZE);
+	box->io_addr = ioremap(addr, TGL_UNCORE_PCI_IMC_MAP_SIZE);
 }
 
 static struct intel_uncore_ops tgl_uncore_imc_freerunning_ops = {
