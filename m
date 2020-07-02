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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC4D2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sA1QpfBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgGBXLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgGBXLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC1C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so31751994ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jd5OyA62jQVyFQS+Wq/MjJJlFxvsmVOnF8emDjOOsMo=;
        b=sA1QpfBd76owcllub48ojOBB4hrz5bMN5CFU6w9NpW3Xalt4ecbLf8GgC+08DGZmqq
         jIkXFUOl6GhEX4/050tdKZ9bWvWUSM50C1MVWudkBOWoHzkgKk1TlHmtOtDokw1Eixnu
         gNMm6ybIdPku0Y5eh5UF3wbP0F4IxSTjMA5wEiSHY7Acgethvb3iBdFVdfBVQtBy/Jqb
         yknLtNyTj18LqP7Bu5kKmpXB1rwZG31U9dpSupQUVIFDOIr+s2fTh/ZLHhuiZ43UFlQa
         BjrOwhmGQ77rPSaMCbI+2un/Joh6LlLj5RXA8n1PkeIyq3Ifa0BMrpIGMhhTj2jmLKIW
         iWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd5OyA62jQVyFQS+Wq/MjJJlFxvsmVOnF8emDjOOsMo=;
        b=skQPr0f018WAisN6JYKinenIann8VNEqEY0dkyY/ZPNtrN9LAksF8Z8lQMA+hB7lW+
         TPX6hvSQgMcGe+VBvBDTsyKBKuB9Et/ZW7vaqdvkGghxMkffEqsGqtE8kT5A3U16wC0t
         5zZK3vz2YjuViz/Ns5s0BHqWklcH6FjJAlUC2usZOukx0aNu4NUPNwJZfO/4tS2gi4Nh
         bIffHiJ3S8wc29znBwu/VXBTSdwD7qNbiCR8aqrsbK4ojXGywOUcCV9ydLfj645pfKX+
         /Hc85zMkhH/TU4WkCft6EN7zBx3ZF/ovhjxkuQpTJrcx5hAhlyOSUPSaOOdxqq1R+pCS
         V4xw==
X-Gm-Message-State: AOAM531l6fq3vqKTVSYui6FPJN7zXrSUZtajdTmOTpB8zWOxhGwWBCTL
        UCN7whKAG/w84DBJI3drI4TaSLx7
X-Google-Smtp-Source: ABdhPJyqxw7ZvtPVgnaerdULLZOuq0rT64ji6ODuxQYI7clvuu4PlTcba96E8JEeQHg4hPal2gJKtA==
X-Received: by 2002:a17:906:784c:: with SMTP id p12mr29556705ejm.123.1593731476582;
        Thu, 02 Jul 2020 16:11:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/15] options: keep the options sorted
Date:   Fri,  3 Jul 2020 01:10:36 +0200
Message-Id: <20200702231039.55015-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declarations and definitions of the variables corresponding to
the options half-sorted half-unsorted.

Sort them a little more.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c |  98 +++++++++++++++++++-------------------
 options.h | 137 ++++++++++++++++++++++++++++--------------------------
 2 files changed, 120 insertions(+), 115 deletions(-)

diff --git a/options.c b/options.c
index 092c8690d054..9f05bdf9cf4f 100644
--- a/options.c
+++ b/options.c
@@ -18,20 +18,33 @@
 #include <string.h>
 
 
-int verbose, optimize_level, optimize_size, preprocessing;
-int die_if_error = 0;
-int has_error = 0;
-int do_output = 1;
-
 #ifndef __GNUC__
 # define __GNUC__ 2
 # define __GNUC_MINOR__ 95
 # define __GNUC_PATCHLEVEL__ 0
 #endif
 
+enum flag_type {
+	FLAG_OFF,
+	FLAG_ON,
+	FLAG_FORCE_OFF
+};
+
+int die_if_error = 0;
+int do_output = 1;
 int gcc_major = __GNUC__;
 int gcc_minor = __GNUC_MINOR__;
 int gcc_patchlevel = __GNUC_PATCHLEVEL__;
+int has_error = 0;
+int optimize_level;
+int optimize_size;
+int preprocess_only;
+int preprocessing;
+int verbose;
+
+#define CMDLINE_INCLUDE 20
+int cmdline_include_nr = 0;
+char *cmdline_include[CMDLINE_INCLUDE];
 
 const char *base_filename;
 const char *diag_prefix = "";
@@ -39,11 +52,35 @@ const char *gcc_base_dir = GCC_BASE;
 const char *multiarch_dir = MULTIARCH_TRIPLET;
 const char *outfile = NULL;
 
