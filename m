Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B5C35242
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D9520726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZFLV0Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBGSIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:08:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47049 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:08:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so138001pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0v8qFG+lakbNwCs1dTA5aCEVT1bp7ahYq6NmZeNOrGQ=;
        b=YZFLV0Uw3aGkA8Di8/+VdoaniHd8W36VUerYnREvcVaDz4ZrjpBC4fp7llzYwLLqjE
         /dh336xBMloCOnEejmmoYQAr0i95xSJlW4+cMn/Rnw8K9BM4eSB+8E0tAcdHodTR5X6p
         e2x/gsyjUYhqYvdt+wKzZHifjOXU37OXwd0HShElOPyGhZhRlycYXLRVoKCDxy6Cobd/
         MgawCZ3tNO5lRvO0ZFjRWNxUisGE57LqlAtmsYlV+6bveBq2YnCqRIo48IEw6M30/cZ/
         9bi/LcSXSpWVhq2qIL43638VAiF0MCaPG3Ms98jKGeMtEzVepZwziTrhIAoyrFHjTCEj
         blWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0v8qFG+lakbNwCs1dTA5aCEVT1bp7ahYq6NmZeNOrGQ=;
        b=hQ5A3A6KC/L/Fc/1wIHAmJG+tnEdiXgfd2pqCdrbqRsT0lZQhJZRPnR/nSklQ2sK5M
         ycuSeXFYW3557IinA41dlZf4yKT3TALNqcbg3e3paqv+3J1jxYl4526IpQy/122X7aNK
         4VmME8KvKyrzq4RmdGqK6tluF/gB0wI4X5geDaX9VxbcT3axMIoi3M1NB370GsNQvCfx
         ao4S46ij9XcuZRWxFgXEbY+GLlc0ct9mofq73hUzK3F1ChcCK18YQiE7dbPpf+UdUdmx
         a3G3Q7csFZbP6SYngiXszxLpXabvWWqbTsLtG5VnteeY8xd3PRPfG1pTXlm1CN+OGLdO
         ugVg==
X-Gm-Message-State: APjAAAUu02utd/6TG177KCWXMPUl2f6+YindL2wSWfo4sD3ZlDWpVcHG
        vyemySAD0jAbssUdWw3Fjf0=
X-Google-Smtp-Source: APXvYqzaBM/+hmIPNy9bRy1dcY11rU8mCOKoOMHz1OaRc6/wqt8f9BoesHM+STBvRwQHi4+d72LfiQ==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr105769pfp.257.1581098888027;
        Fri, 07 Feb 2020 10:08:08 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.120])
        by smtp.googlemail.com with ESMTPSA id gx18sm3088795pjb.8.2020.02.07.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:08:07 -0800 (PST)
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
Subject: [PATCH 1/3] sched: Remove __rcu annotation from cred pointer
Date:   Fri,  7 Feb 2020 23:35:03 +0530
Message-Id: <20200207180504.4200-1-frextrite@gmail.com>
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

