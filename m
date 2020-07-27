Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF33C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDCA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgG0Vuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:50:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34089 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0Vuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so4944772qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKap99YMpd59dOGOX7zP3mBQNGnZwMBaTyLtvOGre74=;
        b=DYui5yupTx+ylvYnX4HKtYDA/0ZZuYurhqNAWuFDsH8Z+OI5bGQlV6Mf5IRrjjBFgT
         IUNPDGwXDWXHXL+jszXpFMOe5EA2Mur1HbmjYhZwVF7AeBFYX2BRFZtf1dngDCqREkET
         jISwWRGk6JcE8x7EJHPJAIMSabVuwzc1y60AUUV8g6Z+TaKvZVzVrKAyT3oQsdnOFbaq
         dj+8GJAqi+DRbeU6HONA4SIfzrTOY8QffzG6JGvfxd3FuD3Z3SZkcG+RjJB0MMm37STy
         NT++CtqzQ3G5GDQyegPX/8H1hsMfy+6kizWi+5hl7mOvxHCb5b4F//VUPCoJW+OgdtvL
         oXLg==
X-Gm-Message-State: AOAM532wJDGIUbZjlHGhclWbmIURzpEvgbr1geMCFvuJ6wviFpU143pS
        qhhQR3z/47UnUtnf65mazJY=
X-Google-Smtp-Source: ABdhPJw+82hd4lKnqvJWnpV7E2hfTuXOAky+bRh08oMQFdgdxgPzDPE21pi0zqp2cwDGeCf6s+KPbQ==
X-Received: by 2002:ac8:4e86:: with SMTP id 6mr24453080qtp.341.1595886650384;
        Mon, 27 Jul 2020 14:50:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] x86/kaslr: Make command line handling safer
Date:   Mon, 27 Jul 2020 17:50:40 -0400
Message-Id: <20200727215047.3341098-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
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
 arch/x86/boot/compressed/kaslr.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..a4af89646094 100644
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
+	unsigned long cmd_line, cmd_line_size = 0;
 
 	/*
 	 * Avoid the region that is unsafe to overlap during
@@ -421,12 +424,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* No need to set mapping for initrd, it will be handled in VO. */
 
 	/* Avoid kernel command line. */
-	cmd_line  = (u64)boot_params->ext_cmd_line_ptr << 32;
-	cmd_line |= boot_params->hdr.cmd_line_ptr;
+	cmd_line = get_cmd_line_ptr();
 	/* Calculate size of cmd_line. */
-	ptr = (char *)(unsigned long)cmd_line;
-	for (cmd_line_size = 0; ptr[cmd_line_size++];)
-		;
+	if (cmd_line)
+		cmd_line_size = strlen((char *)cmd_line);
 	mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 	mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
 	add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-- 
2.26.2

