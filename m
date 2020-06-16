Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F41B20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hLIF+av2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgFPFwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPFwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:52:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A8FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:52:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so792206pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9xJ0w/BClyOU092ahHJOYPA0Zd7qJvi8iGNSD3HOMY=;
        b=hLIF+av2hKjEnvdfsOw1kuNALuVGB/jpUN85+Vi8wctLXJe0Qa+tvq1RIckYau3Me8
         H7hVnpLmBqDFkMmhSNuDsaI/y7+ZSw6UGfHHG5nwn68mHDqZ2Hkmc9GTDDpv+2ufraC/
         czJyLITRhOFHmD2zFEfzB0U/FdJx0efdLWqPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d9xJ0w/BClyOU092ahHJOYPA0Zd7qJvi8iGNSD3HOMY=;
        b=W999te9k4CjmbaZthloBdsUD7xuXmzM2TF+c7v8cuVLwFXLJxhQPdeJ8Rj4ZJeCgxQ
         XJaNk6bETor5RuWc8YnyK6XBIKSbmHZYoxQwGIL0RF4ZIk8O4NXQtvuuE/1oZ+Ik5enW
         +XXf8R2y8uI+wFSnt2+XtBNrjK3r7wNadZslDdwGaByUtlehAPkakLLRtahgbA2gO/Zq
         Litcw7rLFzqk1TMjIlMnso/nnMFtyEItKBk8xMjdku+JiloFBEs5qCJsrhQsmDvmlnQE
         Zhvc1m/+WpZt26FB8h+gmvSG5HvEiEpa5HBpPVWUya2tLCQlFjfx3Edrdo5BghhvCSAX
         pUhg==
X-Gm-Message-State: AOAM531dAmm7sZNlJv6alCp4sNLjrCnn3VcK1wupOhUol6ZZmv4q5Viu
        svrLR6dSOC7gAqWt7hQjJ3zoLQ==
X-Google-Smtp-Source: ABdhPJw606OdXdLtePjQNNUgZfXeodkoPRiJRfIuUGFaK3Dzlt6PpLBKI6QYoXdvsjzLyVTWIL0R+Q==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr759202pll.18.1592286749249;
        Mon, 15 Jun 2020 22:52:29 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id s11sm15176073pfh.204.2020.06.15.22.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 22:52:28 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] clk: Provide future parent in clk notification
Date:   Tue, 16 Jun 2020 13:52:23 +0800
Message-Id: <20200616055223.119360-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current clk notification handlers cannot know its new parent in
PRE_RATE_CHANGE event. This patch simply adds parent clk to
clk_notifier_data so the child clk is now able to know its future
parent prior to reparenting.

Change-Id: I099a784d5302a93951bdc6254d85f8df8c770462
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/clk/clk.c   | 30 +++++++++++++++++-------------
 include/linux/clk.h |  9 ++++++---
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3f588ed06ce3..62c4e7b50ae5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1458,6 +1458,7 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
 /**
  * __clk_notify - call clk notifier chain
  * @core: clk that is changing rate
+ * @parent: new parent of core
  * @msg: clk notifier type (see include/linux/clk.h)
  * @old_rate: old clk rate
  * @new_rate: new clk rate
@@ -1469,13 +1470,15 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
  * called if all went well, or NOTIFY_STOP or NOTIFY_BAD immediately if
  * a driver returns that.
  */
