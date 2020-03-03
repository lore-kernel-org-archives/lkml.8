Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E68C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A3020656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259054;
	bh=E3YVgtsw6Ht4SRsv2+bJ31Iqon7r6QazEhUVanUXS3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVfXg82UYUHl6JrcJk9Dn0dGIzobvFT7BYGXYMrB+0hCtmFw5qyGlpMoyeprrqhBY
	 Q65yb7/oqo+UuDmfz256MjYTm9VGQRmPY4Ncj80Yi5OlhgRUl/NVMzdVmTxZ+Awxpa
	 mznd9/TdSCsjdBR76SwOjDClr0PPYLHkOw4wCP0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgCCRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbgCCRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:50:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1490420CC7;
        Tue,  3 Mar 2020 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257817;
        bh=E3YVgtsw6Ht4SRsv2+bJ31Iqon7r6QazEhUVanUXS3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PleMDdzS/8ySrfKkqnOecbIg7+StsyVUTCdCH+ITCprnSZffyT05+XoNOqVpbgWuw
         nW1g3IxL+jvn6Fri7+dRhJZ1ceg34ioyuCL2hA7oAOweZDWGZ4oBM36XLd49k6ajRb
         BmQAd3yHj/kvpdqP+wNh9Dy52P/dkClrxHL/AvMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 5.5 133/176] selftests: Install settings files to fix TIMEOUT failures
Date:   Tue,  3 Mar 2020 18:43:17 +0100
Message-Id: <20200303174320.136453781@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit b9167c8078c3527de6da241c8a1a75a9224ed90a upstream.

Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
timeout per test") added a 45 second timeout for tests, and also added
a way for tests to customise the timeout via a settings file.

For example the ftrace tests take multiple minutes to run, so they
were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
timeout setting").

This works when the tests are run from the source tree. However if the
tests are installed with "make -C tools/testing/selftests install",
the settings files are not copied into the install directory. When the
tests are then run from the install directory the longer timeouts are
not applied and the tests timeout incorrectly.

So add the settings files to TEST_FILES of the appropriate Makefiles
to cause the settings files to be installed using the existing install
logic.

Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/ftrace/Makefile    |    2 +-
 tools/testing/selftests/livepatch/Makefile |    2 ++
 tools/testing/selftests/rseq/Makefile      |    2 ++
 tools/testing/selftests/rtc/Makefile       |    2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -2,7 +2,7 @@
 all:
 
 TEST_PROGS := ftracetest
-TEST_FILES := test.d
+TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 include ../lib.mk
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -8,4 +8,6 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -19,6 +19,8 @@ TEST_GEN_PROGS_EXTENDED = librseq.so
 
 TEST_PROGS = run_param_test.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
 
 $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -6,4 +6,6 @@ TEST_GEN_PROGS = rtctest
 
 TEST_GEN_PROGS_EXTENDED = setdate
 
+TEST_FILES := settings
+
 include ../lib.mk


