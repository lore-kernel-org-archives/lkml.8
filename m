Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F91C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC0A2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="MqmwwGLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgG1SI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgG1SI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:08:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05220C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:08:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so12385105pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/9beP98f98Vf1zxiKQSOkO8IXWG5BYB+nIvxcLtCTU=;
        b=MqmwwGLKgjBAB1MvvthLY8ID+OloHNBejgeU6MMoJezNO42uXn3uZCYB1cN1v2egf0
         gcnexjKCOv6L1HwkKoFojdwikyJDk/A+bWF/vAgzjBCJO4jbSUBCMvD5e6U8HmrcQjSI
         pjgCNgmCmOS/3RS2TLVwDHr/Qp2FzXL23YCYZae3vOsDtCjLsExAyVaE/g19SkahSExe
         pGSBud28VXtHmkZQBQUm+5L7biZF2p9HezxIEGrbPJ7F0AVLHy+tVve9hXexAvI9Gbi0
         vo41QNWCXEl8+rRyFL8xOC1hWUHkzw32wez11r4JGgz/DQJbH/R9sob4HFBKTjoo3aX4
         G5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/9beP98f98Vf1zxiKQSOkO8IXWG5BYB+nIvxcLtCTU=;
        b=JQOqoArfCLyRLPHQTKJd6x6kIzrjk4M+ef68qqE59DCFMrsavXll36BDEUuX03tbva
         LyLvsRmejJbXB+Bdu6sVXCZjGg94bzDTHEarTBjuzECX6BRUHYx6ku4YS/rJCAwjGxhG
         6yJaS0QVeiibnpijXiJ+9ygyyxCqUzyofXfFpOu9BEmH/siPsIhCCfq5r/2n13/nPlYG
         oBAr49K1DBu5ws24Jz1fi0PsjNsWYyg7RRHIqbdaHmTxha4f0OgV3GeLvwfiB/A/D+wc
         kK1CSynbuRFDOdzTtJvwcJisUBx2tbPpAU2/38dpGEz3oW8NCzyEV4aSL5bXrExgOKAW
         1Cfg==
X-Gm-Message-State: AOAM530ULV5l+M1fJhjicZOxf/ga7HlTUd9ZJsmG2yQicMEg8B1nV6ED
        dXZry0P3aNCSk+EY4KH16JBszBvyBr5PQKrg
X-Google-Smtp-Source: ABdhPJzU6O+QFw+Lofj9skIB8yD44AlqL1FAgPp36utq6qkUjLqLKInjfqnO91j7BH3OIABWGQEIwg==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr7794558pfr.114.1595959706541;
        Tue, 28 Jul 2020 11:08:26 -0700 (PDT)
Received: from C02CV1DAMD6P.sso.bytedance.com ([103.136.221.69])
        by smtp.gmail.com with ESMTPSA id n2sm19539822pfq.140.2020.07.28.11.08.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:08:26 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com, songmuchun@bytedance.com
Subject: [PATCH 1/2] ftrace: setup correct FTRACE_FL_REGS flags for module
Date:   Wed, 29 Jul 2020 02:05:53 +0800
Message-Id: <20200728180554.65203-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When module loaded and enabled, we will use __ftrace_replace_code
for module if any ftrace_ops referenced it found. But we will get
wrong ftrace_addr for module rec in ftrace_get_addr_new, because
rec->flags has not been setup correctly. It can cause the callback
function of a ftrace_ops has FTRACE_OPS_FL_SAVE_REGS to be called
with pt_regs set to NULL.
So setup correct FTRACE_FL_REGS flags for rec when we call
referenced_filters to find ftrace_ops references it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/trace/ftrace.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fca01a168ae5..a3d141f53c9e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6190,8 +6190,11 @@ static int referenced_filters(struct dyn_ftrace *rec)
 	int cnt = 0;
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-		if (ops_references_rec(ops, rec))
-		    cnt++;
+		if (ops_references_rec(ops, rec)) {
+			cnt++;
+			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
+				rec->flags |= FTRACE_FL_REGS;
+		}
 	}
 
 	return cnt;
@@ -6372,8 +6375,8 @@ void ftrace_module_enable(struct module *mod)
 		if (ftrace_start_up)
 			cnt += referenced_filters(rec);
 
-		/* This clears FTRACE_FL_DISABLED */
-		rec->flags = cnt;
+		rec->flags &= ~FTRACE_FL_DISABLED;
+		rec->flags += cnt;
 
 		if (ftrace_start_up && cnt) {
 			int failed = __ftrace_replace_code(rec, 1);
-- 
2.20.1