-static int __clk_notify(struct clk_core *core, unsigned long msg,
-		unsigned long old_rate, unsigned long new_rate)
+static int __clk_notify(struct clk_core *core, struct clk_core *parent,
+			unsigned long msg, unsigned long old_rate,
+			unsigned long new_rate)
 {
 	struct clk_notifier *cn;
 	struct clk_notifier_data cnd;
 	int ret = NOTIFY_DONE;
 
+	cnd.parent = parent ? parent->hw->clk : NULL;
 	cnd.old_rate = old_rate;
 	cnd.new_rate = new_rate;
 
@@ -1597,7 +1600,7 @@ static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 	 * & ABORT_RATE_CHANGE notifiers
 	 */
 	if (core->notifier_count && msg)
-		__clk_notify(core, msg, old_rate, core->rate);
+		__clk_notify(core, core->parent, msg, old_rate, core->rate);
 
 	hlist_for_each_entry(child, &core->children, child_node)
 		__clk_recalc_rates(child, msg);
@@ -1834,7 +1837,7 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 /**
  * __clk_speculate_rates
  * @core: first clk in the subtree
- * @parent_rate: the "future" rate of clk's parent
+ * @parent: the "future" parent of core
  *
  * Walks the subtree of clks starting with clk, speculating rates as it
  * goes and firing off PRE_RATE_CHANGE notifications as necessary.
@@ -1846,7 +1849,7 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
  * take on the rate of its parent.
  */
 static int __clk_speculate_rates(struct clk_core *core,
-				 unsigned long parent_rate)
+				 struct clk_core *parent)
 {
 	struct clk_core *child;
 	unsigned long new_rate;
@@ -1854,11 +1857,12 @@ static int __clk_speculate_rates(struct clk_core *core,
 
 	lockdep_assert_held(&prepare_lock);
 
-	new_rate = clk_recalc(core, parent_rate);
+	new_rate = clk_recalc(core, parent ? parent->rate : 0);
 
 	/* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STOP */
 	if (core->notifier_count)
-		ret = __clk_notify(core, PRE_RATE_CHANGE, core->rate, new_rate);
+		ret = __clk_notify(core, parent, PRE_RATE_CHANGE,
+				   core->rate, new_rate);
 
 	if (ret & NOTIFY_STOP_MASK) {
 		pr_debug("%s: clk notifier callback for clock %s aborted with error %d\n",
@@ -1867,7 +1871,7 @@ static int __clk_speculate_rates(struct clk_core *core,
 	}
 
 	hlist_for_each_entry(child, &core->children, child_node) {
-		ret = __clk_speculate_rates(child, new_rate);
+		ret = __clk_speculate_rates(child, core);
 		if (ret & NOTIFY_STOP_MASK)
 			break;
 	}
@@ -1996,7 +2000,8 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
 		return NULL;
 
 	if (core->notifier_count) {
-		ret = __clk_notify(core, event, core->rate, core->new_rate);
+		ret = __clk_notify(core, core->parent, event,
+				   core->rate, core->new_rate);
 		if (ret & NOTIFY_STOP_MASK)
 			fail_clk = core;
 	}
@@ -2098,7 +2103,8 @@ static void clk_change_rate(struct clk_core *core)
 		clk_core_disable_unprepare(parent);
 
 	if (core->notifier_count && old_rate != core->rate)
-		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
+		__clk_notify(core, core->parent, POST_RATE_CHANGE,
+			     old_rate, core->rate);
 
 	if (core->flags & CLK_RECALC_NEW_RATES)
 		(void)clk_calc_new_rates(core, core->new_rate);
@@ -2479,7 +2485,6 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 {
 	int ret = 0;
 	int p_index = 0;
-	unsigned long p_rate = 0;
 
 	lockdep_assert_held(&prepare_lock);
 
@@ -2508,7 +2513,6 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 					__func__, parent->name, core->name);
 			return p_index;
 		}
-		p_rate = parent->rate;
 	}
 
 	ret = clk_pm_runtime_get(core);
@@ -2516,7 +2520,7 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 		return ret;
 
 	/* propagate PRE_RATE_CHANGE notifications */
-	ret = __clk_speculate_rates(core, p_rate);
+	ret = __clk_speculate_rates(core, parent);
 
 	/* abort if a driver objects */
 	if (ret & NOTIFY_STOP_MASK)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7fd6a1febcf4..e246e160b290 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -60,16 +60,19 @@ struct clk_notifier {
 /**
  * struct clk_notifier_data - rate data to pass to the notifier callback
  * @clk: struct clk * being changed
+ * @parent: new parent of this clk
  * @old_rate: previous rate of this clk
  * @new_rate: new rate of this clk
  *
  * For a pre-notifier, old_rate is the clk's rate before this rate
- * change, and new_rate is what the rate will be in the future.  For a
- * post-notifier, old_rate and new_rate are both set to the clk's
- * current rate (this was done to optimize the implementation).
+ * change, new_rate is what the rate will be in the future, and parent is
+ * new parent of the clk after new_rate is applied, For a post-notifier,
+ * parent, old_rate, and new_rate are all set to the clk's current state.
+ * (this was done to optimize the implementation).
  */
 struct clk_notifier_data {
 	struct clk		*clk;
+	struct clk		*parent;
 	unsigned long		old_rate;
 	unsigned long		new_rate;
 };
-- 
2.27.0.290.gba653c62da-goog

