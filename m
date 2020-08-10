Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC522206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 01:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpGjhd5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHJBAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 21:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJBAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 21:00:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D990FC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 18:00:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so3942969pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXUIwf2ehBPUDiy3lFJF1kJPO1DKKK/C2iqXILzYiwQ=;
        b=XpGjhd5IF5/XHVzC9m/JLd1F/Oqsq9kyQql9WB89B7hF5M2gyx7A0Ru4wOjMq5a0St
         Ap1yomu4hZ0kRLmRJBGqkQktBer/GHiTgQz/K9V9qK6zVSRC6h0+U3jNTlYHhZmjuk+t
         7cBahxYgAIkoIZxNU9wO40PDX9V47v07DpIoxkAmTAlh2HwL/SyLlHRtMOJjGuISax/O
         LU6JzGavRyA0rn19wN0/Atf4QXdxPmkj7mkplxZcP+/W1N5+QjV3qaMJRre+ZD50X+oq
         cmHApQfgdS3cnIE6ajopdgzuKyIPSPkYuUD6xTr7cj2p0n/PnQhe7apWHNT/P45dbWPx
         CXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXUIwf2ehBPUDiy3lFJF1kJPO1DKKK/C2iqXILzYiwQ=;
        b=OC+Bd2YUueHPNnkoRKJwhyhwHmGZnqTYQmIGwtkH0QBl511YvoSP/gbaWXd7FtycYs
         HPeLz/AkyX3BYTdjKgjZQJbz6sEixHAEeq/LOmLdJynkzAxHLwSgqJDV/UflGd4UTQ/z
         3kFmKw5HIsdLnDgR6fP3KT1rM2VeBp6SHjl+JA1fnZzNyQyh0JiSEjgAW8deOhlSDyIu
         l4J2sbrptr76M0rW3Dzilwn7hHCEUod3F4HMcAGtls+TIgj/reDuqug2rOe0PlSjCURe
         +yYcR8Gc0fTJ1w6DmriBhMJ1oBBPbKMe4qj7/ZKrG7jpJZXKs8YcrNj4C78TwnssvGYC
         Y9Lw==
X-Gm-Message-State: AOAM530E4r6ZbYih1EmW1FBWS8tNqBeufNfWEySq0U1mabvBzou7Ukkk
        YX7kUm2K0SI59dhbtYaW82Y=
X-Google-Smtp-Source: ABdhPJyX7RzBsUVOG8vXjDxXDnWVrm/Ms6e8XrP+UGLnd1ksmb7I2+9jaGvd8SDNM6YBNbMA52w3tA==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr26078715pjr.164.1597021218377;
        Sun, 09 Aug 2020 18:00:18 -0700 (PDT)
Received: from XiaoXinPro-13.hytera.com ([167.99.75.144])
        by smtp.gmail.com with ESMTPSA id r91sm17477735pja.56.2020.08.09.18.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:00:17 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/fair: Remove the duplicate check from group_has_capacity()
Date:   Mon, 10 Aug 2020 09:00:09 +0800
Message-Id: <20200810010009.92758-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. The group_has_capacity() function is only called in
   group_classify().
2. The following inequality has already been checked in
   group_is_overloaded() which was also called in
   group_classify().

	(sgs->group_capacity * imbalance_pct) <
                        (sgs->group_runnable * 100)

So just remove the duplicate check from group_has_capacity().

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/fair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..a41903fb327a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8234,10 +8234,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
-	if ((sgs->group_capacity * imbalance_pct) <
-			(sgs->group_runnable * 100))
-		return false;
-
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
-- 
2.25.1

