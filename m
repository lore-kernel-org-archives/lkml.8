Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86467207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H95qmqkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgHACdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgHACdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 22:33:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5135DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:33:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so5590099pgf.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDtO0Okrnr12+McGOxB2uAxG63eMShlMxD428sFJ6/M=;
        b=H95qmqkLgB3oB0V5c9fU1FxBJIMVMRvMopQLYp4vKbPNVMyQuGfHG5EzX10axH2J/q
         5BONL8lpaK6CwgLBTxfFFrWGHUNnDo06ae2V2LpVsihXDNsdLhYwcWtpYOA3J0kNp5WW
         7KtbsFnF70VE88VoLV919G7lcRgP4MnUEidnfHOCRWHQybcGh4CB8QvHt6/BzGvq97JI
         oFFfgQ4gf9BhcHt8Rwh0zf0QUTrSCz34/F+S14h64rKSXI1fQ5QZF1sHBfYyfBI7INh4
         DXr8xESRHF5Lui005s8tTfT7cgo2RovENUjdB8ZvqwaxtyKn0Cl/IanzN+yWSdW9pwK0
         YIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDtO0Okrnr12+McGOxB2uAxG63eMShlMxD428sFJ6/M=;
        b=FxQ14cVc5myeIMxyWpn7Dta6r4NfKVDEFsDbROZvg3iGvHtXSSOuCcpYihR8E9JyCz
         iRYrKjmyu6NG0JIyR7xzOFrOwO0ekBPOFYkF1m1f/1jg+YtFTLcVFcDgqmWCBumknTC/
         FGZh+Fo67G9JW74JeazTJ/xbgSZVXjYXNwNB4agnHn4LphxIPie34vB1wt1Ypna4I8qw
         Suw0/DCuqm+TTQCXirgLMVR4OD1gChMpkc0NUY7sAwsAIIBydF/fA7I9tWM+kLAa41Yg
         PBZ8Qm/wTBwib65nSgWyxvUNHAbIP9MYX+trvHTNwdBV9d4OHqPQ6uLc9hR9/Dbvvfmq
         s81g==
X-Gm-Message-State: AOAM533EEjShCu+AWcAIgcPIcUxJQAtXFWz2/+7T2TR+9N5zCA0QZU1U
        HHa1w4R5fmDiCk/f3aI1xWs=
X-Google-Smtp-Source: ABdhPJwf883MYIdZut9nUjmx73O9Ji69NFHFb2ct+NPoteKPGRsn7jwT5QuBHv4+R01AU2yFXIBaNg==
X-Received: by 2002:a62:2785:: with SMTP id n127mr4910513pfn.303.1596249186764;
        Fri, 31 Jul 2020 19:33:06 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.8])
        by smtp.gmail.com with ESMTPSA id h7sm11994674pfq.15.2020.07.31.19.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 19:33:06 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] sched/fair: reduce preemption with IDLE tasks runable
Date:   Sat,  1 Aug 2020 10:32:48 +0800
Message-Id: <20200801023248.90104-1-benbjiang@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

No need to preempt when there are only one runable CFS task with
other IDLE tasks on runqueue. The only one CFS task would always
be picked in that case.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..8fb80636b010 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4527,7 +4527,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (cfs_rq->nr_running > cfs_rq.idle_h_nr_running + 1)
 		check_preempt_tick(cfs_rq, curr);
 }
 
-- 
2.21.0

