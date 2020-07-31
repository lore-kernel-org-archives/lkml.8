Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1144C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B82A20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHL3/dWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgGaIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgGaIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:41 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:41 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l5so3065710wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wdHz4VAV7cWLg1rq1e/SyhC9acNNi0lj4Bxe95gHR1c=;
        b=fHL3/dWw1EHVS7WtZlSGyIHWOwTlMq18graguqY/6X1lzcsC/OHyCgO/p3evFWUHID
         SdMZKlATAp8ToqPHyAFJyIFqjYs6OBnAJZMGun+21mjHidCsOwsDbirsHUwcI0KiN6r5
         TU+ZbuEqK0cbkkpj+lYu1CqDfXnBvqot/uMdQIN1bMTpFT8ZerxjFoOv1OBu7XP9wZiq
         NJwYUB3veLy2rxXwVos/pbrvYU846iDAI3e5czG5WHkQQINTjTGx6O0q1JK+1waFg2G+
         5ixPwRRmti87KhNYoVH58fRhPUpqMjMdn1S/3W0vJG/oRhBYiJ6JbniYM3zFP2MqMBxT
         J5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wdHz4VAV7cWLg1rq1e/SyhC9acNNi0lj4Bxe95gHR1c=;
        b=ScDuddy1HQ9W+dheUPQzJzHZSsWigP+Y4Gtb5O2fVt2EHI20oVuWFObifrVkbZyZou
         Jx9iWbrDEo4jI6SxjRDVrsvvmRSO57zGcMNKrZg0yCP373hvlTzjbhI5COADp7yaLcZW
         1EDQkzmwoUAtIArZQQxVegkZcatdQ8wlq6OuiWOmpq5/92TxiX1OPR3Y9iSfIkOtF/VF
         k82NsGkCNY80mi1WIP5qk45Et2tcp3PcCweHOs+MjgYS7/y/3JgYqkCOn+iTR8Orlq4H
         WpWxiC8Fd9vL1K0S4PwarigDtvAwk+ta4BMeQ2VC211fU7SsjWqTPHDeSgiYpHeMtiXt
         H4Nw==
X-Gm-Message-State: AOAM531ovcJbJ/yoWo0W7Kwh786sx449OhAis6jCmblqfbXyipzrXrin
        S8FCuapjTf9LDPTJFpdXmY+8FVCeqQ==
X-Google-Smtp-Source: ABdhPJxsMOnttopvDl1CgCKajkBHpZ9tKgAmNv+H7XNIvr9JN8M5ZQZjjFPezbpJk7Kaeb6BfBD859xnyw==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr2954894wmb.185.1596183459822;
 Fri, 31 Jul 2020 01:17:39 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:20 +0200
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
Message-Id: <20200731081723.2181297-3-elver@google.com>
Mime-Version: 1.0
References: <20200731081723.2181297-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 2/5] kcsan: Simplify constant string handling
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify checking prefixes and length calculation of constant strings.
For the former, the kernel provides str_has_prefix(), and the latter we
should just use strlen("..") because GCC and Clang have optimizations
that optimize these into constants.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 8 ++++----
 kernel/kcsan/report.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 3a9566addeff..116bdd8f050c 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -300,16 +300,16 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		WRITE_ONCE(kcsan_enabled, true);
 	} else if (!strcmp(arg, "off")) {
 		WRITE_ONCE(kcsan_enabled, false);
-	} else if (!strncmp(arg, "microbench=", sizeof("microbench=") - 1)) {
+	} else if (str_has_prefix(arg, "microbench=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("microbench=")], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
-	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+	} else if (str_has_prefix(arg, "test=")) {
 		unsigned long iters;
 
-		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+		if (kstrtoul(&arg[strlen("test=")], 0, &iters))
 			return -EINVAL;
 		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d05052c23261..15add93ff12e 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -279,8 +279,8 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 
 		cur = strnstr(buf, "kcsan_", len);
 		if (cur) {
-			cur += sizeof("kcsan_") - 1;
-			if (strncmp(cur, "test", sizeof("test") - 1))
+			cur += strlen("kcsan_");
+			if (!str_has_prefix(cur, "test"))
 				continue; /* KCSAN runtime function. */
 			/* KCSAN related test. */
 		}
-- 
2.28.0.163.g6104cc2f0b6-goog

