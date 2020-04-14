Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D432C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A8B206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reaaSqsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632873AbgDNUP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632823AbgDNUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:14:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B0FC0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:58:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y84so772949pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nxgycjZCK6bQ5TksD/KbhY7IXRvt1UDt7K60PjJOJP8=;
        b=reaaSqsDSb7MU9D89DGulCaGJQFBMZImkY9bkZDBFhJ0A+F/ibJ8fLskK6kTy1rqDY
         1g1cek9xaVK1K1GzRJxEjDrqJeIWwK95rrQno/wsthv6vS5xAaH9Q5uw9P4kLN+7oSau
         uiI0LBMvubr6PFG/F4L/WN/My/uC5tDAK65ezHSrUjlQij5UZviKicZsDsjbPBrOqf5h
         pys2sLm1iAEx9CWzMeyOwd6XNa5p32LeZW5FEbeCkewBXS3MkSv3aaQ3x3gMS9ntoON5
         CleMlNe/yR53PBjvsnGXc95UX/zpYDM5vaIqdLjk12vdFTsJuyEkuiHs3PMuPFuXaNUQ
         CWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nxgycjZCK6bQ5TksD/KbhY7IXRvt1UDt7K60PjJOJP8=;
        b=oTh9y3ztQd8n+tz7mqPGhBRFMugeo++rgyPuP4uMivM38JuAOoL5vG3kHu/gchOThN
         W51sPS0yAiGnShyt2cff4cSJ8x2J64SITjxQ+CwYuHrLLtTDbnurVuZtKJ7sfNdN57NA
         mCj7RjDaNZYAn59lnYEbQBMQQHfIbTtxykDwcJuj+UX5RQ0PvR9cbAhGHSqjbE8YoB/m
         YHC+LTXHzFrG/1NHxZmwLmqgXEt5mLRznHMtNMES2yYu3rqiKRhLTAqJFTfz1GUL9JwK
         +Q9i+XsN/cQ9ylQdhUGV5N4hOvZ1wN9jOvEBrW7bsNVtOzaoK6PJa63Ukz2KpEHShkV9
         tY7Q==
X-Gm-Message-State: AGi0PuaPSlcK1PFiUuaQ8iJGI6t6pGX8flrdBuRU53HP5exmytxUPRz6
        dCWG3idTisM8gwSBKXF/q/Pu6QNY
X-Google-Smtp-Source: APiQypKWHBdZ+kl0ZEvAN8m4Nb+5nzmzO63G3Uomz8LI1Ofdi8MQd3ATGzMC1oSg/4pqf3nJD2qQpYFM
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr1993775pjr.22.1586894313617;
 Tue, 14 Apr 2020 12:58:33 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:56:38 -0700
Message-Id: <20200414195638.156123-1-gbiv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] tools/build: tweak unused value workaround
From:   George Burgess IV <gbiv@google.com>
To:     akpm@linux-foundation.org
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        George Burgess IV <gbiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang has -Wself-assign enabled by default under -Wall, which always
gets -Werror'ed on this file, causing sync-compare-and-swap to be
disabled by default. The generally-accepted way to spell "this value is
intentionally unused," is casting it to `void`. This is accepted by both
GCC and Clang with -Wall enabled: https://godbolt.org/z/qqZ9r3

Signed-off-by: George Burgess IV <gbiv@google.com>
---
 tools/build/feature/test-sync-compare-and-swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/test-sync-compare-and-swap.c b/tools/build/feature/test-sync-compare-and-swap.c
index 1e38d1930a97..3bc6b0768a53 100644
--- a/tools/build/feature/test-sync-compare-and-swap.c
+++ b/tools/build/feature/test-sync-compare-and-swap.c
@@ -7,7 +7,7 @@ int main(int argc, char *argv[])
 {
 	uint64_t old, new = argc;
 
-	argv = argv;
+	(void)argv;
 	do {
 		old = __sync_val_compare_and_swap(&x, 0, 0);
 	} while (!__sync_bool_compare_and_swap(&x, old, new));
-- 
2.26.0.110.g2183baf09c-goog

