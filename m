Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1DCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 02:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24022074D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 02:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFgqBT3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHMCxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 22:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHMCxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:53:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BBC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 19:53:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so2066783pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qdg5ICKkw844+c4bO+aPNXZ+mzhilYRRfw1w5alQM80=;
        b=rFgqBT3yJy3T8ekWWpgECxbs8t0FsOBjYOEtaMb8DQJb07xdNq6ikvmpZGwiJwZ3Lc
         7QZIeOXCJ4bMCIXwTY05d4DEMfxy6xSXUOhMGSNheCkpZXO/VNovXZaiKRfUkxNrkhBC
         qVgY/0HsfT9OmQ1aVGphDAL2tWoAIdWrVhLjJ59RarCpJKk7GBruwDzQbyX9ghu3MkLl
         3mSyCxEVCcgTwJJw04pFK7de81DWfX8xSs7oQSp3Licm8CLBH+1D3o2UPxJR1kBCO1Z6
         +oh5S2GoEqpd8Jx/yeZHEmCcoLTTd+5pa4vvofAOpuyTVhajRxj9XhX+j3C7ERWPFmna
         OCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qdg5ICKkw844+c4bO+aPNXZ+mzhilYRRfw1w5alQM80=;
        b=aHjbqILriFLcYoQvtvFIhcC3ONFb5ntDh5DLrcv+NyLTruySi92a0fBRR2ujjs32p1
         tWSWHjCK6kr1TFbgIjWcbCfqnWt9oKjsFyJjgjxB8DyEm2WHjP4TLnP/DnmbDwQ/azfw
         tiy+Let+7Ay8J0DfIA1PJp3yKw57AfZePKu385B/axTvZe9UCzxi/Ie9HRipw8YLj1m9
         CtB6V3FopAQHIVfKsuHw/u+Uj2qawUmb7SRjQ+Yj3owuY0Y1c+HcSE/1loQJnsZOsRxH
         w6qG6LmA80Vonyc2Jz9QhOOtzdwuyJB0kPizhj5zL0Dr+vFRSdpnM2pBsTm/+R0KJ5Am
         RkjQ==
X-Gm-Message-State: AOAM532WlvTeoGpnfpcl/q2Vjdu97LXDn3Ldzh6ZhUXzcR136s1IAe9X
        FPMcrCxq/88791k70EmfpUs=
X-Google-Smtp-Source: ABdhPJxcD8qcWMtaj2hCnGFtA9hQAOoaqbq5mDPW2pcy1YTZxfVEUosBiMLQAsN9xouis9m3TnAl3A==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr2142058plo.129.1597287231989;
        Wed, 12 Aug 2020 19:53:51 -0700 (PDT)
Received: from ubuntu.localdomain ([118.193.245.26])
        by smtp.gmail.com with ESMTPSA id f195sm3614244pfa.96.2020.08.12.19.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 19:53:51 -0700 (PDT)
From:   hui yang <yanghui.def@gmail.com>
To:     christian.brauner@ubuntu.com
Cc:     christian@brauner.io, peterz@infradead.org, christian@kellner.me,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, wad@chromium.org,
        YangHui <yanghui.def@gmail.com>
Subject: [PATCH v2] mm: LMK, adjust oom_score_adj when fork a new process
Date:   Thu, 13 Aug 2020 10:53:31 +0800
Message-Id: <1597287211-4291-1-git-send-email-yanghui.def@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YangHui <yanghui.def@gmail.com>

Also it rely on inheritance,But there are some things you need't inheriting
if all children oom_score_adj is -1000,the oom is meaningless

Signed-off-by: YangHui <yanghui.def@gmail.com>
---
 include/uapi/linux/oom.h | 1 +
 kernel/fork.c            | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/oom.h b/include/uapi/linux/oom.h
index 750b1c5..0251f23 100644
--- a/include/uapi/linux/oom.h
+++ b/include/uapi/linux/oom.h
@@ -8,6 +8,7 @@
  */
 #define OOM_SCORE_ADJ_MIN	(-1000)
 #define OOM_SCORE_ADJ_MAX	1000
+#define OOM_SCORE_ADJ_DEFAULT  0
 
 /*
  * /proc/<pid>/oom_adj set to -17 protects from the oom killer for legacy
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190..9dfa388 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1584,8 +1584,8 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	tty_audit_fork(sig);
 	sched_autogroup_fork(sig);
 
-	sig->oom_score_adj = current->signal->oom_score_adj;
-	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
+	sig->oom_score_adj = OOM_SCORE_ADJ_DEFAULT;
+	sig->oom_score_adj_min = OOM_SCORE_ADJ_MIN;
 
 	mutex_init(&sig->cred_guard_mutex);
 	mutex_init(&sig->exec_update_mutex);
-- 
2.7.4

