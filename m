Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A45AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BCF206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 01:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHCBPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:15:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33140 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHCBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 21:15:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id 6so27200491qtt.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 18:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqKzpllSGPPCUJdcTHjuzKk2JONMRxxf8Mio+enWVv8=;
        b=OKAA42CZW6QFPqdsMvPQKYQAZcpP3XSb0FezPhNQu03U47jQ7krL6OZ5RN4rKxOp09
         9/Zp8grlGx09aOmebwew3aQWfFoSU4H82s0bPnYjZbNUyk9vku2Fw6OrKgsQKlmcrGsJ
         hdajTB0hzDpCzQHwE30CTb5eMfG5x+/4aRHq2GZNpeXPrrhtQfX5YyBXQBpe0TZrHCfl
         cmuOH9j3/c/T2BEPAslvtJwJQwSPzl3tp/HvjZNazdiy+iuExkhtKKldVlB1JEX712bX
         OazPCtIevBOz6Xh3jmp/NbPXuwvtInl77U9ie1ZCzQEogAkBD3CwQdudV01ES5suCGZz
         ARXw==
X-Gm-Message-State: AOAM532sN8y/1TmBY09C8pgtfoWGsDm9q/CLXWqVPvEhf2yQTSRCvLQA
        0tV5mW3f9aUOEN8FdelJF/A=
X-Google-Smtp-Source: ABdhPJzSlBgKojdqHiyy+lQPi+zKAOWmuO450YLVtXJPXjHrO87Bq+y+l4yl8Pa0T/P4oK6Nz0TmYw==
X-Received: by 2002:aed:34e2:: with SMTP id x89mr14144623qtd.313.1596417336887;
        Sun, 02 Aug 2020 18:15:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q29sm22015801qtc.10.2020.08.02.18.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 18:15:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/kaslr: Replace strlen with strnlen
Date:   Sun,  2 Aug 2020 21:15:34 -0400
Message-Id: <20200803011534.730645-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803011534.730645-1-nivedita@alum.mit.edu>
References: <202007311632.54A7554192@keescook>
 <20200803011534.730645-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strnlen is safer in case the command line is not NUL-terminated.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 903ccdca0551..a5842eea84cb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -43,6 +43,10 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled;
 unsigned int pgdir_shift __ro_after_init = 39;
@@ -278,7 +282,7 @@ static void handle_mem_options(void)
 	if (!args)
 		return;
 
-	len = strlen(args);
+	len = strnlen(args, COMMAND_LINE_SIZE-1);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
 		error("Failed to allocate space for tmp_cmdline");
@@ -425,7 +429,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
 	if (cmd_line) {
-		cmd_line_size = strlen((char *)cmd_line) + 1;
+		cmd_line_size = strnlen((char *)cmd_line, COMMAND_LINE_SIZE-1) + 1;
 		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
 		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-- 
2.26.2

