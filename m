Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E9C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C137C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgDMPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:12:40 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:31754 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgDMPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:12:34 -0400
Received: from localhost.localdomain ([93.22.151.169])
        by mwinf5d63 with ME
        id SFCX2200J3fYTYl03FCY5q; Mon, 13 Apr 2020 17:12:32 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Apr 2020 17:12:32 +0200
X-ME-IP: 93.22.151.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: renesas: r9a06g032: Fix some typo in comments
Date:   Mon, 13 Apr 2020 06:17:09 +0200
Message-Id: <20200413041709.3630-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file seems to be for R9A06G032 only. So replace reference to
R9A09G032 by R9A06G032 to avoid confusion.

AFAIK, R9A09G032 does'nt exist.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 1907ee195a08..d900f6bf53d0 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * R9A09G032 clock driver
+ * R9A06G032 clock driver
  *
  * Copyright (C) 2018 Renesas Electronics Europe Limited
  *
@@ -338,8 +338,8 @@ clk_rdesc_get(struct r9a06g032_priv *clocks,
 }
 
 /*
- * This implements the R9A09G032 clock gate 'driver'. We cannot use the system's
- * clock gate framework as the gates on the R9A09G032 have a special enabling
+ * This implements the R9A06G032 clock gate 'driver'. We cannot use the system's
+ * clock gate framework as the gates on the R9A06G032 have a special enabling
  * sequence, therefore we use this little proxy.
  */
 struct r9a06g032_clk_gate {
-- 
2.20.1

