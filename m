Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB3C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC8F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgBYOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:48:00 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:46106 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgBYOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:48:00 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 72nr2200M5USYZQ062nsVf; Tue, 25 Feb 2020 15:47:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j6bV1-0007yI-Rg; Tue, 25 Feb 2020 15:47:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j6bV1-0005AV-Oq; Tue, 25 Feb 2020 15:47:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.miao@nvidia.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: boot: Fix ATAGs with appended DTB
Date:   Tue, 25 Feb 2020 15:47:49 +0100
Message-Id: <20200225144749.19815-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At early boot, register r8 may contain an ATAGs or DTB pointer.
When an appended DTB is found, its address is stored in r8, for
extraction of the RAM base address later.

However, if r8 contained an ATAGs pointer before, that pointer will be
lost, and the provided ATAGs is no longer folded into the provided DTB.

Fix this by leaving r8 untouched.

Fixes: 137e522593918be2 ("ARM: 8960/1: boot: Obtain start of physical memory from DTB")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not tested with ATAGs, only with [uz]Image + DTB, and zImage with
appended DTB.
---
 arch/arm/boot/compressed/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 339d4b4cfbbeed15..a351ed2bc195ed8d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -267,16 +267,18 @@ not_angel:
 		cmp	r0, r1		@ do we have a DTB there?
 		bne	1f
 
-		mov	r8, r6		@ use it if so
 		/* preserve 64-bit alignment */
 		add	r5, r5, #7
 		bic	r5, r5, #7
-		add	sp, sp, r5	@ and move stack above it
+		add	sp, sp, r5	@ if so, move stack above DTB
+		mov	r0, r6		@ and extract memory start from DTB
+		b	2f
 
 1:
 #endif /* CONFIG_ARM_APPENDED_DTB */
 
 		mov	r0, r8
+2:
 		bl	fdt_get_mem_start
 		mov	r4, r0
 		cmp	r0, #-1
-- 
2.17.1

