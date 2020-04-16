Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15ACF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="vZlhn8/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437611AbgDPGyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437468AbgDPGxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:53:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:53:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so1238052pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/CQZoGW8xTIdwCAh4UqkqE162V6pHfTYOX0anhI4o4=;
        b=vZlhn8/yJvtTxkCzKniy8DccIuYm0E39+i4iRDz51seKzKxru4ogqKBKokO/0piOdb
         I4HSFqzPt+jYzVvaikrXY2veoSxmA7RxBpXkeghDEkJerhTMQ9+hxXXYKgN8npCJ7Rwj
         49tuQx309AKp0c7H5dMbpv6cBdbcuWL3ac8RSBHaHDHWFMnD9POtlegU+3O+GCzhkIxb
         yahuvP8IJfA/Ctl9q5CxL4oytWQLGgWRq1AhR8HtLIacOsIkYy6FLAHdjjTnl3rtGJg2
         oBKBkfJBni5z2YgbdlbKxzQJ1vpu++7yzNeyVi5I87TYASpZLmXLjJnq4bZOEFclK7oG
         R7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/CQZoGW8xTIdwCAh4UqkqE162V6pHfTYOX0anhI4o4=;
        b=jmLN+qXY+ZtoIkubS4IEuxFN1nqZvIcPlGuxeMqScdcAvcq0x35Oy9GBiLUq3rUYVn
         5nbOTzd4ZPKVvQKpouVff3npiNwopx5EyBS1UT2Bo7CyR9rHeGUzuZ7FIIUd1RWCT0Lz
         AgGEVa4PoqAbipdiUu67/+E5epsWlEyXkFXoVCQLtXjynrDvnYwtGqrii27zqfN02ZKP
         VAkHOAZ5dvFczRvO7TNxXFVeZyZ6VI/Ato19NZktRRLPbcoRBqVL9BV/grjlgH34s44P
         qPWHzC6d7PsdrQRf2lQf0jHeSqCgjp4Konp0fyM3kRd3jveRwrLhBbO6NbyyUCS8EY9+
         7jxQ==
X-Gm-Message-State: AGi0PubQOY5A2zjSOL75kzfDtQVtahbqYR+NKhGSToxpNCdkUCmvgh/q
        vMfZ23E4gNAAgKYHGOCjBeECiA==
X-Google-Smtp-Source: APiQypJYUEN7Ch73Q/XMtopky0BQdIbYzK9+tqYUP0iIkbUwE3bJdRtB3727RFPfKua30GwM6x50Qw==
X-Received: by 2002:a63:358f:: with SMTP id c137mr1323094pga.178.1587020014570;
        Wed, 15 Apr 2020 23:53:34 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id c10sm14536714pgh.48.2020.04.15.23.53.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 23:53:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
Date:   Thu, 16 Apr 2020 14:53:10 +0800
Message-Id: <20200416065310.37539-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be no difference between the two, but on some
architectures(e.g. x86_64), there will be optimizations for
__this_cpu_add(). We can disassemble the code for you to see
the difference between them on x86_64.

  1) this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;

     ffffffff810d7227: add %gs:0x7ef37fa9(%rip),%rax # f1d8 <this_cpu_off>
     ffffffff810d722f: add %rsi,(%rax)               # %rsi is @cputime

This result in two add instructions emitted by the compiler.

  2) __this_cpu_add(ca->cpuusage->usages[index], cputime);

     ffffffff810d7227: add %rsi,%gs:(%rax)           # %rsi is @cputime

This result in only one add instruction emitted by the compiler.

So we have enough reasons to use the __this_cpu_add().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb103834345..6448b0438ffb2 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -347,7 +347,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	rcu_read_lock();
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
+		__this_cpu_add(ca->cpuusage->usages[index], cputime);
 
 	rcu_read_unlock();
 }
@@ -363,7 +363,7 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
 
 	rcu_read_lock();
 	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
-		this_cpu_ptr(ca->cpustat)->cpustat[index] += val;
+		__this_cpu_add(ca->cpustat->cpustat[index], val);
 	rcu_read_unlock();
 }
 
-- 
2.11.0

