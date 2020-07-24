Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDFC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386072068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3UAmU16N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9eQQ+Xa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGXH46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:56:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449AC0619D3;
        Fri, 24 Jul 2020 00:56:56 -0700 (PDT)
Date:   Fri, 24 Jul 2020 07:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595577414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfvrFr9qUx7uwrDcr0kApQeMT+pgLIbj6yxk0k+1+xU=;
        b=3UAmU16NiuG+9JTZdWfGQdnJEIRZJY6yx1IQRHAMgpYxE/fCuqFT4ip8clRXNQ6xns44MH
        NzOATn7P000vGTmOXCUMdrOoYVVsVjyFtF5SpOSuUpqZ06eLCtqYvmdoCwof5UwmdfU7ht
        nD8mGo/Jw718p5xC4wwOvyQtvn/zvCqGAx4VNCcQuaHyVEX4M8iXaEn7z0w1Rxm56ZJH9j
        MYHrFFkTMyqDM0appErPu4gO6cfYOJrEwUk0BYfDJR0oSBB+qpMvY5W3olLKPmyHkzx6JI
        nTFuUpk3mzSnf9tKchP9R+6/GqCr35f4hqrKRKZ0RZH95J5iTA5R505crDwwOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595577414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfvrFr9qUx7uwrDcr0kApQeMT+pgLIbj6yxk0k+1+xU=;
        b=9eQQ+Xa1Q+ocmJ9J9nKcQri4jLyLNl2t4gHKkV3vvJfd7OJItuC14xUEZiPVWWUE+YZ9wH
        McgFy6wJ0YooIjDQ==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Correct noinstr qualifiers
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723161405.852613-1-ira.weiny@intel.com>
References: <20200723161405.852613-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <159557741400.4006.18075760142886374050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     7f6fa101dfac8739764e47751d314551f6160c98
Gitweb:        https://git.kernel.org/tip/7f6fa101dfac8739764e47751d314551f6160c98
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Thu, 23 Jul 2020 09:14:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 09:54:15 +02:00

x86: Correct noinstr qualifiers

The noinstr qualifier is to be specified before the return type in the
same way inline is used.

These 2 cases were missed by previous patches.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200723161405.852613-1-ira.weiny@intel.com

---
 arch/x86/kernel/alternative.c  | 2 +-
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff..069e77c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1044,7 +1044,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-int noinstr poke_int3_handler(struct pt_regs *regs)
+noinstr int poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 14e4b4d..6d7aa56 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1212,7 +1212,7 @@ static void kill_me_maybe(struct callback_head *cb)
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void noinstr do_machine_check(struct pt_regs *regs)
+noinstr void do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
