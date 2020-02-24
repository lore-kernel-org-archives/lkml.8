Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A06C35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC72067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3wDz0iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBXDbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:31:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34058 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBXDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:31:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so3476211plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 19:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yejd20Vwzkjy8wctsJA53OKjv5gxUU+XuqGntcv4+CU=;
        b=M3wDz0iS7qqef+rCSuMgCtuEz2fPfB0i2PQQPSDRrzLM71oR9VagSgkgIIH+/fmtyz
         nAYbPEAUaPwa9yyiFLjrIpWiSBWdYHu/m3TZp+4X0zsnhc9mTl2kKrWWYSa+rQQ80JGa
         fpnMuz2cYu8X/YaJeCZfLCxS+WM1p+5qYQWdUun8bDZP4JkFcH/8P0kH/zYLUTwWt/4Q
         aVbZd81IuRb2N0kJYgAH9EDE3gGkbKembOjzSZJnTuQcNFlm/exeO+Js8Ja6Fbwv4gCp
         reNy+jVi2UL3rY3pSzx4MKRU+TN2dxWEC2SVuJdif0mzpGS+M6otQ3oTIbAqqPMAUISj
         4ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yejd20Vwzkjy8wctsJA53OKjv5gxUU+XuqGntcv4+CU=;
        b=TK+7l+8kZJIiGDc9gMKy7+3cCiBsNLNioik2db+VYrJ9/zX9u8zYi/7v62MB+l0diE
         YaKMv6NW7Odk3Fmz6DPudWVVLyl80YSJPzn0d2payuVWTczObA9yXVLzFa9Ka7TYXxLa
         O2Vw1XrJq9UWNazNloRFv4untV2kiTr+GOT0LfS0p2QEMgqGhyjd2gcWohWdKsAk85Dg
         Z+LIJfxxe6JRNXr5bkqyWiftWEmPMjBjpvXgDQ21LCDN51ozC8nOV3a3WQf3owG612ha
         3ZhVO9EHmdMxZhWoe+ArPesnp6IfkRyQCPoerRQJIRH/zsu2345rC38CRyZlC+jtAeKx
         OPvA==
X-Gm-Message-State: APjAAAV1njAtK8Csxb9P+dyRNJZQBYfxUhYLqoi/xEu5QLu5ugAu4211
        BQ2643dEkOGeYQhFtg4fl0GBNJBPsZA=
X-Google-Smtp-Source: APXvYqz09B0TtrBg/YMiwim1nibuNRPTxkXazNNiOqJVMtuRX4OI6AZ22CCf2Ygv2e3wRNdpB+zIAw==
X-Received: by 2002:a17:90a:7f93:: with SMTP id m19mr17247993pjl.92.1582515061569;
        Sun, 23 Feb 2020 19:31:01 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id a17sm10375623pfo.146.2020.02.23.19.31.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 23 Feb 2020 19:31:01 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] sched/pelt: use shift operation instead of division operation
Date:   Mon, 24 Feb 2020 11:30:55 +0800
Message-Id: <1582515055-14515-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use shift operation to calculate the periods instead of division,
since shift operation is more efficient than division operation.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index bd006b7..ac79f8e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -114,7 +114,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 	u64 periods;
 
 	delta += sa->period_contrib;
-	periods = delta / 1024; /* A period is 1024us (~1ms) */
+	periods = delta >> 10; /* A period is 1024us (~1ms) */
 
 	/*
 	 * Step 1: decay old *_sum if we crossed period boundaries.
-- 
1.9.1

