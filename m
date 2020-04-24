Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED141C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4D620767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfemyIP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDXGN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgDXGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:13:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54013C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:13:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t17so6853074plo.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j69Gvq4vK6TM54rY0b5SnTVA9UkpfVZ6E3MyvEyHlqI=;
        b=BfemyIP0zYRMDJCjezWr7m8AQL61Z/72boZMliqIwghZTJIVADjHd5bmtErPIRGjYm
         EN9ZQlvgSQnqe7mZEihpt6+GuiQzLm3V+5XqujDK3DG8qdww/f/5ii+vKhgXic9HprEO
         0pw37j1OFeQ9CLDyiDvYNUht9sxOPlQp4A8NFYaFKJ9URZQvZ0P6Xrj21DFZXhNI5O3r
         UumJLrf1jjN+hOeM/EhRVKfk0fBogTqRQe+GcXBNt1Y10fzHCEKQ7hONQyYf7X29KWMV
         M/aroWJZseiFi4bv4TrgcUz0wGkm44PBM9GgN7ymIMrI4o/OdPS2w8M/V2xFAiiOGIVg
         jK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j69Gvq4vK6TM54rY0b5SnTVA9UkpfVZ6E3MyvEyHlqI=;
        b=hSVf5PTCL3kWQdftSjLBC3ucHiHFs8NZCX1b8xJVEK7Fxht7iK+lUgLSY/SjbRSe4o
         Yhv9OArjoOZjoYJUSkuYVMONmr3lXpZrMDcfmcvHvJ62YKg+T4nigsXsaJ98pPMiJQBD
         zY3TmD7I/jFBZJG0D48pBZizyBXi6ho3WilDq1x3GrxLOteKdy8ZYi6nwXivgaIfZNzl
         aNcrBW5DEpgnVKv7A9Wf54wS94w7+R2GcewVNd4Jj+kxGNAg6LtH0rlyU9RiQVvycDJO
         09FLH1xXWjIc/Itl/Gfa5o0OtRQPxERDJgsJ/ono9DCpTJzA6JGwyKdTXGsKUGgA/X5T
         ccdA==
X-Gm-Message-State: AGi0PuYXWARIuxywm4td76q+XItJFbEEoNcOiZ+i0w6szzrT+LNtzVPj
        jS23VbOhPWgAZbnaltoKEIyRNGNv9+y5vg==
X-Google-Smtp-Source: APiQypL2zlL31A5jpzBKC3FbBvFwsLF1gfS/AMJI9xfZ+QHa7TkZ0qqxmOMOvLXeH9ENCuU0namh/ku7DsxfGQ==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr7831219pgu.61.1587708834690;
 Thu, 23 Apr 2020 23:13:54 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:38 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 1/5] Add KUnit Struct to Current Task
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
2.26.2.303.gf8c07b1a785-goog

