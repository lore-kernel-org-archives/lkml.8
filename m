Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C919C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67672206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="peYf1Hsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgDUOli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDUOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:41:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B1AC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:41:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so5307190plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAkWzyrmiNTr4R8CFrDKjccmx17c2tmL1k3qSayXTkA=;
        b=peYf1Hsx3QFOvH4UdxFxKFC6xujLskLrprQL2GmBrt8R9l3AotDY6kdN6Q4WyCwKKv
         +6n0FoKCn4JYUi+SL1/QrEbMtVHUkqCSkKgp92vkbMEtbAs+rnN1K38RvM85JKdNKgoW
         ruyMSqetc0SCQ/COtqHlbzLP6U2lVGLDoI5mZunfVtWQ9z9MZX08vKvBO0o0qxZt3W9q
         tdm7QhSDAXsDQssB5jnFt+ZniJjeyL1XGE4OcMfJDveAJcnDkzqhHjgZmqdcDO6GQcgj
         rTSFYGBcahBrB6Its5CASSnUv2ca+vYsIPRGC9UPYluL/Jm9qR/mKZ8kfCXJxk+0ywTz
         CDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAkWzyrmiNTr4R8CFrDKjccmx17c2tmL1k3qSayXTkA=;
        b=VsBXNTl4nhgjSGbKlyqMAYK3Pgnm2m+Z4vnm0TKjzHBcoqfbBqsE3IXUIYJq/kWGHN
         y9M7+rtmlCnhraGjcGbyZgVcHUONxQduwDbfM/9lcuFoXS+y5DeQJPeIJAVVb5H67FSE
         8tc+TtYXRTqGquEb+qrpkbgzZpFVeMPdyrecY2AfJ+vTRLz0MsDichpgoVw8FxtDtGXX
         9vAM6DTjuAxEBFuAZlT7CQa+7PLVI9mTmhuqA3OSha0TyFNV6CxeZXvGfF6rPxYZr8MD
         WscvlykR42Uq+VPfDhhS0V9hQ9qvGFmv65XBB8z4NI8gWXHcFyaJA/qQP85Pnhvywyiv
         yYLQ==
X-Gm-Message-State: AGi0PubEqo74QrUS7mp+48msWrveFVQdbW9EodYWZ1rSfeg9+4Fowy0s
        CpfzoIzWvZvt+5rLX4APWTk9Cg==
X-Google-Smtp-Source: APiQypLOBAOMlLYRXcDAQ8iZMfW8KRRIv5z+Tt48CyOLKweyws0hiPajteOPhKUSaumNmVz+0RSfoQ==
X-Received: by 2002:a17:90a:d917:: with SMTP id c23mr5914490pjv.192.1587480097282;
        Tue, 21 Apr 2020 07:41:37 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id b8sm2613936pft.11.2020.04.21.07.41.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 07:41:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] sched/fair: Use __this_cpu_read() in wake_wide()
Date:   Tue, 21 Apr 2020 22:41:23 +0800
Message-Id: <20200421144123.33580-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is executed with preemption(and interrupts) disabled,
so it's safe to use __this_cpu_write().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 870853c47b63c..356660ec4ff3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5705,7 +5705,7 @@ static int wake_wide(struct task_struct *p)
 {
 	unsigned int master = current->wakee_flips;
 	unsigned int slave = p->wakee_flips;
-	int factor = this_cpu_read(sd_llc_size);
+	int factor = __this_cpu_read(sd_llc_size);
 
 	if (master < slave)
 		swap(master, slave);
-- 
2.11.0

