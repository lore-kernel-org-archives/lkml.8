Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ACB20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgFPMWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgFPMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA794C08C5C6;
        Tue, 16 Jun 2020 05:21:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbB-0004dC-04; Tue, 16 Jun 2020 14:21:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8917A1C06DA;
        Tue, 16 Jun 2020 14:21:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add support for perf text poke event for
 text_poke_bp_batch() callers
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-3-adrian.hunter@intel.com>
References: <20200512121922.8997-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010932.16989.7697312095382772284.tip-bot2@tip-bot2>
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

Commit-ID:     d769811ca93303deb1d8729d20cceaca7051a6f1
Gitweb:        https://git.kernel.org/tip/d769811ca93303deb1d8729d20cceaca7051a6f1
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:09 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:48 +02:00

perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers

Add support for perf text poke event for text_poke_bp_batch() callers. That
includes jump labels. See comments for more details.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-3-adrian.hunter@intel.com
---
 arch/x86/kernel/alternative.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff..f94c9f3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
@@ -1001,6 +1002,7 @@ struct text_poke_loc {
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 old;
 };
 
 struct bp_patching_desc {
@@ -1168,8 +1170,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
+		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+	}
 
 	text_poke_sync();
 
@@ -1177,14 +1181,45 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
 		int len = text_opcode_size(tp[i].opcode);
 
 		if (len - INT3_INSN_SIZE > 0) {
+			memcpy(old + INT3_INSN_SIZE,
+			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+			       len - INT3_INSN_SIZE);
 			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
 				  (const char *)tp[i].text + INT3_INSN_SIZE,
 				  len - INT3_INSN_SIZE);
 			do_sync++;
 		}
+
+		/*
+		 * Emit a perf event to record the text poke, primarily to
+		 * support Intel PT decoding which must walk the executable code
+		 * to reconstruct the trace. The flow up to here is:
+		 *   - write INT3 byte
+		 *   - IPI-SYNC
+		 *   - write instruction tail
+		 * At this point the actual control flow will be through the
+		 * INT3 and handler and not hit the old or new instruction.
+		 * Intel PT outputs FUP/TIP packets for the INT3, so the flow
+		 * can still be decoded. Subsequently:
+		 *   - emit RECORD_TEXT_POKE with the new instruction
+		 *   - IPI-SYNC
+		 *   - write first byte
+		 *   - IPI-SYNC
+		 * So before the text poke event timestamp, the decoder will see
+		 * either the old instruction flow or FUP/TIP of INT3. After the
+		 * text poke event timestamp, the decoder will see either the
+		 * new instruction flow or FUP/TIP of INT3. Thus decoders can
+		 * use the timestamp as the point at which to modify the
+		 * executable code.
+		 * The old instruction is recorded so that the event can be
+		 * processed forwards or backwards.
+		 */
+		perf_event_text_poke(text_poke_addr(&tp[i]), old, len,
+				     tp[i].text, len);
 	}
 
 	if (do_sync) {
