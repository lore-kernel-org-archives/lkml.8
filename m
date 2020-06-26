Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D409C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F69207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9icln6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFZOC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:02:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:02:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so4318126pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wsTccNPiizn0fz7nFYthbYqYqqgPn20kogZkyyPGgEo=;
        b=s9icln6pXQmn2Ld47CpHrj/Cr7JnWK7w+Wvs/pcn9HkBD5j0nXwpz1L6BWPrTZkm5I
         66bNwWRQQOREHcDos+686Sog1zEXhqdxlqQ9LS47wWIkJ0mIWWdwnaKs7KkvcoVeS4M2
         jpfJha9+HyqMQ0RSD8KrTyhNYSmDjeE7AamjkBTyFszO1GjNEAZYA6Rk7MkPD3dXpWSz
         +9/j6hPt2IZZB5U0fNgXXFKW4W3lhZjrmsTGmmMaVSfgkDD0FoYSZK6C9F7ZhuwI7JDY
         goi5MZvCMVBKuoPAzhor2B71dJLr5xHAP48UdfxzZYTcBPxduAcCyitiCR3dtMIgwTir
         8Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wsTccNPiizn0fz7nFYthbYqYqqgPn20kogZkyyPGgEo=;
        b=XaHpsstXRAcPt59bFZaPQEPSn2YubSEoRpWBaZ17GjQid7URkWMR2sJPL0fba1FkDy
         LMVr4cU/QA6iRczMqoN/gyLjxsRlzbv6cbwuKw37x1DI8xKdbWKJ6W+ADq0Zrl27kWeA
         noTvQafqEtm/TYsoGVUtiZRt3RvIyyf11uxrebT96+Utj56Getkqr3UJr0n4TyLBeq8r
         w49UTwrc9j1W93S44frfECvey07YLDpIc65havjVY2HxlvilBIi3PCmWpq4D93vc+Ens
         UclkpRmr8G+pmBVt3SZNdBetwg29otNimeGrw7zAWtIoawHJrHjWYRoAAWv9fSmIfqh+
         ibnw==
X-Gm-Message-State: AOAM533OufogFlnrl9o9r4oayyddkXjP1ksTO8XZQWSaANcnDxD6IbUL
        nkPwvvzd3za+aK9pMpICq01ts8py
X-Google-Smtp-Source: ABdhPJxy3Wh2qtlfBGDhL9qh4+9Sr7CAEfx6nRoVXpTSOMHXrNKSfeCv7n09SXejFpIMMhS3xkJu5A==
X-Received: by 2002:a17:90b:fd3:: with SMTP id gd19mr3873405pjb.83.1593180177164;
        Fri, 26 Jun 2020 07:02:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x126sm26386383pfc.36.2020.06.26.07.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 07:02:55 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] sched: Declare sched_rt_bandwidth_account() in include file
Date:   Fri, 26 Jun 2020 07:02:53 -0700
Message-Id: <20200626140253.141358-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reports:

kernel/sched/rt.c:626:6: warning:
		no previous prototype for ‘sched_rt_bandwidth_account’

Let's declare it, and remove the declaration from the source file
where it is called.

Fixes: faa5993736d9 ("sched/deadline: Prevent rt_time growth to infinity")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Note:
    I know that checkpatch complains about this.
    I declared the function 'extern' to match other declarations in sched.h.

 kernel/sched/deadline.c | 2 --
 kernel/sched/sched.h    | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..ca1b66db5787 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1131,8 +1131,6 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 	return (dl_se->runtime <= 0);
 }
 
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 /*
  * This function implements the GRUB accounting rule:
  * according to the GRUB reclaiming algorithm, the runtime is
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c1e5fe..02c5d48ed7f3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -469,6 +469,7 @@ extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
 extern long sched_group_rt_period(struct task_group *tg);
 extern int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk);
+extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
-- 
2.17.1

