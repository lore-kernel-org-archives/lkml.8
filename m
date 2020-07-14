Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF15C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B5E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zy1V71pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGNUlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgGNUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:41:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15ADC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:41:39 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w18so10400714qvd.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rJt5ovSTMz7G2VZjYNzh69nF3iFTY3dkO7HTEhyGrdo=;
        b=Zy1V71plqmAkPYMcUoLCETjZ4SBhTvXoo7im64OokW04LYUIsyrJt69U1FcJndkP3x
         0AoBKi2urhNe8IcN7fd7chmUIK5jFz6jyT2axji+O3l31gFM/os6kADVzlahumEuzN4Y
         aC+qSRCxoRsqUGkvsYgK2AE0yLgb3YlxE5DDUJyjief+rOOdpwK7NU3xcHZKzHY9gOPO
         NvmTppsjOcm28PMXJCtdpqyLPCZEYyfoENj5wJ4AUQDlCpggfx/chuh2rfPKfq51MVyp
         dDZiiqnUbdX81UNi82/+ND9BjimZognIzNk5YM4EaR6/XbKAAwsF+krL68ZJ1W++Lo5A
         iGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rJt5ovSTMz7G2VZjYNzh69nF3iFTY3dkO7HTEhyGrdo=;
        b=nllK1hG1t96v3ImV8tg4d8NmW+OXgrZawjhG8lr/2kbrXDWJCmGzGnnpCISsH0ldTQ
         vl/V2UywmSU9jPHd6pTMzpgaPPGCzE8TjdOwIqKMmnrkjQaH75k+Nms2Y4IDOvpGHYAm
         MkePXj55XlQsmfpV/oPllaV8860hlx48T64ffl+neGw7yy1m+bX98hCVNHVJK7me+cYo
         c8Z3M3qoCD2lDAH5+z1H+7CjLBa9MykPia0JtFYRqbWD1tG8Yccv6HLW0m1L3zQTwz1q
         gc+0+N8AlGJMyjQ1JBGpcAYvM2c6OmwFFD2MPxEH1mcjTgx5TsoS+/7aHqndQj5u37Tb
         sxGQ==
X-Gm-Message-State: AOAM533UEOkCru7H42dJXFeXz6D97w+bisD7D2AFXELMsJl7m6RM+AZI
        gORhDzJK/UCx1aPNGqkOSZIQKJYE3ipydvzpW9EFEw==
X-Google-Smtp-Source: ABdhPJzdC1TQxJrTIZOZxQTLrI6CP3Ilr7aTn18Y6mWGirKrbLsVH6XhwZY9qWBUkPUaN346rev2NIN1dB4OyP/Kkus44A==
X-Received: by 2002:a05:6214:108c:: with SMTP id o12mr6465155qvr.168.1594759298801;
 Tue, 14 Jul 2020 13:41:38 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:41:29 -0700
In-Reply-To: <20200714204130.54729-1-brendanhiggins@google.com>
Message-Id: <20200714204130.54729-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200714204130.54729-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v1 1/2] kunit: tool: fix broken default args in unit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, vitor@massaru.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
the default build directory for KUnit tests, but failed to update
associated unit tests for kunit_tool, so update them.

Fixes: ddbd60c779b4 ("kunit: use --build_dir=.kunit as default")
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index f9eeaea94cad1..ee942d80bdd02 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -258,14 +258,14 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '', None)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
 		assert self.linux_source_mock.run_kernel.call_count == 0
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -273,7 +273,7 @@ class KUnitMainTest(unittest.TestCase):
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='', timeout=300)
+			build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -313,7 +313,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -321,7 +321,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='', timeout=timeout)
+			build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
-- 
2.27.0.389.gc38d7665816-goog

