Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA6C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1909F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht5AFNuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgCaI2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33417 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgCaI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:09 -0400
Received: by mail-pj1-f65.google.com with SMTP id jz1so814570pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vvuaHKk+HlpvQjDOfBcZlMXDUHafhx6H0xOVhNlX8Y8=;
        b=ht5AFNuS5603oSD/oK4BFIR4Iy+szv9JbbLkUO4Hgtys8CjCnV8i2B+dqAayfRbP4e
         N1QWHs5BZlEiqd7xn/+CJH2IGbjiJXBaBuZViJ1nacDb6+SGKwN2yqhE5DTmeNFlN91n
         8p9Y/3QjvgIpCGGc3tTllvnrb9Wz0fJ3ZTJ2rqqQIF5erYT2PVeGlIwlIZItp5dW29fR
         PtyfdMJ17JjgkBJoSWggJEuGq1r4N2B1Hy5F8yHFP9CHAWCFV5ZVB+/Tj0nBuPXrgy0G
         XFeeEkK+YsTQE8SsA4Krv9gmL2E3Y688pJDnvCRDQUg0eRX66Cml59Yx40VsO6pkRyM6
         ufww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vvuaHKk+HlpvQjDOfBcZlMXDUHafhx6H0xOVhNlX8Y8=;
        b=rDyEh3cGUd6qI6prOI0XL5793Qzk3E2pN/YIDV8fJeTlapp7kkf2UQYUtPMBrh1Wfo
         IU1ikfd3MEnPx+UFly7ror0YRNo0WRQ3m9lU9imOexvBWQ1q+YCKPOXP4+4KtwrsbaGF
         7tPMr1FXvCDDXKDFzz2ZwzylbA/ANwppxeQlHi2egzxlLpAhO/9j9hI5XzHOqtNK5ie6
         DibgbUaoFLgaErW4CkNZzdnARTvmjZ93eXUpYbC1hCe6BvcTdUqVJGdqbZaA/mPGyDYQ
         o4pXNz4T6L81YvWvaIkq5B63QHtc9yZgQeD5B4QFSHZwl2O0aG1jmb9ZGL7HNYOzJkjG
         4+bg==
X-Gm-Message-State: AGi0Pua6j6H10lvTnh4GsX60lFMc3PRb5uOIfXfbO6ZPdQu4KxD9/ss5
        ay2Nj8YMCd9hfocLA0GB4G0=
X-Google-Smtp-Source: APiQypJuZqMrbnsNW0kwXp/mvKJzQNU9CO7+4pJ9P+iZCSECFrIhVV1gqRp9kWZMdp6CvBAblav/Yg==
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr2487666pjb.143.1585643288402;
        Tue, 31 Mar 2020 01:28:08 -0700 (PDT)
Received: from localhost.localdomain.info ([103.220.76.84])
        by smtp.gmail.com with ESMTPSA id l62sm11095775pgd.82.2020.03.31.01.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 01:28:08 -0700 (PDT)
From:   li haoran <lhr01130208@gmail.com>
To:     mingo@redhat.com
Cc:     pertez@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Li Haoran <lhr01130208@gmail.com>
Subject: [PATCH] sched/fair: Fix a comment typo
Date:   Tue, 31 Mar 2020 04:28:02 -0400
Message-Id: <1585643282-1521-1-git-send-email-lhr01130208@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Haoran <lhr01130208@gmail.com>

Fix a comment typo in check_preempt_wakeup()

Signed-off-by: Li Haoran <lhr01130208@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7fb20adabeb..7e9831831635 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6870,7 +6870,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally check_prempt_curr() after an enqueue (which may have
+	 * unconditionally check_preempt_curr() after an enqueue (which may have
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
-- 
2.17.2 (Apple Git-113)

