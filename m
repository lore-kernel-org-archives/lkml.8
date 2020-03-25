Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD56920714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCYLs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:48:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCYLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:48:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4Wi-0000VB-KG; Wed, 25 Mar 2020 12:48:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2C2A81C0450;
        Wed, 25 Mar 2020 12:48:52 +0100 (CET)
Date:   Wed, 25 Mar 2020 11:48:51 -0000
From:   "tip-bot2 for Qiujun Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/alternatives: Mark text_poke_loc_init() static
Cc:     Qiujun Huang <hqjagain@gmail.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583253732-18988-1-git-send-email-hqjagain@gmail.com>
References: <1583253732-18988-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Message-ID: <158513693176.28353.3974017486615811388.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     244febbee876203d8505dfadcc6edb82a0e061b8
Gitweb:        https://git.kernel.org/tip/244febbee876203d8505dfadcc6edb82a0e061b8
Author:        Qiujun Huang <hqjagain@gmail.com>
AuthorDate:    Wed, 04 Mar 2020 00:42:12 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 25 Mar 2020 12:42:35 +01:00

x86/alternatives: Mark text_poke_loc_init() static

The function is only used in this file so make it static.

 [ bp: Massage. ]

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1583253732-18988-1-git-send-email-hqjagain@gmail.com
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 15ac0d5..7867dfb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1167,8 +1167,8 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		atomic_cond_read_acquire(&desc.refs, !VAL);
 }
 
-void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-			const void *opcode, size_t len, const void *emulate)
+static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
 
