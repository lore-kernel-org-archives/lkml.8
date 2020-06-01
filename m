Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D9520776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkdmq2EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFATtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFATtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:49:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC932C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:49:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so2945262pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6PL3OvGHOMkzabQ8qT3x0ZtC2fHA0sA9zFM3NMGSpSw=;
        b=jkdmq2ECZn8XeEaaj/N/CW3LrA+0U98ltS2tZpuvuB9OA3dvhAYnHS/oT5nXz0hI3R
         jOjEO/KCn3QMj+yUcocRbEP1aFIXZJxeowvwnd0GF1Gt1pZCQlhxbg7DKqM5+6NPxmkb
         Y6PA529f29GtXHZfiFf9HmrBH3sa1nKj23hoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6PL3OvGHOMkzabQ8qT3x0ZtC2fHA0sA9zFM3NMGSpSw=;
        b=XbSJwAPaUOtpunbJb6QWUpvn5QwlTC15+Ahw65yuPKFy+SRRmQfqqeb4RTe/+AKk5O
         5u+7ZS2jaYKujY5mS8lzcvlADLzoJZJ8r8jyE90FzFtHQzBsfk1/Nr1bNPaQy7hn8tow
         sj5RY+lGQWDuRa5Nw5chbEE4yZ9aO97ddPoNzdCUAeOsS4YWIRux9KDHQ5f4cP5iZiGK
         TioiRy1pi1WxyuArCyf126MTeoUyL5C5PzHCVvj58Ue/8YvjL9SeFfg1Q8qa1iX/+SMn
         4EYwnmK7BSbS9NYDF/aX/XUc+PF/exytGHb83ozg43NkrgmIG4w+d/EMQ4DtcHNlBktR
         veYg==
X-Gm-Message-State: AOAM5321MAGm00pWgKHPVeAkbG1J/YLbJZLG6pmfEjwutRS6lJuBfp2E
        m5ax2OopVZ40GCHCmyISfz7AcA==
X-Google-Smtp-Source: ABdhPJwC5ehzi7feo6zyI23fvGhYfOJewqw9hvI4V9sUl1lxAaFA4zFza+9VkY9DUEp0AJw649eLlw==
X-Received: by 2002:aa7:9093:: with SMTP id i19mr21284432pfa.152.1591040940326;
        Mon, 01 Jun 2020 12:49:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm187978pff.147.2020.06.01.12.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:48:59 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:48:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Expand benchmark to per-filter
 measurements
Message-ID: <202006011245.236AAF3D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to see how much (at a minimum) each filter adds to the
syscall overhead. Add additional calculations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
As part of the performance discussions, this is what I'm adding to the
seccomp selftest in for-next/seccomp to get more details.
https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#md8a6fd608cfd1f3c70aaf9ccc4f09fcc33b5fc1b
This does not include the BPF-bypass mode, which I don't see a way to
do without creating major problems with seccomp. ;)
---
 .../selftests/seccomp/seccomp_benchmark.c     | 36 +++++++++++++++----
 tools/testing/selftests/seccomp/seccomp_bpf.c |  2 --
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 5838c8697ec3..eca13fe1fba9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -68,32 +68,54 @@ int main(int argc, char *argv[])
 	};
 	long ret;
 	unsigned long long samples;
-	unsigned long long native, filtered;
+	unsigned long long native, filter1, filter2;
 
 	if (argc > 1)
 		samples = strtoull(argv[1], NULL, 0);
 	else
 		samples = calibrate();
 
+	printf("Current BPF sysctl settings:\n");
+	system("sysctl net.core.bpf_jit_enable");
+	system("sysctl net.core.bpf_jit_harden");
 	printf("Benchmarking %llu samples...\n", samples);
 
+	/* Native call */
 	native = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
 	printf("getpid native: %llu ns\n", native);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	assert(ret == 0);
 
+	/* One filter */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
 	assert(ret == 0);
 
-	filtered = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW: %llu ns\n", filtered);
+	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 1 filter: %llu ns\n", filter1);
 
-	printf("Estimated seccomp overhead per syscall: %llu ns\n",
-		filtered - native);
+	if (filter1 == native)
+		printf("No overhead measured!? Try running again with more samples.\n");
 
-	if (filtered == native)
-		printf("Trying running again with more samples.\n");
+	/* Two filters */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
+	assert(ret == 0);
+
+	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 2 filters: %llu ns\n", filter2);
+
+	/* Calculations */
+	printf("Estimated total seccomp overhead for 1 filter: %llu ns\n",
+		filter1 - native);
+
+	printf("Estimated total seccomp overhead for 2 filters: %llu ns\n",
+		filter2 - native);
+
+	printf("Estimated seccomp per-filter overhead: %llu ns\n",
+		filter2 - filter1);
+
+	printf("Estimated seccomp entry overhead: %llu ns\n",
+		filter1 - native - (filter2 - filter1));
 
 	return 0;
 }
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 4dae278cf77e..402ccb3a4e52 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3824,7 +3824,6 @@ TEST(user_notification_filter_empty_threaded)
 
 /*
  * TODO:
- * - add microbenchmarks
  * - expand NNP testing
  * - better arch-specific TRACE and TRAP handlers.
  * - endianness checking when appropriate
@@ -3832,7 +3831,6 @@ TEST(user_notification_filter_empty_threaded)
  * - arch value testing (x86 modes especially)
  * - verify that FILTER_FLAG_LOG filters generate log messages
  * - verify that RET_LOG generates log messages
- * - ...
  */
 
 TEST_HARNESS_MAIN
-- 
2.25.1


-- 
Kees Cook
