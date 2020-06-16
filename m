Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6544C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50F02080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CncR2ckP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgFPMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgFPMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:37:04 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E6C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:37:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u48so16565868qth.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1xZsTLo/mLSdGNuFOenJEIpuLskAW05lb+ykXWbx68A=;
        b=CncR2ckPQIqp5hX5YHoZMyol22QiF7P7xoaQb3qSonwPZL3UAk/R+pHMvquKf0d87C
         4YZEAN+A/0MfQW6Cj5+Dn3LTQI9iTt0CCX8n+UPUx8JSJIBYf8QHQrnI8BxRIgcNCYEK
         oBT4xYNMu+rkP43syP7IpaH5gb/zHdMlwHH/fO5FshnUGbzQjBs7/tEj+msttR2IHW7w
         IOj/nYGu84Kp9OIVPLiAGDGtM4Tk4PsW3YppKggvhSKUOR2wonQWz1P086/MwUqg+1BN
         c864AG5GQzb45OfPrdlEpQ/A/Fi742H7XI60y9aNTI6g2cdJbuOJK3sZD0Ro5vpuS4YI
         GTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1xZsTLo/mLSdGNuFOenJEIpuLskAW05lb+ykXWbx68A=;
        b=N8RAAr7vrw/swliLQ5qQeFCcps6QAYIl+N9+jo4JDhw7bDBRe8/9nXJ5ufOMz+8f7v
         9uc/6K0LaQSHfxVEJL5ZGL55+4m4guakm9Um+1Cf8T8pF86hbfgBzTnaDCMVLd0AAlzs
         yoqmdLzdN3ERdbtl3VHw6qemIx6WpB6Ol2UfaQ9BFhd+hnWukLjJvvgnlMkIKTmgL+mE
         of2f2evdP1Y4DlD2ExA/I6pUyvi+56qy3tj868U9ZbEbkom44ev479vCmubp0oLVKxFN
         QX6gi/aWCLppgzJiRqHx/VD9TkuPpFqTJRFaFX9d7rI0MCuu7akO54CxTmij97VTqj1b
         CbLQ==
X-Gm-Message-State: AOAM530GxabDhERNeN0u8vuQ6CmSAYgDCLPTcyOML94WJMh+HMiQ5vxW
        zSrX02QNJSExO2MZHj7lYHQtTMI7gQ==
X-Google-Smtp-Source: ABdhPJzlujLtRYSoGtbR364ja8ECJ+N0OhikaUYPJzj/NWlqKDE9gBHlud4ZlMQRSPu70L9TBAeZNvE5pA==
X-Received: by 2002:a05:6214:14a6:: with SMTP id bo6mr1988177qvb.244.1592311022252;
 Tue, 16 Jun 2020 05:37:02 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:36:25 +0200
In-Reply-To: <20200616123625.188905-1-elver@google.com>
Message-Id: <20200616123625.188905-5-elver@google.com>
Mime-Version: 1.0
References: <20200616123625.188905-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 4/4] kcsan: Add jiffies test to test suite
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test that KCSAN nor the compiler gets confused about accesses to
jiffies on different architectures.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index 3af420ad6ee7..fed6fcb5768c 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -366,6 +366,11 @@ static noinline void test_kernel_read_struct_zero_size(void)
 	kcsan_check_read(&test_struct.val[3], 0);
 }
 
+static noinline void test_kernel_jiffies_reader(void)
+{
+	sink_value((long)jiffies);
+}
+
 static noinline void test_kernel_seqlock_reader(void)
 {
 	unsigned int seq;
@@ -817,6 +822,23 @@ static void test_assert_exclusive_access_scoped(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, match_expect_inscope);
 }
 
+/*
+ * jiffies is special (declared to be volatile) and its accesses are typically
+ * not marked; this test ensures that the compiler nor KCSAN gets confused about
+ * jiffies's declaration on different architectures.
+ */
+__no_kcsan
+static void test_jiffies_noreport(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_jiffies_reader, test_kernel_jiffies_reader);
+	do {
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
 /* Test that racing accesses in seqlock critical sections are not reported. */
 __no_kcsan
 static void test_seqlock_noreport(struct kunit *test)
@@ -867,6 +889,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_bits_nochange),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer_scoped),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
+	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	{},
 };
-- 
2.27.0.290.gba653c62da-goog

