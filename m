Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E6CC3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A1B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AwE8pWyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgBTEmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:42:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbgBTEmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:42:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48NMQb1JZMz9sRt; Thu, 20 Feb 2020 15:42:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582173767;
        bh=DYCVUaJqREzhND+/ZTURlnZqhJ6ZboY/OqZaFazcPb8=;
        h=From:To:Cc:Subject:Date:From;
        b=AwE8pWycjubfvwD9jO89f6JQoUD0PilynV9mjD6EgLGfXn2d3qYuW5f621z4s0AuO
         n0oljC15XWSLEOAYfJmx/kakMY9RHpZN8fD/lv8P3NAzgL/ExBzcE+VEF4r7yWKi3v
         xdV9P5X1BTcXOlyh2fTwR3uBE/XK73IFWlxNilq0Wb/p6nsPcTIBX04UHmvahaIfkH
         b3foH8VpvuUaEr7AAbde6NxMoTICRM7SXfPThMErfpcCkAGXpSfAXA73mRkkrdra0a
         Sqf0DMVb0U5pubfX0hp3p/9JUMXzn82TJqmUFUKJVnsu9hkjKm3z3SeoY0HffLgRVK
         Y/PQ2FWnOJgew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Install settings files to fix TIMEOUT failures
Date:   Thu, 20 Feb 2020 15:42:41 +1100
Message-Id: <20200220044241.2878-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/testing/selftests/ftrace/Makefile    | 2 +-
 tools/testing/selftests/livepatch/Makefile | 2 ++
 tools/testing/selftests/net/mptcp/Makefile | 2 ++
 tools/testing/selftests/rseq/Makefile      | 2 ++
 tools/testing/selftests/rtc/Makefile       | 2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index cd1f5b3a7774..d6e106fbce11 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -2,7 +2,7 @@
 all:
 
 TEST_PROGS := ftracetest
-TEST_FILES := test.d
+TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
 include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 3876d8d62494..1acc9e1fa3fb 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -8,4 +8,6 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 93de52016dde..ba450e62dc5b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -8,6 +8,8 @@ TEST_PROGS := mptcp_connect.sh
 
 TEST_GEN_FILES = mptcp_connect
 
+TEST_FILES := settings
+
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630a..f1053630bb6f 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -19,6 +19,8 @@ TEST_GEN_PROGS_EXTENDED = librseq.so
 
 TEST_PROGS = run_param_test.sh
 
+TEST_FILES := settings
+
 include ../lib.mk
 
 $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index de9c8566672a..90fa1a346908 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -6,4 +6,6 @@ TEST_GEN_PROGS = rtctest
 
 TEST_GEN_PROGS_EXTENDED = setdate
 
+TEST_FILES := settings
+
 include ../lib.mk
-- 
2.21.1

