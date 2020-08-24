Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE52C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C894122B4B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259495;
	bh=+k/m/PhyK12aBbZ+P4lc6R+lVQy+FH3PiNue5J/umrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AE3dcoQag5LQQxNRmpWAQUNaMzQ5jbXVHyMjg42ClZtkmmeze7c1Kk8OScewcE/h
	 lNV4fqmz0/iMcpFI8+/s0Pi8LIpDrefBfTW0nR5gPG6/nGEM9AA6eNXsO8dBxK5UpM
	 45Xe351PWTnJihKoGxFGSx9pFeUJFaaPwhoFBaRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgHXI6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgHXI5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:57:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB61522B47;
        Mon, 24 Aug 2020 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259473;
        bh=+k/m/PhyK12aBbZ+P4lc6R+lVQy+FH3PiNue5J/umrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7gQjNSwmyFnV7oX587cVpvYOn+bfYK+IR0ZLkssgY8zxKBZab3WQDiZF3ZnrMWjr
         6XsN/16vYFecBQMw+ND21WcRrpmVT6/Sb7NonYvuTg7OhDUv/GzTJEnqfhDs9vZrRw
         fzIf0T6H+ICx1vSMR8zoE7rxixOQ6EaLYYXgnXc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 4.19 71/71] clk: Evict unregistered clks from parent caches
Date:   Mon, 24 Aug 2020 10:32:02 +0200
Message-Id: <20200824082359.534322751@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

commit bdcf1dc253248542537a742ae1e7ccafdd03f2d3 upstream.

We leave a dangling pointer in each clk_core::parents array that has an
unregistered clk as a potential parent when that clk_core pointer is
freed by clk{_hw}_unregister(). It is impossible for the true parent of
a clk to be set with clk_set_parent() once the dangling pointer is left
in the cache because we compare parent pointers in
clk_fetch_parent_index() instead of checking for a matching clk name or
clk_hw pointer.

Before commit ede77858473a ("clk: Remove global clk traversal on fetch
parent index"), we would check clk_hw pointers, which has a higher
chance of being the same between registration and unregistration, but it
can still be allocated and freed by the clk provider. In fact, this has
been a long standing problem since commit da0f0b2c3ad2 ("clk: Correct
lookup logic in clk_fetch_parent_index()") where we stopped trying to
compare clk names and skipped over entries in the cache that weren't
NULL.

There are good (performance) reasons to not do the global tree lookup in
cases where the cache holds dangling pointers to parents that have been
unregistered. Let's take the performance hit on the uncommon
registration path instead. Loop through all the clk_core::parents arrays
when a clk is unregistered and set the entry to NULL when the parent
cache entry and clk being unregistered are the same pointer. This will
fix this problem and avoid the overhead for the "normal" case.

Based on a patch by Bjorn Andersson.

Fixes: da0f0b2c3ad2 ("clk: Correct lookup logic in clk_fetch_parent_index()")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190828181959.204401-1-sboyd@kernel.org
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |   52 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -40,6 +40,17 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
+static struct hlist_head *all_lists[] = {
+	&clk_root_list,
+	&clk_orphan_list,
+	NULL,
+};
+
+static struct hlist_head *orphan_list[] = {
+	&clk_orphan_list,
+	NULL,
+};
+
 /***    private data structures    ***/
 
 struct clk_core {
@@ -2618,17 +2629,6 @@ static int inited = 0;
 static DEFINE_MUTEX(clk_debug_lock);
 static HLIST_HEAD(clk_debug_list);
 
-static struct hlist_head *all_lists[] = {
-	&clk_root_list,
-	&clk_orphan_list,
-	NULL,
-};
-
-static struct hlist_head *orphan_list[] = {
-	&clk_orphan_list,
-	NULL,
-};
-
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
@@ -3328,6 +3328,34 @@ static const struct clk_ops clk_nodrv_op
 	.set_parent	= clk_nodrv_set_parent,
 };
 
+static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
+						struct clk_core *target)
+{
+	int i;
+	struct clk_core *child;
+
+	for (i = 0; i < root->num_parents; i++)
+		if (root->parents[i] == target)
+			root->parents[i] = NULL;
+
+	hlist_for_each_entry(child, &root->children, child_node)
+		clk_core_evict_parent_cache_subtree(child, target);
+}
+
+/* Remove this clk from all parent caches */
+static void clk_core_evict_parent_cache(struct clk_core *core)
+{
+	struct hlist_head **lists;
+	struct clk_core *root;
+
+	lockdep_assert_held(&prepare_lock);
+
+	for (lists = all_lists; *lists; lists++)
+		hlist_for_each_entry(root, *lists, child_node)
+			clk_core_evict_parent_cache_subtree(root, core);
+
+}
+
 /**
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
@@ -3366,6 +3394,8 @@ void clk_unregister(struct clk *clk)
 			clk_core_set_parent_nolock(child, NULL);
 	}
 
+	clk_core_evict_parent_cache(clk->core);
+
 	hlist_del_init(&clk->core->child_node);
 
 	if (clk->core->prepare_count)


