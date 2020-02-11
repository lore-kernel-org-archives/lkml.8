Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A022206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9j9/fkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgBKRrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:47:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgBKRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:47:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so10279701wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GVBOb7DrBV2lxuO60nCMr09n1GF1C56jma5Qdz978IE=;
        b=O9j9/fkx46gdb3bDhO7sj7Po7d7dmuG877RLoZMOtgLNFSK7ukSxsKUQMSaHv4mb4+
         A9y5oNzJgDgoCpQ3K4XjNkaP/c7zAz9pu9e5fQ66omfCGP4pM8fWutUpVOBTiWdxXhle
         DcF6sPG3frm19VyRmR7CcQTZEpXYlrO9ddvGI1/k9h4ogfp5mgEzsk2jW9VZVjybXpn8
         JT7cU/2Sav7d1NjkBviXEBYqL38/7i2AqCGBcxNlL9Z7+MUcmlMCYWibMiUKlKWHi9VP
         lBLiAasvruE6wiirzitSdqIyiRiXLzOxsIX9p3nw/q8qDgSJldEarE92VigjT5s935/l
         3PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GVBOb7DrBV2lxuO60nCMr09n1GF1C56jma5Qdz978IE=;
        b=Sgqew0YSruCuW7OvY3/3rtR4B2eU2TzdQnQiPvHjtOGqr3eZXLxaqmDOlDiBpOc0P1
         sG9cO9SJ7j7cm48TTVWDNWVNL1JArN/3EMVFjacFBnoododyf00pub/CfFSsUfBZTms7
         pQIIbDEJNf+uE3MDS3CeBW5SOqfzwdpLRon1sHkUmIDEjp8XQRDBr8HQ6DEhQLltSEXh
         hZOO4SaGILey47XNKleYNY6vd+IEbpn4FOqfeqGi2gLbfLxS/CJ+2RBTxayYi/3N68Zd
         Ga01YpScFsPgoblc3O31s+M/OK2DlHDTYvGqonBbBBkyVS0OCtHpB9Yz6nKjJBQGyNdz
         6oZg==
X-Gm-Message-State: APjAAAUHikMunp6faPFDq8xA2QZsOt4up/y9d2v6oTu93nFshwmQc3vp
        OzT79l7OSgcHlEqBvJgnGncK/Q==
X-Google-Smtp-Source: APXvYqzvDb3VsBe+vvFMSLBB+jgYXnKTaTC+3mAoumpcWD4kUqyZ4EsL16x7g7UGU45JGGq77BnBpw==
X-Received: by 2002:adf:f484:: with SMTP id l4mr10094371wro.207.1581443230173;
        Tue, 11 Feb 2020 09:47:10 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:39bd:f3e9:9eaa:e898])
        by smtp.gmail.com with ESMTPSA id s12sm6104764wrw.20.2020.02.11.09.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:47:09 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 4/4] sched/fair: Take into runnable_avg to classify group
Date:   Tue, 11 Feb 2020 18:46:51 +0100
Message-Id: <20200211174651.10330-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174651.10330-1-vincent.guittot@linaro.org>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the new runnable_avg signal to classify a group and to
mitigate the volatility of util_avg in face of intensive migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d7cb207be30..5f8f12c902d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7691,6 +7691,7 @@ struct sg_lb_stats {
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
+	unsigned long group_runnable; /* Total utilization of the group */
 	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
@@ -7911,6 +7912,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return false;
+
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
@@ -7936,6 +7941,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 			(sgs->group_util * imbalance_pct))
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return true;
+
 	return false;
 }
 
@@ -8030,6 +8039,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
-- 
2.17.1

