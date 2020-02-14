Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B62C3B1AB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3C24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701038;
	bh=4TMk3oPXzDqusW1Vw1/tbsbx3c4Xl54P2d6RaQrX17s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5es0NBNjFtWh7y2HniMWzbpwurGJg4Q3sYEWh/cD9dmYXoZiU4i5+T1j6H1+tUD0
	 LhP4ZHkGYq5EiFQwIK1DDFbZ+fMn2XQjFUfNQt2duJPF4fA8FeNF4gz3hw9OFg0WVb
	 ldYoGd6RVcSsIolm0pqMLUSq+djrYFSff+3B8+6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbgBNQJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391223AbgBNQJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE96D2468C;
        Fri, 14 Feb 2020 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696550;
        bh=4TMk3oPXzDqusW1Vw1/tbsbx3c4Xl54P2d6RaQrX17s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TH7yPdhZdL2dgt9AVFya0MTwiq/ctnmrdym3MwlVr9oy/KVZyrElnvxJ/O5A19eC
         v8z76M0NHpfBGlfsf+P6R2rMcLCtxf1UTGrjBTB3nF8kONxPnUgD7GzL2uP34n+vHB
         hKJol7vmFvYJ8kPfBaiemtSgMdjVouP0EXqhWNMU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Guanglei <guanglei.li@unisoc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 343/459] sched/core: Fix size of rq::uclamp initialization
Date:   Fri, 14 Feb 2020 10:59:53 -0500
Message-Id: <20200214160149.11681-343-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Guanglei <guanglei.li@unisoc.com>

[ Upstream commit dcd6dffb0a75741471297724640733fa4e958d72 ]

rq::uclamp is an array of struct uclamp_rq, make sure we clear the
whole thing.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/1577259844-12677-1-git-send-email-guangleix.li@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00743684a549a..9540b7e076e64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1252,7 +1252,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
-- 
2.20.1

