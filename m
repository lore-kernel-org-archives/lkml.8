Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E92C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AC520734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eP6QBUGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFPGrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgFPGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:47:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDDC03E96A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:47:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so3959453yby.19
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rY8mLmisHjWy1FJ/edCX4pC2W+lemlUit54tKdWmG4c=;
        b=eP6QBUGwa7iE9veBVB488E9XSbW6RgnTJdBxJO+wT6o54RHljVgl+A3CITwHr8gLON
         PfnPz11VeEuGVvisiOQsjLo80bewfSJcEPQAwsHVdXAhPm1/Htb/FYU+vYRW/G/IUVWX
         4SUAcx0wuITm7pk1cCPLMI0iAQmh2Eol4ciJzAgcKPSXWYsp4qLlDrzg2VSUTVjGvDrE
         QLe9mPbjYCgVV8KrUWfqpTEbzRS4facU+WEapKgq5cvNSYZYdamicQVfOGbGm6AV2iSf
         jef5HN7zgUQAjZ4Jq4Gr1gMV9ZJk+Hx1zL87tEETTy5GfPGK5f/43daVz1f7PGjalTAQ
         Rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rY8mLmisHjWy1FJ/edCX4pC2W+lemlUit54tKdWmG4c=;
        b=Bf7oD7fgP6Kqi+qHv+y4xm0gYhfo7WfKrj5RFfEvNDWpQnAF+6wnEWxdgqdwX3E1+Q
         BYxKwMHNCjBaXyOx7OgnGHjgs8vYHQxvvdeBGfwrM5ZZ7Uv8FxkTa7r++rpN7WU5ABJI
         CXJ71ShUad/8y/AWCogSFUk77vvLwWF+qNSYGUlxMyuF58SeH+5P3kpwfDnsZsXiCDlV
         HhTb7FaM43l68B4kuidBqXOAofJJLdgvIyCXawsAtcp3jLtR/4qe8pB4Nh9pRbveuejc
         YM20hIl6SVnOKILQ3ziBkY4yTTn1utucZn+F8v1jvV+baG6C8p8q4RjNrfgzdZT9LKXm
         ATng==
X-Gm-Message-State: AOAM5332pogOMW0f98amfuOW37LlCLXA+ZxQApysW3NBcaZw65fG+RYz
        K49XKF2pw0XAkx4RQZ0n87hi7q35jIbQbA==
X-Google-Smtp-Source: ABdhPJyNOyWelBu1uraSPS7WDyezI/GDjB2D9r6wLSLmxn41Z6buzjfQlhIA8UL0JpC9xH6dNY9wtycb2OVPig==
X-Received: by 2002:a25:c507:: with SMTP id v7mr1841055ybe.306.1592290064202;
 Mon, 15 Jun 2020 23:47:44 -0700 (PDT)
Date:   Mon, 15 Jun 2020 23:47:30 -0700
Message-Id: <20200616064730.123871-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] kunit: kunit_tool: Fix invalid result when build fails
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When separating out different phases of running tests[1]
(build/exec/parse/etc), the format of the KunitResult tuple changed
(adding an elapsed_time variable). This is not populated during a build
failure, causing kunit.py to crash.

This fixes [1] to probably populate the result variable, causing a
failing build to be reported properly.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ba7a893ad89114e773b3dc32f6431354c465d6

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 787b6d4ad716..f9b769f3437d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -82,7 +82,9 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 					request.make_options)
 	build_end = time.time()
 	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+		return KunitResult(KunitStatus.BUILD_FAILURE,
+				   'could not build kernel',
+				   build_end - build_start)
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
 				   'could not build kernel',
-- 
2.27.0.290.gba653c62da-goog

