Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA88206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgENLMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:12:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgENLMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:12:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 54691B04F;
        Thu, 14 May 2020 11:12:44 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix builds for VR41xx platforms
Date:   Thu, 14 May 2020 13:12:34 +0200
Message-Id: <20200514111235.58459-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing inclusion of Platform files, broke VR41xx platforms. Add Makefile
to vr41xx directory and traverse subdirs from it.

Fixes: 26bff9eb49201aeb ("MIPS: Only include the platformfile needed")
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/vr41xx/Makefile | 5 +++++
 arch/mips/vr41xx/Platform | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/vr41xx/Makefile

diff --git a/arch/mips/vr41xx/Makefile b/arch/mips/vr41xx/Makefile
new file mode 100644
index 000000000000..765020d5ee4d
--- /dev/null
+++ b/arch/mips/vr41xx/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+obj-$(CONFIG_MACH_VR41XX)	+= common/
+obj-$(CONFIG_CASIO_E55)		+= casio-e55/
+obj-$(CONFIG_IBM_WORKPAD)	+= ibm-workpad/
diff --git a/arch/mips/vr41xx/Platform b/arch/mips/vr41xx/Platform
index b6c8d5c08ddb..3f593a3e5678 100644
--- a/arch/mips/vr41xx/Platform
+++ b/arch/mips/vr41xx/Platform
@@ -1,19 +1,16 @@
 #
 # NEC VR4100 series based machines
 #
-platform-$(CONFIG_MACH_VR41XX)	+= vr41xx/common/
 cflags-$(CONFIG_MACH_VR41XX)	+= -I$(srctree)/arch/mips/include/asm/mach-vr41xx
 
 #
 # CASIO CASSIPEIA E-55/65 (VR4111)
 #
-platform-$(CONFIG_CASIO_E55)	+= vr41xx/casio-e55/
 load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
 # IBM WorkPad z50 (VR4121)
 #
-platform-$(CONFIG_IBM_WORKPAD)	+= vr41xx/ibm-workpad/
 load-$(CONFIG_IBM_WORKPAD)	+= 0xffffffff80004000
 
 #
-- 
2.16.4

