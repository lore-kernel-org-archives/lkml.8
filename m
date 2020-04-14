Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60071C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB2C20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tniFeoki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404499AbgDNDRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404486AbgDNDRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB92C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id p13so10336402pgk.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qmS4Dws1dS9Cf9mpNh1dkBLiz6hqHz5k1HrVTs3BHIU=;
        b=tniFeokiM0fcdzRPHG1ZbY9ozBysDVZ/aYvbq902VEONvODDGN/4/AT7Q/QD43RaKG
         A1SPyDQUACNvXr8ytYrkcN7tkAvv28uU02BFBJryzTx876TVzWaft4V6l9RXExPBRjIm
         aSi9pMgHwnv6rIPIdSj1ZKpYdqljYl1+o2o2GWV/+Wr2bkpxuDI4hGJQbXdq6od6c8Om
         9xdLlOxCICXwcuG6aB1tSJdAKkOcXcZgJrfOajKOOf5mGJp+d5gjj/XiZCWCQ5l8fKJ6
         ydKrqljfMn/rMylk4TKt+nHAEX9YlDL8ye+X4LaBoYCZO3cJMz1/NuKNlMGbuGnPAoO9
         RyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qmS4Dws1dS9Cf9mpNh1dkBLiz6hqHz5k1HrVTs3BHIU=;
        b=m61db3kofiHvt7KoP/ljGmOmxzQT92al/fyxIdj+rz2Ws8WeNXuy04tW2EICMzleJI
         zMvVubk4xaBdFW0vV0PqKugZfqmVSf51AfTqatj7TeQKjlaObGCazFbXZyvNk72OMgAt
         ZuL9xmg8AalgwP1Hl06GsqNDL8d20ne/rzkUbZFR8Pw+xP+Y4I9FMAduOmZrLiySkMr6
         T9APL+XYncV4xlMPckzbIdhl3PthkahbquwuppMvvcO6f1Rwx8heQujejZuC2cpOTU2z
         uFqIS34mM9EcCNaL6r3vEMXOKH7F3fKctWb76xR9J6PTayRR0oczIrjXdrI2+9xU1/AO
         c7fw==
X-Gm-Message-State: AGi0PuaZvd7hKolEmxmLOSZVAgFQcL6BA3wnOg3T6G2FcwavXxeB9nvn
        0XJkJA5K0fAhe4FGUE1Fw7yfILOyWJPa3Q==
X-Google-Smtp-Source: APiQypKW5TDCpyIvzemzn/s78Ld1CH+htFCh8fWOvNw2ECN6IMlElhfG7YP8qxjm0N6Glpf+/LH8+Hhn27QBOQ==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr5197470pjy.143.1586834254059;
 Mon, 13 Apr 2020 20:17:34 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:16:45 -0700
In-Reply-To: <20200414031647.124664-1-davidgow@google.com>
Message-Id: <20200414031647.124664-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200414031647.124664-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 1/4] Add KUnit Struct to Current Task
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
index 04278493bf15..7ca3e5068316 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,10 @@ struct task_struct {
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
2.26.0.110.g2183baf09c-goog

