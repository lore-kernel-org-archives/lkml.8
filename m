Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198CDC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD032206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="P9nAG3sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgBLPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34880 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgBLPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so2949207wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2b1vZdJB4fiB9dYZ8R4EVlvDmFhemk1yGL7m8x27ncI=;
        b=P9nAG3sCekfWOdg3lNUlchKDW9KngUBOshbLoI9QlMao7IuGsNCGiRQmsM5jyOy8h7
         eDNmkMCZ0xWQrv0OZYUHONPP3s+AYvgvQluxT7jld5MuQ7aAkilOM36dfFOxVqDM360/
         K/PiolLCwpZPe/7whzgPJsRbCFL1ikVq25NDV2bLJaiqICVNT2PcdFAJZqXFzyxYD/uX
         QaVC5ad9/tbQdKh0V/rfOZZBCPO+hfh3siAiqYFwm6OUIVzixSm7RXd6lP/uNP4I2Iqn
         o6ZQ63ObhLDIyVHN+catYjxZ68FL8viAjgbpCS18j374JSMJ+jWN4ycWPKoocMw17yBT
         Wu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2b1vZdJB4fiB9dYZ8R4EVlvDmFhemk1yGL7m8x27ncI=;
        b=lsDjDjb7bv1LM/wj42z0e/5rd/xNJrWrsicNfpLzgSB4/wk0QFNdMYyHIrOft1irlM
         Ojii66PY+R7I8NJWMiYa3s3LHZWmm4M8wj9BI2mOHHvrJuVxQgMoXvMZqf/hHfhmNjKC
         pyr7gQJ6L9ZiNLFLTStMX/8ZZNoUemIVUGiYPN6w8zYqyiBs05Q+9qhalbWC0Et8kpya
         gO6YMj/DK9tChJDtvi5kS5SsjeTA4b4kD3m0mcm2V3ExsqEfLbpfBflDqoddlP0OtcI4
         1ZAfckotf7zv+JVVIM2cmWfotWqTQREz9qesdExE+FHPDjhscihjsylx4uncmKdtMrns
         gFvw==
X-Gm-Message-State: APjAAAUm7I3we0P3UNarFyRcKmlJXlwEbnHIYSJmBkE6fW/9e3iE6oxP
        UpNqgNnZvjjc2nGsgrqKe1clsELFV2lZjCFk
X-Google-Smtp-Source: APXvYqyVZzyREsKCwIpvW3nU2jnNRMOMp532AvKAz0tsWZrbNqP1R0h0y1FHpFnNFmF0IVE4w7sL6A==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr15526775wrw.126.1581522162585;
        Wed, 12 Feb 2020 07:42:42 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v17sm984494wrt.91.2020.02.12.07.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:42 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 6/7] microblaze: Implement architecture spinlock
Date:   Wed, 12 Feb 2020 16:42:28 +0100
Message-Id: <ed53474e9ca6736353afd10ebe7ea98e4c6c459e.1581522136.git.michal.simek@xilinx.com>
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

Using exclusive loads/stores to implement spinlocks which can be used on
SMP systems.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++++
 arch/microblaze/include/asm/spinlock_types.h |  25 ++
 2 files changed, 265 insertions(+)
 create mode 100644 arch/microblaze/include/asm/spinlock.h
 create mode 100644 arch/microblaze/include/asm/spinlock_types.h

