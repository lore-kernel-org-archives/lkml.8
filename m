Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54512C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133372075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ecV7GTgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIJHGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgIJHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D2C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:44 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j19so3478017qtp.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W2nrS/kBK4lWw8uYN1BB5WUGx+sqFHBHeS5Oy6sIX6M=;
        b=ecV7GTgPDsG/kApsANDQzCfbg0cEbu4YIiSd36Fb/L+RAwrNpvp/FUFv/nBGuALrML
         pJRzm0dq75dEmTd0SdXVvQC6D1BeKD2mcUuQhJQjWXX7OJKSrRJ3qMBdCbNVTIRPXotv
         vfTA6wz65eudtK2ZmK0w78GFHF05VRyUE/YIEjgBXUVK2aD7YooMd3U0tgjzXetoSLhq
         IdSN+uK8VTaxz2keWnRS6y3jNhlRkR7YnxhzbZocEAaqTtAuNjHa5yQBG2wWFbpEPeCW
         2OLZmM9N0cXkodbwtwpwxmG9DtcYVY9J8vzszCBKAeFO1zVSB+6jHYq2YYs0SPxcbw4B
         olnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W2nrS/kBK4lWw8uYN1BB5WUGx+sqFHBHeS5Oy6sIX6M=;
        b=UYXRyVURAkwtPG81Keh/yz9wLgPKmSFP53i/xM7s1Otb8RVgYODVWXOg+CIk4hgQxa
         PAcGLM/yYF84Oc5XTAn9mL1W++lEizMtQUV8va/ljJcbyEC3fZuZn3rqCTKTMqZ4QlWt
         Mar/6oTaeHNASxIW3KpxJWJcDM8PtCapWiZKZNqa8UERSGV35GhhaCCzCwU36ySM0m4G
         SvlayB1MOJrX+C8b4kKl9UUJ6UZvl62AoxOviZ9TwqnogRmJGdtU3E1pjpX7QGXvlMtJ
         ddDcG0JBSRb2b3l+Yh8rSym705GfzJfmSYwRXVPbo0GGLR6BtQveAMwEBPo2Nh4Eaoym
         h4gQ==
X-Gm-Message-State: AOAM530gZU6YWIBA7Lc+jheBMmdBNFWLRLCwF5pUQmJGFSRt+GKvtgpY
        8JvB85Q8dLfRDluAIpK4Xs9r1TZeqG4bJw==
X-Google-Smtp-Source: ABdhPJzXpkB2ckKT5eUysvFRDlrYdivhKP1T1o74kG0EOhhSSnmL7Z3PI7l2Fxsys3P2CKihUDCs2QOYTTDF7Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:ad4:5a53:: with SMTP id
 ej19mr7590337qvb.54.1599721423196; Thu, 10 Sep 2020 00:03:43 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:26 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 1/5] Add KUnit Struct to Current Task
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
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..9df9416c5a40 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1203,6 +1203,10 @@ struct task_struct {
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.526.ge36021eeef-goog

