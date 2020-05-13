Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8723CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD152206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbgEMMWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgEMMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:22:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A1C061A0C;
        Wed, 13 May 2020 05:22:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYqOm-00027y-1k; Wed, 13 May 2020 14:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9DD381C0244;
        Wed, 13 May 2020 14:22:07 +0200 (CEST)
Date:   Wed, 13 May 2020 12:22:07 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] READ_ONCE: Fix comment describing 2x32-bit atomicity
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512090101.2497-1-will@kernel.org>
References: <20200512090101.2497-1-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158937252745.390.15949021620332290976.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     ffed638b6a2180da8fd002a46632d746af72b299
Gitweb:        https://git.kernel.org/tip/ffed638b6a2180da8fd002a46632d746af72b299
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Tue, 12 May 2020 10:01:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 May 2020 14:17:09 +02:00

READ_ONCE: Fix comment describing 2x32-bit atomicity

READ_ONCE() permits 64-bit accesses on 32-bit architectures, since this
crops up in a few places and is generally harmless because either the
upper bits are always zero (e.g. for a virtual address or 32-bit time_t)
or the architecture provides 64-bit atomicity anyway.

Update the corresponding comment above compiletime_assert_rwonce_type(),
which incorrectly states that 32-bit x86 provides 64-bit atomicity, and
instead reference 32-bit Armv7 with LPAE.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200512090101.2497-1-will@kernel.org

---
 include/linux/compiler.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 741c93c..e24cc3a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -384,9 +384,9 @@ static inline void *offset_to_ptr(const int *off)
 
 /*
  * Yes, this permits 64-bit accesses on 32-bit architectures. These will
- * actually be atomic in many cases (namely x86), but for others we rely on
- * the access being split into 2x32-bit accesses for a 32-bit quantity (e.g.
- * a virtual address) and a strong prevailing wind.
+ * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
+ * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
+ * (e.g. a virtual address) and a strong prevailing wind.
  */
 #define compiletime_assert_rwonce_type(t)					\
 	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
