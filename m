Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C39206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586279;
	bh=EGvrvG1audPsW1wwbscXqzjxXvxqTczeFC0n97JcnzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RdwAqQOsTIaE3QwCTsTdOS2+lnB5tRayjy0rIgc+0vW7GkA41jzf5osma7ZQTvAxn
	 aUolebDnaX3qZ0RL4NbrcCzRD2Ptfbv/ooV04SR3HCq2uz62wwvY6/dnThpoGHp2ro
	 YINHHCJPFRrhcs9pf/3lv3CusheQqInzK/+2ON5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgHEALS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgHEAKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637F922CA0;
        Wed,  5 Aug 2020 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586254;
        bh=EGvrvG1audPsW1wwbscXqzjxXvxqTczeFC0n97JcnzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpPzzdDzqXzr7ScrCVOK18oGdlakOMtT9ikxzhQ03oL+Nkf76tx9O40p0R9+XgVlR
         QGwllzFaaj20Ocixt8NFJR9McPHOJ2UMA4NEf0ujmpWAM2IjUAkMIyB8IVAVKpdTeq
         XhhY9DQDvH3RTrSTjUQLJnkickIEN11jawGPpnME=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 09/14] tools/lib/lockdep: New stacktrace API
Date:   Tue,  4 Aug 2020 20:10:38 -0400
Message-Id: <20200805001043.3331907-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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

