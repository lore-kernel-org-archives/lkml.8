Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E9C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2301920772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759111;
	bh=zRZCiOpv/kmMlJxQeyRwH+7szgYRurWO+1olXjkYMTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkuRTTM+eOD/NWi3dY/Yc5wTyXN7gR0HXOFO6Gitr5vuR45IJG3F+neDMlVjv3Gho
	 TXzlEkB499c+DIXrIcFZit9Rkozufk/dF7eJzugnFm+XjjgNpBr6r2UBLqiCATzMba
	 nCrJ8803timSooAF9lNfJfGxeF9tCmI62rcmBPbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgDAQia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732169AbgDAQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F424212CC;
        Wed,  1 Apr 2020 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759106;
        bh=zRZCiOpv/kmMlJxQeyRwH+7szgYRurWO+1olXjkYMTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF/3PfwFXtyRj3HIjx/p1YLDPRp/bfZREr4hTBdP/teyxweL46cTT9y9EP9OSywM2
         m9qo9VQXBfQPU2Oh4LyLjJwLYiu3OOy6ShCtUsHpuO1HV6Vi/+V9QtgB2QrtaA6BZb
         ufWj82AKbFX03jUKsaG1WrSskPMyQYvtAbVIhPKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+f9b32aaacd60305d9687@syzkaller.appspotmail.com,
        syzbot+2f8c233f131943d6056d@syzkaller.appspotmail.com,
        syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com
Subject: [PATCH 4.9 041/102] net_sched: cls_route: remove the right filter from hashtable
Date:   Wed,  1 Apr 2020 18:17:44 +0200
Message-Id: <20200401161540.504958837@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit ef299cc3fa1a9e1288665a9fdc8bff55629fd359 ]

route4_change() allocates a new filter and copies values from
the old one. After the new filter is inserted into the hash
table, the old filter should be removed and freed, as the final
step of the update.

However, the current code mistakenly removes the new one. This
looks apparently wrong to me, and it causes double "free" and
use-after-free too, as reported by syzbot.

Reported-and-tested-by: syzbot+f9b32aaacd60305d9687@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+2f8c233f131943d6056d@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+9c2df9fd5e9445b74e01@syzkaller.appspotmail.com
Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_route.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -542,8 +542,8 @@ static int route4_change(struct net *net
 			fp = &b->ht[h];
 			for (pfp = rtnl_dereference(*fp); pfp;
 			     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
-				if (pfp == f) {
-					*fp = f->next;
+				if (pfp == fold) {
+					rcu_assign_pointer(*fp, fold->next);
 					break;
 				}
 			}