diff --git a/arch/microblaze/include/asm/spinlock.h b/arch/microblaze/include/asm/spinlock.h
new file mode 100644
index 000000000000..0199ea9f7f0f
--- /dev/null
+++ b/arch/microblaze/include/asm/spinlock.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013-2020 Xilinx, Inc.
+ */
+
+#ifndef _ASM_MICROBLAZE_SPINLOCK_H
+#define _ASM_MICROBLAZE_SPINLOCK_H
+
+/*
+ * Unlocked value: 0
+ * Locked value: 1
+ */
+#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	 %0, %1, r0;\n"
+		/* not zero? try again */
+		"	bnei	%0, 1b;\n"
+		/* increment lock by 1 */
+		"	addi	%0, r0, 1;\n"
+		/* attempt store */
+		"	swx	%0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&lock->lock)
+		: "cc", "memory"
+	);
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	unsigned long prev, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %2 to %0 */
+		"1:	lwx	 %0, %2, r0;\n"
+		/* not zero? clear reservation */
+		"	bneid	%0, 2f;\n"
+		/* increment lock by one if lwx was sucessful */
+		"	addi	%1, r0, 1;\n"
+		/* attempt store */
+		"	swx	%1, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		"2:"
+		/* Outputs: temp variable for load result */
+		: "=&r" (prev), "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&lock->lock)
+		: "cc", "memory"
+	);
+
+	return (prev == 0);
+}
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	%0, %1, r0;\n"
+		/* clear */
+		"	swx	r0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&lock->lock)
+		: "cc", "memory"
+	);
+}
+
+/* RWLOCKS */
+static inline void arch_write_lock(arch_rwlock_t *rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	 %0, %1, r0;\n"
+		/* not zero? try again */
+		"	bneid	%0, 1b;\n"
+		/* set tmp to -1 */
+		"	addi	%0, r0, -1;\n"
+		/* attempt store */
+		"	swx	%0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *rw)
+{
+	unsigned long prev, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to tmp */
+		"1:	lwx	%0, %2, r0;\n"
+		/* not zero? abort */
+		"	bneid	%0, 2f;\n"
+		/* set tmp to -1 */
+		"	addi	%1, r0, -1;\n"
+		/* attempt store */
+		"	swx	%1, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		"2:"
+		/* Outputs: temp variable for load result */
+		: "=&r" (prev), "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+	/* prev value should be zero and MSR should be clear */
+	return (prev == 0);
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	%0, %1, r0;\n"
+		/* clear */
+		"	swx	r0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+}
+
+/* Read locks */
+static inline void arch_read_lock(arch_rwlock_t *rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	%0, %1, r0;\n"
+		/* < 0 (WRITE LOCK active) try again */
+		"	bltid	%0, 1b;\n"
+		/* increment lock by 1 if lwx was sucessful */
+		"	addi	%0, %0, 1;\n"
+		/* attempt store */
+		"	swx	%0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *rw)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to tmp */
+		"1:	lwx	%0, %1, r0;\n"
+		/* tmp = tmp - 1 */
+		"	addi	%0, %0, -1;\n"
+		/* attempt store */
+		"	swx	%0, %1, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%0, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%0, 1b;\n"
+		/* Outputs: temp variable for load result */
+		: "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *rw)
+{
+	unsigned long prev, tmp;
+
+	__asm__ __volatile__ (
+		/* load conditional address in %1 to %0 */
+		"1:	lwx	%0, %2, r0;\n"
+		/* < 0 bail, release lock */
+		"	bltid	%0, 2f;\n"
+		/* increment lock by 1 */
+		"	addi	%1, %0, 1;\n"
+		/* attempt store */
+		"	swx	%1, %2, r0;\n"
+		/* checking msr carry flag */
+		"	addic	%1, r0, 0;\n"
+		/* store failed (MSR[C] set)? try again */
+		"	bnei	%1, 1b;\n"
+		"2:"
+		/* Outputs: temp variable for load result */
+		: "=&r" (prev), "=&r" (tmp)
+		/* Inputs: lock address */
+		: "r" (&rw->lock)
+		: "cc", "memory"
+	);
+	return (prev >= 0);
+}
+
+#endif /* _ASM_MICROBLAZE_SPINLOCK_H */
diff --git a/arch/microblaze/include/asm/spinlock_types.h b/arch/microblaze/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..ffd3588f6546
--- /dev/null
+++ b/arch/microblaze/include/asm/spinlock_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2013-2020 Xilinx, Inc.
+ */
+
+#ifndef __ASM_MICROBLAZE_SPINLOCK_TYPES_H
+#define __ASM_MICROBLAZE_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile signed int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
-- 
2.25.0

