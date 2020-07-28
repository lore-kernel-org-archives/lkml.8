Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA99C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62592177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgG1W51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37296 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgG1W5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id d27so16233608qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CS3nkfur/wtuJwamFCyLW/VYOsPmVtLxcUoj/a554wA=;
        b=S8K5s3/78SDje7umSCqJVAwiQzUMg21GBy80Q013TpqodewusT+j465qya+3fCIKXt
         bukcSagLZX+J9mJyACfyAPXJt9HL4Rdw7L1wB8Sse2JZDtPyJhm1dOQH7kZrdtK9u2yh
         eET5XppLVljLQlJOrSJF1K0AjpjoH5EsGFwpwIICrUglNBslloCwf6Ra/G2YxJPTAoVT
         gfPOxEIkHECfS65cURM3SLa1r0DtQsfFQcfsK514Y3h4Gmb3rNRe0vlUyyv5TnDDuI7U
         9C8cXkixecCIEVnrRBSQGlDH0kSvWUgJWs9yzdqpzjnNwK4UybNk0nO4JUGyFK6S+ExH
         jbUw==
X-Gm-Message-State: AOAM533VjPgUK6jki+gsyQjGj5j0ER1tQYxstyd65ngjrKYceLjMV2SC
        AX7Uq4AwDAQfmlO6hVgaao/hE1gK
X-Google-Smtp-Source: ABdhPJz2gF7MBwHTZ+6JkTZecLG5muhCSW+YAgSnpDgOwMyhQZ593/poyNDtpiYnFD9sJMX9zjLt0g==
X-Received: by 2002:aed:364a:: with SMTP id e68mr12835879qtb.260.1595977044372;
        Tue, 28 Jul 2020 15:57:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/21] x86/kaslr: Make command line handling safer
Date:   Tue, 28 Jul 2020 18:57:02 -0400
Message-Id: <20200728225722.67457-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the possibility that the command line is NULL.

Replace open-coded strlen with a function call.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..e0f69f3625ae 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -268,15 +268,19 @@ static void parse_gb_huge_pages(char *param, char *val)
 static void handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
-	size_t len = strlen((char *)args);
+	size_t len;
 	char *tmp_cmdline;
 	char *param, *val;
 	u64 mem_size;
 
+	if (!args)
+		return;
+
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
 		!strstr(args, "hugepages"))
 		return;
 
+	len = strlen(args);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
 		error("Failed to allocate space for tmp_cmdline");
@@ -399,8 +403,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 {
 	unsigned long init_size = boot_params->hdr.init_size;
 	u64 initrd_start, initrd_size;
-	u64 cmd_line, cmd_line_size;
-	char *ptr;
+	unsigned long cmd_line, cmd_line_size;
 
 	/*
 	 * Avoid the region that is unsafe to overlap during
@@ -421,16 +424,15 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* No need to set mapping for initrd, it will be handled in VO. */
 
 	/* Avoid kernel command line. */
-	cmd_line  = (u64)boot_params->ext_cmd_line_ptr << 32;
-	cmd_line |= boot_params->hdr.cmd_line_ptr;
+	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
-	ptr = (char *)(unsigned long)cmd_line;
-	for (cmd_line_size = 0; ptr[cmd_line_size++];)
-		;
-	mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
-	mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
-	add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-			 mem_avoid[MEM_AVOID_CMDLINE].size);
+	if (cmd_line) {
+		cmd_line_size = strlen((char *)cmd_line) + 1;
+		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
+		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
+		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
+				 mem_avoid[MEM_AVOID_CMDLINE].size);
+	}
 
 	/* Avoid boot parameters. */
 	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
-- 
2.26.2

