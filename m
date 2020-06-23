Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A77120656
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945824;
	bh=I6VnDk4BoSmtkRXVnFLIIrNS4DEqu4Z8iF3KWD9auXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+7XjhVwQMe378JPdGQ4AQXDXrjN4Quaoh9J0mL8RBCbo2+ie3dTgRQoI6OIBrZLf
	 lBpBdIlcCYbxkAcT/QthhLEMMA+RsjZbzYVJYdmlwF33BQ7zcZm17IqkFGNmj/4+KL
	 cAxHYPd34zgqSHtK7R2ZWpCql/hKIKniG1CUOXG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393084AbgFWU5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392484AbgFWUnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44822070E;
        Tue, 23 Jun 2020 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944990;
        bh=I6VnDk4BoSmtkRXVnFLIIrNS4DEqu4Z8iF3KWD9auXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1jk6kyFp/sfIVqV0wBAE4q3QQ5H6ZuAM85kofodYzJZWLcpUdqdXcV6lqbLJ8dKH
         rM8YUKDrKRXzC7oRrt7nxafUv2TsXQONfxil0oh7mcGo8Az78InSKuCTwCle8N/BYf
         zJwM0nStPb3ATdTP45ZHa5/coN7pOnKx3+2OW89Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 204/206] sched/rt, net: Use CONFIG_PREEMPTION.patch
Date:   Tue, 23 Jun 2020 21:58:52 +0200
Message-Id: <20200623195327.077871462@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2da2b32fd9346009e9acdb68c570ca8d3966aba7 ]

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the comment to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-22-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 50498a75c04bf..8db77e09387b8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -902,7 +902,7 @@ EXPORT_SYMBOL(dev_get_by_napi_id);
  *
  *	The use of raw_seqcount_begin() and cond_resched() before
  *	retrying is required as we want to give the writers a chance
- *	to complete when CONFIG_PREEMPT is not set.
+ *	to complete when CONFIG_PREEMPTION is not set.
  */
 int netdev_get_name(struct net *net, char *name, int ifindex)
 {
-- 
2.25.1



