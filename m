Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660BDC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE11206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="kwBckb66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBLPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBLPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so3054686wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRQHopDwtt7VDhZDYxLWi8CpgNXtJxRWkqUqbIm/C4I=;
        b=kwBckb66/8fU3BKinswZiGUYtkS9C0ASyi7RR9dnUkBSC9Z9droi4Kh3XNQEjqqe1K
         LomVBcPnlTLCpkYxFmLyA92BchVxz7kUBWLslzFFYPfyU8H6KQlwa901h1ruzeKd/06h
         qWIhA5xZ4XBr9AkzkxzgMCDiYfzKo7fnhgJ7wrEDwA/ZULCiwpkxMHH3EsV6bNMPomP0
         TvQ5nKK6ZCozfGOwVeCyKBok4oTHoayseGKaH3S3stuVl2QqHiHvaFgXgdlC5PCw0d46
         AB8H9V346fb6gATDYOFREvnfqQpLPnmEjPXwmt1Y/Y0aulWP5/QzJfVYauR9+joPKyud
         3NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GRQHopDwtt7VDhZDYxLWi8CpgNXtJxRWkqUqbIm/C4I=;
        b=euQQZMFpQQV0+awoZkl9fzwe5OlHL32IYYolPONB2wxHAkbfcOll56rs6FM88BQHdN
         kizJZCgQdCDqj1p4Z6Nhfz5keTcOC5fK0JvytWr5OQqDQWnpgX0No1nbge/wvtWSvoJJ
         lIJrC+XrCGTgQ/GHEh4LG1xqbjm8zOCPcfoWTU/LqkK5syIWnRTAinO3ybpsILTFgkRn
         pW/wDWkgENGR14xE3C8Ty7Jtpua0MEboL25DNZiZQR5x28o2lbM9hyt8wKCIpcGNA65W
         LKNVo40y09asoRbbtBGObob5sXZPIzxtGb47qFUch2HbK+eK1XJmiIlBnfcJIYYJ3R27
         uOWA==
X-Gm-Message-State: APjAAAWxX3L6EXrmcV0WgWpH3h8K3/CMHYCGN+099Kuz6qGeaDuucyV9
        WO9U8MC5TeU8BZgI+U+R61fJ07bptJWkSQmg
X-Google-Smtp-Source: APXvYqyu9SdCAr7IbdJFovQW+5YOQJ+JEWE0aBdEyXYA1WK6hkcuBKchEA1BbXisO1qIuMay2+y+aw==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr13973250wmi.118.1581522157617;
        Wed, 12 Feb 2020 07:42:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y185sm1323889wmg.2.2020.02.12.07.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:37 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/7] microblaze: Define SMP safe bit operations
Date:   Wed, 12 Feb 2020 16:42:25 +0100
Message-Id: <6a052c943197ed33db09ad42877e8a2b7dad6b96.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581522136.git.michal.simek@xilinx.com>
References: <cover.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

For SMP based system there is a need to have proper bit operations.
Microblaze is using exclusive load and store instructions.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild   |   1 -
 arch/microblaze/include/asm/bitops.h | 189 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 arch/microblaze/include/asm/bitops.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index abb33619299b..0da195308ac9 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += compat.h
