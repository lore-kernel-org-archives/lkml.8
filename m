Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F69AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6610A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD2Ju6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:50:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51073 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2Ju5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:50:57 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jTjMl-0007Pi-9V
        for linux-kernel@vger.kernel.org; Wed, 29 Apr 2020 09:50:55 +0000
Received: by mail-pg1-f200.google.com with SMTP id 85so1736256pgh.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zcUVI111kTUl6jkpNzi5Gx/jlqEV32o0KCz4lY+rvjU=;
        b=tpWRYKXUWfIPfL52cI4g9vxhGQDLzYWyesDEtnTn1Q7Wq8c9gd8CcvVqXiojKbOkdJ
         t40hLkIDFHJbRUPALk4Kk6dSQabl5S/M9Wols2OoYacyJAaP/NGwvfFcVMj29lxev70i
         ISQrI2GgkKfqhj3tHHwnC3rTlQzGA0SnhuzQHoeID54jYzFGtwlmbENVCS5Q8sL7aaBY
         taauyE3qXSUx9SYU/Y4aZrNd9MoAyT4YltueDJ/lwrYDjhWRKTt5WIr/OUCazH+9lLtW
         vE3i5qvBL+HhWAD5qHMOYmSuEuNqkR/UQTg9HGp7O2cLAtKewlSRTkigyRz1UjRVZ6a6
         UxiQ==
X-Gm-Message-State: AGi0PuZH7r7ymSiSf+TRhYO61UVS9/NFzIT1eU1UoJUmbLSOIIqBfJ3e
        /FlNgiapDNos3n8V4bcg4gmHbYpc0fytazgn0IX+WrplbEnCw3AnP3hYN8LiFUq9OEjsaKujUPQ
        DaCwghn9ehS9B/llEkOVfkRbfJ5T2O2rqKUZnnYkg
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr2159565pjt.62.1588153853657;
        Wed, 29 Apr 2020 02:50:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJnFjG85yGekdABmcCBBQawx763Q/KKDaavim1fiFUcQhdJWIHl4fsXV3TRt5MngWIwTd4WDg==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr2159522pjt.62.1588153853193;
        Wed, 29 Apr 2020 02:50:53 -0700 (PDT)
Received: from localhost.localdomain (223-136-190-244.emome-ip.hinet.net. [223.136.190.244])
        by smtp.gmail.com with ESMTPSA id u3sm733678pfb.105.2020.04.29.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:50:52 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, shuah@kernel.org,
        colin.king@canonical.com, mhiramat@kernel.org,
        yangx.jy@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        po-hsu.lin@canonical.com
Subject: [PATCH] selftests/ftrace: treat module requirement unmet situation as unsupported
Date:   Wed, 29 Apr 2020 17:50:44 +0800
Message-Id: <20200429095044.24625-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the required module for the test does not exist, use
exit_unsupported instead of exit_unresolved to indicate this test is
not supported.

By doing this we can make test behaviour in sync with the
irqsoff_tracer.tc test in preemptirq, which is also treating module
existence in this way. Moreover, the test won't exit with a non-zero
return value if the module does not exist.

Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
Fixes: af2a0750f374 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
index d75a869..3d6189e 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -5,7 +5,7 @@
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 echo "Let the module run a little"
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 801ecb6..3d0e3ca 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -5,7 +5,7 @@
 rmmod ftrace-direct ||:
 if ! modprobe ftrace-direct ; then
   echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 if [ ! -f kprobe_events ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
index b02550b..dd8b10d 100644
--- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
@@ -5,7 +5,7 @@
 rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 echo "Waiting for irq work"
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
index 1a4b4a4..26dc06a 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
 m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 : "Wildcard should be resolved after loading module"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index d861bd7..4e07c69 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -8,7 +8,7 @@ rmmod trace-printk ||:
 if ! modprobe trace-printk ; then
   echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
 m"
-  exit_unresolved;
+  exit_unsupported;
 fi
 
 MOD=trace_printk
-- 
2.7.4

