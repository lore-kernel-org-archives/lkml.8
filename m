Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAEF205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9DIcWm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFBOgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:36:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F62C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:36:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f187so17467047ybc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8vggNqY3GSAouo8x9FrTGZVFgabBzu+O3KL9Xujh+3U=;
        b=X9DIcWm09UmxmRsz16EpMv8qqmV3DSHtK5fNi9pZkF0pev0FkS6Kw0yXboODbOhcfK
         2oaVKS0u9n/MBWmZ73GCHGX6zYdb4dqjEDRhRMg5CdsnG4F7SBt190Dn6Km4mfbkI3c3
         9CcbTRMYKcsvMNM84NHPjaO9xZBdrwaW7iRVw/GVzHLsCztDaU/n27Qe9OWwN1HDesld
         edMg7FVgKhxKabeKrqWF2Clt7U1jlvur1afMMXtLBVkKoV8BYPPwXArC9DFYdDi9I3NZ
         +uLz+0q0uf+ghqOILA9biElscHDatT19W4reWQjsUjRLpF1cnCgWpVRDeYz2FZD2naj7
         kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8vggNqY3GSAouo8x9FrTGZVFgabBzu+O3KL9Xujh+3U=;
        b=BTJA3HKVozXOiNxmGq7LXU1i9scgvIYTrVxn97xFJqz7KEun31t04RvJGDU56SZEcr
         Hz14RzSvBsiuNo8/e+3MaeV/bjxKBZKbxDcjfoS06F4gBVZePrH/l54booJd0nccLsgk
         7lBFNKocK4bH4s9Oab50YonPoEPewWw1qajY2IZXM6Goa+gVKOXP3wkHEo5I6G2d9GpV
         tJtotKupKGJvRUQMWkr7osMoK/PImjx88S5stbuu7kC3pWd+4AsJYkWPNkUPEbdIk1u9
         7swAzGbiMZkFQ8n5NN4JWtg4I7Op0L4hnmbq6O+gE6hbnT/jC3xUU39WN5FYhVOkBLQu
         92kg==
X-Gm-Message-State: AOAM530QSGMbWv5lvAgKtaNyu6dyYYQlVjsg6+RmX9/T4uRN7OfrCyDM
        EcQ64UfUVBRV2kPCiJy7q19sVlpalQ==
X-Google-Smtp-Source: ABdhPJw0iDolPXQPDOUxeiAWTlaNAPQf17kOAyUeJkzG9+Hcx/eXIf7QRjtoPOiNipYQO1L0yJx4O90gfA==
X-Received: by 2002:a25:31c6:: with SMTP id x189mr4868765ybx.402.1591108606409;
 Tue, 02 Jun 2020 07:36:46 -0700 (PDT)
Date:   Tue,  2 Jun 2020 16:36:33 +0200
Message-Id: <20200602143633.104439-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] kcsan: Prefer '__no_kcsan inline' in test
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of __no_kcsan_or_inline, prefer '__no_kcsan inline' in test --
this is in case we decide to remove __no_kcsan_or_inline.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---

Hi Paul,

This is to prepare eventual removal of __no_kcsan_or_inline, and avoid a
series that doesn't apply to anything other than -next (because some
bits are in -tip and the test only in -rcu; although this problem might
be solved in 2 weeks). This patch is to make sure in case the
__kcsan_or_inline series is based on -tip, integration in -next doesn't
cause problems.

This came up in
https://lkml.kernel.org/r/20200529185923.GO706495@hirez.programming.kicks-ass.net

Thanks,
-- Marco

---
 kernel/kcsan/kcsan-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index a8c11506dd2a..3af420ad6ee7 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -43,7 +43,7 @@ static struct {
 };
 
 /* Setup test checking loop. */
-static __no_kcsan_or_inline void
+static __no_kcsan inline void
 begin_test_checks(void (*func1)(void), void (*func2)(void))
 {
 	kcsan_disable_current();
@@ -60,7 +60,7 @@ begin_test_checks(void (*func1)(void), void (*func2)(void))
 }
 
 /* End test checking loop. */
-static __no_kcsan_or_inline bool
+static __no_kcsan inline bool
 end_test_checks(bool stop)
 {
 	if (!stop && time_before(jiffies, end_time)) {
-- 
2.27.0.rc2.251.g90737beb825-goog

