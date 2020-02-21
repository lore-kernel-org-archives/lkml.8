Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F1BC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272729;
	bh=xFhBmw0OsCRZLZGUfObY3W1rt2hlf52F5D9bNt+4aaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gioZpHijSYeVaTjnr8hy5FJpydsDsGtBEunptNsYDRuDVPI32MUY6OgcIPG22dB+0
	 2bHjwUJc1g36d+YqWdYCGtaUUSggpeUIpwW46CSQ7iH5uEqnfaJ06Et40gsMs48h39
	 592zqxc5UFp+iOyZtwSKJfhPKAetDJJZ/J/KdBgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgBUIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgBUIMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:12:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B8D24650;
        Fri, 21 Feb 2020 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272725;
        bh=xFhBmw0OsCRZLZGUfObY3W1rt2hlf52F5D9bNt+4aaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZ8Vy0jPSLxQB25pYiAgwJd7NrUyGln1sr3z//iBmNHoT1NwN7ZUHylm6+slY9UC2
         dQPaEhtopqRGQg2xvFiGejYDkvmLYg601tA612H0qq2l90YCrRR6HclCdGvOA9gJGo
         rrmEajlxABHG4lk9bxuSM6O9pE2rkdy1rGM6x7l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Guanglei <guanglei.li@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 250/344] sched/core: Fix size of rq::uclamp initialization
Date:   Fri, 21 Feb 2020 08:40:49 +0100
Message-Id: <20200221072412.189178126@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Guanglei <guanglei.li@unisoc.com>

[ Upstream commit dcd6dffb0a75741471297724640733fa4e958d72 ]

rq::uclamp is an array of struct uclamp_rq, make sure we clear the
whole thing.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/1577259844-12677-1-git-send-email-guangleix.li@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dfaefb175ba05..e6c65725b7ce0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1252,7 +1252,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
-- 
2.20.1



