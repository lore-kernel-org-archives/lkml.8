Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5858C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E5B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPOCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:02:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43840 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:02:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so22779377ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHcm9L3dRNb5ixg4Vx8DtSyRu6w9IGdCFJXH11ueGYU=;
        b=SKq+cfrPkC8Ev/Dk9VchfmgKzCqUug+YRX76TxpG9tNlKIMNeYy9V8g+w8yEw8lS+z
         U8TD5vnfJ9GGVPE8QvWdA8Vw3BCoM5dupTJwWyl8r4jsdcNBBMsDSsK7e36OpmJa3lUJ
         7281+1rQERy9Mv+TNwRYmlJng/3mqqdsV4mCl7WlsheSCOGvXu1o4r3eZzZxHoGx+ilP
         1Ialio3rN9otCPqh59dc6MoRwv46lzjrFyJZEdCdrjaXAJiYnePUmJh+bA9xXrAWlw5j
         IeL8HkKwUhTBnU725rrRgW16Qq/dHDTrA8y4ezRF7tZkWvYQUOO38ZoK1StDSfbSH1t8
         rBYQ==
X-Gm-Message-State: APjAAAVi457pYsqegiYvcMD3pVvaZpv8LsdNr0uHmGz+1khIkISbUILM
        aG18Cj2ZhV8I0iu62i3+bwo=
X-Google-Smtp-Source: APXvYqyAMq71HrYqROKPETkwe9gkBwv1GrgOU9b7N6fzOWxGgqPjVPdubC5FFLbDX9+L1tI4lbnD6Q==
X-Received: by 2002:a2e:97d9:: with SMTP id m25mr2444728ljj.146.1579183352102;
        Thu, 16 Jan 2020 06:02:32 -0800 (PST)
Received: from localhost.localdomain ([213.87.157.244])
        by smtp.gmail.com with ESMTPSA id 204sm10682795lfj.47.2020.01.16.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 06:02:30 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     notify@kernel.org
Subject: [PATCH 1/1] timer: Warn about schedule_timeout() called for tasks in TASK_RUNNING state
Date:   Thu, 16 Jan 2020 17:02:18 +0300
Message-Id: <20200116140218.1328022-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we were preparing the patch 6dcd5d7a7a29c1e, we made a mistake noticed
by Linus: schedule_timeout() was called without setting the task state to
anything particular. It calls the scheduler, but doesn't delay anything,
because the task stays runnable. That happens because sched_submit_work()
does nothing for tasks in TASK_RUNNING state.

Let's add a WARN_ONCE() under CONFIG_SCHED_DEBUG to detect such kernel
API misuse.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 kernel/time/timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823515e9..52ad2d6ce352 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1887,6 +1887,11 @@ signed long __sched schedule_timeout(signed long timeout)
 		}
 	}
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ONCE(current->state == TASK_RUNNING,
+			"schedule_timeout for TASK_RUNNING\n");
+#endif
+
 	expire = timeout + jiffies;
 
 	timer.task = current;
-- 
2.24.1

