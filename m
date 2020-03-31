Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9251DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5705320772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645912;
	bh=IKMRmH74vmWvgonCOt9OVPayC8V5NZ4cwRm+9cNEM0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2gRi0Z83V4Ps3eN2E1zBZClzT9bAgg6zH1uI6yvvhlHV9Okz9P6DvOa9EmYIEqbUQ
	 xntPT4mB7UVNzR3kBpvDFt4ZKwj1B1nvGYr1P0lxWgTG05EiT5zTiZh1EIu+ylMrFM
	 /M3/TZv2stnUlQtVn+psrn2iL5o5FXPW/6IQyrWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgCaJLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731726AbgCaJLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:11:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE2920675;
        Tue, 31 Mar 2020 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645898;
        bh=IKMRmH74vmWvgonCOt9OVPayC8V5NZ4cwRm+9cNEM0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYdMoGA5PwQj06Ga2ls2Pm0X4UgsxNSpce+KH5DmU5TCdcG5XC8WyCPfr3foVGvh6
         7lwnv/Ettl4/ta1/PyEwXHI16bbEqFlfWUWVzK2i0TEWsOlQ5O3h0HIP2ix1M5B22U
         wm7ctazJe3QXo4GC6EuF5PLHtPthZRKec6A51QvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+653090db2562495901dc@syzkaller.appspotmail.com
Subject: [PATCH 5.4 029/155] net_sched: hold rtnl lock in tcindex_partial_destroy_work()
Date:   Tue, 31 Mar 2020 10:57:49 +0200
Message-Id: <20200331085421.661305225@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit b1be2e8cd290f620777bfdb8aa00890cd2fa02b5 ]

syzbot reported a use-after-free in tcindex_dump(). This is due to
the lack of RTNL in the deferred rcu work. We queue this work with
RTNL in tcindex_change(), later, tcindex_dump() is called:

        fh = tp->ops->get(tp, t->tcm_handle);
	...
        err = tp->ops->change(..., &fh, ...);
        tfilter_notify(..., fh, ...);

but there is nothing to serialize the pending
tcindex_partial_destroy_work() with tcindex_dump().

Fix this by simply holding RTNL in tcindex_partial_destroy_work(),
so that it won't be called until RTNL is released after
tc_new_tfilter() is completed.

Reported-and-tested-by: syzbot+653090db2562495901dc@syzkaller.appspotmail.com
Fixes: 3d210534cc93 ("net_sched: fix a race condition in tcindex_destroy()")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -261,8 +261,10 @@ static void tcindex_partial_destroy_work
 					      struct tcindex_data,
 					      rwork);
 
+	rtnl_lock();
 	kfree(p->perfect);
 	kfree(p);
+	rtnl_unlock();
 }
 
 static void tcindex_free_perfect_hash(struct tcindex_data *cp)


