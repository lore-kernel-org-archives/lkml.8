Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F09C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75342168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ueo2AcFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgBLI6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33882 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgBLI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so1203355wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZRLSesB0xOqNiT2wese5rppqLsHQLeDQYOMk2bXckA=;
        b=ueo2AcFimeMTFiPP3IbZl0TPnlPBF005FPKd5IYKGKRzmY+8/rQYaS3iDjFhVPB+Xj
         QMsE4jnYFrfZPtOgYlsCXHLtK4Aah/N5fWxw8mmPXTgR7Apm8OgfqTda1VExGej06uRU
         BU8MMQY4LiRPGHIyyyjmiRVxnoNo1bGWLfq8Qv940v3uif6T8Z+F1iNi2knj0lOB+gEr
         sswMgInBGa1u/n+Owf0K503+H5BLkvR3LsCWidcfqKo8ODkpMlK02mkNQJGN81D3zllT
         pCO13563a1BdBpfPi0+wBzAgJZ4uwRAmJZUO+Dz7qDxG8NNAgq42pHKNDNZ0qzGZYbEr
         g3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/ZRLSesB0xOqNiT2wese5rppqLsHQLeDQYOMk2bXckA=;
        b=nd9qiVEUpMG8HIiNdM7s+H35VpK4VHcn632Hc9j89VGGOinK8BRfKxnUeB0H9dlslg
         K1wgg10BGnM1xIzw9KtQ7sFPGF224Nqc2k1Y5ymHIig6wyA9kkIf7DNxwm6ASis+bztW
         MzYUoNLXzDIy2TqATd89IFhnfjcOzo7WtXOp3KvUNNCyPEG7TzamHZWn3P5qkZQ2htxt
         yiQHZ0nRUKl4EU4+FvuSGaDZUt8CChh6Na5Td4SoKcYLR+ONr5MmZEZdV9YsqgimLTYJ
         B98YPqnzDQga0oQ/zgN2HgLbid8NAmAm5Xe1HzPrMGVxUXnVdxQ/utXFcKt+zfLxqT3v
         tHXQ==
X-Gm-Message-State: APjAAAV/ory31irp2SeY0ihd3an5PbTX36MD7wtTHP5gSQGu4EisLklg
        j55QN7AC6+qUmhPZbUu0yFr/gUh5uFUu9Q==
X-Google-Smtp-Source: APXvYqxAgvg4FcIxber9sCFZngzdtoRgMpXUpIofiVmmIZpeoBvSy0NFJY8WCEGKLzq9hq35sBE1ug==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr13766704wro.310.1581497890874;
        Wed, 12 Feb 2020 00:58:10 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h18sm9035992wrv.78.2020.02.12.00.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:10 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 01/10] microblaze: Convert headers to SPDX license
Date:   Wed, 12 Feb 2020 09:57:58 +0100
Message-Id: <6e347b2b75337b410561d671acd569ee37d3493e.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert all headers to SPDX.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/cache.h          | 5 +----
 arch/microblaze/include/asm/cacheflush.h     | 6 +-----
 arch/microblaze/include/asm/checksum.h       | 5 +----
 arch/microblaze/include/asm/cpuinfo.h        | 5 +----
 arch/microblaze/include/asm/current.h        | 5 +----
 arch/microblaze/include/asm/delay.h          | 7 +------
 arch/microblaze/include/asm/dma.h            | 5 +----
 arch/microblaze/include/asm/elf.h            | 5 +----
 arch/microblaze/include/asm/entry.h          | 5 +----
 arch/microblaze/include/asm/exceptions.h     | 5 +----
 arch/microblaze/include/asm/fixmap.h         | 5 +----
 arch/microblaze/include/asm/flat.h           | 5 +----
 arch/microblaze/include/asm/io.h             | 5 +----
 arch/microblaze/include/asm/irq.h            | 5 +----
 arch/microblaze/include/asm/irqflags.h       | 5 +----
 arch/microblaze/include/asm/mmu.h            | 5 +----
 arch/microblaze/include/asm/mmu_context_mm.h | 5 +----
 arch/microblaze/include/asm/module.h         | 5 +----
 arch/microblaze/include/asm/page.h           | 5 +----
 arch/microblaze/include/asm/pgalloc.h        | 5 +----
 arch/microblaze/include/asm/pgtable.h        | 5 +----
 arch/microblaze/include/asm/processor.h      | 5 +----
 arch/microblaze/include/asm/ptrace.h         | 5 +----
 arch/microblaze/include/asm/pvr.h            | 5 +----
 arch/microblaze/include/asm/registers.h      | 5 +----
 arch/microblaze/include/asm/sections.h       | 5 +----
 arch/microblaze/include/asm/setup.h          | 5 +----
 arch/microblaze/include/asm/string.h         | 5 +----
 arch/microblaze/include/asm/switch_to.h      | 5 +----
 arch/microblaze/include/asm/thread_info.h    | 5 +----
 arch/microblaze/include/asm/timex.h          | 5 +----
 arch/microblaze/include/asm/tlbflush.h       | 5 +----
 arch/microblaze/include/asm/uaccess.h        | 5 +----
 arch/microblaze/include/asm/unaligned.h      | 5 +----
 arch/microblaze/include/asm/unistd.h         | 5 +----
 arch/microblaze/include/asm/unwind.h         | 5 +----
 36 files changed, 36 insertions(+), 147 deletions(-)

