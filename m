Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A9C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FA120675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXCs+F68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgEMEkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 00:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgEMEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 00:40:40 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC8C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:40:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b1so12401896qtt.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i81V4PB/xvy4exN3WKZDaY9Qtljbz9rOQNSIFlvgV/s=;
        b=mXCs+F684h2MAhCfzTebwQYqJl6pEj6HoSBcFHktJsdv/I2FfIaE3F06TBiHhvnvk6
         5bnOO4PF/9E4EDlxhBZKhY/w2RBfjoPSoIqExRAjSaSR9y5nKNWglxCJCXOpjwncZ/hi
         l/cLXzndmxnnWEoShdnt+JsKOARBwtdYyLDF4JXjRtiCI7EW6TKx1my7gsd1w6QEikhR
         DgfCQPoLetQmaozOcC3/V8PxTZF/rBslayHd9JNon3iTUNJFrIeBkwQ267gfib82DiO0
         TiZ4bkhA7ofnKWj/vNAFjcxYiNgfmh3Ep5oYb4PdCdD1BO46AcXjBjM0q6ylh+XTiv1n
         8+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i81V4PB/xvy4exN3WKZDaY9Qtljbz9rOQNSIFlvgV/s=;
        b=IzT3IJXaTFaPehCgxXVc3GYQp9qgTfVbFY9jBXzC0GxTSE3yuqthN5aGRVrZ17oMhf
         6bmjOtLH/Dyigk45AivwzmDXAuX76bG/sO3ZWXeTachI5dLGpjbN8XDYyhIytjpzMlKX
         2FeLTG9iDLAsR4Ijzg2PpDMnOwARpneJ5Qx1h0/38/J5DFAw1Brw62G4+6j5NxxIXuDu
         TfwfZFVKVnYd3Z0wKQZI6+elRBHY3wro69tUS/0XePxYOQd01T0KR2gLq2+FmSyJBD9k
         Mt/DaM5FKT3+5D4a/YEPG0Z+xMt0DMEevmLfuF44wzeUG2INaMdo13aRGYAtRda3KP6v
         KMcg==
X-Gm-Message-State: AGi0PuZtlqPucQkmZdgNCcqKqlROlKDq2RLFcU9xtjTT6knbluSbH0u5
        BEiYeAmsUc3SkY25a6lC0dE=
X-Google-Smtp-Source: APiQypKbxoI7Rf+aS+eyM3b3dtVJjM4UZZmiXknunLnjjYO6nYKRmX+vBtqyqqCVjVnYoqGMn7LimQ==
X-Received: by 2002:ac8:70c:: with SMTP id g12mr24729933qth.71.1589344837641;
        Tue, 12 May 2020 21:40:37 -0700 (PDT)
