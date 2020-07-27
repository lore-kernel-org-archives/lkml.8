Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B601AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840EB206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgG0Vuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:50:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36438 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Vuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id g26so16852580qka.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1Rnn4vCkQ65/r9EgXb15c20xR4qwlNC9n/tWJktCdE=;
        b=bevj1rMhuvv6uyBAK3k0bT3w9YbQ8gc4yGGxaSX28JKSV5xwxIQZq8nZXJBeDl+Vxc
         5aMk9oVWUIbvC7uHNK2BDC4Oe44gP0lSmnwbZHgPgUuTA4XkWpYflceNXTcZ3EpDey4C
         kJqJu1Bdk8CTInidDH9LrIdLl6ylDQn003dH+n2rcxGf7DcJlw94EMR+M5Lt2SizavoA
         ws7l/wpZKryKGHKRzBLREMjnxxP0EHjR49YKjOLBA9fC8ocr+//NIgKTq7xM5rc3cAfE
         0UVQ1L4w4tHFCg5flWV0WlgLmroavijRngeYFMEKoZcjOp5tPyWT7fvwt7AISQf8u1NI
         +USQ==
X-Gm-Message-State: AOAM532LqM2QsWuCAUmUCoojMX1BNz/mIzXELmCk7T9i6DiOQOI2ikYc
        Rhf57Jjc1/gyb6lGEVmQt94mWvBl
X-Google-Smtp-Source: ABdhPJwUGUX9TSFI5E7wxj7zw0hzZOUDIZCMtIVhdqDvFhBOaT4ObjCMmW/tTOJ31S9JvfuY9mocyw==
X-Received: by 2002:a37:6c3:: with SMTP id 186mr19768572qkg.457.1595886651272;
        Mon, 27 Jul 2020 14:50:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] x86/kaslr: Remove bogus warning and unnecessary goto
Date:   Mon, 27 Jul 2020 17:50:41 -0400
Message-Id: <20200727215047.3341098-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the warning on seeing "--" in handle_mem_options. This will trigger
whenever one of the memory options is present in the command line
together with "--", but there's no problem if that is the case.

Replace goto with break.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a4af89646094..21cd9e07f1f6 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -295,10 +295,8 @@ static void handle_mem_options(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 		/* Stop at -- */
-		if (!val && strcmp(param, "--") == 0) {
-			warn("Only '--' specified in cmdline");
-			goto out;
-		}
+		if (!val && strcmp(param, "--") == 0)
+			break;
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
@@ -311,7 +309,7 @@ static void handle_mem_options(void)
 				continue;
 			mem_size = memparse(p, &p);
 			if (mem_size == 0)
-				goto out;
+				break;
 
 			mem_limit = mem_size;
 		} else if (!strcmp(param, "efi_fake_mem")) {
@@ -319,7 +317,6 @@ static void handle_mem_options(void)
 		}
 	}
 
-out:
 	free(tmp_cmdline);
 	return;
 }
-- 
2.26.2

