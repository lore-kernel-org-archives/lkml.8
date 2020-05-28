Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062D6208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590697005;
	bh=qn510wgUCURz8e5nXmTkZDJ1jP1E7gkThyqKFt10Ac0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hnrwe7nxUUKCLqHp22PIdWENrxvBtiIY5J6wWubtx0KVpTLB8D9yuHU+rZb/wYVEx
	 xfaXpaSJuRf3d0/OwYEu6DxjA6kMj5XXJaxhDzee90JyeZbWS+I9vpfHyvXDlEzl4j
	 cm+GO79tmUYuP0GAmQqRNDK/r2f2FSd4w78kdqd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407223AbgE1UQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406998AbgE1UOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37E02145D;
        Thu, 28 May 2020 20:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696855;
        bh=qn510wgUCURz8e5nXmTkZDJ1jP1E7gkThyqKFt10Ac0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odS2hHpLsQKsBqaTLmFgt88Bl6lo67HxWKF+WpQrQpckOM6c4cUlR6hC3GqTAVPu4
         Da+msFzakb3SqybAz1TKbnlILwQ2lWRsnoDFgnglCWixfFAAxJ2rdn70Z8ixmhGKXl
         y7sGCFKRBAAx8Dij4zsfAPBSN4WZsD3kL+GZ3AsY=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 02/16] x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Date:   Thu, 28 May 2020 16:13:48 -0400
Message-Id: <20200528201402.1708239-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This is temporary.  It will allow the next few patches to be tested
incrementally.

Setting unsafe_fsgsbase is a root hole.  Don't do it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-4-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/x86/kernel/cpu/common.c                  | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..af3aaade195b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3033,6 +3033,9 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
+	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
+			replaced with a nofsgsbase flag.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe24..4224760c74e2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -418,6 +418,22 @@ static void __init setup_cr_pinning(void)
 	static_key_enable(&cr_pinning.key);
 }
 
+/*
+ * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
+ * updated. This allows us to get the kernel ready incrementally.
+ *
+ * Once all the pieces are in place, these will go away and be replaced with
+ * a nofsgsbase chicken flag.
+ */
+static bool unsafe_fsgsbase;
+
+static __init int setup_unsafe_fsgsbase(char *arg)
+{
+	unsafe_fsgsbase = true;
+	return 1;
+}
+__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1478,6 +1494,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Enable FSGSBASE instructions if available. */
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+		if (unsafe_fsgsbase)
+			cr4_set_bits(X86_CR4_FSGSBASE);
+		else
+			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
+	}
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
-- 
2.25.1

