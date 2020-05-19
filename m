Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF3020872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgESUBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgEST67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC4C08C5C0;
        Tue, 19 May 2020 12:58:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O0-0008WO-34; Tue, 19 May 2020 21:58:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C8F41C04E3;
        Tue, 19 May 2020 21:58:39 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:39 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Use native swapgs in asm_load_gs_index()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512213809.583980272@linutronix.de>
References: <20200512213809.583980272@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831915.17951.5043866712580848379.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3d1723d88a0c28ad7db441aed6c912e99467abfe
Gitweb:        https://git.kernel.org/tip/3d1723d88a0c28ad7db441aed6c912e99467abfe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 May 2020 14:54:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:54 +02:00

x86/entry/64: Use native swapgs in asm_load_gs_index()

When PARAVIRT_XXL is in use, then load_gs_index() uses xen_load_gs_index()
and asm_load_gs_index() is unused.

It's therefore pointless to use the paravirtualized SWAPGS implementation
in asm_load_gs_index(). Switch it to a plain swapgs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512213809.583980272@linutronix.de

---
 arch/x86/entry/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index be8ed3a..9747b42 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1043,11 +1043,11 @@ idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
  */
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
-	SWAPGS
+	swapgs
 .Lgs_change:
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
-	SWAPGS
+	swapgs
 	FRAME_END
 	ret
 SYM_FUNC_END(asm_load_gs_index)
@@ -1057,7 +1057,7 @@ EXPORT_SYMBOL(asm_load_gs_index)
 	.section .fixup, "ax"
 	/* running with kernelgs */
 SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
-	SWAPGS					/* switch back to user gs */
+	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
 	movl $__USER_DS, %eax
