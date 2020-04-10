Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD095C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7C20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ni8EWjmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJD0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:26:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39937 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDJD0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:26:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so253239plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zB6eoPbFxQzc9EsGjup8MvOhwkt3OS+0JMpUU/JQ+5I=;
        b=ni8EWjmuQStnLsqCU4sK/2M4goQg86KfwvAnE/aO3L+hEhfDxeKN/FeSp43wy/SPI9
         bvOPCTUR2KFzs1BO3hr0jpt3sSUgkXD50l+acpuGQhfr+nVnCsHUIdC2+lIHaAb78txV
         1KkrykMoValQJ5HgmPmls73DBPIPw69rk+DJsmLTzvCPvM+Kc7jndDY3moN/qRPln0z6
         zm8kAQ7u+GtoxIlC5+bxdiCH/MqCWbWVlPc6+lUEDL8811seCfROPECbULVgmjt1tsnw
         8nDnZWuOa+SjuC6NrP26qrSlQQo9JllcVCFhA3zXOHc/bTkT/0+tS8NtAPpoqBEpNpSL
         LM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zB6eoPbFxQzc9EsGjup8MvOhwkt3OS+0JMpUU/JQ+5I=;
        b=SXz43xk730mcNmVirucpMG8WpfMBfuKoVU66eZgHNQvAKRy9t0I99kMaE/WSs9pYcV
         5R30p0CAtgnS6chwWqNRQkhO2iApaslfX0jCwdrduNK9UDbQRa7NJscGDFP5gmdHR6SS
         ysnmGDFomd//c0LR1eswN8DZTeHYNpVJJ0dMpmITe+8r3wHpluM6GLi0LIhZUotgCwKN
         8Gke0dP4ybMSIGse/ItnZDqyk7BmUNFCt9aJunlHH77mX7Tqc/K/18HekIi2Pl4zf2Q5
         YMm6mf58LgCVNOCLfrXu4A+vVZYYumoy2EiLutg8DZbONvL0SH/t+k2ymj30pWEYT/Pm
         pdTg==
X-Gm-Message-State: AGi0PubDBjyC+tZpcFJii5rAZ+DSt76wqD0Q33TxlWvL7FId3+oMRCHz
        4CFFEYXRBVk+n4jsco/MJ+zFIA==
X-Google-Smtp-Source: APiQypJcSapHwKHabYnMU4zdM3x+GcsZt0Fy7vnxCpA0QyKHKGjvjEt7KxbZtoeQ9K+Sb6vfBR5Flw==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr2699169plo.336.1586489199438;
        Thu, 09 Apr 2020 20:26:39 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w127sm480372pfw.218.2020.04.09.20.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 20:26:38 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: remove the assert of lock for cpu_running
Date:   Fri, 10 Apr 2020 11:26:34 +0800
Message-Id: <20200410032634.57511-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_running is not a lock-class, it lacks the dep_map member in
completion. It causes the error as follow:

arch/riscv/kernel/smpboot.c: In function '__cpu_up':
./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
  364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
      |                                                    ^~
./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
  113 |  int __ret_warn_on = !!(condition);    \
      |                         ^~~~~~~~~
./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
  390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
      |                           ^~~~~~~~~~~~~~~
arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
  118 |  lockdep_assert_held(&cpu_running);

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8bc01f0ca73b..bbc1baa2d90c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -115,7 +115,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 		  task_stack_page(tidle) + THREAD_SIZE);
 	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
 
-	lockdep_assert_held(&cpu_running);
 	wait_for_completion_timeout(&cpu_running,
 					    msecs_to_jiffies(1000));
 
-- 
2.26.0