Received: from LeoBras.aus.stglabs.ibm.com (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id j90sm14201132qte.20.2020.05.12.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 21:40:36 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Cc:     Leonardo Bras <leobras.c@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/rtas: Move type/struct definitions from rtas.h into rtas-types.h
Date:   Wed, 13 May 2020 01:40:24 -0300
Message-Id: <20200513044025.105379-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get any rtas* struct into other headers, including rtas.h
may cause a lot of errors, regarding include dependency needed for
inline functions.

Create rtas-types.h and move there all type/struct definitions
from rtas.h, then include rtas-types.h into rtas.h.

Also, as suggested by checkpath.pl, replace uint8_t for u8, and keep
the same type pattern for the whole file, as they are the same
according to powerpc/boot/types.h.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/rtas-types.h | 124 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/rtas.h       | 118 +-----------------------
 2 files changed, 125 insertions(+), 117 deletions(-)
 create mode 100644 arch/powerpc/include/asm/rtas-types.h

diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/asm/rtas-types.h
new file mode 100644
index 000000000000..59b0b4b25b7a
--- /dev/null
+++ b/arch/powerpc/include/asm/rtas-types.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _POWERPC_RTAS_TYPES_H
+#define _POWERPC_RTAS_TYPES_H
+#ifdef __KERNEL__
+
+typedef __be32 rtas_arg_t;
+
+struct rtas_args {
+	__be32 token;
+	__be32 nargs;
+	__be32 nret;
+	rtas_arg_t args[16];
+	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
+};
+
+struct rtas_t {
+	unsigned long entry;		/* physical address pointer */
+	unsigned long base;		/* physical address pointer */
+	unsigned long size;
+	arch_spinlock_t lock;
+	struct rtas_args args;
+	struct device_node *dev;	/* virtual address pointer */
+};
+
+struct rtas_suspend_me_data {
+	atomic_t working; /* number of cpus accessing this struct */
+	atomic_t done;
+	int token; /* ibm,suspend-me */
+	atomic_t error;
+	struct completion *complete; /* wait on this until working == 0 */
+};
+
+struct rtas_error_log {
+	/* Byte 0 */
+	u8		byte0;			/* Architectural version */
+
+	/* Byte 1 */
+	u8		byte1;
+	/* XXXXXXXX
+	 * XXX		3: Severity level of error
+	 *    XX	2: Degree of recovery
+	 *      X	1: Extended log present?
+	 *       XX	2: Reserved
+	 */
+
+	/* Byte 2 */
+	u8		byte2;
+	/* XXXXXXXX
+	 * XXXX		4: Initiator of event
+	 *     XXXX	4: Target of failed operation
+	 */
+	u8		byte3;			/* General event or error*/
+	__be32		extended_log_length;	/* length in bytes */
+	unsigned char	buffer[1];		/* Start of extended log */
+						/* Variable length.      */
+};
+
+/* RTAS general extended event log, Version 6. The extended log starts
+ * from "buffer" field of struct rtas_error_log defined above.
+ */
+struct rtas_ext_event_log_v6 {
+	/* Byte 0 */
+	u8 byte0;
+	/* XXXXXXXX
+	 * X		1: Log valid
+	 *  X		1: Unrecoverable error
+	 *   X		1: Recoverable (correctable or successfully retried)
+	 *    X		1: Bypassed unrecoverable error (degraded operation)
+	 *     X	1: Predictive error
+	 *      X	1: "New" log (always 1 for data returned from RTAS)
+	 *       X	1: Big Endian
+	 *        X	1: Reserved
+	 */
+
+	/* Byte 1 */
+	u8 byte1;			/* reserved */
+
+	/* Byte 2 */
+	u8 byte2;
+	/* XXXXXXXX
+	 * X		1: Set to 1 (indicating log is in PowerPC format)
+	 *  XXX		3: Reserved
+	 *     XXXX	4: Log format used for bytes 12-2047
+	 */
+
+	/* Byte 3 */
+	u8 byte3;			/* reserved */
+	/* Byte 4-11 */
+	u8 reserved[8];			/* reserved */
+	/* Byte 12-15 */
+	__be32  company_id;		/* Company ID of the company	*/
+					/* that defines the format for	*/
+					/* the vendor specific log type	*/
+	/* Byte 16-end of log */
+	u8 vendor_log[1];		/* Start of vendor specific log	*/
+					/* Variable length.		*/
+};
+
+/* Vendor specific Platform Event Log Format, Version 6, section header */
+struct pseries_errorlog {
+	__be16 id;			/* 0x00 2-byte ASCII section ID	*/
+	__be16 length;			/* 0x02 Section length in bytes	*/
+	u8 version;			/* 0x04 Section version		*/
+	u8 subtype;			/* 0x05 Section subtype		*/
+	__be16 creator_component;	/* 0x06 Creator component ID	*/
+	u8 data[];			/* 0x08 Start of section data	*/
+};
+
+/* RTAS pseries hotplug errorlog section */
+struct pseries_hp_errorlog {
+	u8	resource;
+	u8	action;
+	u8	id_type;
+	u8	reserved;
+	union {
+		__be32	drc_index;
+		__be32	drc_count;
+		struct { __be32 count, index; } ic;
+		char	drc_name[1];
+	} _drc_u;
+};
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_RTAS_TYPES_H */
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3c1887351c71..c35c5350b7e4 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -5,6 +5,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/page.h>
+#include <asm/rtas-types.h>
 #include <linux/time.h>
 #include <linux/cpumask.h>
 
@@ -42,33 +43,6 @@
  *
  */
 
-typedef __be32 rtas_arg_t;
-
-struct rtas_args {
-	__be32 token;
-	__be32 nargs;
-	__be32 nret; 
-	rtas_arg_t args[16];
-	rtas_arg_t *rets;     /* Pointer to return values in args[]. */
-};  
-
-struct rtas_t {
-	unsigned long entry;		/* physical address pointer */
-	unsigned long base;		/* physical address pointer */
-	unsigned long size;
-	arch_spinlock_t lock;
-	struct rtas_args args;
-	struct device_node *dev;	/* virtual address pointer */
-};
-
-struct rtas_suspend_me_data {
-	atomic_t working; /* number of cpus accessing this struct */
-	atomic_t done;
-	int token; /* ibm,suspend-me */
-	atomic_t error;
-	struct completion *complete; /* wait on this until working == 0 */
-};
-
 /* RTAS event classes */
 #define RTAS_INTERNAL_ERROR		0x80000000 /* set bit 0 */
 #define RTAS_EPOW_WARNING		0x40000000 /* set bit 1 */
@@ -148,31 +122,6 @@ struct rtas_suspend_me_data {
 /* RTAS check-exception vector offset */
 #define RTAS_VECTOR_EXTERNAL_INTERRUPT	0x500
 
-struct rtas_error_log {
-	/* Byte 0 */
-	uint8_t		byte0;			/* Architectural version */
-
-	/* Byte 1 */
-	uint8_t		byte1;
-	/* XXXXXXXX
-	 * XXX		3: Severity level of error
-	 *    XX	2: Degree of recovery
-	 *      X	1: Extended log present?
-	 *       XX	2: Reserved
-	 */
-
-	/* Byte 2 */
-	uint8_t		byte2;
-	/* XXXXXXXX
-	 * XXXX		4: Initiator of event
-	 *     XXXX	4: Target of failed operation
-	 */
-	uint8_t		byte3;			/* General event or error*/
-	__be32		extended_log_length;	/* length in bytes */
-	unsigned char	buffer[1];		/* Start of extended log */
-						/* Variable length.      */
-};
-
 static inline uint8_t rtas_error_severity(const struct rtas_error_log *elog)
 {
 	return (elog->byte1 & 0xE0) >> 5;
@@ -212,47 +161,6 @@ uint32_t rtas_error_extended_log_length(const struct rtas_error_log *elog)
 
 #define RTAS_V6EXT_COMPANY_ID_IBM	(('I' << 24) | ('B' << 16) | ('M' << 8))
 
-/* RTAS general extended event log, Version 6. The extended log starts
- * from "buffer" field of struct rtas_error_log defined above.
- */
-struct rtas_ext_event_log_v6 {
-	/* Byte 0 */
-	uint8_t byte0;
-	/* XXXXXXXX
-	 * X		1: Log valid
-	 *  X		1: Unrecoverable error
-	 *   X		1: Recoverable (correctable or successfully retried)
-	 *    X		1: Bypassed unrecoverable error (degraded operation)
-	 *     X	1: Predictive error
-	 *      X	1: "New" log (always 1 for data returned from RTAS)
-	 *       X	1: Big Endian
-	 *        X	1: Reserved
-	 */
-
-	/* Byte 1 */
-	uint8_t byte1;			/* reserved */
-
-	/* Byte 2 */
-	uint8_t byte2;
-	/* XXXXXXXX
-	 * X		1: Set to 1 (indicating log is in PowerPC format)
-	 *  XXX		3: Reserved
-	 *     XXXX	4: Log format used for bytes 12-2047
-	 */
-
-	/* Byte 3 */
-	uint8_t byte3;			/* reserved */
-	/* Byte 4-11 */
-	uint8_t reserved[8];		/* reserved */
-	/* Byte 12-15 */
-	__be32  company_id;		/* Company ID of the company	*/
-					/* that defines the format for	*/
-					/* the vendor specific log type	*/
-	/* Byte 16-end of log */
-	uint8_t vendor_log[1];		/* Start of vendor specific log	*/
-					/* Variable length.		*/
-};
-
 static
 inline uint8_t rtas_ext_event_log_format(struct rtas_ext_event_log_v6 *ext_log)
 {
@@ -287,16 +195,6 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
 #define PSERIES_ELOG_SECT_ID_HOTPLUG		(('H' << 8) | 'P')
 #define PSERIES_ELOG_SECT_ID_MCE		(('M' << 8) | 'C')
 
-/* Vendor specific Platform Event Log Format, Version 6, section header */
-struct pseries_errorlog {
-	__be16 id;			/* 0x00 2-byte ASCII section ID	*/
-	__be16 length;			/* 0x02 Section length in bytes	*/
-	uint8_t version;		/* 0x04 Section version		*/
-	uint8_t subtype;		/* 0x05 Section subtype		*/
-	__be16 creator_component;	/* 0x06 Creator component ID	*/
-	uint8_t data[];			/* 0x08 Start of section data	*/
-};
-
 static
 inline uint16_t pseries_errorlog_id(struct pseries_errorlog *sect)
 {
@@ -309,20 +207,6 @@ inline uint16_t pseries_errorlog_length(struct pseries_errorlog *sect)
 	return be16_to_cpu(sect->length);
 }
 
-/* RTAS pseries hotplug errorlog section */
-struct pseries_hp_errorlog {
-	u8	resource;
-	u8	action;
-	u8	id_type;
-	u8	reserved;
-	union {
-		__be32	drc_index;
-		__be32	drc_count;
-		struct { __be32 count, index; } ic;
-		char	drc_name[1];
-	} _drc_u;
-};
-
 #define PSERIES_HP_ELOG_RESOURCE_CPU	1
 #define PSERIES_HP_ELOG_RESOURCE_MEM	2
 #define PSERIES_HP_ELOG_RESOURCE_SLOT	3
-- 
2.25.4

