Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6143A208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696869;
	bh=G7h9MZ+i6JagDtlXn0bdeL8bVRjHxYgSZBzuuJdogDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1I94jS81fHPuOt2bXh4R37nDYz98XvODLJgi9ubtDFrbMzfhdc4IOxLkgUAuWLhcI
	 Zi4Vb3nHQCvWAORWIzpNsVrJ87JnumUrIFXHQveREIlaaPogqmlK0QrTUj7HUgWxf0
	 8xeCCw9hxPRmCUDkRPvJC+uisN9XCu8urPX0WTzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407023AbgE1UO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406973AbgE1UOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8845208FE;
        Thu, 28 May 2020 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696853;
        bh=G7h9MZ+i6JagDtlXn0bdeL8bVRjHxYgSZBzuuJdogDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSwBgZFoFGdLGx9ekYjcWIEa84fmRiuvhZhzBCVjetifhKaBY3bwAeIoQc+LQ4LSw
         xTvnUlAahN0BbS90bqGtpZU+gdIjtQVAEFXHTwQmY+A6/VkfiwiZw1mTGyFu8eqfFY
         rfl0w+XpRUZCOByt538PonaNkpJgtT+7/PLowR08=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 01/16] x86/ptrace: Prevent ptrace from clearing the FS/GS selector
Date:   Thu, 28 May 2020 16:13:47 -0400
Message-Id: <20200528201402.1708239-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When a ptracer writes a ptracee's FS/GSBASE with a different value, the
selector is also cleared. This behavior is not correct as the selector
should be preserved.

Update only the base value and leave the selector intact. To simplify the
code further remove the conditional checking for the same value as this
code is not performance critical.

The only recognizable downside of this change is when the selector is
already nonzero on write. The base will be reloaded according to the
selector. But the case is highly unexpected in real usages.

[ tglx: Massage changelog ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ptrace.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f0e1ddbc2fd7..cc56efb75d27 100644
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
2.25.1

