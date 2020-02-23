Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A0C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499120659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424902;
	bh=w7dB8T6smZtpdozM3mayPW1yOSMdu7lo1XVeSa7u92U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KkQNCyyfmgHj1mYTIC2ys79y5L1py1jjDibcXfB/LFYvDILGW0W6orSa3HaLcaMtn
	 pqdYAck8s+PLeevU5uxwu3G6ZImjfL8PiMWM9pBbN/YJD+O1+ud1ELe2e6Z4OFSEa6
	 ferhvJZMCq9hXfVL00sl+1PHcGJ1S8jqz4XC1JYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgBWC2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgBWCYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F97324650;
        Sun, 23 Feb 2020 02:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424662;
        bh=w7dB8T6smZtpdozM3mayPW1yOSMdu7lo1XVeSa7u92U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vu1UD82TUvtPYpuZciAx7LPR2IX8KNOHceBHoeDhaMGEZOzZtph3QM+Ui7tafts4z
         qlCqA/micijWOJno0fQj8+HDdm+hQbYjIg5OHRrxZSI5mgWZn0yNZmDLWs/XagW+5h
         y2jjQneqYIDa3XcCj6Nqttgw+PmRS+N04P1LWHSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 08/21] arm/ftrace: Fix BE text poking
Date:   Sat, 22 Feb 2020 21:23:58 -0500
Message-Id: <20200223022411.2159-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022411.2159-1-sashal@kernel.org>
References: <20200223022411.2159-1-sashal@kernel.org>
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
index 5617932a83dfa..26b7321bb2152 100644
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

