Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2DE20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SyjR3aW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/2YWXu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgIDPW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgIDPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5BC061244;
        Fri,  4 Sep 2020 08:21:59 -0700 (PDT)
Date:   Fri, 04 Sep 2020 15:21:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599232915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaX8mwKBi/XAJYbEflwlLJF4Sx6k1YhDQbEOGqO2B2U=;
        b=SyjR3aW8eL3UhKO08YYBRO1cqRRerjvSHPkcjV2QX7aKIVDo3hTaTc2xQSdudd8Q4guAqT
        ChlgJGqzGeA1qaVLz+l4uHm0gLkaHg7iXw32xtKQ1HjSWXlwbXdVvqZKcYyiP7l8FvDJh9
        oGIxsnPotxXLn5dZW3K0ZrA+veAScWGyrQFyXAMnJmlwtPKigD9X7mo/euOmBuRMJDzOlJ
        H4VyUnkcnwVwO3JKXJVWDHfz97px+91bdRZ9beEX0O2AZ5ZFdzuZeVmZxAKtHXxqn9mXn4
        WltVkuzEGq0F7CJWbU5U18UVMG3pI2BDX9CrtjETLvj/J1299itr1otZaCgJNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599232915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaX8mwKBi/XAJYbEflwlLJF4Sx6k1YhDQbEOGqO2B2U=;
        b=N/2YWXu3cC8cyAeel8JYKDuSEuIML+9C15GQPYaJa8gZQaLAWwIH3oU8vO8fqIpMNWGpAe
        01pb02D81fIUmzDw==
From:   "tip-bot2 for Akshay Gupta" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Increase maximum number of banks to 64
Cc:     Akshay Gupta <Akshay.Gupta@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200828192412.320052-1-Yazen.Ghannam@amd.com>
References: <20200828192412.320052-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <159923291431.20229.1749748339999502192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a0bc32b3cacf194dc479b342f006203fd1e1941a
Gitweb:        https://git.kernel.org/tip/a0bc32b3cacf194dc479b342f006203fd1e1941a
Author:        Akshay Gupta <Akshay.Gupta@amd.com>
AuthorDate:    Fri, 28 Aug 2020 19:24:12 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Sep 2020 17:17:27 +02:00

x86/mce: Increase maximum number of banks to 64

...because future AMD systems will support up to 64 MCA banks per CPU.

MAX_NR_BANKS is used to allocate a number of data structures, and it is
used as a ceiling for values read from MCG_CAP[Count]. Therefore, this
change will have no functional effect on existing systems with 32 or
fewer MCA banks per CPU.

However, this will increase the size of the following structures:

Global bitmaps:
- core.c / mce_banks_ce_disabled
- core.c / all_banks
- core.c / valid_banks
- core.c / toclear
- Total: 32 new bits * 4 bitmaps = 16 new bytes

Per-CPU bitmaps:
- core.c / mce_poll_banks
- intel.c / mce_banks_owned
- Total: 32 new bits * 2 bitmaps = 8 new bytes

The bitmaps are arrays of longs. So this change will only affect 32-bit
execution, since there will be one additional long used. There will be
no additional memory use on 64-bit execution, because the size of long
is 64 bits.

Global structs:
- amd.c / struct smca_bank smca_banks[]: 16 bytes per bank
- core.c / struct mce_bank_dev mce_bank_devs[]: 56 bytes per bank
- Total: 32 new banks * (16 + 56) bytes = 2304 new bytes

Per-CPU structs:
- core.c / struct mce_bank mce_banks_array[]: 16 bytes per bank
- Total: 32 new banks * 16 bytes = 512 new bytes

32-bit
Total global size increase: 2320 bytes
Total per-CPU size increase: 520 bytes

64-bit
Total global size increase: 2304 bytes
Total per-CPU size increase: 512 bytes

This additional memory should still fit within the existing .data
section of the kernel binary. However, in the case where it doesn't
fit, an additional page (4kB) of memory will be added to the binary to
accommodate the extra data which will be the maximum size increase of
vmlinux.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
[ Adjust commit message and code comment. ]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200828192412.320052-1-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6adced6..109af5c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -200,12 +200,8 @@ void mce_setup(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
-/*
- * Maximum banks number.
- * This is the limit of the current register layout on
- * Intel CPUs.
- */
-#define MAX_NR_BANKS 32
+/* Maximum number of MCA banks per CPU. */
+#define MAX_NR_BANKS 64
 
 #ifdef CONFIG_X86_MCE_INTEL
 void mce_intel_feature_init(struct cpuinfo_x86 *c);
