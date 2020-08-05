Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD52C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA14520792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Vhtt0A1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHEUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgHEQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:28:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14119C008698
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:28:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so4798866pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A43ByyyVzbSptwNygct83mi3n2DzKWgXvNfPebKl6yg=;
        b=Vhtt0A1Lb+45MJ+Wh1Mnd/6dAyl5W8x4OJgHYPrxVIsTEvhXGbgFbuLoVs9PSI6FVb
         4+koDTinZDAnktM3XmWYW7oHe5byoeDqkyO3ubwkG+KfRrbD2WMJH0qKf4zNdJGVO8xx
         /e+WkeJsW8Oiw8Oedhof48VQhF5C8NcxQC8V7xQa+zd9BKfaXQOlnpPjApEQoPPIPADl
         thisXlmYHDhe2M9jishy6oQJKDq11jKExdFuyCVrsIf0fGx3Nrk9iwaKa1IrCGV07MB8
         jCflwrMAOiNIa8bWrrpkDC6KlBXWRewwszJNRIvUcfK9Dvz2VLM9OGf6oxYKWsMATv8U
         OmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A43ByyyVzbSptwNygct83mi3n2DzKWgXvNfPebKl6yg=;
        b=KetS9Lmp7NNiUs07wni62g0zMvMhFMZp5d4fOnnbkpBU6IGxSHD0aCH5I6Kz36WZFd
         jazcGnn+qOdqg44xpbK1tR1QlLdNVob7bSJr7w6nN61/l5/op3kcDmK0hMjOWc03xphI
         /PoEF2e5VK25mbwFAdzjnYeZRfBjHHUXZxYHe6b9b8blYK/JcV2eC0iMGa2XCwqIzGa+
         qnbELeuHpn4H06MymLYvcA1n0zCZkXsbLQ4mkZtPKigzgOkUFtIp2Kow59NmIEGzdYJg
         6cfKwqTWcJb8ejZP3okq5P+rny2gs6K3laXNoaky9Ka4hGyXSc2lJ0YyCfF0mbR2mNsR
         vzUQ==
X-Gm-Message-State: AOAM530Pn9jvLsdLfm2ieH54/xZotb7U6Mh8CP97PntwDy4ThwO9tcMO
        DnBr7uxx8bB3OxLL1yqs5pb7zA==
X-Google-Smtp-Source: ABdhPJz8Xblx/0gqLzz6ZElpaAiPlDeIUeBjMLlCp2hzlHJxhui/0ePgefixV57yu+dDZ6yxbRkDVQ==
X-Received: by 2002:a17:90a:4502:: with SMTP id u2mr3822075pjg.187.1596644918065;
        Wed, 05 Aug 2020 09:28:38 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.70])
        by smtp.gmail.com with ESMTPSA id 12sm3953119pfn.173.2020.08.05.09.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 09:28:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sfr@canb.auug.org.au, mingo@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] kprobes: fix NULL pointer dereference at kprobe_ftrace_handler
Date:   Thu,  6 Aug 2020 00:27:13 +0800
Message-Id: <20200805162713.16386-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a case of kernel panic on our server. The stack trace is as
follows(omit some irrelevant information):

  BUG: kernel NULL pointer dereference, address: 0000000000000080
  RIP: 0010:kprobe_ftrace_handler+0x5e/0xe0
  RSP: 0018:ffffb512c6550998 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: ffff8e9d16eea018 RCX: 0000000000000000
  RDX: ffffffffbe1179c0 RSI: ffffffffc0535564 RDI: ffffffffc0534ec0
  RBP: ffffffffc0534ec1 R08: ffff8e9d1bbb0f00 R09: 0000000000000004
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: ffff8e9d1f797060 R14: 000000000000bacc R15: ffff8e9ce13eca00
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000080 CR3: 00000008453d0005 CR4: 00000000003606e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <IRQ>
   ftrace_ops_assist_func+0x56/0xe0
   ftrace_call+0x5/0x34
   tcpa_statistic_send+0x5/0x130 [ttcp_engine]

The tcpa_statistic_send is the function being kprobed. After analysis,
the root cause is that the fourth parameter regs of kprobe_ftrace_handler
is NULL. Why regs is NULL? We use the crash tool to analyze the kdump.

  crash> dis tcpa_statistic_send -r
         <tcpa_statistic_send>: callq 0xffffffffbd8018c0 <ftrace_caller>

The tcpa_statistic_send calls ftrace_caller instead of ftrace_regs_caller.
So it is reasonable that the fourth parameter regs of kprobe_ftrace_handler
is NULL. In theory, we should call the ftrace_regs_caller instead of the
ftrace_caller. After in-depth analysis, we found a reproducible path.

  Writing a simple kernel module which starts a periodic timer. The
  timer's handler is named 'kprobe_test_timer_handler'. The module
  name is kprobe_test.ko.

  1) insmod kprobe_test.ko
  2) bpftrace -e 'kretprobe:kprobe_test_timer_handler {}'
  3) echo 0 > /proc/sys/kernel/ftrace_enabled
  4) rmmod kprobe_test
  5) stop step 2) kprobe
  6) insmod kprobe_test.ko
  7) bpftrace -e 'kretprobe:kprobe_test_timer_handler {}'

We mark the kprobe as GONE but not disarm the kprobe in the step 4).
The step 5) also do not disarm the kprobe when unregister kprobe. So
we do not remove the ip from the filter. In this case, when the module
loads again in the step 6), we will replace the code to ftrace_caller
via the ftrace_module_enable(). When we register kprobe again, we will
not replace ftrace_caller to ftrace_regs_caller because the ftrace is
disabled in the step 3). So the step 7) will trigger kernel panic. Fix
this problem by disarming the kprobe when the module is going away.

Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
changelogs in v2:
 1) fix compiler warning for !CONFIG_KPROBES_ON_FTRACE.

 kernel/kprobes.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 146c648eb943..d36e2b017588 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1114,9 +1114,20 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-#define prepare_kprobe(p)	arch_prepare_kprobe(p)
-#define arm_kprobe_ftrace(p)	(-ENODEV)
-#define disarm_kprobe_ftrace(p)	(-ENODEV)
+static inline int prepare_kprobe(struct kprobe *p)
+{
+	return arch_prepare_kprobe(p);
+}
+
+static inline int arm_kprobe_ftrace(struct kprobe *p)
+{
+	return -ENODEV;
+}
+
+static inline int disarm_kprobe_ftrace(struct kprobe *p)
+{
+	return -ENODEV;
+}
 #endif
 
 /* Arm a kprobe with text_mutex */
@@ -2148,6 +2159,13 @@ static void kill_kprobe(struct kprobe *p)
 	 * the original probed function (which will be freed soon) any more.
 	 */
 	arch_remove_kprobe(p);
+
+	/*
+	 * The module is going away. We should disarm the kprobe which
+	 * is using ftrace.
+	 */
+	if (kprobe_ftrace(p))
+		disarm_kprobe_ftrace(p);
 }
 
 /* Disable one kprobe */
-- 
2.11.0

