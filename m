Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AEDC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7945620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCZKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50183 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgCZKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRC-00046d-Sr; Thu, 26 Mar 2020 11:08:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 728B41C0470;
        Thu, 26 Mar 2020 11:08:34 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Resize insn_hash
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.617882545@infradead.org>
References: <20200324160924.617882545@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731413.28353.1076192699779373606.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     513b5ca6b5fbeb766999fb1a4bc9a55c9fb7c9ca
Gitweb:        https://git.kernel.org/tip/513b5ca6b5fbeb766999fb1a4bc9a55c9fb7c9ca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 10:20:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:30 +01:00

objtool: Resize insn_hash

Perf shows we're spending a lot of time in find_insn() and the
statistics show we have around 3.2 million instruction. Increase the
hash table size to reduce the bucket load from around 50 to 3.

This shaves about 2s off of objtool on vmlinux.o runtime, down to 16s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.617882545@infradead.org
---
 tools/objtool/check.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca..f0ce8ff 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -50,7 +50,7 @@ struct instruction {
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
-	DECLARE_HASHTABLE(insn_hash, 16);
+	DECLARE_HASHTABLE(insn_hash, 20);
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
