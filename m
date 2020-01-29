Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B77C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E1C20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgA2SZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:25:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:45858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgA2SZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:25:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01C25AECB;
        Wed, 29 Jan 2020 18:25:52 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     oneukum@suse.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 7/8] usb, cdc-acm: optimize barrier usage for Rmw atomic bitops
Date:   Wed, 29 Jan 2020 10:15:45 -0800
Message-Id: <20200129181545.25302-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can avoid the unnecessary barrier on non LL/SC architectures,
such as x86. Instead, use the smp_mb__after_atomic() call.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/class/cdc-acm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 62f4fb9b362f..0bc4b558f387 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -842,7 +842,7 @@ static void acm_tty_unthrottle(struct tty_struct *tty)
 	clear_bit(ACM_THROTTLED, &acm->flags);
 
 	/* Matches the smp_mb__after_atomic() in acm_read_bulk_callback(). */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	acm_submit_read_urbs(acm, GFP_KERNEL);
 }
-- 
2.16.4

