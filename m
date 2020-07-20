Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89625C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620E52065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260262;
	bh=ceTf5gxEPRZU/gAx/HqJljflWWB7/H/qeH0pUT/l/Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qv6qVRdVkohV8z0HQTy4akB38SiJRS6v2aUUHPLtZdfvQ4d4jUlELxrIYKx2YvxQf
	 D4GF3Usmub4EGjzchN+xfA0/poeSUt0xjZg81wKpsIxOa7Sa+KQ/yjghNNXPVWzCHU
	 jq2jq+QjT15nyoWGE9jE0+5rit9Y7NWVeOy+9lqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgGTPvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbgGTPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:50:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA182065E;
        Mon, 20 Jul 2020 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260255;
        bh=ceTf5gxEPRZU/gAx/HqJljflWWB7/H/qeH0pUT/l/Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS0wbLawKDcBGGJ0ogxNypKENnCZurSunJX90n9kaFwTc//TjvG9k7laPSt9E93Yp
         cVW7tLMSsLLrW56uHZ/RR3HyJ6Mw/CrAfxOv8RzFXvhUus5LRPHqp1lEchHhpIpqOT
         Ag9U+ghs0ZdBKH+7uDrv+dBTKu4934ngUukrLYPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+d411cff6ab29cc2c311b@syzkaller.appspotmail.com
Subject: [PATCH 4.19 008/133] net_sched: fix a memory leak in atm_tc_init()
Date:   Mon, 20 Jul 2020 17:35:55 +0200
Message-Id: <20200720152804.134203694@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 306381aec7c2b5a658eebca008c8a1b666536cba ]

When tcf_block_get() fails inside atm_tc_init(),
atm_tc_put() is called to release the qdisc p->link.q.
But the flow->ref prevents it to do so, as the flow->ref
is still zero.

Fix this by moving the p->link.ref initialization before
tcf_block_get().

Fixes: 6529eaba33f0 ("net: sched: introduce tcf block infractructure")
Reported-and-tested-by: syzbot+d411cff6ab29cc2c311b@syzkaller.appspotmail.com
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_atm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -551,16 +551,16 @@ static int atm_tc_init(struct Qdisc *sch
 	if (!p->link.q)
 		p->link.q = &noop_qdisc;
 	pr_debug("atm_tc_init: link (%p) qdisc %p\n", &p->link, p->link.q);
+	p->link.vcc = NULL;
+	p->link.sock = NULL;
+	p->link.common.classid = sch->handle;
+	p->link.ref = 1;
 
 	err = tcf_block_get(&p->link.block, &p->link.filter_list, sch,
 			    extack);
 	if (err)
 		return err;
 
-	p->link.vcc = NULL;
-	p->link.sock = NULL;
-	p->link.common.classid = sch->handle;
-	p->link.ref = 1;
 	tasklet_init(&p->task, sch_atm_dequeue, (unsigned long)sch);
 	return 0;
 }


