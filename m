Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20804C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEED02053B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBM2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:28:22 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B1C061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:28:21 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:d5a9:cf1c:d29a:7bea])
        by laurent.telenet-ops.be with bizsmtp
        id mCUG2200E1u9Dj501CUGPR; Tue, 02 Jun 2020 14:28:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jg61g-0005fV-C7; Tue, 02 Jun 2020 14:28:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jg61g-0008Ug-9l; Tue, 02 Jun 2020 14:28:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thunderbolt: Improve USB4 config symbol help text
Date:   Tue,  2 Jun 2020 14:28:15 +0200
Message-Id: <20200602122815.32111-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the spelling of "specification", and add a missing "the" article.

Fixes: 690ac0d20d4022bb ("thunderbolt: Update Kconfig entries to USB4")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thunderbolt/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index f02010738bb66246..daa9bb52fc77db81 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -8,8 +8,8 @@ menuconfig USB4
 	select CRYPTO_HASH
 	select NVMEM
 	help
-	  USB4 and Thunderbolt driver. USB4 is the public speficiation
-	  based on Thunderbolt 3 protocol. This driver is required if
+	  USB4 and Thunderbolt driver. USB4 is the public specification
+	  based on the Thunderbolt 3 protocol. This driver is required if
 	  you want to hotplug Thunderbolt and USB4 compliant devices on
 	  Apple hardware or on PCs with Intel Falcon Ridge or newer.
 
-- 
2.17.1

