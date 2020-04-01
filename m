Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB42071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnw5UGnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgDASJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:09:25 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37043 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgDASJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:21 -0400
Received: by mail-pf1-f202.google.com with SMTP id n28so342633pfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7tqR6IbLJuZB8xQehAvx+fGtdnXfyS7jowzmd4c+P/U=;
        b=qnw5UGnLyUK+GZp+VrpZN1Bln3HAT0coO285eDLUYwU7g/QYkogK1DRML0u/t4HRC9
         ri1hhKcMf8hX1DgMHV1aekFh3n1t1833Bp4RyL2vPTKAWoYYf9xvjOKwLZGiFKCEYiQ8
         m2AxZlqAoNPEcVlxTfLPjZ2pNl0qG/X6WZoY8TgJgcTEtWmswlrQ002zWyVbH0s7Md//
         zoMSQRe5ptY0Rh3fBX0jcHbKJzMfO20yHSD2nsa5rZ50r4i0jziDqmwAb5fp5LG0ykyp
         nnvaDeUHc0H6JBXtrZXcIgMjN3i1FkjT/8cZrrZ2aTDOOvkxjTXpbnmknApOZgYZkkkG
         MRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7tqR6IbLJuZB8xQehAvx+fGtdnXfyS7jowzmd4c+P/U=;
        b=IWCcqGq0FqKOvi/m6mmKzgHg5tvtFS+v/+aSXRJXxA0QwqEthqVLujXQexxlAOaeDh
         NAV7DJaJVb6jrOA3m7MtgKqKPxGMW8/nQJoU11TuqS4fT//YWd+DhKoBUknUsavkToOv
         xnM9+t1DonDVCjWijpkexjH3kcuOhe4k6Gcw7kevM4S3Ay8vb7sS1GFYXL1NIpM70W3z
         QiUTBo557zXs90kKxdMQYz7ZC0wmDOeDbFPlcHKFVAtF/PAN3wt2b0Wz7HruhPfv3D1p
         EsdCeC7rp0StTdeu5dDdQE9MX4pfTwMuC8cXSk3egodKl9M7gi+GP+HAgrSD7aY8peoj
         RQXA==
X-Gm-Message-State: AGi0Pua5Z1Dz12VRoG1ifPe6XYXNOYKGUj14MiUxOR6apGe1IArKTS+F
        tNiNXRtDnp/JsuY5xI33OvRvJWGF6j+nOlIr3Iw=
X-Google-Smtp-Source: APiQypLl3dAK0yKLDhBAlH1tPEWkzMGGngQ6Vd1d2wIRSXg9xLwU6R7r5iID12CVWShsM8HsT9c8IxOGCnIRuJDjnCc=
X-Received: by 2002:a17:90a:272d:: with SMTP id o42mr6327393pje.194.1585764558291;
 Wed, 01 Apr 2020 11:09:18 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:06 -0700
In-Reply-To: <20200401180907.202604-1-trishalfonso@google.com>
Message-Id: <20200401180907.202604-4-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 1/4] Add KUnit Struct to Current Task
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
2.26.0.rc2.310.g2932bb562d-goog

