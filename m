Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F8C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8115E2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAEEZ2fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgCSQmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:42:50 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:36924 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgCSQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:47 -0400
Received: by mail-qv1-f73.google.com with SMTP id m12so3310942qvp.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/e3rkkmfd1b6sk0SVgpVxi2weXIopunVz1TGXPB1o2Q=;
        b=pAEEZ2fM6YsbHdnzBd/r6un+oIKRlxlvz3jic9B38l9/9IankeiOaoOJIXS9p0D2jV
         ow0SmBoXTSKrrRTwRcAO4tMBMAlurZUVf0uJrxkFF+knk+IJ068r0uXlT1HVEAj3eNW9
         uaCBdYWNvy6U/Q67m78UJaYkOtw8lYRXqJOpEyvXoINYqFniiK/7opnn84Ne18pmkW5h
         B0KdDc7uye/6o5EQbKiuVQ7OcVeKdMmjIFdOlDri/nbc4xmHHGd1rbHr4j953sC03Jn3
         EPosz5P6phBMu3ty+ycigOodD8CI0sTLjhIALQz96fDc0KKaVQ8LyLQP07s054PHlsAG
         bb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/e3rkkmfd1b6sk0SVgpVxi2weXIopunVz1TGXPB1o2Q=;
        b=tTDv/J0kpdP4f0OE7BC9LbnjFYt7IzM/Zeg6c64nH/3eHf+zQCfl3oX9Ve04CZYl8E
         b35EImYZ54mlDw3NlfCoVUyzzKF899hRynMOCWr7yvzlMNBB8vKlGmNsBslbyGgSLS+N
         5NRCiLIMsdguh6trJ4nWLmk1oqKH/X3MH1XYlj8USBcIxnj8IDXeweDiE/ZTv1OHMZ4k
         g1OsHmQE0p2N830QWQsLcoQ3qvDT7MzyZGlDwO1vbCWk1NsmnSo+dJE3Xi41878uvMhA
         /FcTNyUkRFl9h+IwvVsW+JzA5BSodYIPuXlq10qXhA48NBjREt1XGz/woX7ZK3PfHeeP
         rsUw==
X-Gm-Message-State: ANhLgQ3q4NMJqYE2m+mkVHdbG3LhzGjp7TpqR626k9Z62rmIBPrvUZgr
        tbjqIvzBlKcFFX3eoxUnRPMfoYFp1vsKSMIMTbI=
X-Google-Smtp-Source: ADFU+vtdcXY065iMK3lYGT0t093yNfaC6nBS+XBMSZLjKKHl191H/3QSOnSZr4cojJzsteGn1+C2lU/+Rpuc1wcTgW8=
X-Received: by 2002:a0c:edcf:: with SMTP id i15mr3610736qvr.151.1584636164003;
 Thu, 19 Mar 2020 09:42:44 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:25 -0700
In-Reply-To: <20200319164227.87419-1-trishalfonso@google.com>
Message-Id: <20200319164227.87419-2-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 1/3] Add KUnit Struct to Current Task
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
index 04278493bf15..1fbfa0634776 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.25.1.696.g5e7596f4ac-goog

