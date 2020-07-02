Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F75A20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa342xn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGBXL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgGBXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C18CC08C5DF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a1so31777567ejg.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XftDDHJLGP4abIDDD34XPeZJNkIQZFz4M9hvz8t7ynw=;
        b=sa342xn2HVHfR22KZvlz2pIpNkiA544bdmuwFyl8jqIBDBICuSdecLQUhdgf1vFG9L
         aKA+smhdeYDMyV5pgAr2m4BNQ3gKG9Ia4U3uUJakayzUp+283ekvLS81AIyjKhkqixKF
         lyNUj8F4Cqrm1/Es7g7NOOLSqMTpCuaZij6uVRtN1hIywwoiBjfMOtlwTtjfvXL8TkLn
         x8Om3uUPzW0hMuOY+9RzVeirm+JSRk+KKwl49Q8aCt8Y8MTBqDFmzXa3knOTeN+EUYRR
         emIoySg35EfQhjKaVuPZG05qo+6uoAAggdugXeP6DrzPwlkwsjjdHHKY3vQWjhyzkMKu
         aGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XftDDHJLGP4abIDDD34XPeZJNkIQZFz4M9hvz8t7ynw=;
        b=COMg0PEkZlhugSYJ3a58SFKcXCk2Cm6pv4LT/mFzS4j0ME3jwRz2sg2+GrxyeCg5I7
         qUDVR54UGhRseZYdan19qcg4eJk2gt8j7uJvW4TqC0DoPC5zCDADx4riYScQxgLqU2Ay
         815IIzYnYkhQYJ0bRyPSkymBZd6RJvYt1Gr6/ZGma7BWH4O8ZxzeJ5y4WlAnpnlemrsj
         gdaQGeMq3cZltiwj3rOZn0FMLojCOpwlPimXCJ/2vW80+fYN5tiJD1PyBPavCcGhXAxq
         KQG4Szfp1M3K9QMJM275mX+kSDzctp9WBSoZ8LU2ZFQxL0b6H8WRe3G7Z2cO4M8xTMN0
         tUwg==
X-Gm-Message-State: AOAM533h0PAyxHcnUlPgG1Dr730voWGMXNPqciQ926zq7ydrIQmFFSoI
        2x2jY9lCPSAc1TIP/gWX+p99qNCD
X-Google-Smtp-Source: ABdhPJyB0bbxGkKo34d8X1wyqipu5uIttuzKXyLWFM1vYs9AxN1p3iX7klG+beoKnzeDAKnQsCBHFw==
X-Received: by 2002:a17:906:fac3:: with SMTP id lu3mr22409948ejb.374.1593731477685;
        Thu, 02 Jul 2020 16:11:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/15] cleanup: move predefines in a separate file
Date:   Fri,  3 Jul 2020 01:10:37 +0200
Message-Id: <20200702231039.55015-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that option parsing have moved to a separate file, move
everything related to predefined macros to a separate file too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile    |   1 +
 lib.c       | 221 ---------------------------------------------------
 lib.h       |   1 +
 predefine.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 221 deletions(-)
 create mode 100644 predefine.c

diff --git a/Makefile b/Makefile
index dce666d27c41..f4483f5a1deb 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,7 @@ LIB_OBJS += opcode.o
 LIB_OBJS += optimize.o
 LIB_OBJS += options.o
 LIB_OBJS += parse.o
+LIB_OBJS += predefine.o
 LIB_OBJS += pre-process.o
 LIB_OBJS += ptrlist.o
 LIB_OBJS += ptrmap.o
diff --git a/lib.c b/lib.c
index 53b107d2d063..fd1fe6cb3ba5 100644
--- a/lib.c
+++ b/lib.c
@@ -248,227 +248,6 @@ void add_pre_buffer(const char *fmt, ...)
 	pre_buffer_end = end;
 }
 
