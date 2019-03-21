Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B8C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE90E206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgC1QoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:15 -0400
Received: from mx.sdf.org ([205.166.94.20]:49806 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgC1QoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:13 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhHat008785
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:17 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhHox023138;
        Sat, 28 Mar 2020 16:43:17 GMT
Message-Id: <202003281643.02SGhHox023138@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 20 Mar 2019 22:50:00 -0400
Subject: [RFC PATCH v1 26/50] drivers/nfc/nfcsim: use prandom_32() for time
 delay
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Thierry Escande <thierry.escande@collabora.com>,
        Samuel Ortiz <sameo@linux.intel.com>, linux-nfc@lists.01.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_random_bytes() is expensive crypto-quality seed material.
That's not needed for a simple simulation.

(Also, a 3-10 ms delay, when converted to jiffies, isn't a lot of
granularity.  It's 1 jiffy at HZ=100 and 3 jiffies at HZ=250
or HZ=300.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Thierry Escande <thierry.escande@collabora.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-nfc@lists.01.org
---
 drivers/nfc/nfcsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index a9864fcdfba6b..eb0a909a25487 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -229,8 +229,7 @@ static int nfcsim_send(struct nfc_digital_dev *ddev, struct sk_buff *skb,
 				    dev->mode);
 
 		/* Add random delay (between 3 and 10 ms) before sending data */
-		get_random_bytes(&delay, 1);
-		delay = 3 + (delay & 0x07);
+		delay = 3 + prandom_u32_max(8);
 
 		schedule_delayed_work(&dev->send_work, msecs_to_jiffies(delay));
 	}
-- 
2.26.0

