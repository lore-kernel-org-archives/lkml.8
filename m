Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E706C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572EE206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="v2KaYSRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgD0DYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgD0DX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:23:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA17C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:23:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r14so8298485pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWkCJL3ctEryrbpWSg1ZW6IULUBwZBfg8eB/8pm3+7E=;
        b=v2KaYSRs8N2hD0nieI0w08EXyDPWoLe4COZyE7HRChzl3kk2KlxnlR9/ayKKIt2Nox
         5fw1ezQt5PUHNWdnEtjvuqE3MNkT3hID/9F+gopT/FrZwof2LDyAA0d/O8HN/JSE4HD3
         e4SDrx/vBfSetkevP/62uKDMx+x3qiPM1M1ur4qzByYaAJJ5jBNMArzPXnA5bcH+8D6H
         pzvv0IcgY5C+ucVgtEPSny5SVGs49Wqkn/smAE0DuBGa+f8Mk1n6KyqHKxe1bI7jvsBQ
         Pbe6ueykP4Tb7p4IRB1DBEqWyG9yGlGiGCqYR1GxEAduWyXmczBmSGjQb4FCzzQdhWhu
         CBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWkCJL3ctEryrbpWSg1ZW6IULUBwZBfg8eB/8pm3+7E=;
        b=iDlNn5B0jFodgryDlOQoQfYMuOF8tY0SL8bwjUAZD0Qq09939HGs/eEBMba2IJ4F1O
         2lvY9attBGwHlQXUrevhvEnF8LnFlIucQ8LQKLScG/X7bTdQ4blW2urz0YdphomQcY/h
         NNdN9aUrnFqAeEDRtebg5ldZAJ41KET6aJvOj3p70xxfgSAvJxhEG7zG4DIOOyRfYGW5
         ocvmwMPBc9NW6s+u7ZUhIKbegoCJfzPOfkVPCOU9ocbKvYlhxzr4i87kKWNm4CIdLemY
         +auZbeWqRksvvkgh3h9ahRTYtI0Jc1rOBCUfSRyGDYUPILlG4OcA4pfxZQQckDunPBgU
         TCNA==
X-Gm-Message-State: AGi0Pubjgq4x6eg8XPhaK6OdGN7LX9JCbl6ukIy0btU6A70bJCF3tx90
        RmItQr3t9WxlFOBgn8/VUtRptQ==
X-Google-Smtp-Source: APiQypKrxJvDhiMk2y9+AUkvCg8JM75d5D7xWjTbRzsfAW37wFRws1/5oaDMIVvRDiB+49yL3tHFRQ==
X-Received: by 2002:aa7:9891:: with SMTP id r17mr8410841pfl.5.1587957837798;
        Sun, 26 Apr 2020 20:23:57 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id n69sm10076439pjc.8.2020.04.26.20.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 20:23:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RESEND] sched/fair: add __init to sched_init_granularity functions
Date:   Mon, 27 Apr 2020 11:23:38 +0800
Message-Id: <20200427032338.73743-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function sched_init_granularity() is only called from __init
functions, so mark it __init as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1141c7e77564d..6f05843c76d7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -191,7 +191,7 @@ static void update_sysctl(void)
 #undef SET_SYSCTL
 }
 
-void sched_init_granularity(void)
+void __init sched_init_granularity(void)
 {
 	update_sysctl();
 }
-- 
2.11.0