-enum flag_type {
-	FLAG_OFF,
-	FLAG_ON,
-	FLAG_FORCE_OFF
-};
+enum standard standard = STANDARD_GNU89;
+
+int arch_big_endian = ARCH_BIG_ENDIAN;
+int arch_cmodel = CMODEL_UNKNOWN;
+int arch_fp_abi = FP_ABI_NATIVE;
+int arch_m64 = ARCH_M64_DEFAULT;
+int arch_msize_long = 0;
+int arch_os = OS_NATIVE;
+
+int dbg_compound = 0;
+int dbg_dead = 0;
+int dbg_domtree = 0;
+int dbg_entry = 0;
+int dbg_ir = 0;
+int dbg_postorder = 0;
+
+int dump_macro_defs = 0;
+int dump_macros_only = 0;
+
+unsigned long fdump_ir;
+int fhosted = 1;
+unsigned int fmax_warnings = 100;
+int fmem_report = 0;
+unsigned long long fmemcpy_max_count = 100000;
+unsigned long fpasses = ~0UL;
+int fpic = 0;
+int fpie = 0;
+int fshort_wchar = 0;
+int funsigned_char = 0;
 
 int Waddress = 0;
 int Waddress_space = 1;
@@ -60,11 +97,11 @@ int Wdeclarationafterstatement = -1;
 int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
 int Wdo_while = 0;
+int Wenum_mismatch = 1;
+int Wexternal_function_has_definition = 1;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
-int Wenum_mismatch = 1;
-int Wexternal_function_has_definition = 1;
 int Wmemcpy_max_count = 1;
 int Wnewline_eof = 1;
 int Wnon_pointer_null = 1;
@@ -95,43 +132,6 @@ int Wuniversal_initializer = 0;
 int Wunknown_attribute = 0;
 int Wvla = 1;
 
-int dump_macro_defs = 0;
-int dump_macros_only = 0;
-
-int dbg_compound = 0;
-int dbg_dead = 0;
-int dbg_domtree = 0;
-int dbg_entry = 0;
-int dbg_ir = 0;
-int dbg_postorder = 0;
-
-unsigned long fdump_ir;
-int fhosted = 1;
-unsigned int fmax_warnings = 100;
-int fmem_report = 0;
-unsigned long long fmemcpy_max_count = 100000;
-unsigned long fpasses = ~0UL;
-int fpic = 0;
-int fpie = 0;
-int fshort_wchar = 0;
-int funsigned_char = 0;
-
-int preprocess_only;
-
-enum standard standard = STANDARD_GNU89;
-
-int arch_msize_long = 0;
-int arch_m64 = ARCH_M64_DEFAULT;
-int arch_big_endian = ARCH_BIG_ENDIAN;
-int arch_fp_abi = FP_ABI_NATIVE;
-int arch_os = OS_NATIVE;
-int arch_cmodel = CMODEL_UNKNOWN;
-
-
-#define CMDLINE_INCLUDE 20
-int cmdline_include_nr = 0;
-char *cmdline_include[CMDLINE_INCLUDE];
-
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
 
diff --git a/options.h b/options.h
index 52d1106e7576..7fd01ec6cebe 100644
--- a/options.h
+++ b/options.h
@@ -1,26 +1,85 @@
 #ifndef OPTIONS_H
 #define OPTIONS_H
 
-extern int verbose, optimize_level, optimize_size, preprocessing;
+enum {
+	CMODEL_UNKNOWN,
+	CMODEL_KERNEL,
+	CMODEL_LARGE,
+	CMODEL_MEDANY,
+	CMODEL_MEDIUM,
+	CMODEL_MEDLOW,
+	CMODEL_PIC,
+	CMODEL_SMALL,
+	CMODEL_TINY,
+	CMODEL_LAST,
+};
+
+enum standard {
+	STANDARD_NONE,
+	STANDARD_GNU,
+	STANDARD_C89,
+	STANDARD_GNU89 = STANDARD_C89 | STANDARD_GNU,
+	STANDARD_C94,
+	STANDARD_GNU94 = STANDARD_C94 | STANDARD_GNU,
+	STANDARD_C99,
+	STANDARD_GNU99 = STANDARD_C99 | STANDARD_GNU,
+	STANDARD_C11,
+	STANDARD_GNU11 = STANDARD_C11 | STANDARD_GNU,
+	STANDARD_C17,
+	STANDARD_GNU17 = STANDARD_C17 | STANDARD_GNU,
+};
+
 extern int die_if_error;
