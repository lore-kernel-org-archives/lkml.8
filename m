Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F085C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34084205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 04:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KH87wYJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHEE34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHEE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 00:29:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A09C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 21:29:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k142so30025863qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=KH87wYJUH7h4lE7GNyS9Zkc0/3HRb/qCKsvepF+wF74pNbnprxanLXxWGZSvHNat2a
         KWa0kEHWNrd7PrwIvCVKfksv1mmUs8g8LsJsxRw8MqeCep8TI+d7HZWQeJasaU/JwQTW
         AKpMgngEZL/m8NQmYa4KC6mczZeb/RC8JGkMGn0iRU3KSk33CpJ016RNn/IZGuOGUJL2
         oV6vVsprw0GfpE7+M7sO/O9plsvSGD0AeS1E2y/MrYtytWkyzdyBOZguaFPwKeQ1WQqS
         DYh72SsnIMEPVXGCBfQKMj9RN29n+3XzA7q63+xuoi/uaVbvSqOkv2MSoghGEn2bQzLj
         N8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1s/fGj49wZAcV85LY6dM4ghB8ELbpKuQm5SC6WcoZ6s=;
        b=CumZ8Bu48MFKEs9CFBfPuhUZRkkicV7y8TkdctuXWMhgJiI3Llep532sNtOVlYDbbz
         B+fsMxq7kLbamJm0yV8jF5BDvUu2eDrfYHfOO2hoUH5rT0F4XSdUZYAzQWzNpXrkCycH
         qpUy1cQJ9aTmBn/Rc6r0av7oHNZlrj5CNnm4rFAlk8f0zZBKAfhkaK1FG8usyHSF9Y7M
         +OaT4t6LmkcO4S2rpwUvFQRmhfiAjTideKYBH/2UR8dgsLZM5hJxEPnD8+qY5v3nJu2l
         18ueTtQLfdDftq4HG2Xn4uomyA6JLd0J22/6XY0q4Qa6DabxCnyqCVY/avI1Y2Eig28P
         SI/g==
X-Gm-Message-State: AOAM533rGbWFSorggb9Y6B2LrWcdpBQSGxAEW4qdWeeiFMgsrgCdu+Vl
        3nnsXNy+6QAcj365irgCcuvflpca9XvLRQ==
X-Google-Smtp-Source: ABdhPJylrtvvJBJ9f9qdqVMEdPVylXivJYIOITqT9qZY1M+5gLFwdOVxzioKQUYCPH/JukP+OFQzFLRW8FIJlw==
X-Received: by 2002:a05:6214:1742:: with SMTP id dc2mr1836989qvb.90.1596601789643;
 Tue, 04 Aug 2020 21:29:49 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:33 -0700
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
Message-Id: <20200805042938.2961494-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 1/6] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 27882a08163f..f3f990b82bde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1196,6 +1196,10 @@ struct task_struct {
 	struct kcsan_ctx		kcsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.163.g6104cc2f0b6-goog

