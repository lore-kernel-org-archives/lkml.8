Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC92206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcTbzcIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFKWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BAC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:40:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so2208729pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8dWTlQmCMbwiCMRbCjZeVNLJgh+V7boVZ7LhOeAZmyo=;
        b=PcTbzcIfN/saE1AKyLP3QLfA2xn3sj1rQc12e9h4y1nZg/WpR5cJ+Y9txDFlpgmijY
         iv7lV8cF7cbYkv1xG90AL2+IXFI7kSxFS2byEqpOo4nhl3KwK0vDiOUpNAQrfjAlAQHL
         Bh7Lva7/LeYU5LS9+4ahqy3TpQhYjTKtzBo2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8dWTlQmCMbwiCMRbCjZeVNLJgh+V7boVZ7LhOeAZmyo=;
        b=qcyYBxE5DiysXbsvDp4PYy5CkVlTshdF2z5RkUBcJYRKLfkUJErJsbzaZ9/jKZuXzI
         UYrbkdJhN4qRbsNllmnqF6KkzgPY6HoDDLJFv8vrgTQEHVSBOsPnhO/uTHFnSJ4YlDqS
         B8HtH5ZcctR4F/+iR7L2pKqAmF87cSVey4MoQccPS4LuflIwMLzMl4Vo0P7Crh2uVbq0
         fxeXJ07//cdUxJI2wpete93uyaPsfSI5UFjZSfGqmTVziwMwtFCGEQSGqaX9hQPs8rhz
         xUIRA3wAotowfl8ywD69Q4BzZlNelqIb/OubuKYNOOpXtGVCoxYtrvlixazLIhHrcGS2
         sA+Q==
X-Gm-Message-State: AOAM531BMd+7JKjR58VQEU+JRIh3nrPRX5v6CgbMmuCTxX1yU9RtWaWZ
        hn886ZMyERkGLeHZNlAEw59B5w==
X-Google-Smtp-Source: ABdhPJwYQE6Yn7l9IEG5W8ln2RLgM5dItUHSf0HKCuHaqmAy5cEJBOXotmVD2AqsDCadSqoYlr4Okw==
X-Received: by 2002:a65:6247:: with SMTP id q7mr8112057pgv.353.1591915233518;
        Thu, 11 Jun 2020 15:40:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm4125147pfe.198.2020.06.11.15.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] selftests: Remove unneeded selftest API headers
Date:   Thu, 11 Jun 2020 15:40:23 -0700
Message-Id: <20200611224028.3275174-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused includes of the kselftest.h header.

Cc: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 tools/testing/selftests/pidfd/pidfd_getfd_test.c          | 1 -
 tools/testing/selftests/pidfd/pidfd_setns_test.c          | 1 -
 tools/testing/selftests/uevent/uevent_filtering.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 73d532556d17..7d84097ad45c 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -11,7 +11,6 @@
 #include <syscall.h>
 #include <sys/wait.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 #include "../pidfd/pidfd.h"
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 401a7c1d0312..eecbf18510fd 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -18,7 +18,6 @@
 #include <linux/kcmp.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 /*
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 133ec5b6cda8..f66861cf9c4d 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -20,7 +20,6 @@
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 enum {
diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index f83391aa42cf..5cebfb356345 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
 #include "../kselftest_harness.h"
 
 #define __DEV_FULL "/sys/devices/virtual/mem/full/uevent"
-- 
2.25.1

