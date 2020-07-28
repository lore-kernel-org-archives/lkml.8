Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55604C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D26920775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="hXo36FY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgG1K13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgG1K12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:27:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:27:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so11595649pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptY5CYjhtdiN1Qyeal1rNQp99XEh/bxjKsw8g/EiuFk=;
        b=hXo36FY8OHhk7w4BZs7QeMw1RtDPzeYElG+hls6FySy7ocUd1oxzES5AVWPXE1tpdW
         RZ072F4nXb9GR9UxqAcf3CCfV5IkB9IIOqydmNkB0HGK6s+QzwHn/9URghVZdfcuiQ/R
         5oMY1I4C2PMOTwHlXwUgUw2xTwSlHFJ+OdbCzV+KUfQ9jGxGasBnbECPVsbStEaA83jI
         ytOvvO46XUzbBrv+pFE09gFc6PaKYHuEOmiJ/JekpurW7gTzsHyDq7pUFj79Cc+lBXXC
         Ixr58iXfCcyR9p3YHLZLoECEPvyb0KCEUY1MREdO4XANBx7tdgfEnuFEygABuQU4zvSQ
         Xw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptY5CYjhtdiN1Qyeal1rNQp99XEh/bxjKsw8g/EiuFk=;
        b=Lbf9pSVhGsqAS5YhqXmPI5arrB5E8+del9atRFzaIrXL01vAX2fkvNES72cxydqkv1
         bk4QQzpfZP2a37BFlg08ppDB6b4foOSwsCKdfw46KSsfA9/NiQ2G5FwZ4GR5i3AozCsV
         MB+rr+S8eEZwtBhbf/4tDVHL6ShDeoKQXfETo+34OW7E7N+/JndfzEUKBX6UbFIUuH1f
         NdoqVO2iGaxa2YV+xjLBxYQlNG+RWEcvVNQkhEEo21Ezq2xGQzJkdgKWhCfh08wJgmFw
         Jf5chNKx8TSEC/6TR+EwXZ3oXaHSgThhq8iwLbo/ZaT8Rr2ZK5+V2ODrrTa8auuMzPJ4
         tljA==
X-Gm-Message-State: AOAM532+HeqOdI43YRQAziVz+6liD1GZo7xkt8NYN7vFo0PHpALb36Lp
        mhqkk5+nK8HxI/5eAU2WS5vtCy6IpCG/jyge
X-Google-Smtp-Source: ABdhPJy8nCs9UYv3tk3DEOhbes/jNxBsPRvUAr2rveaR59zs6q3eLm1xH9SYwzzaZ+0YtFRemvJqkA==
X-Received: by 2002:a63:3308:: with SMTP id z8mr23415749pgz.409.1595932047656;
        Tue, 28 Jul 2020 03:27:27 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id m9sm2613056pjs.18.2020.07.28.03.27.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:27:27 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: [PATCH 1/2] ftrace: clear module from hash of all ftrace ops
Date:   Tue, 28 Jul 2020 18:27:19 +0800
Message-Id: <20200728102720.46837-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should clear module from hash of all ops on ftrace_ops_list when
module going, or the ops including these modules will be matched
wrongly by new module loaded later.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/trace/ftrace.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6eb..fca01a168ae5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6223,18 +6223,20 @@ clear_mod_from_hash(struct ftrace_page *pg, struct ftrace_hash *hash)
 /* Clear any records from hashs */
 static void clear_mod_from_hashes(struct ftrace_page *pg)
 {
-	struct trace_array *tr;
+	struct ftrace_ops *op;
 
-	mutex_lock(&trace_types_lock);
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (!tr->ops || !tr->ops->func_hash)
+	mutex_lock(&ftrace_lock);
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+		if (!op->func_hash)
 			continue;
-		mutex_lock(&tr->ops->func_hash->regex_lock);
-		clear_mod_from_hash(pg, tr->ops->func_hash->filter_hash);
-		clear_mod_from_hash(pg, tr->ops->func_hash->notrace_hash);
-		mutex_unlock(&tr->ops->func_hash->regex_lock);
-	}
-	mutex_unlock(&trace_types_lock);
+		mutex_lock(&op->func_hash->regex_lock);
+		clear_mod_from_hash(pg, op->func_hash->filter_hash);
+		clear_mod_from_hash(pg, op->func_hash->notrace_hash);
+		mutex_unlock(&op->func_hash->regex_lock);
+	} while_for_each_ftrace_op(op);
+
+	mutex_unlock(&ftrace_lock);
 }
 
 static void ftrace_free_mod_map(struct rcu_head *rcu)
-- 
2.20.1

