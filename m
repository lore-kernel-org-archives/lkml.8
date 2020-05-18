Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4770C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DA620671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823948;
	bh=mAPBp6yla25QDnZJasFgLtLiQLtE+XJaFTUczGYNvLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvzieNSxSG20do4TUU6xNK5BY9lybS/tLCBvWEWlDeLWQmwjWubGvc6KwPcby1sSR
	 b2jEV0xknvEvN6RgfS8KsCQwqnp+MWgJJ4zlDvYAPPiDKmTjgK5V4tk4vjOQOvtNL7
	 dGq246kVR28qv2geSdDd0Dq4LxEgHhSmAYM3CCZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgERRpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbgERRpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF4E20657;
        Mon, 18 May 2020 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823939;
        bh=mAPBp6yla25QDnZJasFgLtLiQLtE+XJaFTUczGYNvLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9OWNe60YtNilLs6c1DND8aMShHOP/t3TeklCSQ9SgYkb81snbYXHofbjLMyRogwg
         zESkDRQ1pykCD72B7+AVnZtiyfLL398nuRyrNFHREFCcapqQoazfhfbSVfBeKEcBce
         ZCvWtA2VrMGssO3mvLpCvbpJLg3sFfxCjj0qfy8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Zefan Li <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.9 72/90] netprio_cgroup: Fix unlimited memory leak of v2 cgroups
Date:   Mon, 18 May 2020 19:36:50 +0200
Message-Id: <20200518173505.923430661@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
@@ -237,6 +237,8 @@ static void net_prio_attach(struct cgrou
 	struct task_struct *p;
 	struct cgroup_subsys_state *css;
 
+	cgroup_sk_alloc_disable();
+
 	cgroup_taskset_for_each(p, css, tset) {
 		void *v = (void *)(unsigned long)css->cgroup->id;
 


