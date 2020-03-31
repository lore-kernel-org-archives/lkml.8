Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E33C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E462F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645519;
	bh=0H0yxTCH0FS9s8xJIWY4odP8O/qWQfnbC5X7miz54Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1AD1ipDADcxxLWoIVnK1tTHDWoIbpEZr0q85qrfEAJ2LI+n9VmA6LcACkUvAkA78
	 pfdBKnd0gDj4p4YlAulwmtkeW85jld3xx1JWaoAcH8JynoiQQW1JEJCM/vinP2NvAr
	 gqrXcgnLZmP1N7DgFYChMYUA7Zp8y9RoglJVUL2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbgCaJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbgCaJEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:04:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFFD20787;
        Tue, 31 Mar 2020 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645492;
        bh=0H0yxTCH0FS9s8xJIWY4odP8O/qWQfnbC5X7miz54Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mf/DuTMLf/APqh2iwbMuUtqAOIPBJzy37Gr3lRDbSRijeUWwn3ZK1qMTedmf2qQhi
         2EA/ZSS0ZQezJkUSS7fxjZl5pkySlAOaKZ010g4o6nSaNsJHZczKe7AjDLJVyDRLN6
         RZoLZFcbKyFZRq83waDX8a9drhWefL6tMVFFJ6V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+dcc34d54d68ef7d2d53d@syzkaller.appspotmail.com,
        syzbot+c72da7b9ed57cde6fca2@syzkaller.appspotmail.com
Subject: [PATCH 5.5 031/170] net_sched: keep alloc_hash updated after hash allocation
Date:   Tue, 31 Mar 2020 10:57:25 +0200
Message-Id: <20200331085427.367126817@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 0d1c3530e1bd38382edef72591b78e877e0edcd3 ]

In commit 599be01ee567 ("net_sched: fix an OOB access in cls_tcindex")
I moved cp->hash calculation before the first
tcindex_alloc_perfect_hash(), but cp->alloc_hash is left untouched.
This difference could lead to another out of bound access.

cp->alloc_hash should always be the size allocated, we should
update it after this tcindex_alloc_perfect_hash().

Reported-and-tested-by: syzbot+dcc34d54d68ef7d2d53d@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+c72da7b9ed57cde6fca2@syzkaller.appspotmail.com
Fixes: 599be01ee567 ("net_sched: fix an OOB access in cls_tcindex")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_tcindex.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_tcindex.c
+++ b/net/sched/cls_tcindex.c
@@ -359,6 +359,7 @@ tcindex_set_parms(struct net *net, struc
 
 		if (tcindex_alloc_perfect_hash(net, cp) < 0)
 			goto errout;
+		cp->alloc_hash = cp->hash;
 		for (i = 0; i < min(cp->hash, p->hash); i++)
 			cp->perfect[i].res = p->perfect[i].res;
 		balloc = 1;