-////////////////////////////////////////////////////////////////////////////////
-// Predefines
-
-#define	PTYPE_SIZEOF	(1U << 0)
-#define	PTYPE_T		(1U << 1)
-#define	PTYPE_MAX	(1U << 2)
-#define	PTYPE_MIN	(1U << 3)
-#define	PTYPE_WIDTH	(1U << 4)
-#define	PTYPE_TYPE	(1U << 5)
-#define	PTYPE_ALL	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH)
-#define	PTYPE_ALL_T	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH|PTYPE_T)
-
-static void predefined_sizeof(const char *name, const char *suffix, unsigned bits)
-{
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__SIZEOF_%s%s__", name, suffix);
-	predefine(buf, 1, "%d", bits/8);
-}
-
-static void predefined_width(const char *name, unsigned bits)
-{
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_WIDTH__", name);
-	predefine(buf, 1, "%d", bits);
-}
-
-static void predefined_max(const char *name, struct symbol *type)
-{
-	const char *suffix = builtin_type_suffix(type);
-	unsigned bits = type->bit_size - is_signed_type(type);
-	unsigned long long max = bits_mask(bits);
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_MAX__", name);
-	predefine(buf, 1, "%#llx%s", max, suffix);
-}
-
-static void predefined_min(const char *name, struct symbol *type)
-{
-	const char *suffix = builtin_type_suffix(type);
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_MIN__", name);
-
-	if (is_signed_type(type))
-		predefine(buf, 1, "(-__%s_MAX__ - 1)", name);
-	else
-		predefine(buf, 1, "0%s", suffix);
-}
-
-static void predefined_type(const char *name, struct symbol *type)
-{
-	const char *typename = builtin_typename(type);
-	add_pre_buffer("#weak_define __%s_TYPE__ %s\n", name, typename);
-}
-
-static void predefined_ctype(const char *name, struct symbol *type, int flags)
-{
-	unsigned bits = type->bit_size;
-
-	if (flags & PTYPE_SIZEOF) {
-		const char *suffix = (flags & PTYPE_T) ? "_T" : "";
-		predefined_sizeof(name, suffix, bits);
-	}
-	if (flags & PTYPE_MAX)
-		predefined_max(name, type);
-	if (flags & PTYPE_MIN)
-		predefined_min(name, type);
-	if (flags & PTYPE_TYPE)
-		predefined_type(name, type);
-	if (flags & PTYPE_WIDTH)
-		predefined_width(name, bits);
-}
-
-static void predefined_macros(void)
-{
-	predefine("__CHECKER__", 0, "1");
-	predefine("__GNUC__", 1, "%d", gcc_major);
-	predefine("__GNUC_MINOR__", 1, "%d", gcc_minor);
-	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
-
-	predefine("__STDC__", 1, "1");
-	predefine("__STDC_HOSTED__", 0, fhosted ? "1" : "0");
-	switch (standard) {
-	default:
-		break;
-
-	case STANDARD_C94:
-		predefine("__STDC_VERSION__", 1, "199409L");
-		break;
-
-	case STANDARD_C99:
-	case STANDARD_GNU99:
-		predefine("__STDC_VERSION__", 1, "199901L");
-		break;
-
-	case STANDARD_C11:
-	case STANDARD_GNU11:
-		predefine("__STDC_VERSION__", 1, "201112L");
-		break;
-	case STANDARD_C17:
-	case STANDARD_GNU17:
-		predefine("__STDC_VERSION__", 1, "201710L");
-		break;
-	}
-	if (!(standard & STANDARD_GNU) && (standard != STANDARD_NONE))
-		predefine("__STRICT_ANSI__", 1, "1");
-	if (standard >= STANDARD_C11) {
-		predefine("__STDC_NO_ATOMICS__", 1, "1");
-		predefine("__STDC_NO_COMPLEX__", 1, "1");
-		predefine("__STDC_NO_THREADS__", 1, "1");
-	}
-
-	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
-	if (funsigned_char)
-		predefine("__CHAR_UNSIGNED__", 1, "1");
-
-	predefined_ctype("SHORT",     &short_ctype, PTYPE_SIZEOF);
-	predefined_ctype("SHRT",      &short_ctype, PTYPE_MAX|PTYPE_WIDTH);
-	predefined_ctype("SCHAR",     &schar_ctype, PTYPE_MAX|PTYPE_WIDTH);
-	predefined_ctype("WCHAR",      wchar_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
-	predefined_ctype("WINT",        wint_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
-	predefined_ctype("CHAR16",   &ushort_ctype, PTYPE_TYPE);
-	predefined_ctype("CHAR32",    uint32_ctype, PTYPE_TYPE);
-
-	predefined_ctype("INT",         &int_ctype, PTYPE_ALL);
-	predefined_ctype("LONG",       &long_ctype, PTYPE_ALL);
-	predefined_ctype("LONG_LONG", &llong_ctype, PTYPE_ALL);
-
-	predefined_ctype("INT8",      &schar_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT8",     &uchar_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT16",     &short_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT16",   &ushort_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT32",      int32_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT32",    uint32_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT64",      int64_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT64",    uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
-
-	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
-	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
-	predefined_ctype("UINTPTR",   size_t_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
-	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
-	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
-
-	predefined_sizeof("FLOAT", "", bits_in_float);
-	predefined_sizeof("DOUBLE", "", bits_in_double);
-	predefined_sizeof("LONG_DOUBLE", "", bits_in_longdouble);
-
-	if (arch_target->has_int128)
-		predefined_sizeof("INT128", "", 128);
-
-	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
-	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
-	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
-	if (arch_big_endian) {
-		predefine("__BIG_ENDIAN__", 1, "1");
-		predefine("__BYTE_ORDER__", 1, "__ORDER_BIG_ENDIAN__");
-	} else {
-		predefine("__LITTLE_ENDIAN__", 1, "1");
-		predefine("__BYTE_ORDER__", 1, "__ORDER_LITTLE_ENDIAN__");
-	}
-
-	if (optimize_level)
-		predefine("__OPTIMIZE__", 0, "1");
-	if (optimize_size)
-		predefine("__OPTIMIZE_SIZE__", 0, "1");
-
-	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
-
-	// Temporary hacks
-	predefine("__extension__", 0, NULL);
-	predefine("__pragma__", 0, NULL);
-
-	switch (arch_m64) {
-	case ARCH_LP32:
-		break;
-	case ARCH_X32:
-		predefine("__ILP32__", 1, "1");
-		predefine("_ILP32", 1, "1");
-		break;
-	case ARCH_LP64:
-		predefine("__LP64__", 1, "1");
-		predefine("_LP64", 1, "1");
-		break;
-	case ARCH_LLP64:
-		predefine("__LLP64__", 1, "1");
-		break;
-	}
-
-	if (fpic) {
-		predefine("__pic__", 0, "%d", fpic);
-		predefine("__PIC__", 0, "%d", fpic);
-	}
-	if (fpie) {
-		predefine("__pie__", 0, "%d", fpie);
-		predefine("__PIE__", 0, "%d", fpie);
-	}
-
-	if (arch_target->predefine)
-		arch_target->predefine(arch_target);
-
-	if (arch_os >= OS_UNIX) {
-		predefine("__unix__", 1, "1");
-		predefine("__unix", 1, "1");
-		predefine_nostd("unix");
-	}
-
-	if (arch_os == OS_SUNOS) {
-		predefine("__sun__", 1, "1");
-		predefine("__sun", 1, "1");
-		predefine_nostd("sun");
-		predefine("__svr4__", 1, "1");
-	}
-}
-
-////////////////////////////////////////////////////////////////////////////////
-
 static void create_builtin_stream(void)
 {
 	// Temporary hack
diff --git a/lib.h b/lib.h
index b47505f638b4..81253a3e7ee5 100644
--- a/lib.h
+++ b/lib.h
@@ -130,6 +130,7 @@ enum phase {
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 extern void predefine(const char *name, int weak, const char *fmt, ...) FORMAT_ATTR(3);
 extern void predefine_nostd(const char *name);
+extern void predefined_macros(void);
 
 
 extern void dump_macro_definitions(void);
diff --git a/predefine.c b/predefine.c
new file mode 100644
index 000000000000..ff457b389480
--- /dev/null
+++ b/predefine.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: MIT
+// Copyright (C) 2017-2020 Luc Van Oostenryck.
+
+#include <stdio.h>
+
+#include "lib.h"
+#include "machine.h"
+#include "symbol.h"
+
+#define PTYPE_SIZEOF	(1U << 0)
+#define PTYPE_T		(1U << 1)
+#define PTYPE_MAX	(1U << 2)
+#define PTYPE_MIN	(1U << 3)
+#define PTYPE_WIDTH	(1U << 4)
+#define PTYPE_TYPE	(1U << 5)
+#define PTYPE_ALL	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH)
+#define PTYPE_ALL_T	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH|PTYPE_T)
+
+
+static void predefined_sizeof(const char *name, const char *suffix, unsigned bits)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__SIZEOF_%s%s__", name, suffix);
+	predefine(buf, 1, "%d", bits/8);
+}
+
+static void predefined_width(const char *name, unsigned bits)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_WIDTH__", name);
+	predefine(buf, 1, "%d", bits);
+}
+
+static void predefined_max(const char *name, struct symbol *type)
+{
+	const char *suffix = builtin_type_suffix(type);
+	unsigned bits = type->bit_size - is_signed_type(type);
+	unsigned long long max = bits_mask(bits);
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_MAX__", name);
+	predefine(buf, 1, "%#llx%s", max, suffix);
+}
+
+static void predefined_min(const char *name, struct symbol *type)
+{
+	const char *suffix = builtin_type_suffix(type);
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_MIN__", name);
+
+	if (is_signed_type(type))
+		predefine(buf, 1, "(-__%s_MAX__ - 1)", name);
+	else
+		predefine(buf, 1, "0%s", suffix);
+}
+
+static void predefined_type(const char *name, struct symbol *type)
+{
+	const char *typename = builtin_typename(type);
+	add_pre_buffer("#weak_define __%s_TYPE__ %s\n", name, typename);
+}
+
+static void predefined_ctype(const char *name, struct symbol *type, int flags)
+{
+	unsigned bits = type->bit_size;
+
+	if (flags & PTYPE_SIZEOF) {
+		const char *suffix = (flags & PTYPE_T) ? "_T" : "";
+		predefined_sizeof(name, suffix, bits);
+	}
+	if (flags & PTYPE_MAX)
+		predefined_max(name, type);
+	if (flags & PTYPE_MIN)
+		predefined_min(name, type);
+	if (flags & PTYPE_TYPE)
+		predefined_type(name, type);
+	if (flags & PTYPE_WIDTH)
+		predefined_width(name, bits);
+}
+
+void predefined_macros(void)
+{
+	predefine("__CHECKER__", 0, "1");
+	predefine("__GNUC__", 1, "%d", gcc_major);
+	predefine("__GNUC_MINOR__", 1, "%d", gcc_minor);
+	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
+
+	predefine("__STDC__", 1, "1");
+	predefine("__STDC_HOSTED__", 0, fhosted ? "1" : "0");
+	switch (standard) {
+	default:
+		break;
+
+	case STANDARD_C94:
+		predefine("__STDC_VERSION__", 1, "199409L");
+		break;
+
+	case STANDARD_C99:
+	case STANDARD_GNU99:
+		predefine("__STDC_VERSION__", 1, "199901L");
+		break;
+
+	case STANDARD_C11:
+	case STANDARD_GNU11:
+		predefine("__STDC_VERSION__", 1, "201112L");
+		break;
+	case STANDARD_C17:
+	case STANDARD_GNU17:
+		predefine("__STDC_VERSION__", 1, "201710L");
+		break;
+	}
+	if (!(standard & STANDARD_GNU) && (standard != STANDARD_NONE))
+		predefine("__STRICT_ANSI__", 1, "1");
+	if (standard >= STANDARD_C11) {
+		predefine("__STDC_NO_ATOMICS__", 1, "1");
+		predefine("__STDC_NO_COMPLEX__", 1, "1");
+		predefine("__STDC_NO_THREADS__", 1, "1");
+	}
+
+	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
+	if (funsigned_char)
+		predefine("__CHAR_UNSIGNED__", 1, "1");
+
+	predefined_ctype("SHORT",     &short_ctype, PTYPE_SIZEOF);
+	predefined_ctype("SHRT",      &short_ctype, PTYPE_MAX|PTYPE_WIDTH);
+	predefined_ctype("SCHAR",     &schar_ctype, PTYPE_MAX|PTYPE_WIDTH);
+	predefined_ctype("WCHAR",      wchar_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
+	predefined_ctype("WINT",        wint_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
+	predefined_ctype("CHAR16",   &ushort_ctype, PTYPE_TYPE);
+	predefined_ctype("CHAR32",    uint32_ctype, PTYPE_TYPE);
+
+	predefined_ctype("INT",         &int_ctype, PTYPE_ALL);
+	predefined_ctype("LONG",       &long_ctype, PTYPE_ALL);
+	predefined_ctype("LONG_LONG", &llong_ctype, PTYPE_ALL);
+
+	predefined_ctype("INT8",      &schar_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT8",     &uchar_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT16",     &short_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT16",   &ushort_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT32",      int32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT32",    uint32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT64",      int64_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT64",    uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
+
+	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINTPTR",   size_t_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
+	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
+	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
+
+	predefined_sizeof("FLOAT", "", bits_in_float);
+	predefined_sizeof("DOUBLE", "", bits_in_double);
+	predefined_sizeof("LONG_DOUBLE", "", bits_in_longdouble);
+
+	if (arch_target->has_int128)
+		predefined_sizeof("INT128", "", 128);
+
+	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
+	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
+	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
+	if (arch_big_endian) {
+		predefine("__BIG_ENDIAN__", 1, "1");
+		predefine("__BYTE_ORDER__", 1, "__ORDER_BIG_ENDIAN__");
+	} else {
+		predefine("__LITTLE_ENDIAN__", 1, "1");
+		predefine("__BYTE_ORDER__", 1, "__ORDER_LITTLE_ENDIAN__");
+	}
+
+	if (optimize_level)
+		predefine("__OPTIMIZE__", 0, "1");
+	if (optimize_size)
+		predefine("__OPTIMIZE_SIZE__", 0, "1");
+
+	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
+
+	// Temporary hacks
+	predefine("__extension__", 0, NULL);
+	predefine("__pragma__", 0, NULL);
+
+	switch (arch_m64) {
+	case ARCH_LP32:
+		break;
+	case ARCH_X32:
+		predefine("__ILP32__", 1, "1");
+		predefine("_ILP32", 1, "1");
+		break;
+	case ARCH_LP64:
+		predefine("__LP64__", 1, "1");
+		predefine("_LP64", 1, "1");
+		break;
+	case ARCH_LLP64:
+		predefine("__LLP64__", 1, "1");
+		break;
+	}
+
+	if (fpic) {
+		predefine("__pic__", 0, "%d", fpic);
+		predefine("__PIC__", 0, "%d", fpic);
+	}
+	if (fpie) {
+		predefine("__pie__", 0, "%d", fpie);
+		predefine("__PIE__", 0, "%d", fpie);
+	}
+
+	if (arch_target->predefine)
+		arch_target->predefine(arch_target);
+
+	if (arch_os >= OS_UNIX) {
+		predefine("__unix__", 1, "1");
+		predefine("__unix", 1, "1");
+		predefine_nostd("unix");
+	}
+
+	if (arch_os == OS_SUNOS) {
+		predefine("__sun__", 1, "1");
+		predefine("__sun", 1, "1");
+		predefine_nostd("sun");
+		predefine("__svr4__", 1, "1");
+	}
+}
-- 
2.27.0

