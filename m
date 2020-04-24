Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BABC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9920728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mi3qkaGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDXWgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:36:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19599C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 15:36:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o19so11947855qkk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BNYGluVlJlufemB0tZgDnGQgt3ZJZnv+s9tO+bs4no=;
        b=mi3qkaGvjiwVHU1I0SCkUQLdO3SIIdaB1nbSmtfXnVRQAikXuhwmVWeUb1nmnMJQIc
         rxNDs7SQQfuGZHCuJxmJfnAjqS/LLbJUT9fldddCUYCi800d5kn4bCleOBxmABQBJ9kU
         HjCIJFAH8lhIElTgjzg5mn/bpoPxbmS7064LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+BNYGluVlJlufemB0tZgDnGQgt3ZJZnv+s9tO+bs4no=;
        b=SkvWpBjBcobco/l+FCOnbF/SVfImDLajPhi2RGWrObTy1JitGjJWKJrXICXQlIcxWv
         2uQDN/J74hUwu0dywwNGxI28e9rZWCUeA9axP26N2dgAXk99dxdnSH/EQr3cutDb3eDc
         PtPfEzlMxFH5kdgmy+tSvIxc7cJv7816lIX7OpUVZ3KVYKzw05KUcOtqoksitSzQrdjH
         8dZXJNlhSWcD9UTwJ82RNHw+6UWCnm9r0HSV/7fc8xXOIL9ZRyi4uG0J8sTxIzKGbfxt
         qpRfmXnT5wASp6GkHekF3pdEvxYactmUj16XF0q7V8b5x2G8a0SvdjdAYMDxnaevDtYg
         26LA==
X-Gm-Message-State: AGi0PuZ/ZYcK4x3I24dw/OINSjU14ZwSfJlFCf6A86iDJakG8rfT/UKt
        cda0yca8yDaQbHWweFOy18Jg26oH7yk=
X-Google-Smtp-Source: APiQypLqlZkkulLXGJNb1qmPQj2FDWPAiR3qSRhIEzpbRWzsjcJl2p81tjHVqaRslx9UXdS/HBUiog==
X-Received: by 2002:a05:620a:127a:: with SMTP id b26mr11043280qkl.219.1587767799087;
        Fri, 24 Apr 2020 15:36:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j76sm4563859qke.114.2020.04.24.15.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:36:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq module unload
Date:   Fri, 24 Apr 2020 18:36:30 -0400
Message-Id: <20200424223630.224895-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kthread running the test needs to be stopped or it can continue
executing code unloaded by module causing a crash.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Link: http://lore.kernel.org/r/5EA2B0C8.2080706@cn.fujitsu.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/preemptirq_delay_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 31c0fad4cb9e1..1c28ca20e30b6 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -145,10 +145,10 @@ static struct attribute_group attr_group = {
 };
 
 static struct kobject *preemptirq_delay_kobj;
+static struct task_struct *test_task;
 
 static int __init preemptirq_delay_init(void)
 {
-	struct task_struct *test_task;
 	int retval;
 
 	test_task = preemptirq_start_test();
@@ -171,6 +171,9 @@ static int __init preemptirq_delay_init(void)
 static void __exit preemptirq_delay_exit(void)
 {
 	kobject_put(preemptirq_delay_kobj);
+
+	if (test_task)
+		kthread_stop(test_task);
 }
 
 module_init(preemptirq_delay_init)
-- 
2.26.2.303.gf8c07b1a785-goog