diff --git a/arch/microblaze/include/asm/bitops.h b/arch/microblaze/include/asm/bitops.h
new file mode 100644
index 000000000000..a4f5ca09850f
--- /dev/null
+++ b/arch/microblaze/include/asm/bitops.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Microblaze atomic bit operations.
+ *
+ * Copyright (C) 2013 - 2020 Xilinx, Inc.
+ *
+ * Merged version by David Gibson <david@gibson.dropbear.id.au>.
+ * Based on ppc64 versions by: Dave Engebretsen, Todd Inglett, Don
+ * Reed, Pat McCarthy, Peter Bergner, Anton Blanchard.  They
+ * originally took it from the ppc32 code.
+ *
+ * Within a word, bits are numbered LSB first.  Lot's of places make
+ * this assumption by directly testing bits with (val & (1<<nr)).
+ * This can cause confusion for large (> 1 word) bitmaps on a
+ * big-endian system because, unlike little endian, the number of each
+ * bit depends on the word size.
+ *
+ * The bitop functions are defined to work on unsigned longs, so for a
+ * ppc64 system the bits end up numbered:
+ *   |63..............0|127............64|191...........128|255...........196|
+ * and on ppc32:
+ *   |31.....0|63....31|95....64|127...96|159..128|191..160|223..192|255..224|
+ *
+ * There are a few little-endian macros used mostly for filesystem
+ * bitmaps, these work on similar bit arrays layouts, but
+ * byte-oriented:
+ *   |7...0|15...8|23...16|31...24|39...32|47...40|55...48|63...56|
+ *
+ * The main difference is that bit 3-5 (64b) or 3-4 (32b) in the bit
+ * number field needs to be reversed compared to the big-endian bit
+ * fields. This can be achieved by XOR with 0x38 (64b) or 0x18 (32b).
+ */
+
+#ifndef _ASM_MICROBLAZE_BITOPS_H
+#define _ASM_MICROBLAZE_BITOPS_H
+
+#ifndef _LINUX_BITOPS_H
+#error only <linux/bitops.h> can be included directly
+#endif
+
+#include <asm/types.h>
+#include <linux/compiler.h>
+#include <asm/asm-compat.h>
+#include <linux/stringify.h>
+
+/*
+ * clear_bit doesn't imply a memory barrier
+ */
+#define smp_mb__before_clear_bit()	smp_mb()
+#define smp_mb__after_clear_bit()	smp_mb()
+
+#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+/* Macro for generating the ***_bits() functions */
+#define DEFINE_BITOP(fn, op)						\
+static inline void fn(unsigned long mask, volatile unsigned long *_p)	\
+{									\
+	unsigned long tmp;						\
+	unsigned long *p = (unsigned long *)_p;				\
+									\
+	__asm__ __volatile__ (						\
+		/* load conditional address in %2 to %0 */		\
+		"1:	lwx		%0, %3, r0;\n"			\
+		/* perform bit operation with mask */			\
+		stringify_in_c(op)"	%0, %0, %2;\n"			\
+		/* attempt store */					\
+		"	swx		%0, %3, r0;\n"			\
+		/* checking msr carry flag */				\
+		"	addic		%0, r0, 0;\n"			\
+		/* store failed (MSR[C] set)? try again */		\
+		"	bnei		%0, 1b;\n"			\
+		: "=&r" (tmp), "+m" (*p)  /* Outputs: tmp, p */		\
+		: "r" (mask), "r" (p)     /* Inputs: mask, p */		\
+		: "cc", "memory"					\
+	);								\
+}
+
+DEFINE_BITOP(set_bits, or)
+DEFINE_BITOP(clear_bits, andn)
+DEFINE_BITOP(clear_bits_unlock, andn)
+DEFINE_BITOP(change_bits, xor)
+
+static inline void set_bit(int nr, volatile unsigned long *addr)
+{
+	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static inline void clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+static inline void change_bit(int nr, volatile unsigned long *addr)
+{
+	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
+}
+
+/*
+ * Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
+ * operands.
+ */
+#define DEFINE_TESTOP(fn, op)						\
+static inline unsigned long fn(unsigned long mask,			\
+			       volatile unsigned long *_p)		\
+{									\
+	unsigned long old, tmp;						\
+	unsigned long *p = (unsigned long *)_p;				\
+									\
+	__asm__ __volatile__ (						\
+		/* load conditional address in %4 to %0 */		\
+		"1:	lwx		%0, %4, r0;\n"			\
+		/* perform bit operation with mask */			\
+		stringify_in_c(op)"	%1, %0, %3;\n"			\
+		/* attempt store */					\
+		"	swx		%1, %4, r0;\n"			\
+		/* checking msr carry flag */				\
+		"	addic		%1, r0, 0;\n"			\
+		/* store failed (MSR[C] set)? try again */		\
+		"	bnei		%1, 1b;\n"			\
+		/* Outputs: old, tmp, p */				\
+		: "=&r" (old), "=&r" (tmp), "+m" (*p)			\
+		 /* Inputs: mask, p */					\
+		: "r" (mask), "r" (p)					\
+		: "cc", "memory"					\
+	);								\
+	return (old & mask);						\
+}
+
+DEFINE_TESTOP(test_and_set_bits, or)
+DEFINE_TESTOP(test_and_set_bits_lock, or)
+DEFINE_TESTOP(test_and_clear_bits, andn)
+DEFINE_TESTOP(test_and_change_bits, xor)
+
+static inline int test_and_set_bit(unsigned long nr,
+				       volatile unsigned long *addr)
+{
+	return test_and_set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+}
+
+static inline int test_and_set_bit_lock(unsigned long nr,
+				       volatile unsigned long *addr)
+{
+	return test_and_set_bits_lock(BITOP_MASK(nr),
+				addr + BITOP_WORD(nr)) != 0;
+}
+
+static inline int test_and_clear_bit(unsigned long nr,
+					 volatile unsigned long *addr)
+{
+	return test_and_clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+}
+
+static inline int test_and_change_bit(unsigned long nr,
+					  volatile unsigned long *addr)
+{
+	return test_and_change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr)) != 0;
+}
+
+#include <asm-generic/bitops/non-atomic.h>
+
+static inline void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/fls64.h>
+
+/* Little-endian versions */
+#include <asm-generic/bitops/le.h>
+
+/* Bitmap functions for the ext2 filesystem */
+#include <asm-generic/bitops/ext2-atomic-setbit.h>
+
+#include <asm-generic/bitops/sched.h>
+
+#endif /* _ASM_MICROBLAZE_BITOPS_H */
-- 
2.25.0

