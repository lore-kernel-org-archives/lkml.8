Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172BAC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E763720820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172871;
	bh=NWCdWvrnftahbOeAAAbo3rET17oclfuJbv2R+igmKSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZgJ1l/K2wo9QzVTT0Vfpi0R70xN03tpfpiPlubxRPJzUjZ5n4pl/8Dl9gvPOzntdD
	 uXQGLSt6he/CkMmSMDsbdn8vl2Aa6AbTY4iiOcfWnsCchcmD1VUCZNZihSI8vX2tYY
	 IUHlT3xY8AfYg0IZQTmz1uQjYxqFSN5MrtRQtzlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgEKExa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgEKEx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5942184D;
        Mon, 11 May 2020 04:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172808;
        bh=NWCdWvrnftahbOeAAAbo3rET17oclfuJbv2R+igmKSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jSHPIIZm4bPQsKV4zhO2mMN7Tzl07Tv6CdlDC0ZsVIDZoa+GqVcB6XDuDI8SI9cO
         A7YlQ8Igz2pqCmOnaUasI7628HcM9OYsWS1dBcvCnucESOk3RmMII3UB5Czlh+bkYn
         Jb0uezZNoLxhwuP6iCq49s07pbRCPYUw6L6lXFpg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 01/18] x86/ptrace: Prevent ptrace from clearing the FS/GS selector
Date:   Mon, 11 May 2020 00:52:54 -0400
Message-Id: <20200511045311.4785-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When a ptracer writes a ptracee's FS/GS base with a different value, the
selector is also cleared. While this behavior is incorrect as the selector
should be preserved, most userspace applications did not notice that as
they do not use non-zero segments to begin with.

Instead, with this patch, when a tracee sets the base we will let it do
so without clearing the selector.

The change above means that a tracee that already has a selector set
will fail in an attempt to set the base - the change won't stick and the
value will be instead based on the value of the selector. As with the
above, we haven't found userspace that would be affected by this change.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
[sasha: rewrite commit message]
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
 arch/x86/kernel/ptrace.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f0e1ddbc2fd78..cc56efb75d275 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -380,25 +380,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 *
-		 * NB: This behavior is nonsensical and likely needs to
-		 * change when FSGSBASE support is added.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
-- 
2.20.1

