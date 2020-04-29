Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B3C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA9420775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD2L3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:29:01 -0400
Received: from foss.arm.com ([217.140.110.172]:37498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgD2L3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:29:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54586106F;
        Wed, 29 Apr 2020 04:29:00 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703A03F73D;
        Wed, 29 Apr 2020 04:28:59 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/4] kselftest: Enable vDSO test on non x86 platforms
Date:   Wed, 29 Apr 2020 12:28:31 +0100
Message-Id: <20200429112834.24908-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200429112834.24908-1-vincenzo.frascino@arm.com>
References: <20200429112834.24908-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the vDSO tests are built only on x86 platforms and cannot be
cross compiled.

Enable vDSO TARGET for all the platforms.

Future patches will extend the tests.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/Makefile      | 1 +
 tools/testing/selftests/vDSO/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2ff68702fd41..e135b03c3d66 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -61,6 +61,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += user
+TARGETS += vDSO
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..2989e4d5a730 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,7 +9,6 @@ ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 
-ifndef CROSS_COMPILE
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
 ifeq ($(CONFIG_X86_32),y)
@@ -23,4 +22,3 @@ $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
 
-endif
-- 
2.25.2

