Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41162C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171A42084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607606;
	bh=datS3IKUZA9bgjNevrozUDfBcVDSvmpXzGjOJIW+x4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgeybPxNKwTwgSpzVUoWSm8xDw/1kQ5rNtG+jC7Ic/G5Gt784snu/Q8FNqAnKDfgI
	 tY1wQ6dMcQJveFAe3P4I4EG+r3E61IJyYTPLP5CpmDwE91CpDumSBRTirp8Bqh3ZZG
	 uvBGg3X6080vxmBCUl642TuiU/eKh9wuhKq5cVdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgDKMUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgDKMUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:20:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F225A20644;
        Sat, 11 Apr 2020 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607602;
        bh=datS3IKUZA9bgjNevrozUDfBcVDSvmpXzGjOJIW+x4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSWC9BHqoRkIBj9FcVcPoe6IiNiaqEDB1Bk461gVvQ0i5mfubAGphwQVe3bIGSoK2
         rtJaOcQY7MKPFRx0aGMzpdviuCp2HuNUDwHcVUlFX+SRum8LseRRKroSYEMmQr7Sb3
         z7lktQ+hhr8zHpWrds1Z0mwJOv9s3VlAePSOp8Og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8325e509a1bf83ec741d@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 08/44] net_sched: fix a missing refcnt in tcindex_init()
Date:   Sat, 11 Apr 2020 14:09:28 +0200
Message-Id: <20200411115457.578493370@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit a8eab6d35e22f4f21471f16147be79529cd6aaf7 ]

The initial refcnt of struct tcindex_data should be 1,
it is clear that I forgot to set it to 1 in tcindex_init().
This leads to a dec-after-zero warning.

Reported-by: syzbot+8325e509a1bf83ec741d@syzkaller.appspotmail.com
Fixes: 304e024216a8 ("net_sched: add a temporary refcnt for struct tcindex_data")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -151,6 +151,7 @@ static int tcindex_init(struct tcf_proto
 	p->mask = 0xffff;
 	p->hash = DEFAULT_HASH_SIZE;
 	p->fall_through = 1;
+	refcount_set(&p->refcnt, 1); /* Paired with tcindex_destroy_work() */
 
 	rcu_assign_pointer(tp->root, p);
 	return 0;


