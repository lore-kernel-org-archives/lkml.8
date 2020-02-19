Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444FC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8E924654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0wuRZAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSUVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:21:19 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45605 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:21:19 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so25118588oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcApxqQdtPLJZD/Hiy7dx4dLHAfOr3+SL6yidJyJBXo=;
        b=q0wuRZAedqHzuCyXtKgkLLkIpthEdjcgR/GJAbhkDz7pe8R6bRYmwXn1tQdEGfIaBA
         T6vM7Ey8/zFberePS1oEuPAHzewPr9ZgU4bd3kVT1mpihJynyuNUzqGbPomgR5WSUeyi
         HtosNk2oymlLKwXsDZQwZBdCddkn3iBZH8N4xz/0G/c9MtEuEX6bsO0GFKq23eijhRwX
         HbmWS/XU828RQFCrlb4u936JSWqAeWbciKYZSOsPsVKGAyZAZ5ywbJ1IDsrdc/2OxMjc
         DZJTpBvBU+aL1OuML+dwd7BJEjxHkJ9Gif+3WQylcQ9Gk7RDiN7+WSQHyx0lZIiNjfqo
         h8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcApxqQdtPLJZD/Hiy7dx4dLHAfOr3+SL6yidJyJBXo=;
        b=EGA+i1Q417PgdOSjZz7kVsoqyPdi9H0qhxirZbcHrYxq4oEiYw3hLQvh7ZrBdX2QP7
         1q1VC9uMqpEGsAFdl1sW2Bv1+YlcUSB+DjZ9mxVIgF7XvTXi7hEitxQF8qyycLYHXDkx
         oLWUlj324M42XFPTNN0stvoVMwQnCBxeXea37JS3ihi3pDTwCf0RlLlmUJeOXKSYmE4f
         rD1c7TsklPiCJBVxAr+yOU0tMYHgfK/J1/Cz9pJLjA8jSPHNT9moMucq1Zlob/q6FvTk
         x0D5uq93YBeLFvFX+36uTfs7nA7cu+LTv3Vt2J+CsF6FA8HodCBAkHFRWsGgG8Xt4Onu
         uzSA==
X-Gm-Message-State: APjAAAUVDGglmIvEMgGh/IyaH86Am75EKQPHSvPMe+Kz8Esrg6Zq8Tp8
        O6VkF3+o4dY6yrjJaapVIao=
X-Google-Smtp-Source: APXvYqwFbCcnDWGVQp9VCrIc+3VPdJrthDt2En0u3sIYz8aPV+wbH+InzuYOYeP3pLgqnnJXhMikqw==
X-Received: by 2002:aca:b588:: with SMTP id e130mr2061973oif.176.1582143677030;
        Wed, 19 Feb 2020 12:21:17 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id a30sm263270otc.79.2020.02.19.12.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:21:16 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] kernel/extable: Use address-of operator on section symbols
Date:   Wed, 19 Feb 2020 13:20:37 -0700
Message-Id: <20200219202036.45702-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../kernel/extable.c:37:52: warning: array comparison always evaluates to
a constant [-Wtautological-compare]
        if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
                                                          ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses. Using the address of operator silences the warning and
does not change the resulting assembly with either clang/ld.lld or
gcc/ld (tested with diff + objdump -Dr).

Link: https://github.com/ClangBuiltLinux/linux/issues/892
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-3-natechancellor@gmail.com/

* No longer a series because there is no prerequisite patch.
* Use address-of operator instead of casting to unsigned long.

 kernel/extable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index a0024f27d3a1..88f3251b05e3 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -34,7 +34,8 @@ u32 __initdata __visible main_extable_sort_needed = 1;
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
-	if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
+	if (main_extable_sort_needed &&
+	    &__stop___ex_table > &__start___ex_table) {
 		pr_notice("Sorting __ex_table...\n");
 		sort_extable(__start___ex_table, __stop___ex_table);
 	}
-- 
2.25.1

