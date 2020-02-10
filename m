Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA622082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="U9Vq75Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBJOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35827 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgBJOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so2923216plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIOQGMlZTedaYfiimcLs5i5pQWDo9FljfMs1TjQEcn0=;
        b=U9Vq75CsfCrk8YC5116H0+dabjKeTiOKhQkgraNhbenX5HvtheDVKPLDV3BNlYpnNh
         qLgPMyZSaVhzPa6Mgs7n7+4NBr/NoIezxIx9wJrs988csUDrIG4iG2RCHypKQTGJjJot
         i+x+AO4a8fMYXK1X3vhLnN4ERs7FjBzzZMMhmJRw7Wjk6VTR0SgpdWD8P1za59BcELmv
         p/l2Wmz6Z5A6JvZj+ZJh4JNtBhsei+qLE5FdbPkTaCO6ws4IkudkyPX2C9y6SJrcZe3y
         /q9ggztcKeY4qmj9PdZ4TLfKh9XU65F3NOsi+1i2bOb7+KvF32IBqJCQIgIKJaElk4HR
         ZWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIOQGMlZTedaYfiimcLs5i5pQWDo9FljfMs1TjQEcn0=;
        b=a23FATGxCYyocu2vtZpnCZS6OEY5qXoLZ75z0MxTs805xYgpzbp8CxDKFVjRZ/ew/G
         w9gDD1rJR0o7Z8uRmP+DuwLQe7m1EITX6NXNZr9NZpsX8dsZ7FoCMZrzXC+EMT/jF2VZ
         S3iquzjZJB+7M8jS2fw4ydrk1BMzf9jaKYUVhvO024fbs1XVflx4fmdZJAZqA5frFK47
         6v79onKXcRNPuBwWmkgZOthgasQzR7qlZ6uW/mMmMpIs0qFNoLIg1DSEJtmiFIYLyHim
         YBLKlcH7/rTtGKB2NN0ghyCguUfW0zBXcP9/LI0NpLrADnTBhktJ9k1FTeYYAzSxWmAe
         TCNg==
X-Gm-Message-State: APjAAAURURkSWa9RNr1JFQp2Swa/FnJJCgeJGjDb4pGrspMz9X2EXQUV
        ikEmsPJUqkyK5kO7j/PbKYuugk6A8J0=
X-Google-Smtp-Source: APXvYqyhAzEiDVXx6kJF8izF1pU2OEHuqK1gDfiwqhuP/0eo9C4G23IPBGtm70yAfsfa7ofD1r20eA==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr12855033plp.71.1581345933846;
        Mon, 10 Feb 2020 06:45:33 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id dw10sm552079pjb.11.2020.02.10.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:33 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/4 v2] init: move string constants to __initconst section
Date:   Mon, 10 Feb 2020 06:45:02 -0800
Message-Id: <20200210144512.180348-2-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200210144512.180348-1-salyzyn@android.com>
References: <20200207150809.19329-1-salyzyn@android.com> <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A space-saving measure is to move string constants to __initconst.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>
---
 init/main.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index cc0ee4873419c..a58b72c9433e7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -524,24 +524,27 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  * parsing is performed in place, and we should allow a component to
  * store reference of name/value for future reference.
  */
+static const char alloc_fail_msg[] __initconst =
+	"%s: Failed to allocate %zu bytes\n";
 static void __init setup_command_line(char *command_line)
 {
 	size_t len, xlen = 0, ilen = 0;
+	static const char argsep_str[] __initconst = " -- ";
 
 	if (extra_command_line)
 		xlen = strlen(extra_command_line);
 	if (extra_init_args)
-		ilen = strlen(extra_init_args) + 4; /* for " -- " */
+		ilen = strlen(extra_init_args) + strlen(argsep_str);
 
 	len = xlen + strlen(boot_command_line) + 1;
 
 	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
+		panic(alloc_fail_msg, __func__, len + ilen);
 
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+		panic(alloc_fail_msg, __func__, len);
 
 	if (xlen) {
 		/*
@@ -562,9 +565,9 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, " -- ")) {
-			strcpy(saved_command_line + len, " -- ");
-			len += 4;
+		if (!strstr(boot_command_line, argsep_str)) {
+			strcpy(saved_command_line + len, argsep_str);
+			len += strlen(argsep_str);
 		} else
 			saved_command_line[len++] = ' ';
 
@@ -1001,12 +1004,11 @@ static int __init initcall_blacklist(char *str)
 			entry = memblock_alloc(sizeof(*entry),
 					       SMP_CACHE_BYTES);
 			if (!entry)
-				panic("%s: Failed to allocate %zu bytes\n",
-				      __func__, sizeof(*entry));
+				panic(alloc_fail_msg, __func__, sizeof(*entry));
 			entry->buf = memblock_alloc(strlen(str_entry) + 1,
 						    SMP_CACHE_BYTES);
 			if (!entry->buf)
-				panic("%s: Failed to allocate %zu bytes\n",
+				panic(alloc_fail_msg,
 				      __func__, strlen(str_entry) + 1);
 			strcpy(entry->buf, str_entry);
 			list_add(&entry->next, &blacklisted_initcalls);
@@ -1204,7 +1206,7 @@ static void __init do_initcalls(void)
 
 	command_line = kzalloc(len, GFP_KERNEL);
 	if (!command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+		panic(alloc_fail_msg, __func__, len);
 
 	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
 		/* Parser modifies command_line, restore it each time */
-- 
2.25.0.341.g760bfbb309-goog

