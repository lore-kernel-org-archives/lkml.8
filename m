Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B0320866
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974375;
	bh=gX242I+Ys66LLIFI8NFdVo8uWb+C82vQGDzHe3iSuT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cvHrDMumGWHy34oMwRVj5O1e0Q9d/ENQJG6A+EI0QS1IH9AD6do0H8/D8yLPBjQ68
	 O1tikp55ImP/gsZZbNN0gRHk/Ha6uaUrhBuSjQn7w67yAL5SoIvCpVmXwW8eztKZgt
	 gFbjF/AQYIbfls2vYFIF8O5lNO/idSMMM4GRogBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgIAPcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgIAPcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FD6205F4;
        Tue,  1 Sep 2020 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974364;
        bh=gX242I+Ys66LLIFI8NFdVo8uWb+C82vQGDzHe3iSuT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqMHyW/2uwk7GEP2ZtHM1TNmX/iP6znQ2MTVXOGk1JdAkHqe9XZ8zn/mv6zvSB5Mg
         2sYdRzYyAz79JO7WUYMUaJEuolvkHYMkdofk/0ZRTMhoHnyknPathcoSaiIeUB9yPs
         qPbS3LjfOeti1e/VRFr0AlhL7+tIDSNpFshparVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 147/214] arm64: Move handling of erratum 1418040 into C code
Date:   Tue,  1 Sep 2020 17:10:27 +0200
Message-Id: <20200901151000.021484773@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit d49f7d7376d0c0daf8680984a37bd07581ac7d38 ]

Instead of dealing with erratum 1418040 on each entry and exit,
let's move the handling to __switch_to() instead, which has
several advantages:

- It can be applied when it matters (switching between 32 and 64
  bit tasks).
- It is written in C (yay!)
- It can rely on static keys rather than alternatives

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200731173824.107480-2-maz@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/process.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fab013c5ee8c9..10190c4b16dc4 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -498,6 +498,39 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+/*
+ * ARM erratum 1418040 handling, affecting the 32bit view of CNTVCT.
+ * Assuming the virtual counter is enabled at the beginning of times:
+ *
+ * - disable access when switching from a 64bit task to a 32bit task
+ * - enable access when switching from a 32bit task to a 64bit task
+ */
+static void erratum_1418040_thread_switch(struct task_struct *prev,
+					  struct task_struct *next)
+{
+	bool prev32, next32;
+	u64 val;
+
+	if (!(IS_ENABLED(CONFIG_ARM64_ERRATUM_1418040) &&
+	      cpus_have_const_cap(ARM64_WORKAROUND_1418040)))
+		return;
+
+	prev32 = is_compat_thread(task_thread_info(prev));
+	next32 = is_compat_thread(task_thread_info(next));
+
+	if (prev32 == next32)
+		return;
+
+	val = read_sysreg(cntkctl_el1);
+
+	if (!next32)
+		val |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+	else
+		val &= ~ARCH_TIMER_USR_VCT_ACCESS_EN;
+
+	write_sysreg(val, cntkctl_el1);
+}
+
 /*
  * Thread switching.
  */
@@ -514,6 +547,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ptrauth_thread_switch(next);
 	ssbs_thread_switch(next);
+	erratum_1418040_thread_switch(prev, next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
-- 
2.25.1



