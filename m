Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E1BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED55C20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHXQe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgHXQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:33:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28DA3AF8F;
        Mon, 24 Aug 2020 16:34:01 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] MIPS: Remove mach-*/war.h
Date:   Mon, 24 Aug 2020 18:32:54 +0200
Message-Id: <20200824163257.44533-13-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200824163257.44533-1-tsbogend@alpha.franken.de>
References: <20200824163257.44533-1-tsbogend@alpha.franken.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After conversion of all WAR defines we can now remove all mach-*/war.h
files.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/include/asm/mach-cavium-octeon/war.h | 12 ------------
 arch/mips/include/asm/mach-generic/war.h       | 11 -----------
 arch/mips/include/asm/mach-ip22/war.h          | 11 -----------
 arch/mips/include/asm/mach-ip27/war.h          | 11 -----------
 arch/mips/include/asm/mach-ip28/war.h          | 11 -----------
 arch/mips/include/asm/mach-ip30/war.h          |  8 --------
 arch/mips/include/asm/mach-ip32/war.h          | 11 -----------
 arch/mips/include/asm/mach-malta/war.h         | 11 -----------
 arch/mips/include/asm/mach-rc32434/war.h       | 11 -----------
 arch/mips/include/asm/mach-rm/war.h            | 11 -----------
 arch/mips/include/asm/mach-sibyte/war.h        | 11 -----------
 arch/mips/include/asm/mach-tx49xx/war.h        | 11 -----------
 arch/mips/include/asm/war.h                    |  2 --
 13 files changed, 132 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 delete mode 100644 arch/mips/include/asm/mach-generic/war.h
 delete mode 100644 arch/mips/include/asm/mach-ip22/war.h
 delete mode 100644 arch/mips/include/asm/mach-ip27/war.h
 delete mode 100644 arch/mips/include/asm/mach-ip28/war.h
 delete mode 100644 arch/mips/include/asm/mach-ip30/war.h
 delete mode 100644 arch/mips/include/asm/mach-ip32/war.h
 delete mode 100644 arch/mips/include/asm/mach-malta/war.h
 delete mode 100644 arch/mips/include/asm/mach-rc32434/war.h
 delete mode 100644 arch/mips/include/asm/mach-rm/war.h
 delete mode 100644 arch/mips/include/asm/mach-sibyte/war.h
 delete mode 100644 arch/mips/include/asm/mach-tx49xx/war.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
deleted file mode 100644
index ba6df0a186e9..000000000000
--- a/arch/mips/include/asm/mach-cavium-octeon/war.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- * Copyright (C) 2008 Cavium Networks <support@caviumnetworks.com>
- */
-#ifndef __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
-#define __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
-
-#endif /* __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H */
diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/include/asm/mach-generic/war.h
deleted file mode 100644
index 94796ad7e7de..000000000000
--- a/arch/mips/include/asm/mach-generic/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MACH_GENERIC_WAR_H
-#define __ASM_MACH_GENERIC_WAR_H
-
-#endif /* __ASM_MACH_GENERIC_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip22/war.h b/arch/mips/include/asm/mach-ip22/war.h
deleted file mode 100644
index 12cf05dd46d3..000000000000
--- a/arch/mips/include/asm/mach-ip22/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_IP22_WAR_H
-#define __ASM_MIPS_MACH_IP22_WAR_H
-
-#endif /* __ASM_MIPS_MACH_IP22_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip27/war.h b/arch/mips/include/asm/mach-ip27/war.h
deleted file mode 100644
index 0852fe64594d..000000000000
--- a/arch/mips/include/asm/mach-ip27/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_IP27_WAR_H
-#define __ASM_MIPS_MACH_IP27_WAR_H
-
-#endif /* __ASM_MIPS_MACH_IP27_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip28/war.h b/arch/mips/include/asm/mach-ip28/war.h
deleted file mode 100644
index 32796925700a..000000000000
--- a/arch/mips/include/asm/mach-ip28/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_IP28_WAR_H
-#define __ASM_MIPS_MACH_IP28_WAR_H
-
-#endif /* __ASM_MIPS_MACH_IP28_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip30/war.h b/arch/mips/include/asm/mach-ip30/war.h
deleted file mode 100644
index ea77545f5128..000000000000
--- a/arch/mips/include/asm/mach-ip30/war.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_IP30_WAR_H
-#define __ASM_MIPS_MACH_IP30_WAR_H
-
-#endif /* __ASM_MIPS_MACH_IP30_WAR_H */
diff --git a/arch/mips/include/asm/mach-ip32/war.h b/arch/mips/include/asm/mach-ip32/war.h
deleted file mode 100644
index 3e81408795b4..000000000000
--- a/arch/mips/include/asm/mach-ip32/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_IP32_WAR_H
-#define __ASM_MIPS_MACH_IP32_WAR_H
-
-#endif /* __ASM_MIPS_MACH_IP32_WAR_H */
diff --git a/arch/mips/include/asm/mach-malta/war.h b/arch/mips/include/asm/mach-malta/war.h
deleted file mode 100644
index 0f5401c0e888..000000000000
--- a/arch/mips/include/asm/mach-malta/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
-#define __ASM_MIPS_MACH_MIPS_WAR_H
-
-#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/include/asm/mach-rc32434/war.h b/arch/mips/include/asm/mach-rc32434/war.h
deleted file mode 100644
index 0f5401c0e888..000000000000
--- a/arch/mips/include/asm/mach-rc32434/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
-#define __ASM_MIPS_MACH_MIPS_WAR_H
-
-#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/include/asm/mach-rm/war.h b/arch/mips/include/asm/mach-rm/war.h
deleted file mode 100644
index 723c9de79ea1..000000000000
--- a/arch/mips/include/asm/mach-rm/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_RM_WAR_H
-#define __ASM_MIPS_MACH_RM_WAR_H
-
-#endif /* __ASM_MIPS_MACH_RM_WAR_H */
diff --git a/arch/mips/include/asm/mach-sibyte/war.h b/arch/mips/include/asm/mach-sibyte/war.h
deleted file mode 100644
index 157eca1be328..000000000000
--- a/arch/mips/include/asm/mach-sibyte/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_SIBYTE_WAR_H
-#define __ASM_MIPS_MACH_SIBYTE_WAR_H
-
-#endif /* __ASM_MIPS_MACH_SIBYTE_WAR_H */
diff --git a/arch/mips/include/asm/mach-tx49xx/war.h b/arch/mips/include/asm/mach-tx49xx/war.h
deleted file mode 100644
index edf50e2bbb34..000000000000
--- a/arch/mips/include/asm/mach-tx49xx/war.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
- */
-#ifndef __ASM_MIPS_MACH_TX49XX_WAR_H
-#define __ASM_MIPS_MACH_TX49XX_WAR_H
-
-#endif /* __ASM_MIPS_MACH_TX49XX_WAR_H */
diff --git a/arch/mips/include/asm/war.h b/arch/mips/include/asm/war.h
index c20c04855089..21443f096238 100644
--- a/arch/mips/include/asm/war.h
+++ b/arch/mips/include/asm/war.h
@@ -9,8 +9,6 @@
 #ifndef _ASM_WAR_H
 #define _ASM_WAR_H
 
-#include <war.h>
-
 /*
  * Work around certain R4000 CPU errata (as implemented by GCC):
  *
-- 
2.16.4

