Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F46FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C820CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ujI1zcWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgDFMKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:10:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37529 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDFMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:10:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id u65so7430134pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6mLhtlmWMVTR84nfQkFj0UeiYqI/lAWABfPtUwxRcg=;
        b=ujI1zcWP42qZdIINh84ie1npEVP76g1qKpX2ZlvJVuv9SsmVgX4HQSsfhuLPeqzQAe
         z8YhIWc/Dc/xiPMHlr2cYJT4OWouiK8DXszrwIm1kLo+tiCrD7rqFEs3X8udwq51EDWO
         4M533RhNUxRzapSz2T36ulJVfFnqt+a7nQIPgxkrtJSRuIEFPUHOF9GRNF7WZUrqVyc9
         /u4hWJF3Cjt0FpMf4VIgVsGcR9MCckGF/iMx80+znle11QRgNovkbIXyaXYbScvPYrET
         wvAyo1lIk/9wSKtLSKF7TiIYd5FL4sM6dYSIlTbrwymGcSXLoomwnsApaYnZzGVJl0KU
         3v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6mLhtlmWMVTR84nfQkFj0UeiYqI/lAWABfPtUwxRcg=;
        b=MAxG8QLsInb4tQSoSTxT2ukQXHTco90OCtOu/9+XCtueY8EW1v2CehPv3aQ4zJeBW8
         160SmDg7j8Dh2g3ffyPWHkKsCNOW96cw1ci1QBZW42QdlC9cqaBGX1rCaYsaWUcTGGmU
         TGMghDCbxfmp309lqWl2D6lIP88bu/jhq+Cpy6OB/kL7IWU6PEs4FOmRQv+C7T3OMYK8
         eV7OgxRmBZaENPZcsTp/YZeKz8OXEPgjA8rgC4zO00C/b3fTYco3Y8ut9o1+6MavDYy3
         r17Xfg0A7Xov13dkGkRcN3CKcOQYs8hb4AbeePx4aCqcz/1Q2lFi/2a2Fd9hOWCib9A+
         i79g==
X-Gm-Message-State: AGi0PuYDNAPShdXbLD/VwwtuvVWMHD64EJI/GNLySgr3NIxFhZwlwujk
        Ty7GLt5Qlhplae/TGsJkqOV0QA==
X-Google-Smtp-Source: APiQypIqMxQdjz6IFp4hpRLcqO4fbN8fpr4BxiklLRQ/t5C9ZnUZpOqDHpHnv3vNqX8IwrLjLae5rA==
X-Received: by 2002:aa7:8659:: with SMTP id a25mr20399012pfo.173.1586175047658;
        Mon, 06 Apr 2020 05:10:47 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id ne16sm12012966pjb.11.2020.04.06.05.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:10:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] sched/fair: Fix call walk_tg_tree_from() without hold rcu_lock
Date:   Mon,  6 Apr 2020 20:10:08 +0800
Message-Id: <20200406121008.62903-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The walk_tg_tree_from() caller must hold rcu_lock, but the caller
do not call rcu_read_lock() in the unthrottle_cfs_rq(). The
unthrottle_cfs_rq() is used in 3 places. There are
distribute_cfs_runtime(), unthrottle_offline_cfs_rqs() and
tg_set_cfs_bandwidth(). The former 2 already hold the rcu lock,
but the last one does not. So fix it with calling rcu_read_lock()
in the unthrottle_cfs_rq().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f05843c76d7d..870853c47b63c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4782,7 +4782,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	raw_spin_unlock(&cfs_b->lock);
 
 	/* update hierarchical throttle state */
+	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
+	rcu_read_unlock();
 
 	if (!cfs_rq->load.weight)
 		return;
-- 
2.11.0

