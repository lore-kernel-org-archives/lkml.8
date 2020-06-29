Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8739E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459135;
	bh=fMJnMeJx8wGXwDbv34zc9g+wG1Ni0PSEYZC1BY7IAlA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wo8CIV85tcfK3BE8ID889WIfA02ad9GgwlEpqIWv2hx99eFEu2h7Ht66wEZtF6fAS
	 fSHf1g0xkUEwxzXrWekqyxW1BYup476+XUzxIyvjJgBMDb5FWoEYoHnIpJjMnJy3zQ
	 H4npqLFOGaue+BMLT3KN+GgoaFNxwAZIm7pQEDgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgF2TcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:32:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46438 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbgF2TcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:08 -0400
Received: by mail-io1-f65.google.com with SMTP id a12so18448743ion.13;
        Mon, 29 Jun 2020 12:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxRkPuDfPbrS9C7pjKtoug/7Im3FpACWhfxon0s0d4Q=;
        b=mThvgoW64fiF80nE8HeDGJIFps6Vigecmu4kZg7elhENOIRxR2RfUte53R8Mjutwrt
         8mvaT4Z9BpnqKpzy5QNacCy+CQa4EOIlN80/KtPhi+u84dkIQ4UyMCd9kdUcwhZrqAMf
         F8eHpTiHKoEEr0NriZLIWMKoGGWy3npqenp4yNnONev1orkdv1f1mUpEaA0GDaoq2H/d
         c7YqyldK0XfVj4KcsIV3/K0cdUXSEJ0cBBudDF02gKDrVGeZVnZpIRAcKP9LbGA8MbSX
         usB99KSUAbizsqmsn0FI4+ZSyYyLf+udXjBOBrBt8P2dDsAlDPjES9JuJdb9RQa1bMCO
         Q+/w==
X-Gm-Message-State: AOAM530vqTwElNLopWfNMkAhb/PnoKOVEzp5n5AWwia+X7kAu7Nn2mbK
        1n5Kv0pjJIoxnwKckzqhXHukI9N2WQ==
X-Google-Smtp-Source: ABdhPJyoOA8axgu8kqOwB6MHsfwTzlZXdimo9+8p3rtAttS0bGleNvdFKHg38ny8eaDKNKn8oWu/Zg==
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr18219285iow.183.1593459126187;
        Mon, 29 Jun 2020 12:32:06 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.255])
        by smtp.googlemail.com with ESMTPSA id s17sm378792ioj.10.2020.06.29.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:32:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c
Date:   Mon, 29 Jun 2020 13:32:03 -0600
Message-Id: <20200629193203.2727682-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync with upstream dtc primarily to pickup the I2C bus check fixes. The
interrupt_provider check is noisy, so turn it off for now.

This adds the following commits from upstream:

9d7888cbf19c dtc: Consider one-character strings as strings
8259d59f59de checks: Improve i2c reg property checking
fdabcf2980a4 checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
2478b1652c8d libfdt: add extern "C" for C++
f68bfc2668b2 libfdt: trivial typo fix
7be250b4d059 libfdt: Correct condition for reordering blocks
81e0919a3e21 checks: Add interrupt provider test
85e5d839847a Makefile: when building libfdt only, do not add unneeded deps
b28464a550c5 Fix some potential unaligned accesses in dtc

Signed-off-by: Rob Herring <robh@kernel.org>
---
Planning to apply this for 5.8-rc.

 scripts/Makefile.lib        |  4 +++-
 scripts/dtc/checks.c        | 39 ++++++++++++++++++++++++++++++++++---
 scripts/dtc/dtc.h           | 31 +++++++++++++++++++++++++++++
 scripts/dtc/flattree.c      |  2 +-
 scripts/dtc/libfdt/fdt_rw.c |  2 +-
 scripts/dtc/libfdt/fdt_sw.c |  2 +-
 scripts/dtc/libfdt/libfdt.h |  8 ++++++++
 scripts/dtc/treesource.c    |  8 ++++----
 scripts/dtc/version_gen.h   |  2 +-
 scripts/dtc/yamltree.c      |  6 +++---
 10 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 99ac59c59826..e6411b37ecf6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -259,6 +259,7 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
+DTC_FLAGS += -Wno-interrupt_provider
 
 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
@@ -274,7 +275,8 @@ endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
-	-Wproperty_name_chars_strict
+	-Wproperty_name_chars_strict \
+	-Winterrupt_provider
 endif
 
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 4b3c486f1399..b7955dbd71ca 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1022,6 +1022,9 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
 }
 WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
 
