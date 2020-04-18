Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE2022246
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajelyZbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDRDSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgDRDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:18:51 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F98C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h6so3932240pfr.16
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CRqxf8T5bRxo/T712v0WU2H9pMxqHzrv9yCZKsRJO1k=;
        b=ajelyZbAItvKpqcy6Z2JVr/HmXS32yXhFk3WhOlmBUApRGbSGPKDdd2b/0xaWhNzeg
         pbJ6CTgi/hrcR2GA9/9r4zzbzDUI8b9GbneSnyVNJsgPEZfGAivLmf/9i0MBwhfatKWc
         1u972kzMOZ0UKUVZpav0YX5kVnr1nnFj41yoPco0bV0SwhdtPHq679t5GbtNaSuT1JWx
         enZBxFS6znX8KEndztit3HG8GDotznpgTEO+flJfyML1bpO8NCuM5CAMyvzKkG0f4w15
         naNaLqxsnNdBKT4G30UKEdsMDFublaTtLiWZqZZCjoxCDmfQDRgTbBkjd09Ui9VF86By
         lVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CRqxf8T5bRxo/T712v0WU2H9pMxqHzrv9yCZKsRJO1k=;
        b=OWFE0JTCAwW0YReDlocVrgtMAsligTv8vglr3UK2F4z9iwuJqFgTrzMV4JiCMrL4J6
         Vmgu4/lnK8Fwkee4Sg69Kr+obf6xaCEl5MEtL1FW1eqSLr163HnvpyFYeaOzUXrA4f3A
         gqZYTn3hb6sNlzG5+C6CUcCeU8qoBo2HfK7jo6fZFaxKnSOfoPzzYb9zfCM6yrbkT0kV
         /BjLqPpNJ2owaNZ7p2RLpPat80cLG3BbXNu6LzMtkioaruYmFnQ90uQkTOAYayfJQTXD
         Gu9QL0XWnAmBxC6hqqO+uviHcX/AVlb8htj5hqd9rN4mEDGGClWPvbl2jq6GYmimT1s5
         rN7Q==
X-Gm-Message-State: AGi0PuY/hqlBC6MrZ/ye7NgZy2ZySBtypqV0wc08aDEufHzobl52cQn0
        vuqMPIjZ6++VHa+/uKbGL7E4JH8TsxmThQ==
X-Google-Smtp-Source: APiQypK/uUmV70QTUjiQ+OqVVKgYnSy1KwkLpSezPBiabfyjmu2R3Y16ceb+4+Jkm6cFvmP6mJicQAYSfJARqQ==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr7674332pjb.171.1587179929037;
 Fri, 17 Apr 2020 20:18:49 -0700 (PDT)
Date:   Fri, 17 Apr 2020 20:18:29 -0700
In-Reply-To: <20200418031833.234942-1-davidgow@google.com>
Message-Id: <20200418031833.234942-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200418031833.234942-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v6 1/5] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
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
index 4418f5cb8324..e50c568a8dc7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1188,6 +1188,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.26.1.301.g55bc3eb7cb9-goog

