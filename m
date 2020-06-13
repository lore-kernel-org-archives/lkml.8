Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09442C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D10207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9nAlWRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFMP6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgFMP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F6C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so9764046otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/AO95lDmp5L2fyl4dZ1p5ig7gAjN+T9cfmBrZBRsxIQ=;
        b=t9nAlWRm+ySLak8U5pc00ZK27w1/hYYgY833kZDuzAe2lY0sm6ErTexcu/sjJeffiD
         exGS9mRMBcveqomq0+W66L4NtLP1oOvuVT4vELW1NLx4BkvLKz3ne/Mb9OTkLzWjptiB
         6UhwJjwhCFa6JXeRjpWwe7zv7nZJL5ySNtsJmFYK8ZB0UrEXeojAVEupI4sRkukTR0gP
         pfhv8IfsJiiZoPXfE6T0NnhzkzBtUyudHbGxz7nUxwSYm8h9xGOpVfl/BwizRwOBqpcP
         nAPafu2V0njxHMSNeoCoBOZ0JEoJj7l9+BmJaBcvSaOrevqnIALHgyMIE7UdSMX1kIMQ
         YFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/AO95lDmp5L2fyl4dZ1p5ig7gAjN+T9cfmBrZBRsxIQ=;
        b=CDRAhRtIKm1oI+q8HCSeNLUhf0rEuYZ+D4mWy7FBmvNHy8p/+N8ppAi7wxhweyCf45
         G1z0WOdkQKuLQHy2TZbJtSgDplSkAvBv+9spb9Xen1fzHYTqcG8RHsVT+aPknn6BOnof
         ZEVDWVjUC8NWI2f39uB7xaLqr2gmIisi8Wuoj+SHpnTYiB/5bTRQnaBP1eLdWW+C+7Qq
         e4AHKR3h1LFy/eX5H9qOfkl0wy/3rHzg+8eDLEbV/cqmfXa7hKbkzFL7v27N7SzbpHTP
         fHPcCx4aGdXYue4349KRcT0kGw716yRQWqeGBaf48lsIhYXu0X+fRE9OBLh5oz+P7QPU
         TYJQ==
X-Gm-Message-State: AOAM531GFeX21FGd/f5gAlpU4WXlHZUuA8fv6OT21VCMJ+3hDsZtUxkp
        Pg7uSr3816pwK/VqTkmCnaM=
X-Google-Smtp-Source: ABdhPJxd+TNWw9aPxibJSqfFnJkzZY9uP3WZG9v97L+fq2e1ifodfK2Ju37F3jaJvW5u/KsBR4ERQw==
X-Received: by 2002:a9d:6949:: with SMTP id p9mr15642069oto.7.1592063885245;
        Sat, 13 Jun 2020 08:58:05 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 06/24] dyndbg: fix overcounting of ram used by dyndbg
Date:   Sat, 13 Jun 2020 09:57:20 -0600
Message-Id: <20200613155738.2249399-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 66c0bdf06ce7..9b2445507988 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1017,7 +1017,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1033,9 +1032,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1052,9 +1048,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2