+#define I2C_OWN_SLAVE_ADDRESS	(1U << 30)
+#define I2C_TEN_BIT_ADDRESS	(1U << 31)
+
 static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
 {
 	struct property *prop;
@@ -1044,6 +1047,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 	}
 
 	reg = fdt32_to_cpu(*cells);
+	/* Ignore I2C_OWN_SLAVE_ADDRESS */
+	reg &= ~I2C_OWN_SLAVE_ADDRESS;
 	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
 	if (!streq(unitname, unit_addr))
 		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
@@ -1051,10 +1056,15 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
-		if (reg > 0x3ff)
+		/* Ignore I2C_OWN_SLAVE_ADDRESS */
+		reg &= ~I2C_OWN_SLAVE_ADDRESS;
+
+		if ((reg & I2C_TEN_BIT_ADDRESS) && ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff))
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-
+		else if (reg > 0x7f)
+			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits, got \"0x%x\". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property",
+				  reg);
 	}
 }
 WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bridge);
@@ -1547,6 +1557,28 @@ static bool node_is_interrupt_provider(struct node *node)
 
 	return false;
 }
+
+static void check_interrupt_provider(struct check *c,
+				     struct dt_info *dti,
+				     struct node *node)
+{
+	struct property *prop;
+
+	if (!node_is_interrupt_provider(node))
+		return;
+
+	prop = get_property(node, "#interrupt-cells");
+	if (!prop)
+		FAIL(c, dti, node,
+		     "Missing #interrupt-cells in interrupt provider");
+
+	prop = get_property(node, "#address-cells");
+	if (!prop)
+		FAIL(c, dti, node,
+		     "Missing #address-cells in interrupt provider");
+}
+WARNING(interrupt_provider, check_interrupt_provider, NULL);
+
 static void check_interrupts_property(struct check *c,
 				      struct dt_info *dti,
 				      struct node *node)
@@ -1604,7 +1636,7 @@ static void check_interrupts_property(struct check *c,
 
 	prop = get_property(irq_node, "#interrupt-cells");
 	if (!prop) {
-		FAIL(c, dti, irq_node, "Missing #interrupt-cells in interrupt-parent");
+		/* We warn about that already in another test. */
 		return;
 	}
 
@@ -1828,6 +1860,7 @@ static struct check *check_table[] = {
 	&deprecated_gpio_property,
 	&gpios_property,
 	&interrupts_property,
+	&interrupt_provider,
 
 	&alias_paths,
 
diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
index 6e74ecea55a3..a08f4159cd03 100644
--- a/scripts/dtc/dtc.h
+++ b/scripts/dtc/dtc.h
@@ -51,6 +51,37 @@ extern int annotate;		/* annotate .dts with input source location */
 
 typedef uint32_t cell_t;
 
+static inline uint16_t dtb_ld16(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint16_t)bp[0] << 8)
+		| bp[1];
+}
+
+static inline uint32_t dtb_ld32(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint32_t)bp[0] << 24)
+		| ((uint32_t)bp[1] << 16)
+		| ((uint32_t)bp[2] << 8)
+		| bp[3];
+}
+
+static inline uint64_t dtb_ld64(const void *p)
+{
+	const uint8_t *bp = (const uint8_t *)p;
+
+	return ((uint64_t)bp[0] << 56)
+		| ((uint64_t)bp[1] << 48)
+		| ((uint64_t)bp[2] << 40)
+		| ((uint64_t)bp[3] << 32)
+		| ((uint64_t)bp[4] << 24)
+		| ((uint64_t)bp[5] << 16)
+		| ((uint64_t)bp[6] << 8)
+		| bp[7];
+}
 
 #define streq(a, b)	(strcmp((a), (b)) == 0)
 #define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) == 0)
diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
index bd6977eedcb8..07f10d2b5d79 100644
--- a/scripts/dtc/flattree.c
+++ b/scripts/dtc/flattree.c
@@ -156,7 +156,7 @@ static void asm_emit_data(void *e, struct data d)
 		emit_offset_label(f, m->ref, m->offset);
 
 	while ((d.len - off) >= sizeof(uint32_t)) {
-		asm_emit_cell(e, fdt32_to_cpu(*((fdt32_t *)(d.val+off))));
+		asm_emit_cell(e, dtb_ld32(d.val + off));
 		off += sizeof(uint32_t);
 	}
 
diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
index 524b520c8486..93e4a2b56348 100644
--- a/scripts/dtc/libfdt/fdt_rw.c
+++ b/scripts/dtc/libfdt/fdt_rw.c
@@ -436,7 +436,7 @@ int fdt_open_into(const void *fdt, void *buf, int bufsize)
 			return struct_size;
 	}
 
