Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E635C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33D02063A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607863;
	bh=datS3IKUZA9bgjNevrozUDfBcVDSvmpXzGjOJIW+x4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=McqXq4E4NoN9C5cS0WK+U2/3sdVcUiVoPpJkBx26N4MHLe5IcnC6/hjSRD1Mq/mJs
	 j8rGD+Fl7PPrgUoRr47hzKqUnh/qCcnw8pcY9/iAn866dmIP99g4ldVnveS5YcaDGk
	 OEHycgqU5qRXWGeqgsWghkK4KUzngXlb14782beU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgDKMSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgDKMSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:18:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA5A2137B;
        Sat, 11 Apr 2020 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607484;
        bh=datS3IKUZA9bgjNevrozUDfBcVDSvmpXzGjOJIW+x4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNPS8B0HUamMMqgoISSiFNRdxIM0LH6ZnnxP7ncVLanEYdHgqvG9xKDYN1ag2fkWC
         cgRvTgd6DskcVCQw5KUwxaz1LXfdFk3jOJ8fHplh04exEwsK9OWWyyCyXU4PrAcFpN
         k4vlRpQRRa6RxpswhUJQgD1lgT954W31aFZ7GE+8=
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
Subject: [PATCH 5.4 09/41] net_sched: fix a missing refcnt in tcindex_init()
Date:   Sat, 11 Apr 2020 14:09:18 +0200
Message-Id: <20200411115504.768210213@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
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


