Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FEDC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0DB2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579367482;
	bh=lAob5InXYUyPpdo+tJNv9Ez8vXIz/jNo7/URNq9XyKE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tBzNTiuIDDlzkHrDpmjLaxvhZI+M1P5lX/y4Z5acgqC7ukhoWTYh/w7LqwODX3V7e
	 mYDT+equhQ+0tn7EJpw0Uhhaqf3W/X827pGR65sHKQnYic0syLKKJNOIHXwYDC2cI5
	 Ezr6a0VbCjlK8FeLeIej90NYKphhGapj+Lo7WrQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgARRLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:11:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:11:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so25523054wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o0oqsPyrpOKXypqsn+Sj1ixLs4eu//UNYSkrOqQslpU=;
        b=DjXDi5qRSGE9cNxfM53iHjjVwF0Ri9fNVrHRkRzpjVsSz0lO7pQjOwJOmod39T6B6w
         XSAb1eBhqWQCbeSc6Mb1N8olyqSxL78RGvNjbZ+fspoEy7fZ6Bl/jsBPN0cEovzNjwQW
         GCbSL6MDi9ysEFvcnZxrZykT+D0QiGD2pbmV02yYlQ9PyYuRllY6eQBeZB9qaBXLOGPl
         6J5nSNSzYptOKYM1LgCc84Y/gmf784aYXof80g8mUlt8yqFQNuxM+701cAgj76pP0yxy
         GfaOI5fipgTGMKncIMFHr4PvADNHQjJhaGjYfSLuZyTfXQXo/PS9Gpy1tWzPWCqf1Pfz
         llkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=o0oqsPyrpOKXypqsn+Sj1ixLs4eu//UNYSkrOqQslpU=;
        b=ZTrDb10+nBPcjYRg2ghaaN8Urh/ObjOE2kRemxx0od6TMcFjsVOT4+shIFeJNk6n1I
         gsjFCY9H+hqkjN14/FOf9BlU9HxnzU2wLl5+VQZ28NrqcwzlDorNDv+DwCqptvQcBtUK
         YcKl0/VejHxioeA+hMKRHLKLjtYKxBwXJc2KGfIqQ33e9OyGibgyPu7p/8tWH806BDpg
         DEwwCZd2YHLEQQIrhIyt3mDRA5uT3cjMgV8WeokK79ZLimg7Dz2bf4jdj47REXKIg1z9
         ZVsZOSLU8J4aZIrTh8YqjNHZaMMgrv3YyzjEwoJWwxdeEEfQgB6Q3jVDARMGVu1uCpNQ
         B+wg==
X-Gm-Message-State: APjAAAXqLfeJqvMmKGg1BpzBS7C+1v92Qmwc9XS0ziTU7a1qecYCN+L8
        Uyf4EpU3fOovEH6kTLi/g+Y=
X-Google-Smtp-Source: APXvYqyDUd0VMj/4Z6yyarHeuuUuOfuJusHtClpVXEHS+qm5GRnigFD+4T2Hc0bkm3T0qtiCllX1gQ==
X-Received: by 2002:adf:df90:: with SMTP id z16mr9262917wrl.273.1579367479370;
        Sat, 18 Jan 2020 09:11:19 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b21sm3909109wmd.37.2020.01.18.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:11:18 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:11:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] rseq fixes
Message-ID: <20200118171116.GA7596@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

   # HEAD: 463f550fb47bede3a5d7d5177f363a6c3b45d50b rseq: Unregister rseq for clone CLONE_VM

This tree contains two rseq bugfixes:

- CLONE_VM !CLONE_THREAD didn't work properly, the kernel would end up 
  corrupting the TLS of the parent. Technically a change in the ABI but the 
  previous behavior couldn't resonably have been relied on by applications 
  so this looks like a valid exception to the ABI rule.

- Make the RSEQ_FLAG_UNREGISTER ABI behavior consistent with the handling 
  of other flags. This is not thought to impact any applications either.

( Of course both are only one contrary regression report away from being 
  reverted. )

 Thanks,

	Ingo

------------------>
Mathieu Desnoyers (2):
      rseq: Reject unknown flags on rseq unregister
      rseq: Unregister rseq for clone CLONE_VM


 include/linux/sched.h | 4 ++--
 kernel/rseq.c         | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..716ad1d8d95e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1929,11 +1929,11 @@ static inline void rseq_migrate(struct task_struct *t)
 
 /*
  * If parent process has a registered restartable sequences area, the
- * child inherits. Only applies when forking a process, not a thread.
+ * child inherits. Unregister rseq for a clone with CLONE_VM set.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
-	if (clone_flags & CLONE_THREAD) {
+	if (clone_flags & CLONE_VM) {
 		t->rseq = NULL;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 27c48eb7de40..a4f86a9d6937 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -310,6 +310,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	int ret;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
+		if (flags & ~RSEQ_FLAG_UNREGISTER)
+			return -EINVAL;
 		/* Unregister rseq for current thread. */
 		if (current->rseq != rseq || !current->rseq)
 			return -EINVAL;
