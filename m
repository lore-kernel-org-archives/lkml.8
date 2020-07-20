Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5985AC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342782064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260068;
	bh=D0s5K5XkZQ3HTKVMriUyqRs9sunLfFDxsdtHzAGadxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7PuvmqiTIsjKjEU9LPP1gAoGHAIAdVxEM3vVmOtsjet3EsCK56tkm8/YAfF8gvF6
	 CXZKJG7U40xSdBTixUDuIEgZhPhnCMDY1sK0Z9mekTQI3FpxCu70+0ykVZtWrj18O1
	 fD4pKD6hHn/ZV469nLVkCcpkw8O7b+RBdDD4WSK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgGTPrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbgGTPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:47:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6D8206E9;
        Mon, 20 Jul 2020 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260058;
        bh=D0s5K5XkZQ3HTKVMriUyqRs9sunLfFDxsdtHzAGadxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzpkjFsnnRqwpb/thKLMPhi+meTaFp+5uEEIf1LiunE8Js8B5gY4AN7xDcP6wPHiX
         SLsGXN2APCCZ5WNlIbuYj/hb99rLfKy1JYVc4cFNjsA/3COF8AqiN/ud8tNVJsRv5v
         V4oPWltPTH+gK102bN+vDOgBcZiCnw95eJEH073A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 061/125] arm64/alternatives: dont patch up internal branches
Date:   Mon, 20 Jul 2020 17:36:40 +0200
Message-Id: <20200720152805.979692891@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 5679b28142193a62f6af93249c0477be9f0c669b ]

Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
sequences") moved the alternatives replacement sequences into subsections,
in order to keep the as close as possible to the code that they replace.

Unfortunately, this broke the logic in branch_insn_requires_update,
which assumed that any branch into kernel executable code was a branch
that required updating, which is no longer the case now that the code
sequences that are patched in are in the same section as the patch site
itself.

So the only way to discriminate branches that require updating and ones
that don't is to check whether the branch targets the replacement sequence
itself, and so we can drop the call to kernel_text_address() entirely.

Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/r/20200709125953.30918-1-ardb@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/alternative.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index b9045d8d05d88..4c385763c361f 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -44,20 +44,8 @@ struct alt_region {
  */
 static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
 {
-	unsigned long replptr;
-
-	if (kernel_text_address(pc))
-		return true;
-
-	replptr = (unsigned long)ALT_REPL_PTR(alt);
-	if (pc >= replptr && pc <= (replptr + alt->alt_len))
-		return false;
-
-	/*
-	 * Branching into *another* alternate sequence is doomed, and
-	 * we're not even trying to fix it up.
-	 */
-	BUG();
+	unsigned long replptr = (unsigned long)ALT_REPL_PTR(alt);
+	return !(pc >= replptr && pc <= (replptr + alt->alt_len));
 }
 
 #define align_down(x, a)	((unsigned long)(x) & ~(((unsigned long)(a)) - 1))
-- 
2.25.1



