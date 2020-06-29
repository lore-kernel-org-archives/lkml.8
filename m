Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06527C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C970C206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466480;
	bh=RcecoPzbN6cMOUCOjvq9fcSh87a1r6/ArrUZGSnc7+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ex5XNSdo2zrq8EpCP1Z0owEAAbhAcTgNtZGbLGNnkjJrCGuGFCCIDr8sel8VU1TlD
	 HzdlVl7Ku+/DkcfTPKa4JtEdeFeO8wWXdTO9zEM0GZCWjE/s2JNHAbb9vAMWZJIo/r
	 NCtuyZqmoT9VmMrHe0rLRjt69R4V0z/BGGbMg2p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391278AbgF2Vej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgF2Sk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5531D2410A;
        Mon, 29 Jun 2020 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443934;
        bh=RcecoPzbN6cMOUCOjvq9fcSh87a1r6/ArrUZGSnc7+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMIgc3QSFG4m4irqVpchU8KHBXkLo+ai/78rdmOLozAQzYa7PVGcgab+hOxltcY9L
         eWAJA2vwl34Vx7PkeYQrx+x414YDnZ2EqcZe6FsIeOl/eXbFlmQ/tbgRbFqrOYIlMW
         s5JrQPnRk+HTIAzFdg4Bv7aGEOHiZ6mujhZWEFNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 036/265] sch_cake: fix a few style nits
Date:   Mon, 29 Jun 2020 11:14:29 -0400
Message-Id: <20200629151818.2493727-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 3f608f0c41360b11b04c763f348b712f651c8bac ]

I spotted a few nits when comparing the in-tree version of sch_cake with
the out-of-tree one: A redundant error variable declaration shadowing an
outer declaration, and an indentation alignment issue. Fix both of these.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 3482f9569dce5..9475fa81ea7f6 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2678,7 +2678,7 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qdisc_watchdog_init(&q->watchdog, sch);
 
 	if (opt) {
-		int err = cake_change(sch, opt, extack);
+		err = cake_change(sch, opt, extack);
 
 		if (err)
 			return err;
@@ -2995,7 +2995,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			PUT_STAT_S32(BLUE_TIMER_US,
 				     ktime_to_us(
 					     ktime_sub(now,
-						     flow->cvars.blue_timer)));
+						       flow->cvars.blue_timer)));
 		}
 		if (flow->cvars.dropping) {
 			PUT_STAT_S32(DROP_NEXT_US,
-- 
2.25.1

