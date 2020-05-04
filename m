Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F93206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d2jI+fON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEDDy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDDy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:54:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:54:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so6277683plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPS9L7ysttmLvsFDSLjv2rycXWe2ZfvFZhGUCSkxjGY=;
        b=d2jI+fONjp02mrsO6Uj8FaugmVJND0kJy1zkWCVpyEHjP+U5Ogv1/6GYeqtD1YjJJ0
         1u2Ie9j0nzRiJzgz094DNjNWsF0xtBVFolMNQt5AMt9Nh6LfN45UjVGJm/EZ+Bfu7xuP
         y/6DmvaMfLlfTtOrs4TgtSGpucDR72h7WdVYBXJAQ7ELZQPmLv0swUrEsFBuWC600XsH
         EFOxD+D025lGykwqsIf8iZh9Ija/JmJNYka+eFpLyvcR66rpTQpVRgovJ5r+RdM858zc
         Wu+5seWYAZKM/gRIryBX0mFPjAqiH98W0Ra6imguVrllw+uwoz3TvRfCSyUo6CXj0Iff
         +axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPS9L7ysttmLvsFDSLjv2rycXWe2ZfvFZhGUCSkxjGY=;
        b=IE5voDFH8blK18NRTyiENBgH9gWeqaWh8etaRVadbFM7i+Bh7Bi2jxX28MtmAppfQF
         MmHBB6uO+tYcGjWnzP5HLjBvPFXhPGIyRNHhLu9XRI79juLX0QOaXQrVqQ4Xy3KpBzkt
         +DjjQgl+LT+UStlmiy4fgK5IHJIKuSJFmH9gzQf8esB1HMesgm7QAwsTlBEbticWB3t1
         XvSrPw7Wz0/yGZEc8oRC2Qq3igpDW2NAFez1wJA2Tb2oO8j7mK9MRUTsR4pV75Loosvq
         YXBB70TmXElL/Se5CAvaOM/YHVUhpXLJsGX6zkx+gy9+6xIruAIiD4B3cUuu47oJDtIG
         j0cA==
X-Gm-Message-State: AGi0PuakB3i1wsA771Lzu1XS01y2ZwmvjGjSodEN8G5jGupLnodlG24I
        kFNb04QKnDZh5pa6VmnHwLtenQ==
X-Google-Smtp-Source: APiQypKXHm6qgJnASYh9JyzGCcO+f1+hXHaMNhb7B0DDfNO2HO2/dYGRHAzaXDuFc5W6srF/piUbiw==
X-Received: by 2002:a17:90a:3422:: with SMTP id o31mr14921071pjb.18.1588564495228;
        Sun, 03 May 2020 20:54:55 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id b1sm7335121pfa.202.2020.05.03.20.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 20:54:54 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        atishp@atishpatra.org, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH v2] riscv: force __cpu_up_ variables to put in data section
Date:   Mon,  4 May 2020 11:54:48 +0800
Message-Id: <20200504035448.13893-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
Currently, these two variables are put in bss section, there is a
potential risk that secondary harts get the uninitialized value before
main hart finishing the bss clearing. In this case, all secondary
harts would pass the waiting loop and enable the MMU before main hart
set up the page table.

This issue happened on random booting of multiple harts, which means
it will manifest for BBL and OpenSBI which older than v0.6. In OpenSBI
v0.7, it had included HSM extension, all the secondary harts are
waiting in firmware, so it could work fine without this change.

Changes in v2:
  - Add commit description about random booting.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/cpu_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index c4c33bf02369..0ec22354018c 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -15,8 +15,8 @@
 
 const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
-void *__cpu_up_stack_pointer[NR_CPUS];
-void *__cpu_up_task_pointer[NR_CPUS];
+void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
+void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
 
 extern const struct cpu_operations cpu_ops_sbi;
 extern const struct cpu_operations cpu_ops_spinwait;
-- 
2.26.1

