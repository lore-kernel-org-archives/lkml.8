Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF60C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF382054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="pjix9LRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbgEMTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390442AbgEMTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:15:57 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:15:56 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id A73B81D44; Wed, 13 May 2020 21:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz A73B81D44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589397354;
        bh=QJApaYVVjDV2ZABMuLXN+EsQlfEtvul5TQM0jLYTCcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjix9LRIvZi9HTHKf4BWi2D2O3Qt7Q8Q0+9yhAsAflKrmPGL+gXemnPV75KJ31oUb
         cE1Wu42Uh1FJHT818WNb+qxYkzJ/QxgVlYNZc6gmz1scpViY1jObCM/PCj2EWvOdBm
         EPC93Ugxaynw7oZa/BX97BRvzsOc8i31TmMWgbVw=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v3 2/2] staging: vt6655: vt6656: change order of makefile variable definitions
Date:   Wed, 13 May 2020 21:15:51 +0200
Message-Id: <1589397351-24655-3-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
References: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will add indentation to multiline variable and put
obj-$(CONFIG_X) at the beginning of the file. This order of variables is
used in other drives, so this will make vt665x Makefiles fit into the
pattern.

Indentation is fixed in vt6655/Makefile.

Order of variable declaration is changed in vt6656/Makefile.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
v1: Initial patch
v2: This patch was split from original bigger patch
v3: Added more info about what and why it's removed

 drivers/staging/vt6655/Makefile | 24 ++++++++++++------------
 drivers/staging/vt6656/Makefile |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/Makefile b/drivers/staging/vt6655/Makefile
index e70357ec0af8..eda08a1516ab 100644
--- a/drivers/staging/vt6655/Makefile
+++ b/drivers/staging/vt6655/Makefile
@@ -1,15 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
-vt6655_stage-y +=	device_main.o \
-	card.o \
-	channel.o \
-	mac.o \
-	baseband.o \
-	rxtx.o \
-	dpc.o \
-	power.o \
-	srom.o \
-	key.o \
-	rf.o
-
 obj-$(CONFIG_VT6655) +=	vt6655_stage.o
+
+vt6655_stage-y +=	device_main.o \
+			card.o \
+			channel.o \
+			mac.o \
+			baseband.o \
+			rxtx.o \
+			dpc.o \
+			power.o \
+			srom.o \
+			key.o \
+			rf.o
diff --git a/drivers/staging/vt6656/Makefile b/drivers/staging/vt6656/Makefile
index f696a9d7a143..aac323d6a684 100644
--- a/drivers/staging/vt6656/Makefile
+++ b/drivers/staging/vt6656/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_VT6656) +=	vt6656_stage.o
+
 vt6656_stage-y +=	main_usb.o \
 			card.o  \
 			mac.o   \
@@ -11,5 +13,3 @@ vt6656_stage-y +=	main_usb.o \
 			rf.o \
 			usbpipe.o \
 			channel.o
-
-obj-$(CONFIG_VT6656) +=	vt6656_stage.o
-- 
2.26.2

