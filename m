Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F5A2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyaXfJJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHRREo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgHRREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:04:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE0C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:03:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so16904407wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHhaJZL4omWMEhSsDlpfu6kH5HHdc261F7armVnM+tk=;
        b=fyaXfJJY7Gz1vHNo9Gjb151UCFusosFYaZ49ybX/W6V5evBGH65wQQBumzZC9MyxA/
         MAvGCRF4UybKaqsdRSC77fan5k61zqCZgeCy5Cb8B12kdHG0w4bzU3bWz5FnZZGUnbcV
         geaDEEeYrbPPDZsCp9aCuEud410X1ttD1gAlsRAyA4cL+nht1lq7XxrotlESQvvlydFM
         rsT9RaLt3LJ8csbW21Yf3OfnCB0GbA/bkPCT/qrk5P1zG5LMWVGpAQ1YGLgSz+6wP/+z
         t6tiFdULZbzT5df6HS1pDAYeQduSBis5eM20VhMCvKJJ/zWXTIriOHw+K25vvGN5TLk4
         ld6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cHhaJZL4omWMEhSsDlpfu6kH5HHdc261F7armVnM+tk=;
        b=B1xsM6mhTLkKBo2qLJ0QSEi37/0Zq8Waql7llTLaYXdQWJT8wLqIO9LcjhTc3YSHpB
         KIMdJBleRJjQte44duR9uQLRTi9nKEMkwoNyFqxJLUjGT4PloohSAj5Opm7YzET2LtMm
         r4+75VDCNBylpmBa5DaezOhbxfVIyLo1kxcstgiFXkZ//SL1aXTcG4SLsCNNqftERujS
         ms3eCzy37t3HG1cqT5dLouufuyX8ZqyA9bcnOjkDigZqqZXpVXekx59n0cJTn7+6YYFf
         NlncvnUaD2w4CBYLFeujdKZGIdnHUqL2s0E7BFFXj2M0hL1TabBV+WVJuXv1l6HPh2xF
         dgog==
X-Gm-Message-State: AOAM533dFZNve1fVZ1qwkl8DcHN2ZstByGhi3CWymLn1TC6/xKbKICs4
        0Wpjj6g/7plSulIGHkP2G9Y=
X-Google-Smtp-Source: ABdhPJyeWHIMjqL2NKE1RnjBiJJVxJyIedrvd6LvSSCc6iYXEq5IhqWbcm5GRnOjgbRr+Uilj8DBQQ==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr842213wma.95.1597770238467;
        Tue, 18 Aug 2020 10:03:58 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id c14sm34833420wrw.85.2020.08.18.10.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 10:03:57 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] sched/cputime: Mark function as __maybe_unused
Date:   Tue, 18 Aug 2020 18:03:36 +0100
Message-Id: <20200818170337.805624-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on config options, account_other_time() may not be called
anywhere. Add __maybe_unused flag to fix clang warning.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 kernel/sched/cputime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d2300452..43ede0d6661c 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
 /*
  * Account how much elapsed time was spent in steal, irq, or softirq time.
  */
-static inline u64 account_other_time(u64 max)
+static inline u64 __maybe_unused account_other_time(u64 max)
 {
 	u64 accounted;
 
-- 
2.28.0

