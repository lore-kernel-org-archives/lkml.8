Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F23C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EF72082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580945290;
	bh=bKTzow6lnfsmvQ7jDptWZxY6H3I0ImNzPEkMhHjJfFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tnt/QC0AF+CBTg99TU/Dx5fO0CUGLarGrMukEdTgrVEwwy3/N6imcIpPrkx6uydQI
	 suGANcnpwvINAwcTs+h3t9Fd/DOT0Cu2KYVfc70SKIVk+8xVHW9xFhNginxl5b4Nf5
	 AH38OC35naGZQvh7ETUZX/QMkryqL94+Mh+SsfUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBEX2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgBEX2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:28:05 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31A9218AC;
        Wed,  5 Feb 2020 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580945284;
        bh=bKTzow6lnfsmvQ7jDptWZxY6H3I0ImNzPEkMhHjJfFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlBtackbzTq8xRdEjNNSDDnyUF/HYo+6bGp6XpBIL1ehppAzScTvapV3qmWEPebad
         loS77NuXFXfX8prBLA148vA/tFnehbHFik24APENoVAscanQ2PHATRzsbAVNa7LXUn
         adq31FMB7jHN0ujn3iSlLpITFmyz0sYBQNUDJP9Y=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 3/4] clk: Move rate and accuracy recalc to mostly consumer APIs
Date:   Wed,  5 Feb 2020 15:28:01 -0800
Message-Id: <20200205232802.29184-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205232802.29184-1-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some confusion about when recalc is done for the rate and
accuracy clk consumer APIs in relation to the prepare lock being taken.
Oddly enough, we take the lock again in debugfs APIs so that we can call
the internal "clk_core" APIs to get these fields with any necessary
recalculations. Instead of having this confusion, let's introduce a
recalc variant of these two consumer APIs as internal helpers and call
them from the consumer APIs and the debugfs code so that we don't take
the lock more than once.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9ad950178d10..87532e2d124a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -488,7 +488,7 @@ unsigned long clk_hw_get_rate(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_rate);
 
-static unsigned long __clk_get_accuracy(struct clk_core *core)
+static unsigned long clk_core_get_accuracy_no_lock(struct clk_core *core)
 {
 	if (!core)
 		return 0;
@@ -1517,18 +1517,12 @@ static void __clk_recalc_accuracies(struct clk_core *core)
 		__clk_recalc_accuracies(child);
 }
 
-static long clk_core_get_accuracy(struct clk_core *core)
+static long clk_core_get_accuracy_recalc(struct clk_core *core)
 {
-	unsigned long accuracy;
-
-	clk_prepare_lock();
 	if (core && (core->flags & CLK_GET_ACCURACY_NOCACHE))
 		__clk_recalc_accuracies(core);
 
-	accuracy = __clk_get_accuracy(core);
-	clk_prepare_unlock();
-
-	return accuracy;
+	return clk_core_get_accuracy_no_lock(core);
 }
 
 /**
@@ -1542,10 +1536,16 @@ static long clk_core_get_accuracy(struct clk_core *core)
  */
 long clk_get_accuracy(struct clk *clk)
 {
+	long accuracy;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_get_accuracy(clk->core);
+	clk_prepare_lock();
+	accuracy = clk_core_get_accuracy_recalc(clk->core);
+	clk_prepare_unlock();
+
+	return accuracy;
 }
 EXPORT_SYMBOL_GPL(clk_get_accuracy);
 
@@ -1599,19 +1599,12 @@ static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 		__clk_recalc_rates(child, msg);
 }
 
-static unsigned long clk_core_get_rate(struct clk_core *core)
+static unsigned long clk_core_get_rate_recalc(struct clk_core *core)
 {
-	unsigned long rate;
-
-	clk_prepare_lock();
-
 	if (core && (core->flags & CLK_GET_RATE_NOCACHE))
 		__clk_recalc_rates(core, 0);
 
-	rate = clk_core_get_rate_nolock(core);
-	clk_prepare_unlock();
-
-	return rate;
+	return clk_core_get_rate_nolock(core);
 }
 
 /**
@@ -1624,10 +1617,16 @@ static unsigned long clk_core_get_rate(struct clk_core *core)
  */
 unsigned long clk_get_rate(struct clk *clk)
 {
+	unsigned long rate;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_get_rate(clk->core);
+	clk_prepare_lock();
+	rate = clk_core_get_rate_recalc(clk->core);
+	clk_prepare_unlock();
+
+	return rate;
 }
 EXPORT_SYMBOL_GPL(clk_get_rate);
 
@@ -2910,7 +2909,8 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
-		   clk_core_get_rate(c), clk_core_get_accuracy(c));
+		   clk_core_get_rate_recalc(c),
+		   clk_core_get_accuracy_recalc(c));
 
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
@@ -2965,10 +2965,10 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"enable_count\": %d,", c->enable_count);
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
-	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
+	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate_recalc(c));
 	seq_printf(s, "\"min_rate\": %lu,", min_rate);
 	seq_printf(s, "\"max_rate\": %lu,", max_rate);
-	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
+	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy_recalc(c));
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
 		seq_printf(s, "\"phase\": %d,", phase);
@@ -3446,7 +3446,7 @@ static int __clk_core_init(struct clk_core *core)
 	 */
 	if (core->ops->recalc_accuracy)
 		core->accuracy = core->ops->recalc_accuracy(core->hw,
-					__clk_get_accuracy(parent));
+					clk_core_get_accuracy_no_lock(parent));
 	else if (parent)
 		core->accuracy = parent->accuracy;
 	else
-- 
Sent by a computer, using git, on the internet

