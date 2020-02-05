Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95572C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7092082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580945287;
	bh=Vs2ad5m8Wzki1gkcDfV7JuENWCjWBcBgOwmxALy+SKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uenVFXhr7rcy6uBVAmb2P/Km7gcJLaTpkCJa634IdglitNHT7UxH18HENwOdvUCNN
	 wRE2kC161v00KBEMhXu5ArRzvtKfN2FeQAXsENLwBCgeRJohunTeuaKgNxa3oW9BH+
	 q/tr+WOJz8TwCZq+C10ogg4sg9Ml9FR8nVklY6aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBEX2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:28:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgBEX2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:28:04 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798FD217F4;
        Wed,  5 Feb 2020 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580945283;
        bh=Vs2ad5m8Wzki1gkcDfV7JuENWCjWBcBgOwmxALy+SKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMxEOtkgJ/W9H2pRNp1aRL7EAtc8pB+UiR9JYSBfYGwo+SnfXNJLe9Pg/+yNTveYz
         PvkQzveY/Qn7LpjB5nRDrYjpzE5d8RG9yvGwYMS3cphkNAF39yoAgMfVl/VK7ZyuHD
         5bpP0dQhB2oX9ifqURwYcJkaTCAPpSgGISKlQSn8=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 2/4] clk: Use 'parent' to shorten lines in __clk_core_init()
Date:   Wed,  5 Feb 2020 15:28:00 -0800
Message-Id: <20200205232802.29184-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205232802.29184-1-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lines are getting long in this function. Let's move 'parent' up to
the top of the function and use it in many places whenever there is a
parent for a clk. This shortens some lines by avoiding core->parent->
indirections.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 26213e82f5f9..9ad950178d10 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3342,6 +3342,7 @@ static void clk_core_reparent_orphans_nolock(void)
 static int __clk_core_init(struct clk_core *core)
 {
 	int ret;
+	struct clk_core *parent;
 	unsigned long rate;
 
 	if (!core)
@@ -3413,7 +3414,7 @@ static int __clk_core_init(struct clk_core *core)
 			goto out;
 	}
 
-	core->parent = __clk_init_parent(core);
+	parent = core->parent = __clk_init_parent(core);
 
 	/*
 	 * Populate core->parent if parent has already been clk_core_init'd. If
@@ -3425,10 +3426,9 @@ static int __clk_core_init(struct clk_core *core)
 	 * clocks and re-parent any that are children of the clock currently
 	 * being clk_init'd.
 	 */
-	if (core->parent) {
-		hlist_add_head(&core->child_node,
-				&core->parent->children);
-		core->orphan = core->parent->orphan;
+	if (parent) {
+		hlist_add_head(&core->child_node, &parent->children);
+		core->orphan = parent->orphan;
 	} else if (!core->num_parents) {
 		hlist_add_head(&core->child_node, &clk_root_list);
 		core->orphan = false;
@@ -3446,9 +3446,9 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	if (core->ops->recalc_accuracy)
 		core->accuracy = core->ops->recalc_accuracy(core->hw,
-					__clk_get_accuracy(core->parent));
-	else if (core->parent)
-		core->accuracy = core->parent->accuracy;
+					__clk_get_accuracy(parent));
+	else if (parent)
+		core->accuracy = parent->accuracy;
 	else
 		core->accuracy = 0;
 
@@ -3472,9 +3472,9 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	if (core->ops->recalc_rate)
 		rate = core->ops->recalc_rate(core->hw,
-				clk_core_get_rate_nolock(core->parent));
-	else if (core->parent)
-		rate = core->parent->rate;
+				clk_core_get_rate_nolock(parent));
+	else if (parent)
+		rate = parent->rate;
 	else
 		rate = 0;
 	core->rate = core->req_rate = rate;
-- 
Sent by a computer, using git, on the internet

