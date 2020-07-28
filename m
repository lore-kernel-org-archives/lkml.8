Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610162070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgG1VMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:12:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:44928 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1VMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:12:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 2DEB5A1FE;
        Tue, 28 Jul 2020 23:12:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ogk38lsRAjjo; Tue, 28 Jul 2020 23:12:17 +0200 (CEST)
Received: from function.home (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 2B96CA1EC;
        Tue, 28 Jul 2020 23:12:17 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k0WtT-002tps-Hr; Tue, 28 Jul 2020 23:12:15 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org
Subject: [PATCH] staging/speakup: Move out of staging
Date:   Tue, 28 Jul 2020 23:12:08 +0200
Message-Id: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nasty TODO items are done.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 .../ABI/stable}/sysfs-driver-speakup          |  0
 .../admin-guide}/spkguide.txt                 |  0
 MAINTAINERS                                   | 19 +++++++++----------
 drivers/accessibility/Kconfig                 |  2 ++
 drivers/accessibility/Makefile                |  1 +
 .../speakup/DefaultKeyAssignments             |  0
 .../speakup/Kconfig                           |  0
 .../speakup/Makefile                          |  0
 .../{staging => accessibility}/speakup/TODO   |  0
 .../speakup/buffers.c                         |  0
 .../speakup/devsynth.c                        |  0
 .../speakup/fakekey.c                         |  0
 .../{staging => accessibility}/speakup/i18n.c |  0
 .../{staging => accessibility}/speakup/i18n.h |  0
 .../speakup/keyhelp.c                         |  0
 .../speakup/kobjects.c                        |  0
 .../{staging => accessibility}/speakup/main.c |  0
 .../speakup/selection.c                       |  0
 .../speakup/serialio.c                        |  0
 .../speakup/serialio.h                        |  0
 .../speakup/speakup.h                         |  0
 .../speakup/speakup_acnt.h                    |  0
 .../speakup/speakup_acntpc.c                  |  0
 .../speakup/speakup_acntsa.c                  |  0
 .../speakup/speakup_apollo.c                  |  0
 .../speakup/speakup_audptr.c                  |  0
 .../speakup/speakup_bns.c                     |  0
 .../speakup/speakup_decext.c                  |  0
 .../speakup/speakup_decpc.c                   |  0
 .../speakup/speakup_dectlk.c                  |  0
 .../speakup/speakup_dtlk.c                    |  0
 .../speakup/speakup_dtlk.h                    |  0
 .../speakup/speakup_dummy.c                   |  0
 .../speakup/speakup_keypc.c                   |  0
 .../speakup/speakup_ltlk.c                    |  0
 .../speakup/speakup_soft.c                    |  0
 .../speakup/speakup_spkout.c                  |  0
 .../speakup/speakup_txprt.c                   |  0
 .../speakup/speakupmap.h                      |  0
 .../speakup/speakupmap.map                    |  0
 .../speakup/spk_priv.h                        |  0
 .../speakup/spk_priv_keyinfo.h                |  0
 .../speakup/spk_ttyio.c                       |  0
 .../speakup/spk_types.h                       |  0
 .../speakup/synth.c                           |  0
 .../speakup/thread.c                          |  0
 .../speakup/varhandlers.c                     |  0
 drivers/staging/Kconfig                       |  2 --
 drivers/staging/Makefile                      |  1 -
 49 files changed, 12 insertions(+), 13 deletions(-)
 rename {drivers/staging/speakup => Documentation/ABI/stable}/sysfs-driver-speakup (100%)
 rename {drivers/staging/speakup => Documentation/admin-guide}/spkguide.txt (100%)
 rename drivers/{staging => accessibility}/speakup/DefaultKeyAssignments (100%)
 rename drivers/{staging => accessibility}/speakup/Kconfig (100%)
 rename drivers/{staging => accessibility}/speakup/Makefile (100%)
 rename drivers/{staging => accessibility}/speakup/TODO (100%)
 rename drivers/{staging => accessibility}/speakup/buffers.c (100%)
 rename drivers/{staging => accessibility}/speakup/devsynth.c (100%)
 rename drivers/{staging => accessibility}/speakup/fakekey.c (100%)
 rename drivers/{staging => accessibility}/speakup/i18n.c (100%)
 rename drivers/{staging => accessibility}/speakup/i18n.h (100%)
 rename drivers/{staging => accessibility}/speakup/keyhelp.c (100%)
 rename drivers/{staging => accessibility}/speakup/kobjects.c (100%)
 rename drivers/{staging => accessibility}/speakup/main.c (100%)
 rename drivers/{staging => accessibility}/speakup/selection.c (100%)
 rename drivers/{staging => accessibility}/speakup/serialio.c (100%)
 rename drivers/{staging => accessibility}/speakup/serialio.h (100%)
 rename drivers/{staging => accessibility}/speakup/speakup.h (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_acnt.h (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_acntpc.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_acntsa.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_apollo.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_audptr.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_bns.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_decext.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_decpc.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_dectlk.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_dtlk.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_dtlk.h (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_dummy.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_keypc.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_ltlk.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_soft.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_spkout.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakup_txprt.c (100%)
 rename drivers/{staging => accessibility}/speakup/speakupmap.h (100%)
 rename drivers/{staging => accessibility}/speakup/speakupmap.map (100%)
 rename drivers/{staging => accessibility}/speakup/spk_priv.h (100%)
 rename drivers/{staging => accessibility}/speakup/spk_priv_keyinfo.h (100%)
 rename drivers/{staging => accessibility}/speakup/spk_ttyio.c (100%)
 rename drivers/{staging => accessibility}/speakup/spk_types.h (100%)
 rename drivers/{staging => accessibility}/speakup/synth.c (100%)
 rename drivers/{staging => accessibility}/speakup/thread.c (100%)
 rename drivers/{staging => accessibility}/speakup/varhandlers.c (100%)

diff --git a/drivers/staging/speakup/sysfs-driver-speakup b/Documentation/ABI/stable/sysfs-driver-speakup
similarity index 100%
rename from drivers/staging/speakup/sysfs-driver-speakup
rename to Documentation/ABI/stable/sysfs-driver-speakup
diff --git a/drivers/staging/speakup/spkguide.txt b/Documentation/admin-guide/spkguide.txt
similarity index 100%
rename from drivers/staging/speakup/spkguide.txt
rename to Documentation/admin-guide/spkguide.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..5161e8e5e277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16077,6 +16077,15 @@ Q:	https://patchwork.kernel.org/project/linux-sparse/list/
 B:	https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools
 F:	include/linux/compiler.h
 
+SPEAKUP CONSOLE SPEECH DRIVER
+M:	William Hubbs <w.d.hubbs@gmail.com>
+M:	Chris Brannon <chris@the-brannons.com>
+M:	Kirk Reiser <kirk@reisers.ca>
+M:	Samuel Thibault <samuel.thibault@ens-lyon.org>
+L:	speakup@linux-speakup.org
+W:	http://www.linux-speakup.org/
+F:	drivers/accessibility/speakup/
+
 SPEAR CLOCK FRAMEWORK SUPPORT
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -16264,16 +16273,6 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/sm750fb/
 
-STAGING - SPEAKUP CONSOLE SPEECH DRIVER
-M:	William Hubbs <w.d.hubbs@gmail.com>
-M:	Chris Brannon <chris@the-brannons.com>
-M:	Kirk Reiser <kirk@reisers.ca>
-M:	Samuel Thibault <samuel.thibault@ens-lyon.org>
-L:	speakup@linux-speakup.org
-S:	Odd Fixes
-W:	http://www.linux-speakup.org/
-F:	drivers/staging/speakup/
-
 STAGING - VIA VT665X DRIVERS
 M:	Forest Bond <forest@alittletooquiet.net>
 S:	Odd Fixes
diff --git a/drivers/accessibility/Kconfig b/drivers/accessibility/Kconfig
index f10c17dc1dee..6b2f79d1f1b8 100644
--- a/drivers/accessibility/Kconfig
+++ b/drivers/accessibility/Kconfig
@@ -31,4 +31,6 @@ config A11Y_BRAILLE_CONSOLE
 
 	  If unsure, say N.
 
+source "drivers/accessibility/speakup/Kconfig"
+
 endif # ACCESSIBILITY
diff --git a/drivers/accessibility/Makefile b/drivers/accessibility/Makefile
index e8c182f82c44..833603086530 100644
--- a/drivers/accessibility/Makefile
+++ b/drivers/accessibility/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y				+= braille/
+obj-$(CONFIG_SPEAKUP)		+= speakup/
diff --git a/drivers/staging/speakup/DefaultKeyAssignments b/drivers/accessibility/speakup/DefaultKeyAssignments
similarity index 100%
rename from drivers/staging/speakup/DefaultKeyAssignments
rename to drivers/accessibility/speakup/DefaultKeyAssignments
diff --git a/drivers/staging/speakup/Kconfig b/drivers/accessibility/speakup/Kconfig
similarity index 100%
rename from drivers/staging/speakup/Kconfig
rename to drivers/accessibility/speakup/Kconfig
diff --git a/drivers/staging/speakup/Makefile b/drivers/accessibility/speakup/Makefile
similarity index 100%
rename from drivers/staging/speakup/Makefile
rename to drivers/accessibility/speakup/Makefile
diff --git a/drivers/staging/speakup/TODO b/drivers/accessibility/speakup/TODO
similarity index 100%
rename from drivers/staging/speakup/TODO
rename to drivers/accessibility/speakup/TODO
diff --git a/drivers/staging/speakup/buffers.c b/drivers/accessibility/speakup/buffers.c
similarity index 100%
rename from drivers/staging/speakup/buffers.c
rename to drivers/accessibility/speakup/buffers.c
diff --git a/drivers/staging/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
similarity index 100%
rename from drivers/staging/speakup/devsynth.c
rename to drivers/accessibility/speakup/devsynth.c
diff --git a/drivers/staging/speakup/fakekey.c b/drivers/accessibility/speakup/fakekey.c
similarity index 100%
rename from drivers/staging/speakup/fakekey.c
rename to drivers/accessibility/speakup/fakekey.c
diff --git a/drivers/staging/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
similarity index 100%
rename from drivers/staging/speakup/i18n.c
rename to drivers/accessibility/speakup/i18n.c
diff --git a/drivers/staging/speakup/i18n.h b/drivers/accessibility/speakup/i18n.h
similarity index 100%
rename from drivers/staging/speakup/i18n.h
rename to drivers/accessibility/speakup/i18n.h
diff --git a/drivers/staging/speakup/keyhelp.c b/drivers/accessibility/speakup/keyhelp.c
similarity index 100%
rename from drivers/staging/speakup/keyhelp.c
rename to drivers/accessibility/speakup/keyhelp.c
diff --git a/drivers/staging/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
similarity index 100%
rename from drivers/staging/speakup/kobjects.c
rename to drivers/accessibility/speakup/kobjects.c
diff --git a/drivers/staging/speakup/main.c b/drivers/accessibility/speakup/main.c
similarity index 100%
rename from drivers/staging/speakup/main.c
rename to drivers/accessibility/speakup/main.c
diff --git a/drivers/staging/speakup/selection.c b/drivers/accessibility/speakup/selection.c
similarity index 100%
rename from drivers/staging/speakup/selection.c
rename to drivers/accessibility/speakup/selection.c
diff --git a/drivers/staging/speakup/serialio.c b/drivers/accessibility/speakup/serialio.c
similarity index 100%
rename from drivers/staging/speakup/serialio.c
rename to drivers/accessibility/speakup/serialio.c
diff --git a/drivers/staging/speakup/serialio.h b/drivers/accessibility/speakup/serialio.h
similarity index 100%
rename from drivers/staging/speakup/serialio.h
rename to drivers/accessibility/speakup/serialio.h
diff --git a/drivers/staging/speakup/speakup.h b/drivers/accessibility/speakup/speakup.h
similarity index 100%
rename from drivers/staging/speakup/speakup.h
rename to drivers/accessibility/speakup/speakup.h
diff --git a/drivers/staging/speakup/speakup_acnt.h b/drivers/accessibility/speakup/speakup_acnt.h
similarity index 100%
rename from drivers/staging/speakup/speakup_acnt.h
rename to drivers/accessibility/speakup/speakup_acnt.h
diff --git a/drivers/staging/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
similarity index 100%
rename from drivers/staging/speakup/speakup_acntpc.c
rename to drivers/accessibility/speakup/speakup_acntpc.c
diff --git a/drivers/staging/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
similarity index 100%
rename from drivers/staging/speakup/speakup_acntsa.c
rename to drivers/accessibility/speakup/speakup_acntsa.c
diff --git a/drivers/staging/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
similarity index 100%
rename from drivers/staging/speakup/speakup_apollo.c
rename to drivers/accessibility/speakup/speakup_apollo.c
diff --git a/drivers/staging/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
similarity index 100%
rename from drivers/staging/speakup/speakup_audptr.c
rename to drivers/accessibility/speakup/speakup_audptr.c
diff --git a/drivers/staging/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
similarity index 100%
rename from drivers/staging/speakup/speakup_bns.c
rename to drivers/accessibility/speakup/speakup_bns.c
diff --git a/drivers/staging/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
similarity index 100%
rename from drivers/staging/speakup/speakup_decext.c
rename to drivers/accessibility/speakup/speakup_decext.c
diff --git a/drivers/staging/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
similarity index 100%
rename from drivers/staging/speakup/speakup_decpc.c
rename to drivers/accessibility/speakup/speakup_decpc.c
diff --git a/drivers/staging/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
similarity index 100%
rename from drivers/staging/speakup/speakup_dectlk.c
rename to drivers/accessibility/speakup/speakup_dectlk.c
diff --git a/drivers/staging/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
similarity index 100%
rename from drivers/staging/speakup/speakup_dtlk.c
rename to drivers/accessibility/speakup/speakup_dtlk.c
diff --git a/drivers/staging/speakup/speakup_dtlk.h b/drivers/accessibility/speakup/speakup_dtlk.h
similarity index 100%
rename from drivers/staging/speakup/speakup_dtlk.h
rename to drivers/accessibility/speakup/speakup_dtlk.h
diff --git a/drivers/staging/speakup/speakup_dummy.c b/drivers/accessibility/speakup/speakup_dummy.c
similarity index 100%
rename from drivers/staging/speakup/speakup_dummy.c
rename to drivers/accessibility/speakup/speakup_dummy.c
diff --git a/drivers/staging/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
similarity index 100%
rename from drivers/staging/speakup/speakup_keypc.c
rename to drivers/accessibility/speakup/speakup_keypc.c
diff --git a/drivers/staging/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
similarity index 100%
rename from drivers/staging/speakup/speakup_ltlk.c
rename to drivers/accessibility/speakup/speakup_ltlk.c
diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
similarity index 100%
rename from drivers/staging/speakup/speakup_soft.c
rename to drivers/accessibility/speakup/speakup_soft.c
diff --git a/drivers/staging/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
similarity index 100%
rename from drivers/staging/speakup/speakup_spkout.c
rename to drivers/accessibility/speakup/speakup_spkout.c
diff --git a/drivers/staging/speakup/speakup_txprt.c b/drivers/accessibility/speakup/speakup_txprt.c
similarity index 100%
rename from drivers/staging/speakup/speakup_txprt.c
rename to drivers/accessibility/speakup/speakup_txprt.c
diff --git a/drivers/staging/speakup/speakupmap.h b/drivers/accessibility/speakup/speakupmap.h
similarity index 100%
rename from drivers/staging/speakup/speakupmap.h
rename to drivers/accessibility/speakup/speakupmap.h
diff --git a/drivers/staging/speakup/speakupmap.map b/drivers/accessibility/speakup/speakupmap.map
similarity index 100%
rename from drivers/staging/speakup/speakupmap.map
rename to drivers/accessibility/speakup/speakupmap.map
diff --git a/drivers/staging/speakup/spk_priv.h b/drivers/accessibility/speakup/spk_priv.h
similarity index 100%
rename from drivers/staging/speakup/spk_priv.h
rename to drivers/accessibility/speakup/spk_priv.h
diff --git a/drivers/staging/speakup/spk_priv_keyinfo.h b/drivers/accessibility/speakup/spk_priv_keyinfo.h
similarity index 100%
rename from drivers/staging/speakup/spk_priv_keyinfo.h
rename to drivers/accessibility/speakup/spk_priv_keyinfo.h
diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
similarity index 100%
rename from drivers/staging/speakup/spk_ttyio.c
rename to drivers/accessibility/speakup/spk_ttyio.c
diff --git a/drivers/staging/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
similarity index 100%
rename from drivers/staging/speakup/spk_types.h
rename to drivers/accessibility/speakup/spk_types.h
diff --git a/drivers/staging/speakup/synth.c b/drivers/accessibility/speakup/synth.c
similarity index 100%
rename from drivers/staging/speakup/synth.c
rename to drivers/accessibility/speakup/synth.c
diff --git a/drivers/staging/speakup/thread.c b/drivers/accessibility/speakup/thread.c
similarity index 100%
rename from drivers/staging/speakup/thread.c
rename to drivers/accessibility/speakup/thread.c
diff --git a/drivers/staging/speakup/varhandlers.c b/drivers/accessibility/speakup/varhandlers.c
similarity index 100%
rename from drivers/staging/speakup/varhandlers.c
rename to drivers/accessibility/speakup/varhandlers.c
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 4ec5528f89fa..29375013be53 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -56,8 +56,6 @@ source "drivers/staging/sm750fb/Kconfig"
 
 source "drivers/staging/emxx_udc/Kconfig"
 
-source "drivers/staging/speakup/Kconfig"
-
 source "drivers/staging/nvec/Kconfig"
 
 source "drivers/staging/media/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4d34198151b3..fe35e283f7be 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IIO)		+= iio/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
-obj-$(CONFIG_SPEAKUP)		+= speakup/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_STAGING_BOARD)	+= board/
-- 
2.27.0

