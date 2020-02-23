Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3534C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A020707
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425008;
	bh=LkB/ld1v7E5olWXI7Cv6NehVA818PbkX17uUoHk2kUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tf9JnfDcGHZZMREvnREahmJRIVXnRFaYBkYALPrELNhAd7hdabnmHyGO0FF55CkXR
	 GrSQZ2siyNfMNL6mrYsGjk+9LG/32eQ9c0J2sTLrrSE/7KPUJM6gh0FY1ER1BE7JGq
	 o8f7NoljpakjLIKkRD1Sj/9jhLfqPKc7aPy8Hi7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBWCaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgBWCXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0627208C4;
        Sun, 23 Feb 2020 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424632;
        bh=LkB/ld1v7E5olWXI7Cv6NehVA818PbkX17uUoHk2kUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jxotl4JexpuDxvKIOzSu5Zqrj/tGj/s209DDSks+GnFjdGzRhTp8qy4FlW258sCOH
         218jsf9vVeziiZXl/DBTVDHl3CIdllIfJz1UgsM45kXDM05XBXbkQkmCubYPHcga5u
         AWbg2j1GAmCSJJA5makf6UirvNoDCUr5ljTk82ow=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 10/25] arm/ftrace: Fix BE text poking
Date:   Sat, 22 Feb 2020 21:23:24 -0500
Message-Id: <20200223022339.1885-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022339.1885-1-sashal@kernel.org>
References: <20200223022339.1885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit be993e44badc448add6a18d6f12b20615692c4c3 ]

The __patch_text() function already applies __opcode_to_mem_*(), so
when __opcode_to_mem_*() is not the identity (BE*), it is applied
twice, wrecking the instruction.

Fixes: 42e51f187f86 ("arm/ftrace: Use __patch_text()")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/ftrace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index ee673c09aa6c0..dd0215fb6fe23 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -106,13 +106,10 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
 		old = __opcode_to_mem_thumb32(old);
-		new = __opcode_to_mem_thumb32(new);
-	} else {
+	else
 		old = __opcode_to_mem_arm(old);
-		new = __opcode_to_mem_arm(new);
-	}
 
 	if (validate) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
-- 
2.20.1

