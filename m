Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CD72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgBLJUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:20:10 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55800 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgBLJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:20:10 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id 1lL8220015USYZQ01lL8uS; Wed, 12 Feb 2020 10:20:08 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1o3h-0000Zh-5L; Wed, 12 Feb 2020 10:11:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1nbX-0002IJ-Ab; Wed, 12 Feb 2020 09:42:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] lib/scatterlist: Fix sg_copy_buffer() kerneldoc
Date:   Wed, 12 Feb 2020 09:42:41 +0100
Message-Id: <20200212084241.8778-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing closing parenthesis to the description for the to_buffer
parameter of sg_copy_buffer().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5813072bc58955ac..5d63a8857f361d00 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -832,7 +832,7 @@ EXPORT_SYMBOL(sg_miter_stop);
  * @buflen:		 The number of bytes to copy
  * @skip:		 Number of bytes to skip before copying
  * @to_buffer:		 transfer direction (true == from an sg list to a
- *			 buffer, false == from a buffer to an sg list
+ *			 buffer, false == from a buffer to an sg list)
  *
  * Returns the number of copied bytes.
  *
-- 
2.17.1

