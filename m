Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4BC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FDD24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6zyIrEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBTFN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:13:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33067 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBTFN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:13:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id w6so2551491otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZBsGB9tbxhvRXiclwSK9JL1N3w+7ntoBoXx7wbC0SA=;
        b=L6zyIrEA07BO5pZPVjxTdJuZFZ4cMO6KcaAlEy54ZmCSFjEJ6E1a44niIjUGE0QSGd
         GRGW5GcAICDs/++0WZE1YPib3Udk+0OJz8u4fpRBq+7tM6ppcQ4iTBOkQyRaguauGXVP
         N+19xzmx1FH9Aqr5vEz7DQw46BosdXOBuEDva6f28VUpPr0A5zgQkJ8jUGEntSOaFlnM
         99F+xW5PnrQSdQqRXIjI9oDwzFOxTFgC6cLg0gnTe97wG30MxF+UjxIILdtlLNYm4LxO
         /0EsOp9HHnlwmqEEmuKg9uRtLY3f8kXWbI/CJb/xzQcKpSzXv1LUi9zpeA++sl/hk5c0
         6Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZBsGB9tbxhvRXiclwSK9JL1N3w+7ntoBoXx7wbC0SA=;
        b=mmJE4C+8Z+1CTb0aXwvXCuw4CGmCHF6AeLwjGqZdU+xneE/AMX01oCi+2hkqkW/teH
         F/D+sybja9YZnTMsDMM5RtruOuA2P4ym+kv8F8auhi0Y8k3EGK2qbrUGj0I2/UMN0hp8
         QLtGZV/c8T0cLaehfxA0IkgRMIYP06202v4IgCGsENIz5WHDXOUFJ9aIlJdC702SINb0
         zOS94dJX7MVJ34lZS23UYMDiO3ICdzkr8dRCbkMk3sW6ets95de01qLGlksgLBRHEGJh
         SdjPC5mdLl0Ao27WW+kSqHmUo8ZUdKrUX6U3AJMK8XhuDy8Jpdqqwans3DC2QWp2cDkF
         mm2Q==
X-Gm-Message-State: APjAAAUSaM7EMpUxXzJ1hojGU0JPLoJplVIu97XH7lQJQec2drtyFw7d
        Ti/n0BoGy2Eluvit0qaBRBc=
X-Google-Smtp-Source: APXvYqzn/iOB3a3kniJ7S6+vX77Obx/FYjx86k3IKWTZfsD7m+TwvNhj0IFnaXbHigkhtlRv4PF95w==
X-Received: by 2002:a05:6830:1050:: with SMTP id b16mr22621414otp.140.1582175606032;
        Wed, 19 Feb 2020 21:13:26 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h15sm742436otq.67.2020.02.19.21.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:13:25 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] dynamic_debug: Use address-of operator on section symbols
Date:   Wed, 19 Feb 2020 22:13:20 -0700
Message-Id: <20200220051320.10739-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../lib/dynamic_debug.c:1034:24: warning: array comparison always
evaluates to false [-Wtautological-compare]
        if (__start___verbose == __stop___verbose) {
                              ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses. Using the address of operator silences the warning and
does not change the resulting assembly with either clang/ld.lld or
gcc/ld (tested with diff + objdump -Dr).

Link: https://github.com/ClangBuiltLinux/linux/issues/894
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-5-natechancellor@gmail.com/

* No longer a series because there is no prerequisite patch.
* Use address-of operator instead of casting to unsigned long.

 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index aae17d9522e5..8f199f403ab5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1031,7 +1031,7 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
+	if (&__start___verbose == &__stop___verbose) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}
-- 
2.25.1

