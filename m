Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F1206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgGHMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgGHMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:18:09 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jul 2020 05:18:09 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554BC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:18:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 492F5101E69A5;
        Wed,  8 Jul 2020 14:12:30 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D4C096106EBC;
        Wed,  8 Jul 2020 14:12:29 +0200 (CEST)
X-Mailbox-Line: From b1af31b0e351bcbc056fe1ec44500737a7998d43 Mon Sep 17 00:00:00 2001
Message-Id: <b1af31b0e351bcbc056fe1ec44500737a7998d43.1594210157.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 14:12:22 +0200
Subject: [PATCH] driver core: Drop mention of obsolete bus rwsem from
 kernel-doc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15 years ago, commit 6eded061b126 ("Fix up bus code and remove use of
rwsem") removed the bus rwsem, but left over a reference to it in a
kernel-doc comment.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/dd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9353d811cce83..cc42c91c5bf56 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -430,10 +430,9 @@ static void driver_sysfs_remove(struct device *dev)
  * Allow manual attachment of a driver to a device.
  * Caller must have already set @dev->driver.
  *
- * Note that this does not modify the bus reference count
- * nor take the bus's rwsem. Please verify those are accounted
- * for before calling this. (It is ok to call with no other effort
- * from a driver's probe() method.)
+ * Note that this does not modify the bus reference count.
+ * Please verify that is accounted for before calling this.
+ * (It is ok to call with no other effort from a driver's probe() method.)
  *
  * This function must be called with the device lock held.
  */
-- 
2.27.0

