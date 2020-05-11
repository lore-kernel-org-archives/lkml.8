Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39773C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041AD2495A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172814;
	bh=u4mtq4oc2YFCohhLV9L1ke8AzlV9vHB9ppjZwfyugSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0tCrx49pCAsWiCOuv5l6TgVQd3OPxHK4ks/vnvqgXzxxQJRW/tC0cCAXsPDYGdQV
	 OS2R2eVV9WIYB+CcaJ/Ww4xWzu5tOrOHN/Gt/UpLLVq1HFcRLh63p1WcYhiR9eT+EI
	 1OmrpByB/6HpMUFrMCYClYDulMw6oNKXE9LJ6TCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEKExc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKExb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED2F24955;
        Mon, 11 May 2020 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172811;
        bh=u4mtq4oc2YFCohhLV9L1ke8AzlV9vHB9ppjZwfyugSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4iHGzcnuki8Fmmq8eCPl//ClO9NAzyOcOXMqzDMPj9xVAhMCNWn43Eq1jSgmFK9U
         uFbSuNOZTH/IC6TQ2jBIk81hoFP9s2jE3n++IhdOgdDHvje5HzjC5/zqllVkDzw5+e
         2Y2rfihbOmqnnCBPXIRod1vQMUbFUty39tR8XNP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 03/18] x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Date:   Mon, 11 May 2020 00:52:56 -0400
Message-Id: <20200511045311.4785-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/x86/kernel/cpu/common.c                  | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdfe..af3aaade195b8 100644
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
index bed0cb83fe245..4224760c74e27 100644
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
2.20.1

