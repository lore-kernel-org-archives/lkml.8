Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3BC38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E9A20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955994;
	bh=ak3MKSqPh/TSr0rPK5DUxHnAyY73imxeaHdwafJvqA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6RaMnx57YkFCFGfLrCPpTJn4fmfWU9A/nGFF6+ud/eHUy3Bc88AmJiPkS0a3i8/+
	 TDKHATY0DNKg86RdLg3yoYDVyRP0RUQHO4D8yiHn/Qms+JvclzJXjGpfL7kmMRBO+n
	 NhSV+eKEZCBty4PfJK89rBJEb8MbJf/v2kxkYMr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897114AbgDOLgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408863AbgDOLeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:34:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B148520775;
        Wed, 15 Apr 2020 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950489;
        bh=ak3MKSqPh/TSr0rPK5DUxHnAyY73imxeaHdwafJvqA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTuuJMCPXcGFmeqzyPbu3QYS1Olh4swdhdl/hw/qccYmj+MDCClCElgkvZ2Wsr8Vg
         Hgk2595dVJ/qZrFLXlf1iy3WJeXWbhHrGfs5RWg5qQar85G8xHGFoO/9BrMtBIyLkK
         iQqvL5teSgEjemlHQl2XMhdPtMhvFpYibMM0BRX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 003/129] clk: Don't cache errors from clk_ops::get_phase()
Date:   Wed, 15 Apr 2020 07:32:38 -0400
Message-Id: <20200415113445.11881-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit f21cf9c77ee82ef8adfeb2143adfacf21ec1d5cc ]

We don't check for errors from clk_ops::get_phase() before storing away
the result into the clk_core::phase member. This can lead to some fairly
confusing debugfs information if these ops do return an error. Let's
skip the store when this op fails to fix this. While we're here, move
the locking outside of clk_core_get_phase() to simplify callers from
the debugfs side.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20200205232802.29184-2-sboyd@kernel.org
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 48 +++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 95adf6c6db3db..305544b68b8a7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2660,12 +2660,14 @@ static int clk_core_get_phase(struct clk_core *core)
 {
 	int ret;
 
-	clk_prepare_lock();
+	lockdep_assert_held(&prepare_lock);
+	if (!core->ops->get_phase)
+		return 0;
+
 	/* Always try to update cached phase if possible */
-	if (core->ops->get_phase)
-		core->phase = core->ops->get_phase(core->hw);
-	ret = core->phase;
-	clk_prepare_unlock();
+	ret = core->ops->get_phase(core->hw);
+	if (ret >= 0)
+		core->phase = ret;
 
 	return ret;
 }
@@ -2679,10 +2681,16 @@ static int clk_core_get_phase(struct clk_core *core)
  */
 int clk_get_phase(struct clk *clk)
 {
+	int ret;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_get_phase(clk->core);
+	clk_prepare_lock();
+	ret = clk_core_get_phase(clk->core);
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_get_phase);
 
@@ -2896,13 +2904,21 @@ static struct hlist_head *orphan_list[] = {
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
+	int phase;
+
+	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
-		   clk_core_get_rate(c), clk_core_get_accuracy(c),
-		   clk_core_get_phase(c),
-		   clk_core_get_scaled_duty_cycle(c, 100000));
+		   clk_core_get_rate(c), clk_core_get_accuracy(c));
+
+	phase = clk_core_get_phase(c);
+	if (phase >= 0)
+		seq_printf(s, "%5d", phase);
+	else
+		seq_puts(s, "-----");
+
+	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
@@ -2939,6 +2955,7 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
 
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
+	int phase;
 	unsigned long min_rate, max_rate;
 
 	clk_core_get_boundaries(c, &min_rate, &max_rate);
@@ -2952,7 +2969,9 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"min_rate\": %lu,", min_rate);
 	seq_printf(s, "\"max_rate\": %lu,", max_rate);
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
-	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
+	phase = clk_core_get_phase(c);
+	if (phase >= 0)
+		seq_printf(s, "\"phase\": %d,", phase);
 	seq_printf(s, "\"duty_cycle\": %u",
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
@@ -3434,14 +3453,11 @@ static int __clk_core_init(struct clk_core *core)
 		core->accuracy = 0;
 
 	/*
-	 * Set clk's phase.
+	 * Set clk's phase by clk_core_get_phase() caching the phase.
 	 * Since a phase is by definition relative to its parent, just
 	 * query the current clock phase, or just assume it's in phase.
 	 */
-	if (core->ops->get_phase)
-		core->phase = core->ops->get_phase(core->hw);
-	else
-		core->phase = 0;
+	clk_core_get_phase(core);
 
 	/*
 	 * Set clk's duty cycle.
-- 
2.20.1

