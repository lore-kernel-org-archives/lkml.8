Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6894FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFB020719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLkmlZPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgDBUqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:46:55 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42588 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbgDBUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:52 -0400
Received: by mail-pf1-f202.google.com with SMTP id v18so1510043pfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=onaohHgaOvnldbVkQ7ukvTTvpY4LJI7aLjqWlCpDam4=;
        b=uLkmlZPnWV4hIizE3xdRyl/uYalR5pRcYYHR1n6kg8gpU9EfdCTxwDlYMTffAMRXpb
         51ZQ5abBrghVfVMjA65lfSSDa209mCM92O4D3d08fkulyUxqEny+g1MFcNKteeOHVsiX
         9ZolEaJqGlMMdjefGrRQTwgAcBixIiJE3IpV5mP1/7QJS/hxZ1BuTcknj8lVmnr1p85B
         rmLZKzuu5i3ad24BnwGhykb1GhGV/iqfu+9/FMIYPYEnEOGTgTxNhMI6HK/vGPL+QTJy
         0uMZPhALmfH3QQFJk9WdxHXCC1Mbp7k8KekCafO7ur+8Oob5VaeXIgbPBaHdhhMP1+XP
         FphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=onaohHgaOvnldbVkQ7ukvTTvpY4LJI7aLjqWlCpDam4=;
        b=LrfNAkYiaxw6raRG1yOM6+G0biDuHogr/L5WreggqqDHNLKHGiq5RDJk6kfF/LBCL+
         B7SbaSt/1FfmnGqHi0uMILriMoNvBf92ngmBuk06DtQMX+d6Fm903bg+OmsnpELeDDwa
         NQES1kepJQmwN5Zo+xShKe05ZJ/zahGgGKZg9dCj3UpoopWxmH59wcF0QMi28Zd1FCe2
         5/H8qwVy5IOcnR3GhPQhOja4aaGlVWk4tDqbv+6qCPeCYTBMSiqRMT1xgU3zqzwUBzLA
         ojg9otih/PzQwRxeEx2pSQjoRSAsb/tBnWuwhQXTbp+AdE25WTrscTf6fPMO2PLIgi1y
         3hPQ==
X-Gm-Message-State: AGi0Puak8Sb25DS2bLX+k1HA82bUK1HtGCMMVaFBbLpsaGLvpw/ERRTl
        sjByUxWzySogv9s/XZ/zlgAkM7OvRU/FVi8Fd0w=
X-Google-Smtp-Source: APiQypL6WJEPfVj8ECTyT+JSoqDa473N80tBf6hRWZ7qWqp2yq3gnBihUQDEqfd0Gm/MAfHVuwI7Bl06FiAE8BCbCV8=
X-Received: by 2002:a17:90a:d3c7:: with SMTP id d7mr5575934pjw.169.1585860410527;
 Thu, 02 Apr 2020 13:46:50 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:38 -0700
In-Reply-To: <20200402204639.161637-1-trishalfonso@google.com>
Message-Id: <20200402204639.161637-4-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 1/4] Add KUnit Struct to Current Task
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
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
2.26.0.292.g33ef6b2f38-goog

