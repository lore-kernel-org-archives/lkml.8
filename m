Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC46C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1E524680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAVL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:27:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:27:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuEAI-0001aX-LX; Wed, 22 Jan 2020 12:27:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3DE1E1C1A3B;
        Wed, 22 Jan 2020 12:27:18 +0100 (CET)
Date:   Wed, 22 Jan 2020 11:27:18 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/decoder: Add TEST opcode to Group3-2
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157966631413.9580.10311036595431878351.stgit@devnote2>
References: <157966631413.9580.10311036595431878351.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157969243800.396.2663775329967340720.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     8b7e20a7ba54836076ff35a28349dabea4cec48f
Gitweb:        https://git.kernel.org/tip/8b7e20a7ba54836076ff35a28349dabea4cec48f
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 22 Jan 2020 13:11:54 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Jan 2020 12:17:32 +01:00

x86/decoder: Add TEST opcode to Group3-2

Add TEST opcode to Group3-2 reg=001b as same as Group3-1 does.

Commit

  12a78d43de76 ("x86/decoder: Add new TEST instruction pattern")

added a TEST opcode assignment to f6 XX/001/XXX (Group 3-1), but did
not add f7 XX/001/XXX (Group 3-2).

Actually, this TEST opcode variant (ModRM.reg /1) is not described in
the Intel SDM Vol2 but in AMD64 Architecture Programmer's Manual Vol.3,
Appendix A.2 Table A-6. ModRM.reg Extensions for the Primary Opcode Map.

Without this fix, Randy found a warning by insn_decoder_test related
to this issue as below.

    HOSTCC  arch/x86/tools/insn_decoder_test
    HOSTCC  arch/x86/tools/insn_sanity
    TEST    posttest
  arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  arch/x86/tools/insn_decoder_test: warning: ffffffff81000bf1:	f7 0b 00 01 08 00    	testl  $0x80100,(%rbx)
  arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 2
  arch/x86/tools/insn_decoder_test: warning: Decoded and checked 11913894 instructions with 1 failures
    TEST    posttest
  arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 random instructions with 0 errors (seed:0x871ce29c)

To fix this error, add the TEST opcode according to AMD64 APM Vol.3.

 [ bp: Massage commit message. ]

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/157966631413.9580.10311036595431878351.stgit@devnote2
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 8908c58..53adc17 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -929,7 +929,7 @@ EndTable
 
 GrpTable: Grp3_2
 0: TEST Ev,Iz
-1:
+1: TEST Ev,Iz
 2: NOT Ev
 3: NEG Ev
 4: MUL rAX,Ev
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 8908c58..53adc17 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -929,7 +929,7 @@ EndTable
 
 GrpTable: Grp3_2
 0: TEST Ev,Iz
-1:
+1: TEST Ev,Iz
 2: NOT Ev
 3: NEG Ev
 4: MUL rAX,Ev
