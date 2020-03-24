Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7120719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vh8jn8n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCXF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:59:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38105 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCXF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:59:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so4420161pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cSoIVh8LicHMny30ou4Ib5KY5U4nREhEMxSaKlU4Qjc=;
        b=vh8jn8n6+sEHafn9tkZ4spqW92Q1JwpZQpLMy+6etGlskWffwj8V6qLEaZyR5vs3C+
         fPw1NPhfUiQTpj03jxoNsVO95kwUEgHfGT6rPC3iCZfHIU8tEvAV7uSAHb0UoTCLKXVo
         Mg7CeyopWDQZlZrHgx58uzSqDV+luXhD2lxnuw0nl25ocwsP/bY9VR/bf9RgcG1BIFV0
         rnHnQh0LCwNrb4RxUaMng5uIJgfUi0ranb9nT9kENTcmq4jFy3b1WeoijGt+DxZixN5/
         Fo7GhH2tFa+R/U0NLcflEJS6uW6DqVDdHySBFr2EH706SscPihG3RWW/Y+2ZyJi8RiAf
         s1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cSoIVh8LicHMny30ou4Ib5KY5U4nREhEMxSaKlU4Qjc=;
        b=uGi/kIflo3D2Vr96AKO4PTjSdSKMtN9JCMoBUDSwLQjYkYnoJ9P6y+tA9Ujxlr20k0
         2hy53jlgIyZUoyWzpd95Gzn+rO4448vWu3SLXO2Lddah0mLtTfnvTFFPfamYVF+JXz8C
         NODRC8p3tTNXakkWlrshBECWvoEH8SdYk80sLuTbVtWXKTQsHSHdcdetnxLmvVAIo7xI
         KePqu0AU5YkT01iZOKuGZJJhxzkaD5k72fQerxxPYhst1Q0GLaNQ+DPb46iQmMdr5Xfl
         hRO4turoc1k+WKEuGbx475Dopmk1nPAbSHmOo8YGK/J5deYGSD38Kcww0PsDLZppFty9
         GR0Q==
X-Gm-Message-State: ANhLgQ0SZtqWyd2Hf7U82e3MPUdV7esgigqj7E3c6V6lN2BBYRR+QyJy
        Xsb88d1YuKw81cdJ8+PpIdM=
X-Google-Smtp-Source: ADFU+vuRpap5scyiBHrO6hjTpceoRmuPLlcVy3yyQ+MmjPLnQGd5wduAxBQ2RBlquYfUyln9OvzFJQ==
X-Received: by 2002:a62:880f:: with SMTP id l15mr27680179pfd.218.1585029587550;
        Mon, 23 Mar 2020 22:59:47 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s12sm13921742pgi.38.2020.03.23.22.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Mar 2020 22:59:46 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     saravanak@google.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
Date:   Tue, 24 Mar 2020 13:59:36 +0800
Message-Id: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

This allows timer drivers to be compiled as modules.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/clocksource/timer-of.c | 17 +++++++++--------
 drivers/clocksource/timer-of.h |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 572da47..fd3b868 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -19,7 +19,7 @@
  *
  * Free the irq resource
  */
-static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
+static void timer_of_irq_exit(struct of_timer_irq *of_irq)
 {
 	struct timer_of *to = container_of(of_irq, struct timer_of, of_irq);
 
@@ -47,7 +47,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_irq_init(struct device_node *np,
+static int timer_of_irq_init(struct device_node *np,
 				    struct of_timer_irq *of_irq)
 {
 	int ret;
@@ -91,7 +91,7 @@ static __init int timer_of_irq_init(struct device_node *np,
  *
  * Disables and releases the refcount on the clk
  */
-static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
+static void timer_of_clk_exit(struct of_timer_clk *of_clk)
 {
 	of_clk->rate = 0;
 	clk_disable_unprepare(of_clk->clk);
@@ -107,7 +107,7 @@ static __init void timer_of_clk_exit(struct of_timer_clk *of_clk)
  *
  * Returns 0 on success, < 0 otherwise
  */
-static __init int timer_of_clk_init(struct device_node *np,
+static int timer_of_clk_init(struct device_node *np,
 				    struct of_timer_clk *of_clk)
 {
 	int ret;
@@ -146,12 +146,12 @@ static __init int timer_of_clk_init(struct device_node *np,
 	goto out;
 }
 
-static __init void timer_of_base_exit(struct of_timer_base *of_base)
+static void timer_of_base_exit(struct of_timer_base *of_base)
 {
 	iounmap(of_base->base);
 }
 
-static __init int timer_of_base_init(struct device_node *np,
+static int timer_of_base_init(struct device_node *np,
 				     struct of_timer_base *of_base)
 {
 	of_base->base = of_base->name ?
@@ -165,7 +165,7 @@ static __init int timer_of_base_init(struct device_node *np,
 	return 0;
 }
 
-int __init timer_of_init(struct device_node *np, struct timer_of *to)
+int timer_of_init(struct device_node *np, struct timer_of *to)
 {
 	int ret = -EINVAL;
 	int flags = 0;
@@ -209,6 +209,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 		timer_of_base_exit(&to->of_base);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(timer_of_init);
 
 /**
  * timer_of_cleanup - release timer_of ressources
@@ -217,7 +218,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
  * Release the ressources that has been used in timer_of_init().
  * This function should be called in init error cases
  */
-void __init timer_of_cleanup(struct timer_of *to)
+void timer_of_cleanup(struct timer_of *to)
 {
 	if (to->flags & TIMER_OF_IRQ)
 		timer_of_irq_exit(&to->of_irq);
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3..1b8cfac5 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -66,9 +66,9 @@ static inline unsigned long timer_of_period(struct timer_of *to)
 	return to->of_clk.period;
 }
 
-extern int __init timer_of_init(struct device_node *np,
+extern int timer_of_init(struct device_node *np,
 				struct timer_of *to);
 
-extern void __init timer_of_cleanup(struct timer_of *to);
+extern void timer_of_cleanup(struct timer_of *to);
 
 #endif
-- 
1.9.1

