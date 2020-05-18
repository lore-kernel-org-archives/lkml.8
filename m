Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C1F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824260;
	bh=/Ua9XrqbJSoRkQyQ+LB68APHpv44F3/AJIASOFivlPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tpvh1nP9Zpb76ZCMQS3dx+CvgEs3h7k0VY974a4zWPCTGHq52/Ci6h4LF6GRpsI+r
	 gmYwpr4bACqitJKN3uef1aG2RCOKpGdRcTMGIL6gBZYHPaIkzSu3+B1xAPqYX7oJOh
	 TyipqWS1qoBCf/m+bBg0LgoUJtWJb2kDR713aBUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgERRu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730750AbgERRuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9438A20715;
        Mon, 18 May 2020 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824255;
        bh=/Ua9XrqbJSoRkQyQ+LB68APHpv44F3/AJIASOFivlPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnZun8pf8svNKPtm/zW1dSfgfnRHyr3NlHrGDkK4p3Oj9phAW2xkz4sQBpqmhFWJN
         wOE3SUirB7m4uiQbKtsbfXrARld6ToZL1iHmztPhi2kogLDr/z2HPY61rrUyD652GX
         z3wMJo3UacJfcqnx5qxQe6nF/SWnL23HvOWMPS00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Zefan Li <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 19/80] netprio_cgroup: Fix unlimited memory leak of v2 cgroups
Date:   Mon, 18 May 2020 19:36:37 +0200
Message-Id: <20200518173454.260324438@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zefan Li <lizefan@huawei.com>

[ Upstream commit 090e28b229af92dc5b40786ca673999d59e73056 ]

If systemd is configured to use hybrid mode which enables the use of
both cgroup v1 and v2, systemd will create new cgroup on both the default
root (v2) and netprio_cgroup hierarchy (v1) for a new session and attach
task to the two cgroups. If the task does some network thing then the v2
cgroup can never be freed after the session exited.

One of our machines ran into OOM due to this memory leak.

In the scenario described above when sk_alloc() is called
cgroup_sk_alloc() thought it's in v2 mode, so it stores
the cgroup pointer in sk->sk_cgrp_data and increments
the cgroup refcnt, but then sock_update_netprioidx()
thought it's in v1 mode, so it stores netprioidx value
in sk->sk_cgrp_data, so the cgroup refcnt will never be freed.

Currently we do the mode switch when someone writes to the ifpriomap
cgroup control file. The easiest fix is to also do the switch when
a task is attached to a new cgroup.

Fixes: bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Tested-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Zefan Li <lizefan@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/netprio_cgroup.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/netprio_cgroup.c
+++ b/net/core/netprio_cgroup.c
@@ -240,6 +240,8 @@ static void net_prio_attach(struct cgrou
 	struct task_struct *p;
 	struct cgroup_subsys_state *css;
 
+	cgroup_sk_alloc_disable();
+
 	cgroup_taskset_for_each(p, css, tset) {
 		void *v = (void *)(unsigned long)css->cgroup->id;
 


