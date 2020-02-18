Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E182070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvxBbLuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:48:20 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53631 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgBRJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:48:20 -0500
Received: by mail-vk1-f201.google.com with SMTP id m72so7960130vka.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VedbwuHNa6UymbnPf6cGdxwCyajJaN/7KT6rMvtKD48=;
        b=GvxBbLuuWpOrlJ3HkLdkNmsgkx1NR4w548ngWwR/+xgfgSIH+lz9Zgc3tJX5d5+JQD
         WCZfAKHreGiMnzfeetMhSszycd3MyCWJuqMXGGPyvZPVePv1MCBaol91NTW0bR6MT/KO
         AoN8JlsuiO674UZyA36R+ymTFyNod50Yzofr0xebPEd10DsUpsQojxsDV6N58Yp1/qmd
         +3cuYO7yvCJec7ZJ4fcJMPCpHGEbkMs4C8YpgmEYsHS8cAEG3hrABq10xFvZ0F+siTC+
         dUe+de2at+7370+E/y+3LUHuwlwL8wuM0jX60NlzEqOiLYUk4BoszSm52Rv+7W2iPraT
         YQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VedbwuHNa6UymbnPf6cGdxwCyajJaN/7KT6rMvtKD48=;
        b=lWXb08BKh/9JvqMwdseJ0M+frAz5cHJtkyjwIeGKNSjmKWbcPkqNTxRQ/xOE2nmL4K
         sU9UbJV48UfrGVZHSdNWfTK1kO7kGMXST30t3ybf55H89LfIigteL1x7zuGvJ/iK2N01
         +W0KxWUAxw+g0i4EKFBLW0kgaHogKlTcy91J4bSDrGr9m7eqf+nzYYZxmmQhbqjjGOjK
         o1hVEh9VK2HhtJY1Oz1HW+z84VBxmyk6F3Rcj5PkBe30yy07+QEIY5v7uPQdAavMXgv4
         foXPcfdfiD96VeF9rsbB4EhQypImsSj3lp46pqBb1C7fGMfTTZjcLiRScOdH4tKYd+me
         0dNg==
X-Gm-Message-State: APjAAAVfMKd+fMZs8f1rlDCVvCSr7Q/djIBO+G990VGN03/Mz/+k8oVU
        aZaCcmDz49NoQBJ/CqcY5gCbqTItx8w=
X-Google-Smtp-Source: APXvYqyeZjHdWa6sKbCf2tU/oxEfVeogpW+N2vWAgQGc/WmuSsjwM5DqpXUgipXzeaYvOq+6ld0aH1ZGiS8=
X-Received: by 2002:ab0:4983:: with SMTP id e3mr10045766uad.65.1582019299274;
 Tue, 18 Feb 2020 01:48:19 -0800 (PST)
Date:   Tue, 18 Feb 2020 10:48:15 +0100
Message-Id: <20200218094815.233387-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] lib/test_stackinit: move a local outside the switch statement
From:   glider@google.com
To:     keescook@chromium.org, jannh@google.com, ard.biesheuvel@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now CONFIG_INIT_STACK_ALL is unable to initialize locals declared
in switch statements, see http://llvm.org/PR44916.
Move the variable declaration outside the switch in lib/test_stackinit.c
to prevent potential test failures until this is sorted out.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/test_stackinit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index 2d7d257a430e..41e2a6e0cdaa 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -282,9 +282,9 @@ DEFINE_TEST(user, struct test_user, STRUCT, none);
  */
 static int noinline __leaf_switch_none(int path, bool fill)
 {
-	switch (path) {
-		uint64_t var;
+	uint64_t var;
 
+	switch (path) {
 	case 1:
 		target_start = &var;
 		target_size = sizeof(var);
-- 
2.25.0.265.gbab2e86ba0-goog

