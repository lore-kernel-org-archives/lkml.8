Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EFFC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF82495C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340780;
	bh=WMY2KhaknJ6qcA8omuj0vvPzI9GIiw3E9kxGJCALNEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyRUnqCYXjNrbjSJ+Y1dvF5aerGKWPjcEXG4e4Ggi67ZdYQImS4xwOx6BGzuXYB0b
	 3mA1BdNIu+qF9aB1c7oelPdwHkS2AAR8zZ80ZThTak0EF/p9t0guBFduJaH333CEgb
	 4aYbg4MwsmuJdzZpB3b7cDxNsAlaZhDMlljTyIUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgEANqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbgEANo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:44:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8AAB2051A;
        Fri,  1 May 2020 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340696;
        bh=WMY2KhaknJ6qcA8omuj0vvPzI9GIiw3E9kxGJCALNEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMW9xVBYzfZZTcTzlTdGZ9xK5jGVVR9jqJtD7L1ZBbxdVi+kJcXeIBC7j7lUueSvy
         DIeVtr20/6BPJZykqo/r1l4sl11npoeZIYNmE8IOy1Q0OyB0fuciSNlSM2+mJ+P4lx
         nuap2Yi5UdpfiesTyvMYW7qEcYqhs1TTj7PeRCEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 087/106] sched/vtime: Work around an unitialized variable warning
Date:   Fri,  1 May 2020 15:24:00 +0200
Message-Id: <20200501131554.026238033@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit e0d648f9d883ec1efab261af158d73aa30e9dd12 ]

Work around this warning:

  kernel/sched/cputime.c: In function ‘kcpustat_field’:
  kernel/sched/cputime.c:1007:6: warning: ‘val’ may be used uninitialized in this function [-Wmaybe-uninitialized]

because GCC can't see that val is used only when err is 0.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200327214334.GF8015@zn.tnic
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cputime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index dac9104d126f7..ff9435dee1df2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1003,12 +1003,12 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 		   enum cpu_usage_stat usage, int cpu)
 {
 	u64 *cpustat = kcpustat->cpustat;
+	u64 val = cpustat[usage];
 	struct rq *rq;
-	u64 val;
 	int err;
 
 	if (!vtime_accounting_enabled_cpu(cpu))
-		return cpustat[usage];
+		return val;
 
 	rq = cpu_rq(cpu);
 
-- 
2.20.1



