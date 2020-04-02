Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861BFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BA1206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7uZ1Wcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgDBF5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:57:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37066 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBF5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:57:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id x1so943338plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0v8qFG+lakbNwCs1dTA5aCEVT1bp7ahYq6NmZeNOrGQ=;
        b=G7uZ1WcvWQXQhE89TjGanF83SSBtnYTzfsKrsZMSO99kV3o0lqB4hLjVXUJgPIlEKN
         MMVBXIwdagq4gBOwV1UYGru2LrNs1b2VXa5vu5r3MzNYwBfTIJ8ITowd1B36Go8wrBru
         DRTpy/WThWpv9D+uoEjemiAT3xmnzkOOv9JPYZxXQn4x2ogiXP+LkuHhR0IsefzV1Lw8
         S06y5Yq7W8YqatW+5AjcTHL3m2WsvWt6kCHqhgRN7d3t4XxGV/DEIKS2TpRbRb9glSzl
         5Mmy6E9a3tylkrg9wUbIO9IWA16tWCpLmACemp8pmWBs5Sw9SKKy1cWB+OIsx6lZogXv
         ECug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0v8qFG+lakbNwCs1dTA5aCEVT1bp7ahYq6NmZeNOrGQ=;
        b=H+xpB/jUZg2L7DhCZhy/LEK1l3gVXQwSiroFEKkIWPtA1JzIkD+fyxISsbZVtbpCRj
         vKE39wVuMpk57PGgzcL/KI49n89pPwG/A76P43kd7IMuKIwDBesKBMsqrfj9UyCqxj+9
         brUMxKwJOcLJfFO8WFoFxsvH0YbFZVji0MrT43L0pnzGhA5O9J1Cd7Dqw26u8agHeS7M
         5MePUpYWBD8686zfZ/VqkImLp2C9bXQIFYUYbIqtDvnGw0oFxCcYz6Ey2qf7hvnP+Jp1
         diZj2yoTdy7BTP0TU0qX1I18XtfHwK+9mu4oiGUTDfcAU6vDcfmnGlUlsWrsuavwLniQ
         povQ==
X-Gm-Message-State: AGi0Puby1tJLa8dVbnEKzFNczAwe5rNBeGYdJ05uM5varlEgHBHT56ua
        tAl8mzaT3SlcxG0gLQsV46o=
X-Google-Smtp-Source: APiQypLJsNATH03qXt80StDeQlmOxYsyjU6euM+h1RDJeAOmpFoPbaurqtKpPF1ZmeSswUcufB1swQ==
X-Received: by 2002:a17:90a:fe18:: with SMTP id ck24mr2037363pjb.57.1585807031699;
        Wed, 01 Apr 2020 22:57:11 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.161])
        by smtp.googlemail.com with ESMTPSA id 207sm2776058pgg.19.2020.04.01.22.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:57:11 -0700 (PDT)
From:   Amol Grover <frextrite@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 1/3 RESEND] sched: Remove __rcu annotation from cred pointer
Date:   Thu,  2 Apr 2020 11:26:38 +0530
Message-Id: <20200402055640.6677-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_struct::cred (subjective credentials) is *always* used
task-synchronously, hence, does not require RCU semantics.

task_struct::real_cred (objective credentials) can be used in
RCU context and its __rcu annotation is retained.

However, task_struct::cred and task_struct::real_cred *may*
point to the same object, hence, the object pointed to by
task_struct::cred *may* have RCU delayed freeing.

Suggested-by: Jann Horn <jannh@google.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/sched.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 716ad1d8d95e..39924e6e0cf2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,8 +879,11 @@ struct task_struct {
 	/* Objective and real subjective task credentials (COW): */
 	const struct cred __rcu		*real_cred;
 
-	/* Effective (overridable) subjective task credentials (COW): */
-	const struct cred __rcu		*cred;
+	/*
+	 * Effective (overridable) subjective task credentials (COW)
+	 * which is used task-synchronously
+	 */
+	const struct cred		*cred;
 
 #ifdef CONFIG_KEYS
 	/* Cached requested key. */
-- 
2.24.1

