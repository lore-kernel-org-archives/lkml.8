Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793FDC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F9320780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684204;
	bh=McSR8byyd5pn7qxZsE2sBlU9Wb5OJcdDZ1fu4w2Wa9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qNznFRASTgoHYCz5h5tWoB+6Bca2YxR+fi8UGZb6Wlxsas4ntWl7z3tYCG62gqVhV
	 s7bFnc0UTLrp3k9vUxWI/H0CioiP4LlUi3LQWOo85ssQM9ZgCvBPBVPJ+mYqQj4mAi
	 y4TFcP391cyt2ZUeAB3mdZnGw59dfDF1ADexIV7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgDWXXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgDWXWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB7A214AF;
        Thu, 23 Apr 2020 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684132;
        bh=McSR8byyd5pn7qxZsE2sBlU9Wb5OJcdDZ1fu4w2Wa9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffNYf0NkcWlw++M4pDh2+T9403+bIikkQJb/VHg8hJzE1LJ9avnRABtX9Yg0mnxIT
         jiUUMVyu5zAp9ur3sbWmW/4G0VHVCVeSobCw/Lp0OAo1GbTzVrFWlOIejSKWWm/g1m
         hZ+2x5PWSfdMwP8yV28P92qMtjtu0djHOQXqw6gY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 01/18] x86/ptrace: Prevent ptrace from clearing the FS/GS selector
Date:   Thu, 23 Apr 2020 19:21:50 -0400
Message-Id: <20200423232207.5797-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When a ptracer writes a ptracee's FS/GS base with a different value, the
selector is also cleared. This behavior is not correct as the selector
should be preserved.

Update only the base value and leave the selector intact. To simplify the
code further remove the conditional checking for the same value as this
code is not performance-critical.

The only recognizable downside of this change is when the selector is
already nonzero on write. The base will be reloaded according to the
selector. But the case is highly unexpected in real usages.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

