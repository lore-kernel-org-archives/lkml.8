Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F69C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B482054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="KQtAzF8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbgEMTP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:15:58 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:54582 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:15:57 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id D87FB18CA; Wed, 13 May 2020 21:15:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz D87FB18CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589397353;
        bh=lauLfYuhKgqMV/K/CT1WEOxuKL5htIQBOBQSFXp9cGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQtAzF8lmAuT+aZCguzTnfUX6RuMPzoNDLsLPpTrZRfTjEJ2SXh0Y8trOFK3JxiVX
         cteu7NRv3Sn39SBa7aHd3MAS5UPP/TZA7AK3xJDn0oQgxP0nfyfeChrfWJmIe9ffQs
         U72xBlSFIsI1Mm3Yw/abKOy6539K0cdQO1bDFZmQ=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v3 1/2] staging: vt6656: vt6655: removing unused macros definition Makefiles
Date:   Wed, 13 May 2020 21:15:50 +0200
Message-Id: <1589397351-24655-2-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
References: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is removing definition of CFLAGS in Makefile of vt6656 and
vt6655, as those are defining macros that are not used. This will remove
undef of one macro from vt6655/device_main.c, as it is only undef and it is
not used anywhere else, so it is safe to remove it.

Macros are removed from vt665x/Makefile and vt6655/device_main.c.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
v1: Initial patch
v2: This patch was split from original bigger patch
v3: Added more info about what and why it's removed

 drivers/staging/vt6655/Makefile      | 3 ---
 drivers/staging/vt6655/device_main.c | 1 -
 drivers/staging/vt6656/Makefile      | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/vt6655/Makefile b/drivers/staging/vt6655/Makefile
index a151f30fc46f..e70357ec0af8 100644
--- a/drivers/staging/vt6655/Makefile
+++ b/drivers/staging/vt6655/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# TODO: all of these should be removed
-ccflags-y := -DLINUX -D__KERNEL__ -D__NO_VERSION__
-ccflags-y += -DHOSTAP
 
 vt6655_stage-y +=	device_main.o \
 	card.o \
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 5889023d19c4..41cbec4134b0 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -32,7 +32,6 @@
  *
  * Revision History:
  */
-#undef __NO_VERSION__
 
 #include <linux/file.h>
 #include "device.h"
diff --git a/drivers/staging/vt6656/Makefile b/drivers/staging/vt6656/Makefile
index a0f3862dea75..f696a9d7a143 100644
--- a/drivers/staging/vt6656/Makefile
+++ b/drivers/staging/vt6656/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# TODO: all of these should be removed
-ccflags-y := -DLINUX -D__KERNEL__ -DEXPORT_SYMTAB -D__NO_VERSION__
-ccflags-y += -DHOSTAP
 
 vt6656_stage-y +=	main_usb.o \
 			card.o  \
-- 
2.26.2

