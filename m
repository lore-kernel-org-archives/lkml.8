Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0FC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE127206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW2/PvNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgDHUxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41292 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgDHUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id f52so8239590otf.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfXAIkbDtUGinj6WrImltHTYGnIkr+5/g1NS9il9oS8=;
        b=XW2/PvNiCbDbqg1qIEUP+SDZWS/QDrIwGgt7a80/JPCdaxiv0JOddv/AJg1D2Jwos2
         qdPYcnWODW60kfp6dyQiLT23lE9iB1XhdjIS36/PtR4emONAsdoFsr32yqSX11Gh8JQu
         BnWjS5bja9nEDuC7kjQU8zveJsQ99ZVtk6dManvqOQu4qSZW6yuxK90d47w0GfeeUD8K
         8GYrZvdU1jWD9d06NTj/hAT0MDXBsQ2+lIAUlOnyv0wnYoONhmlrp/GwZ7TCbrc6twGi
         vB5jmbnJgic6i6JgF4msOlzJSk9YU1qrig1rpY7Xj75Ua9ea4pBDP2RxblT+BVUcby7c
         cRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfXAIkbDtUGinj6WrImltHTYGnIkr+5/g1NS9il9oS8=;
        b=L3V1WTa9o6DQSjhG9e+BwZwRTWjM1OkEVqAFVg4+QXpLX4+zvGzonC7wWJjGmHuCJG
         maNvCn4BpLfZfHg/GyCWj8icLJWJZUdbr/FMeBEUvSoujv+YBf/VfLitnNAX+5znHIqE
         G1ZioIcv9APZS1QnVJwdnWVNGz6THAEDWiYnSzjFN/j2HNjMD/NJDb7Sjfi34JUDZ99j
         bPg3j+CLoM8//vqnCtTqzu8lj/bipsAUdUiY4kKoYvfh084dKGHFdUbMhEVV6XBHFW3p
         SBYwDEPS/iMaGHa+zsQLeOwngTiJpCedtPIND1P497/2Z39zd+neB2bWl9ZN4e25AQza
         UH6g==
X-Gm-Message-State: AGi0PuZi3D7Ja1NIY+LTyrA64jY8VHg/ZYEqOHAZCQCZAu5eqtc2ZoWn
        9tEerlsjPTx//4rSkGY0yfo=
X-Google-Smtp-Source: APiQypKeT8Ad8HdctOjnsH1U3qP029nJsaCkUq0Ua1Ksvg/VeivD8Z6SfY8CTSNFBeiOEkTiPiObsg==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr7180137otl.51.1586379232632;
        Wed, 08 Apr 2020 13:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id m15sm2055883otp.11.2020.04.08.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:52 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
Date:   Wed,  8 Apr 2020 13:53:23 -0700
Message-Id: <20200408205323.44490-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang + -Wtautological-compare and
CONFIG_CPUMASK_OFFSTACK unset:

arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
equal to a null pointer is always false [-Wtautological-pointer-compare]
        if (downed_cpus == NULL &&
            ^~~~~~~~~~~    ~~~~
arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
equal to a null pointer is always false [-Wtautological-pointer-compare]
        if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
            ^~~~~~~~~~~    ~~~~
2 warnings generated.

Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
cpumask_available to fix warnings of this nature. Use that here so that
clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.

Link: https://github.com/ClangBuiltLinux/linux/issues/982
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/x86/mm/mmio-mod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index 109325d77b3e..43fd19b3f118 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL &&
+	if (!cpumask_available(downed_cpus) &&
 	    !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
 		pr_notice("Failed to allocate mask\n");
 		goto out;
@@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
 	int cpu;
 	int err;
 
-	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
+	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
 		return;
 	pr_notice("Re-enabling CPUs...\n");
 	for_each_cpu(cpu, downed_cpus) {

base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
-- 
2.26.0

