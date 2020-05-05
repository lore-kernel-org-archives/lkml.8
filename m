Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72802C4725A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA024953
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgEEODZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729376AbgEEODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:03:18 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D86C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:03:17 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by xavier.telenet-ops.be with bizsmtp
        id b23G2200M3VwRR30123Gdr; Tue, 05 May 2020 16:03:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVyAG-0000P2-IV; Tue, 05 May 2020 16:03:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVyAG-0007VS-G4; Tue, 05 May 2020 16:03:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] block: Make request_queue.rpm_status an enum
Date:   Tue,  5 May 2020 16:03:14 +0200
Message-Id: <20200505140314.28813-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_queue.rpm_status is assigned values of the rpm_status enum only,
so reflect that in its type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
Perhaps this was done to avoid the need to #include <linux/pm.h>?
Let's see what kbuild has to report about this...

v2:
  - Add Acked-by.
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f00bd4042295967d..1e2c6f7a188941f1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -454,7 +454,7 @@ struct request_queue {
 
 #ifdef CONFIG_PM
 	struct device		*dev;
-	int			rpm_status;
+	enum rpm_status		rpm_status;
 	unsigned int		nr_pending;
 #endif
 
-- 
2.17.1

