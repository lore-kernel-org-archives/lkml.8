Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68A020829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgG1W5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:50 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38388 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgG1W5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:33 -0400
Received: by mail-qv1-f66.google.com with SMTP id m9so9976402qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6HZ9zvu2ge9bSuVRCDsIjdzt9oaZjNfBsDumZVPTMo=;
        b=ZNSukRNI7nAREg/cSUgmtXUbGMN0yfqf/effYm8hnTmQI8pQBYStZxltem38EEPxQi
         l5HNcjcDBb9/om7fJEKk7vcMzDP+W0rkYmG54yjcQ684GBqIoINjeiycO1V/WNNVXYSZ
         MrMJwDH2hmulxRr5Gzb+ZkkTqcWvaKsSgw8U9j5xksayWd28ZeGKJ2hNTJxwG6mJPhDd
         ECzy1sxzBoW1fB0YhtDb9u9WD8dSJCQ09R4zZJ6HbsYFBG0lrntFaqCMr0PfjmRNeob1
         Ws8iQvbQYoOHk8PtMlncfpMqDG9x1oD2gkN59+jcsJBziLaMJ4rZ3zjdH8PJC3HyjfyU
         Srug==
X-Gm-Message-State: AOAM5307/Nza8XMT9Ag6wcWsOlj/Ae2WxDOiOnXu9Wu3nRQLXZmZGNku
        xraK2SZDDZ0O83GhCr6GyY8=
X-Google-Smtp-Source: ABdhPJy0LrtHXpy9GX+bs3RABWNg2LBvMgJ/JGJDWNAM7SW9ypXzjOqoto2zNFqcBEg3YwoVTOjY2w==
X-Received: by 2002:a0c:fc07:: with SMTP id z7mr1054532qvo.65.1595977052196;
        Tue, 28 Jul 2020 15:57:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/21] x86/kaslr: Short-circuit gb_huge_pages on x86-32
Date:   Tue, 28 Jul 2020 18:57:12 -0400
Message-Id: <20200728225722.67457-12-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit does not have GB pages, so don't bother checking for them. Using
the IS_ENABLED allows the compiler to completely remove the
gb_huge_pages code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0df513e3e2ce..3727e9708690 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -303,7 +303,7 @@ static void handle_mem_options(void)
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(PARSE_MEMMAP, val);
-		} else if (strstr(param, "hugepages")) {
+		} else if (IS_ENABLED(CONFIG_X86_64) && strstr(param, "hugepages")) {
 			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
@@ -551,7 +551,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 	struct mem_vector tmp;
 	int i = 0;
 
-	if (!max_gb_huge_pages) {
+	if (!IS_ENABLED(CONFIG_X86_64) || !max_gb_huge_pages) {
 		store_slot_info(region, image_size);
 		return;
 	}
-- 
2.26.2