-	if (can_assume(LIBFDT_ORDER) |
+	if (can_assume(LIBFDT_ORDER) ||
 	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
index 26759d5dfb8c..94ce4bb91a00 100644
--- a/scripts/dtc/libfdt/fdt_sw.c
+++ b/scripts/dtc/libfdt/fdt_sw.c
@@ -32,7 +32,7 @@ static int fdt_sw_probe_(void *fdt)
 /* 'memrsv' state:	Initial state after fdt_create()
  *
  * Allowed functions:
- *	fdt_add_reservmap_entry()
+ *	fdt_add_reservemap_entry()
  *	fdt_finish_reservemap()		[moves to 'struct' state]
  */
 static int fdt_sw_probe_memrsv_(void *fdt)
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index 36fadcdea516..fe49b5d78938 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -9,6 +9,10 @@
 #include "libfdt_env.h"
 #include "fdt.h"
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 #define FDT_FIRST_SUPPORTED_VERSION	0x02
 #define FDT_LAST_SUPPORTED_VERSION	0x11
 
@@ -2069,4 +2073,8 @@ int fdt_overlay_apply(void *fdt, void *fdto);
 
 const char *fdt_strerror(int errval);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif /* LIBFDT_H */
diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
index c9d980c8abfc..061ba8c9c5e8 100644
--- a/scripts/dtc/treesource.c
+++ b/scripts/dtc/treesource.c
@@ -110,13 +110,13 @@ static void write_propval_int(FILE *f, const char *p, size_t len, size_t width)
 			fprintf(f, "%02"PRIx8, *(const uint8_t*)p);
 			break;
 		case 2:
-			fprintf(f, "0x%02"PRIx16, fdt16_to_cpu(*(const fdt16_t*)p));
+			fprintf(f, "0x%02"PRIx16, dtb_ld16(p));
 			break;
 		case 4:
-			fprintf(f, "0x%02"PRIx32, fdt32_to_cpu(*(const fdt32_t*)p));
+			fprintf(f, "0x%02"PRIx32, dtb_ld32(p));
 			break;
 		case 8:
-			fprintf(f, "0x%02"PRIx64, fdt64_to_cpu(*(const fdt64_t*)p));
+			fprintf(f, "0x%02"PRIx64, dtb_ld64(p));
 			break;
 		}
 		if (p + width < end)
@@ -183,7 +183,7 @@ static enum markertype guess_value_type(struct property *prop)
 			nnotcelllbl++;
 	}
 
-	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul))
+	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul <= (len-nnul))
 	    && (nnotstringlbl == 0)) {
 		return TYPE_STRING;
 	} else if (((len % sizeof(cell_t)) == 0) && (nnotcelllbl == 0)) {
diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
index 61dd7112d6e4..0714799446f8 100644
--- a/scripts/dtc/version_gen.h
+++ b/scripts/dtc/version_gen.h
@@ -1 +1 @@
-#define DTC_VERSION "DTC 1.6.0-g87a656ae"
+#define DTC_VERSION "DTC 1.6.0-g9d7888cb"
diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
index 5b6ea8ea862f..4e93c12dc658 100644
--- a/scripts/dtc/yamltree.c
+++ b/scripts/dtc/yamltree.c
@@ -59,10 +59,10 @@ static void yaml_propval_int(yaml_emitter_t *emitter, struct marker *markers, ch
 			sprintf(buf, "0x%"PRIx8, *(uint8_t*)(data + off));
 			break;
 		case 2:
-			sprintf(buf, "0x%"PRIx16, fdt16_to_cpu(*(fdt16_t*)(data + off)));
+			sprintf(buf, "0x%"PRIx16, dtb_ld16(data + off));
 			break;
 		case 4:
-			sprintf(buf, "0x%"PRIx32, fdt32_to_cpu(*(fdt32_t*)(data + off)));
+			sprintf(buf, "0x%"PRIx32, dtb_ld32(data + off));
 			m = markers;
 			is_phandle = false;
 			for_each_marker_of_type(m, REF_PHANDLE) {
@@ -73,7 +73,7 @@ static void yaml_propval_int(yaml_emitter_t *emitter, struct marker *markers, ch
 			}
 			break;
 		case 8:
-			sprintf(buf, "0x%"PRIx64, fdt64_to_cpu(*(fdt64_t*)(data + off)));
+			sprintf(buf, "0x%"PRIx64, dtb_ld64(data + off));
 			break;
 		}
 
-- 
2.25.1