-extern int repeat_phase;
 extern int do_output;
-extern int gcc_major, gcc_minor, gcc_patchlevel;
-extern unsigned int tabstop;
+extern int gcc_major;
+extern int gcc_minor;
+extern int gcc_patchlevel;
+extern int optimize_level;
+extern int optimize_size;
+extern int preprocess_only;
+extern int preprocessing;
+extern int repeat_phase;
+extern int verbose;
+
+extern int cmdline_include_nr;
+extern char *cmdline_include[];
 
 extern const char *base_filename;
 extern const char *diag_prefix;
 extern const char *gcc_base_dir;
 extern const char *multiarch_dir;
 extern const char *outfile;
-extern int cmdline_include_nr;
-extern char *cmdline_include[];
 
-extern char **handle_switch(char *arg, char **next);
-extern void handle_switch_finalize(void);
+extern enum standard standard;
+extern unsigned int tabstop;
 
+extern int arch_big_endian;
+extern int arch_cmodel;
+extern int arch_fp_abi;
+extern int arch_m64;
+extern int arch_msize_long;
+extern int arch_os;
 
-extern int preprocess_only;
+extern int dbg_compound;
+extern int dbg_dead;
+extern int dbg_domtree;
+extern int dbg_entry;
+extern int dbg_ir;
+extern int dbg_postorder;
+
+extern int dump_macro_defs;
+extern int dump_macros_only;
+
+extern unsigned long fdump_ir;
+extern int fhosted;
+extern unsigned int fmax_warnings;
+extern int fmem_report;
+extern unsigned long long fmemcpy_max_count;
+extern unsigned long fpasses;
+extern int fpic;
+extern int fpie;
+extern int fshort_wchar;
+extern int funsigned_char;
 
 extern int Waddress;
 extern int Waddress_space;
@@ -39,7 +98,6 @@ extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
-extern int Wsparse_error;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
@@ -62,6 +120,7 @@ extern int Wshadow;
 extern int Wshift_count_negative;
 extern int Wshift_count_overflow;
 extern int Wsizeof_bool;
+extern int Wsparse_error;
 extern int Wstrict_prototypes;
 extern int Wtautological_compare;
 extern int Wtransparent_union;
@@ -72,61 +131,7 @@ extern int Wuniversal_initializer;
 extern int Wunknown_attribute;
 extern int Wvla;
 
-extern int dump_macro_defs;
-extern int dump_macros_only;
-
-extern int dbg_compound;
-extern int dbg_dead;
-extern int dbg_domtree;
-extern int dbg_entry;
-extern int dbg_ir;
-extern int dbg_postorder;
-
-extern unsigned int fmax_warnings;
-extern int fmem_report;
-extern unsigned long fdump_ir;
-extern int fhosted;
-extern unsigned long long fmemcpy_max_count;
-extern unsigned long fpasses;
-extern int fpic;
-extern int fpie;
-extern int fshort_wchar;
-extern int funsigned_char;
-
-extern int arch_msize_long;
-extern int arch_m64;
-extern int arch_big_endian;
-extern int arch_fp_abi;
-extern int arch_os;
-
-enum {
-	CMODEL_UNKNOWN,
-	CMODEL_KERNEL,
-	CMODEL_LARGE,
-	CMODEL_MEDANY,
-	CMODEL_MEDIUM,
-	CMODEL_MEDLOW,
-	CMODEL_PIC,
-	CMODEL_SMALL,
-	CMODEL_TINY,
-	CMODEL_LAST,
-};
-extern int arch_cmodel;
-
-enum standard {
-	STANDARD_NONE,
-	STANDARD_GNU,
-	STANDARD_C89,
-	STANDARD_GNU89 = STANDARD_C89 | STANDARD_GNU,
-	STANDARD_C94,
-	STANDARD_GNU94 = STANDARD_C94 | STANDARD_GNU,
-	STANDARD_C99,
-	STANDARD_GNU99 = STANDARD_C99 | STANDARD_GNU,
-	STANDARD_C11,
-	STANDARD_GNU11 = STANDARD_C11 | STANDARD_GNU,
-	STANDARD_C17,
-	STANDARD_GNU17 = STANDARD_C17 | STANDARD_GNU,
-};
-extern enum standard standard;
+extern char **handle_switch(char *arg, char **next);
+extern void handle_switch_finalize(void);
 
 #endif
-- 
2.27.0

