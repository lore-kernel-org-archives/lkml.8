Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E191FC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC943207BB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgIFPra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:47:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39463 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgIFPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:46:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id w12so10811132qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwfFY7TN/tKtx1/whrHCZkKmf/vlnao87UIaSBAnD6M=;
        b=TmolK0xPkn3hcaeoeb316dlk9+meudqGXCq0J72njHZjj0nRg9T6Gc1zkwJwXObdNu
         FSM8mvINwsxycDURjE3/+4I+J/oq0Gb0DeJA+led8fwGje+djTkXirFMBDTe5Ei03G0x
         SBIR4mA2ciR7WQQBrpPRVPc6lDnpaWaWtPYsUXZk4VfKvzrgQhxb6pPk4PPyWQbYEeKT
         64yjP0drYT7Jp23wE8PbWu/I+htgjdpPrjBRVj++hCpV3zTMyfdiDgxzXNwYrNM/Feyi
         Xg1VrYarcn4nXndKjJ0aZAWLmFn/oEzX/V1923OxoTIRzSKZV2JOF1O9hfsZ+IrCFIf0
         lw3Q==
X-Gm-Message-State: AOAM5309xGgObxsghtI3aFALlb8EV768crSlYeZIWc8vmBUqifPuFYpt
        LfUZ6Bfoaaz8NLk1E+6Qp8Q7i3Nh5AU=
X-Google-Smtp-Source: ABdhPJwVNYcWCwnQKJwB4b0AZCl9ORVySSJIv97QqSUD6+hjpJqR6USO9fdacEEQxDDfN5fQlIavKg==
X-Received: by 2002:a37:e103:: with SMTP id c3mr15760313qkm.90.1599407199227;
        Sun, 06 Sep 2020 08:46:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u55sm9774286qtu.42.2020.09.06.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 08:46:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cmdline: Disable instrumentation of cmdline unconditionally
Date:   Sun,  6 Sep 2020 11:46:37 -0400
Message-Id: <20200906154637.1618112-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit, cmdline_find_option_bool() is used before paging is enabled,
from check_loader_disabled_bsp() in the early microcode loader.
Instrumentation options that insert accesses to global data will likely
crash or corrupt memory at this point.

cmdline_find_option{,_bool}() are only used during boot, so
instrumentation is not that useful anyway.

Disable instrumentation unconditionally, and additionally disable:
- GCOV
- UBSAN
- tracing: change -pg -> CC_FLAGS_FTRACE
- STACKLEAK_PLUGIN
- BRANCH_PROFILING

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/lib/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index aa067859a70b..0ad4ae9def44 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -15,17 +15,19 @@ CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
 endif
 
 # Early boot use of cmdline; don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
+GCOV_PROFILE_cmdline.o    := n
 KCOV_INSTRUMENT_cmdline.o := n
 KASAN_SANITIZE_cmdline.o  := n
+UBSAN_SANITIZE_cmdline.o  := n
 KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
+CFLAGS_REMOVE_cmdline.o = $(CC_FLAGS_FTRACE)
 endif
 
 CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
-endif
+CFLAGS_cmdline.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_cmdline.o += -DDISABLE_BRANCH_PROFILING
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
-- 
2.26.2

