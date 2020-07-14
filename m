Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D1722C9C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752908;
	bh=N0oRkARnbaSnclY/Nw/wDIbiTxdcWzxHoAT1rVY5lT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wHQBK9OBa7cVQ173D+qATsXCUjZsCV/bwAIqCiNdplyJ6XK3zM0s+k0Bhbg1tJCjm
	 dIiTuUAyzF2+uvV8Q+hqu+pbsbTe7Ccem036uMI9MkBd/JDj67TEc22udPDaWrChNN
	 7Oq/wjFCLWgUrHZrt4SZ9NQL5ojxv80LViu6WOeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgGNSzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbgGNSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2891422B47;
        Tue, 14 Jul 2020 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752903;
        bh=N0oRkARnbaSnclY/Nw/wDIbiTxdcWzxHoAT1rVY5lT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyWhuHyxLCvC/Ss5BeSX/ytCcbh/QIBKex6zp9VEvvB//mTYGukBg9/xOystKvgXp
         2mouq2q1Jm34zwTTGKHz3JJndCGdKUz2fF5vP2c4j2VoR12wEBOGbtZQ75huYoa6Xa
         E9CrCtQQ090s7F8k39TFSO6xN19f72GWd2XdWEhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 044/166] sched/core: Check cpus_mask, not cpus_ptr in __set_cpus_allowed_ptr(), to fix mask corruption
Date:   Tue, 14 Jul 2020 20:43:29 +0200
Message-Id: <20200714184117.989709434@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

[ Upstream commit fd844ba9ae59b51e34e77105d79f8eca780b3bd6 ]

This function is concerned with the long-term CPU mask, not the
transitory mask the task might have while migrate disabled.  Before
this patch, if a task was migrate-disabled at the time
__set_cpus_allowed_ptr() was called, and the new mask happened to be
equal to the CPU that the task was running on, then the mask update
would be lost.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200617121742.cpxppyi7twxmpin7@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2618ade80479..8034434b10400 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1637,7 +1637,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (cpumask_equal(p->cpus_ptr, new_mask))
+	if (cpumask_equal(&p->cpus_mask, new_mask))
 		goto out;
 
 	/*
-- 
2.25.1



