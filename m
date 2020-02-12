Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A20BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4295B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBLKPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:15:51 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:59560 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBLKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:15:50 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 1mFn2200F5USYZQ01mFnGU; Wed, 12 Feb 2020 11:15:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3b-0001NA-CT; Wed, 12 Feb 2020 11:15:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3b-0002Ir-Ay; Wed, 12 Feb 2020 11:15:47 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        James Hartley <james.hartley@sondrel.com>,
        John Crispin <john@phrozen.org>
Cc:     linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] MIPS: jz4740: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:15:41 +0100
Message-Id: <20200212101544.8793-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212101544.8793-1-geert+renesas@glider.be>
References: <20200212101544.8793-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ingenic JZ4740 platform code is not a clock provider, and just needs
to call of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/jz4740/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 5476899f0882a4b4..605a84a250bfb299 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -4,8 +4,8 @@
  *  JZ4740 platform time support
  */
 
-#include <linux/clk-provider.h>
 #include <linux/clocksource.h>
+#include <linux/of_clk.h>
 
 #include <asm/mach-jz4740/timer.h>
 
-- 
2.17.1

