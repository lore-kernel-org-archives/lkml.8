Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF39C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE9820873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="pXSncOrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBJOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52724 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgBJOpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so4317614pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rqLbVYv460dUH3IJ0c/loh8twIuA5GT6A0w7pzFOh4=;
        b=pXSncOrRFavu5lHfU7KB5kwaQaTDaleDhis7Uupn9HVUMQKHi/wDLtq+cLXtrrzK8L
         DBll2vMcEhoOoqLv7fML8PiOLSlTNWqvFpxy5LqNKktGQZRkqW8KEZn/E95JSAQXGnXT
         A4J1NWkuboEQDnEuubE1pR1HtNe4epjaGwpyp0U2/aYk+Vi86rAil7ZjDgx36x5ndp5z
         F+9Ate4oouSgVKRtU2kx8QUbBhnRy+RubrMrokil9g1vNtcJY0NPmVgAx/f3e0mgNsYI
         cSXHxU+Xz2VihT1c2l4lIHERX12qIyynLxgbdmB93G/J3ySt1p+QMS4LkTxE7cgVTB4I
         elCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rqLbVYv460dUH3IJ0c/loh8twIuA5GT6A0w7pzFOh4=;
        b=WkkY3Yi1OXbpzXRjttXU0h0PjBWImtTFoJJYL73fosYIt5CnaXTWybgqND8CAgUy5T
         mdU5YCH3Iy6vHeG/4QsL8C2R6nOZNOxYGRzWDlqndhxGr3/szP884vIlR+GOfvjkE3dW
         vj6gNZwAyJB1XT2kkFrsrqbcS6CSRNd8ib7lQ8Uk2VbkT9JBcv1JF6NhZz72u4qarTv7
         ukYHB021fGhsCZWDYd1TtMc0ap4UEDfJ/+rTR1+v7agaabbMfPxBSO2txJ66tPwIAE1T
         MP81IufPCiMVhr19YHdqTkURTkdioEe41la+HzkkJX7VoAVfBM+9FCwE6WauosywQVSi
         4glA==
X-Gm-Message-State: APjAAAU5L52ndPJz8tHDZmbqooJnQwAmyn6EFlYdywrNDCjD9NAofCc2
        agO+D2XIYZIvi+NAb7+CXn1YgakIYqQ=
X-Google-Smtp-Source: APXvYqxdjkW0legBHIjGJbmhoKn6HrCFfcTxzVs6h9JnzJ9spMBh7nLnvg3tqybDizmRNLsViEjmqg==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr13756935ply.55.1581345939153;
        Mon, 10 Feb 2020 06:45:39 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id dw10sm552079pjb.11.2020.02.10.06.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:38 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/4 v2] init: boot_command_line can be truncated
Date:   Mon, 10 Feb 2020 06:45:03 -0800
Message-Id: <20200210144512.180348-3-salyzyn@android.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200210144512.180348-1-salyzyn@android.com>
References: <20200207150809.19329-1-salyzyn@android.com> <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_command_line may be truncated, use strnlen, strnstr and strlcpy
to handle it.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <keescook@chromium.org>
---
 init/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index a58b72c9433e7..9f4ce0356057e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -536,7 +536,7 @@ static void __init setup_command_line(char *command_line)
 	if (extra_init_args)
 		ilen = strlen(extra_init_args) + strlen(argsep_str);
 
-	len = xlen + strlen(boot_command_line) + 1;
+	len = xlen + strnlen(boot_command_line, sizeof(boot_command_line)) + 1;
 
 	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
 	if (!saved_command_line)
@@ -555,7 +555,7 @@ static void __init setup_command_line(char *command_line)
 		strcpy(saved_command_line, extra_command_line);
 		strcpy(static_command_line, extra_command_line);
 	}
-	strcpy(saved_command_line + xlen, boot_command_line);
+	strlcpy(saved_command_line + xlen, boot_command_line, len - xlen);
 	strcpy(static_command_line + xlen, command_line);
 
 	if (ilen) {
@@ -565,7 +565,8 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, argsep_str)) {
+		if (!strnstr(boot_command_line, argsep_str,
+			     sizeof(boot_command_line))) {
 			strcpy(saved_command_line + len, argsep_str);
 			len += strlen(argsep_str);
 		} else
@@ -669,7 +670,7 @@ void __init parse_early_param(void)
 		return;
 
 	/* All fall through to do_early_param. */
-	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	strlcpy(tmp_cmdline, boot_command_line, sizeof(boot_command_line));
 	parse_early_options(tmp_cmdline);
 	done = 1;
 }
-- 
2.25.0.341.g760bfbb309-goog

