Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517A4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDFC21974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8BIq7mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgFRJcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgFRJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:32:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EAC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k186so5743289yba.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wAC/0zMBk1R1mKjHS4CraP1dln5upgDgvVtxjRPVBbA=;
        b=C8BIq7mEJOO8a5LHVQ1SuDhcysfjMc5V2zuefaCD1/AohUdWCQ6EzEpjc/S+CtyVqD
         1IhMpQrvVmfXwSUu+I9vQF1+c/54BZFxIKOdFnpCS6XgDWQJ4LQNWdZkuvXVf5PkgisN
         OMuF+A5L2J5RCry6wyradYuB/UTxB8gGYvWfpT7ZXyWQLjVVZAB36ligjDfkOAXazDmg
         C+lKnEOrLJsGhipSA01GmPwzu7HWTekfnJ3m0MhcTjtdUgLmAlR2X7ReYnwzZFgJLmO2
         U5hkTjCWaNLWE9rRwvvU3WjYa6roSqQgnXBu7zdU/5DcTFHM2ecWAy4ESfuivG5UBR1Z
         5o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wAC/0zMBk1R1mKjHS4CraP1dln5upgDgvVtxjRPVBbA=;
        b=XpXTI7N+5MpOm6mw2Vo9k3oqSzdDzDHVvUhsYs9BODKgX8VD2oz4UbapEAVoJgH7E3
         qWnRDE1UDJBq8/X/CeR6YsH5J6MqCpcBNx+TIrjbKAPIbEzvMag1wmDHlDdF9WQ+ZUwq
         n5PPU38YWYnJzaLDbs8EHwBtACBvVKOuyEDWkB7ZgpwV5Blxl7trfDUKtlx6qZ58+OIs
         yMu3Zhjv2PR4mCZCSbJLFc/Vk8M3JAdzYmplVkS3fkAfACECLOOyj0z3FVGNT0Jjsnf8
         kmXkV0upf9Msg2/juw/gcOF6UfhbErh9RxNlrQjTQ7w5eDOIRq4GWzTC838xyWpiryRh
         dE+w==
X-Gm-Message-State: AOAM532EIDa0/SKMRjVZOAbesh0AjlJOKBwgdceFm+N9fE57TtN5RRey
        WToUbffBXX2VtHe7K3VU8vstPkCCBA==
X-Google-Smtp-Source: ABdhPJyoNvmUy6LQW6lg0uXVx0KMGkjLhkRReal6sqe7bk+aXHSMMR5P0LvdBpXockzmMqxZT8kS9TKSlg==
X-Received: by 2002:a25:348a:: with SMTP id b132mr5314699yba.491.1592472724817;
 Thu, 18 Jun 2020 02:32:04 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:31:18 +0200
In-Reply-To: <20200618093118.247375-1-elver@google.com>
Message-Id: <20200618093118.247375-4-elver@google.com>
Mime-Version: 1.0
References: <20200618093118.247375-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 3/3] kcsan: Disable branch tracing in core runtime
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, dvyukov@google.com,
        cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable branch tracing in core KCSAN runtime if branches are being
traced (TRACE_BRANCH_PROFILING). This it to avoid its performance
impact, but also avoid recursion in case KCSAN is enabled for the branch
tracing runtime.

The latter had already been a problem for KASAN:
https://lore.kernel.org/lkml/CANpmjNOeXmD5E3O50Z3MjkiuCYaYOPyi+1rq=GZvEKwBvLR0Ug@mail.gmail.com/

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index fea064afc4f7..65ca5539c470 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -8,7 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
-	-fno-stack-protector
+	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
-- 
2.27.0.290.gba653c62da-goog

