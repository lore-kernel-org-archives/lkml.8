Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0299C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDED2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PMjmKdLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHTJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHTJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:18:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D4C061383
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:18:07 -0700 (PDT)
Received: from zn.tnic (p2e584b51.dip0.t-ipconnect.de [46.88.75.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE5871EC036E;
        Thu, 20 Aug 2020 11:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597915082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=zWu7GXpPGp9gtFU0JqALmskyRmOOBg9d4rIoS5+QQz0=;
        b=PMjmKdLLoJIYTUWVoC8IfC8pHY8rPbaa0JFiP4q3sg/CxarXXaI6426vX+rym4M+zCJ31a
        Jp+WRhNz5W6oKZ/cdAXXMVtG5nSzaZmXIa2YnwyvTcCEx08nKSPceomLnNrXLespNtXr5O
        QCx3TIZVBvrHcTpBs9otRa9oWByS42M=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/entry/64: Add an LFENCE after SAVE_AND_SET_GSBASE
Date:   Thu, 20 Aug 2020 11:15:44 +0200
Message-Id: <20200820091544.26564-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The FSGSBASE macro to swap current GSBASE with the kernel GSBASE
probably had a speculation-stopping MSR write at some point but not
anymore.

Therefore, a fence is needed to stop speculation. Add it.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
---
 arch/x86/entry/entry_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 26fc9b42fadc..3931d47cdd83 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -839,11 +839,9 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * Read the current GSBASE and store it in %rbx unconditionally,
 	 * retrieve and set the current CPUs kernel GSBASE. The stored value
 	 * has to be restored in paranoid_exit unconditionally.
-	 *
-	 * The MSR write ensures that no subsequent load is based on a
-	 * mispredicted GSBASE. No extra FENCE required.
 	 */
 	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	FENCE_SWAPGS_KERNEL_ENTRY
 	ret
 
 .Lparanoid_entry_checkgs:
-- 
2.21.0

