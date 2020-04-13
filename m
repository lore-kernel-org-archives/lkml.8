Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E5C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BD20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgDMJyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727830AbgDMJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:54:41 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00FCC008749
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:47:48 -0700 (PDT)
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id S9ij220085USYZQ019ijFR; Mon, 13 Apr 2020 11:42:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jNvc3-0007LZ-3o; Mon, 13 Apr 2020 11:42:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jNvVQ-0006Xc-VO; Mon, 13 Apr 2020 11:35:52 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Drop redundant generic-y += hardirq.h
Date:   Mon, 13 Apr 2020 11:35:52 +0200
Message-Id: <20200413093552.25102-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cleanup in commit 630f289b7114c0e6 ("asm-generic: make more
kernel-space headers mandatory") did not take into account the recently
added line for hardirq.h in commit acc45648b9aefa90 ("m68k: Switch to
asm-generic/hardirq.h"), leading to the following message during the
build:

    scripts/Makefile.asm-generic:25: redundant generic-y found in arch/m68k/include/asm/Kbuild: hardirq.h

Fix this by dropping the now redundant line.

Fixes: 630f289b7114c0e6 ("asm-generic: make more kernel-space headers mandatory")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Feel free to take this one directly, as I have no other m68k fixes
queued for v5.7 yet.

 arch/m68k/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index a0765aa60ea9aa8d..1bff55aa2d54e2ce 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += extable.h
-generic-y += hardirq.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-- 
2.17.1

