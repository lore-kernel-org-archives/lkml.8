Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DC3C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2622082E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrQYKNEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBIWj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:39:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55748 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:39:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so7820419wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oV5aBvmYJySuTUfGJ+OmTE5dACque/jzYZjzoBMaClg=;
        b=hrQYKNEmPDa8TRCwvKkjG8XEanpfxMN/Q2nO1o9xIz+izA2+bm309YQW9JxACOuREe
         Jm0chg0MdwNqGoWY07v36XoB1BzQZFf22VnM1dPi/iYwMBJ0SexEuAxDd55gp6Koh5Lv
         JYhnSx0QTmXBQpofxPqBmbX8kErh05uTpzkdHxECZ+gNR9qj0ryqXruLAc4CMGVlamhM
         i9B7cMySGS5Z+ZIWmmIBI2PY4DrFpBlLSaI4sKYb7mhbJDVnaTt/CAn2HaGQZtYKQ39T
         rhjWT4AaJg8NX+A6JXKF7fQ8AdAZtl60x4EKByGeJLJ8XAHXg4UEPowrYEm8qwMXViMf
         Y0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oV5aBvmYJySuTUfGJ+OmTE5dACque/jzYZjzoBMaClg=;
        b=j+P7EAu8TY1s45oS33McIuBpMn+nRU3XVQkwWSEH4QCGH1SEluZm9t/haxhx1KvUUf
         5O3VwGaqX1iXGSWEIfID53AS7774Yft1ajn5bcMti40sUo0IiD0hI8h04JLwZekMUmrg
         mpgea91tUnMTw3mZbiPP0J69QKVjo7zZy601vWzDzTy4jybUIw/4ku2XVw+SOWB1j2Yv
         Dvq66ueSLHEY9/zjSLpv8d6Z8gjHb+9wBsS4oSryWfwbaCsSGEs8Y5a9MoPQZKatLQ7z
         HjKpsFI8IGc4otymhDKDPkQJgPf8i3O2NgCQctU8uv/OuWr5+LyLZjlXuxLBZ7Stnyuw
         P2hg==
X-Gm-Message-State: APjAAAWrdhN3E42yn9AU1e/AB47I+995R0gEvNIUhqpXfBSVDOpHxGbT
        tR2D4LvPcy3c4hKwdurmsg==
X-Google-Smtp-Source: APXvYqwd8XpnE082ajxYmcujV5Bttt+3a0qN4rm7+h5qP0/q6yTNdhuAgT7ZqKsS+BnYSKUNFX1TbA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr11806361wmc.82.1581287994604;
        Sun, 09 Feb 2020 14:39:54 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id a16sm4251432wrt.30.2020.02.09.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:39:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 06/11] sched/deadline: Add missing annotation for dl_task_offline_migration()
Date:   Sun,  9 Feb 2020 22:39:33 +0000
Message-Id: <4cebf47c30ce24ee1972f4b6330376d8f32802b9.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warning at dl_task_offline_migration()

warning: context imbalance in dl_task_offline_migration()
	 - unexpected unlock

The root cause is the missing annotation for dl_task_offline_migration()

Add the missing __releases(rq->lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f875cb9..68ea3a4933db 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -527,6 +527,7 @@ static inline void deadline_queue_pull_task(struct rq *rq)
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq);
 
 static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p)
+	__releases(rq->lock)
 {
 	struct rq *later_rq = NULL;
 	struct dl_bw *dl_b;
-- 
2.24.1

