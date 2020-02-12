Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F714C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD2206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBLKQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:16:07 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:59544 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBLKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:15:50 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 1mFn2200B5USYZQ01mFnGS; Wed, 12 Feb 2020 11:15:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3b-0001N4-9i; Wed, 12 Feb 2020 11:15:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3b-0002Il-7X; Wed, 12 Feb 2020 11:15:47 +0100
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
Subject: [PATCH 2/7] MIPS: BMIPS: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:15:39 +0100
Message-Id: <20200212101544.8793-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212101544.8793-1-geert+renesas@glider.be>
References: <20200212101544.8793-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BMIPS platform code is not a clock provider, and just needs
to call of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/bmips/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 2f81a94c71a60f74..19308df5f577914d 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -10,11 +10,11 @@
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/memblock.h>
-#include <linux/clk-provider.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/libfdt.h>
-- 
2.17.1