diff --git a/arch/microblaze/include/asm/cache.h b/arch/microblaze/include/asm/cache.h
index 4efe96a036f7..a149b3e711ec 100644
--- a/arch/microblaze/include/asm/cache.h
+++ b/arch/microblaze/include/asm/cache.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Cache operations
  *
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2003 John Williams <jwilliams@itee.uq.edu.au>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_CACHE_H
diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index b091de77b15b..11f56c85056b 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
@@ -5,11 +6,6 @@
  * based on v850 version which was
  * Copyright (C) 2001,02,03 NEC Electronics Corporation
  * Copyright (C) 2001,02,03 Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
- *
  */
 
 #ifndef _ASM_MICROBLAZE_CACHEFLUSH_H
diff --git a/arch/microblaze/include/asm/checksum.h b/arch/microblaze/include/asm/checksum.h
index adeecebbb0d1..2e5ebd599943 100644
--- a/arch/microblaze/include/asm/checksum.h
+++ b/arch/microblaze/include/asm/checksum.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_CHECKSUM_H
diff --git a/arch/microblaze/include/asm/cpuinfo.h b/arch/microblaze/include/asm/cpuinfo.h
index 8f4996730552..786ffa669bf1 100644
--- a/arch/microblaze/include/asm/cpuinfo.h
+++ b/arch/microblaze/include/asm/cpuinfo.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Generic support for queying CPU info
  *
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2007 John Williams <jwilliams@itee.uq.edu.au>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_CPUINFO_H
diff --git a/arch/microblaze/include/asm/current.h b/arch/microblaze/include/asm/current.h
index 29303ed825cc..a4bb45be30e6 100644
--- a/arch/microblaze/include/asm/current.h
+++ b/arch/microblaze/include/asm/current.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_CURRENT_H
diff --git a/arch/microblaze/include/asm/delay.h b/arch/microblaze/include/asm/delay.h
index ea2a9cd9b159..05fe9e3e0039 100644
--- a/arch/microblaze/include/asm/delay.h
+++ b/arch/microblaze/include/asm/delay.h
@@ -1,10 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * include/asm-microblaze/delay.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2008 Michal Simek
  * Copyright (C) 2007 John Williams
  * Copyright (C) 2006 Atmark Techno, Inc.
diff --git a/arch/microblaze/include/asm/dma.h b/arch/microblaze/include/asm/dma.h
index 0d73d0c6de37..e6cb6d0725af 100644
--- a/arch/microblaze/include/asm/dma.h
+++ b/arch/microblaze/include/asm/dma.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_DMA_H
diff --git a/arch/microblaze/include/asm/elf.h b/arch/microblaze/include/asm/elf.h
index 659024449064..5331a8473a46 100644
--- a/arch/microblaze/include/asm/elf.h
+++ b/arch/microblaze/include/asm/elf.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef _ASM_MICROBLAZE_ELF_H
 #define _ASM_MICROBLAZE_ELF_H
diff --git a/arch/microblaze/include/asm/entry.h b/arch/microblaze/include/asm/entry.h
index 596e485ae707..6c42bed41166 100644
--- a/arch/microblaze/include/asm/entry.h
+++ b/arch/microblaze/include/asm/entry.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Definitions used by low-level trap handlers
  *
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_ENTRY_H
diff --git a/arch/microblaze/include/asm/exceptions.h b/arch/microblaze/include/asm/exceptions.h
index e6a8ddea1dca..d67e65b72215 100644
--- a/arch/microblaze/include/asm/exceptions.h
+++ b/arch/microblaze/include/asm/exceptions.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Preliminary support for HW exception handing for Microblaze
  *
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2005 John Williams <jwilliams@itee.uq.edu.au>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_EXCEPTIONS_H
diff --git a/arch/microblaze/include/asm/fixmap.h b/arch/microblaze/include/asm/fixmap.h
index 06c0e2b1883f..0379ce5229e3 100644
--- a/arch/microblaze/include/asm/fixmap.h
+++ b/arch/microblaze/include/asm/fixmap.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fixmap.h: compile-time virtual memory allocation
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 1998 Ingo Molnar
  *
  * Copyright 2008 Freescale Semiconductor Inc.
diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
index 1ab86770eaee..79a749f4ad04 100644
--- a/arch/microblaze/include/asm/flat.h
+++ b/arch/microblaze/include/asm/flat.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * uClinux flat-format executables
  *
  * Copyright (C) 2005 John Williams <jwilliams@itee.uq.edu.au>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_FLAT_H
diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index d33c61737b8b..1dd6fae41897 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_IO_H
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index 5166f0893e2b..cb6ab55d1d01 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_IRQ_H
diff --git a/arch/microblaze/include/asm/irqflags.h b/arch/microblaze/include/asm/irqflags.h
index c9a6262832c4..818c6c9f550d 100644
--- a/arch/microblaze/include/asm/irqflags.h
+++ b/arch/microblaze/include/asm/irqflags.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_IRQFLAGS_H
diff --git a/arch/microblaze/include/asm/mmu.h b/arch/microblaze/include/asm/mmu.h
index 1f9edddf7f4b..97f1243101cc 100644
--- a/arch/microblaze/include/asm/mmu.h
+++ b/arch/microblaze/include/asm/mmu.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_MMU_H
diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index 97559fe0b953..a1c7dd48454c 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_MMU_CONTEXT_H
diff --git a/arch/microblaze/include/asm/module.h b/arch/microblaze/include/asm/module.h
index 7be1347fce42..eda1c183b6c7 100644
--- a/arch/microblaze/include/asm/module.h
+++ b/arch/microblaze/include/asm/module.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_MODULE_H
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index f4b44b24b02e..ae7215c94706 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * VM ops
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2006 Atmark Techno, Inc.
  * Changes for MMU support:
  *    Copyright (C) 2007 Xilinx, Inc.  All rights reserved.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_PAGE_H
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index fcf1e23f2e0a..1d7a91252d03 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_PGALLOC_H
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 2def331f9e2c..45b30878fc17 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_PGTABLE_H
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 66b537b8d138..1ff5a82b76b6 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_PROCESSOR_H
diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/include/asm/ptrace.h
index 5b18ec124e51..bfcb89df5e26 100644
--- a/arch/microblaze/include/asm/ptrace.h
+++ b/arch/microblaze/include/asm/ptrace.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef _ASM_MICROBLAZE_PTRACE_H
 #define _ASM_MICROBLAZE_PTRACE_H
diff --git a/arch/microblaze/include/asm/pvr.h b/arch/microblaze/include/asm/pvr.h
index 4bbdb4c03b57..186ee8c3c818 100644
--- a/arch/microblaze/include/asm/pvr.h
+++ b/arch/microblaze/include/asm/pvr.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Support for the MicroBlaze PVR (Processor Version Register)
  *
  * Copyright (C) 2009 - 2011 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
  * Copyright (C) 2007 - 2011 PetaLogix
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file COPYING in the main directory of this
- * archive for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_PVR_H
diff --git a/arch/microblaze/include/asm/registers.h b/arch/microblaze/include/asm/registers.h
index 68c3afb73877..ee81e1cba008 100644
--- a/arch/microblaze/include/asm/registers.h
+++ b/arch/microblaze/include/asm/registers.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_REGISTERS_H
diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index 1b281d3ea734..a9311ad84a67 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_SECTIONS_H
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index ce9b7b786156..c209d5297029 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2007-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef _ASM_MICROBLAZE_SETUP_H
 #define _ASM_MICROBLAZE_SETUP_H
diff --git a/arch/microblaze/include/asm/string.h b/arch/microblaze/include/asm/string.h
index aec2f59298b8..34071a848b6a 100644
--- a/arch/microblaze/include/asm/string.h
+++ b/arch/microblaze/include/asm/string.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_STRING_H
diff --git a/arch/microblaze/include/asm/switch_to.h b/arch/microblaze/include/asm/switch_to.h
index f45baa2c5e09..5afd6d9977b2 100644
--- a/arch/microblaze/include/asm/switch_to.h
+++ b/arch/microblaze/include/asm/switch_to.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_SWITCH_TO_H
diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 9afe4b5bd6c8..ad8e8fcb90d3 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_THREAD_INFO_H
diff --git a/arch/microblaze/include/asm/timex.h b/arch/microblaze/include/asm/timex.h
index befcf3de5532..e99cc29cbe57 100644
--- a/arch/microblaze/include/asm/timex.h
+++ b/arch/microblaze/include/asm/timex.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_TIMEX_H
diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
index 2e1353c2d18d..6f8f5c77a050 100644
--- a/arch/microblaze/include/asm/tlbflush.h
+++ b/arch/microblaze/include/asm/tlbflush.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_TLBFLUSH_H
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index a1f206b90753..09498fe1ab98 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008-2009 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2008-2009 PetaLogix
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_UACCESS_H
diff --git a/arch/microblaze/include/asm/unaligned.h b/arch/microblaze/include/asm/unaligned.h
index b162ed880495..448299beab69 100644
--- a/arch/microblaze/include/asm/unaligned.h
+++ b/arch/microblaze/include/asm/unaligned.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef _ASM_MICROBLAZE_UNALIGNED_H
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index d79d35ac6253..cfe3f888b432 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2007-2008 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef _ASM_MICROBLAZE_UNISTD_H
 #define _ASM_MICROBLAZE_UNISTD_H
diff --git a/arch/microblaze/include/asm/unwind.h b/arch/microblaze/include/asm/unwind.h
index d248b7de4b13..c327d673622a 100644
--- a/arch/microblaze/include/asm/unwind.h
+++ b/arch/microblaze/include/asm/unwind.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Backtrace support for Microblaze
  *
  * Copyright (C) 2010  Digital Design Corporation
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef __MICROBLAZE_UNWIND_H
-- 
2.25.0

