Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32352073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865846;
	bh=EGvrvG1audPsW1wwbscXqzjxXvxqTczeFC0n97JcnzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kF2Y8kk8y7rBOo39gmml+lskvzl3cw94+eZnXZoAtVY86YEhW2Aa/PkZDhxcfC9Lr
	 VCSbTVZLfxO10498LQEGKaReeitwuVOZDNQuo/izp4WF13Car5dg3zjaFvFITW5HcM
	 v9DGassnW0Rl7aTkgGCvbYPNDtTg6eV2xA6tkES4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgFVWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbgFVWnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2725520842;
        Mon, 22 Jun 2020 22:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865794;
        bh=EGvrvG1audPsW1wwbscXqzjxXvxqTczeFC0n97JcnzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxdJAbiddXcSDedCMCLRHxX0xCISKNqyNARUNDcGyUrSrL3XLH2Ion42MbQlKeE2F
         oGfdX5REKjHsKudi1U8NzzXQ+ncfPM0One0TtneJNg3aNLX8yge7MF+AKEoyFhoKVS
         gICm5Gt5eX71/dyHTf6mCdZG4hFvEpGuTDrUtwuM=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 09/14] tools/lib/lockdep: New stacktrace API
Date:   Mon, 22 Jun 2020 18:42:53 -0400
Message-Id: <20200622224258.1208588-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel switched to using kernel/stacktrace.c, and the API slightly
changed.

Adjust it to make stack traces work again.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/stacktrace.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/linux/stacktrace.h b/tools/include/linux/stacktrace.h
index ae343ac35bfa7..b290b98d883aa 100644
--- a/tools/include/linux/stacktrace.h
+++ b/tools/include/linux/stacktrace.h
@@ -15,10 +15,18 @@ static inline void print_stack_trace(struct stack_trace *trace, int spaces)
 	backtrace_symbols_fd((void **)trace->entries, trace->nr_entries, 1);
 }
 
+static inline void stack_trace_print(const long unsigned int *entries, unsigned int nr, int spaces)
+{
+	backtrace_symbols_fd((void **)entries, nr, 1);
+}
+
 #define save_stack_trace(trace)	\
 	((trace)->nr_entries =	\
 		backtrace((void **)(trace)->entries, (trace)->max_entries))
 
+#define stack_trace_save(e, m, x) \
+	backtrace((void **)(e), (m))
+
 static inline int dump_stack(void)
 {
 	void *array[64];
-- 
2.25.1

