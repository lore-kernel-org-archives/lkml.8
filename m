Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8398DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C7C20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:35:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbgHMMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:35:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E40E6F766FDC4B80B350;
        Thu, 13 Aug 2020 20:35:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 20:35:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <xiyou.wangcong@gmail.com>
Subject: [PATCH stable-4.19] cgroup: add missing skcd->no_refcnt check in cgroup_sk_clone()
Date:   Thu, 13 Aug 2020 20:33:42 +0000
Message-ID: <20200813203342.1120351-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add skcd->no_refcnt check which is missed when backporting
ad0f75e5f57c ("cgroup: fix cgroup_sk_alloc() for sk_clone_lock()").

This patch is needed in stable-4.9, stable-4.14 and stable-4.19.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/cgroup/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae98c714edd..2a879d34bbe5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5957,6 +5957,8 @@ void cgroup_sk_clone(struct sock_cgroup_data *skcd)
 {
 	/* Socket clone path */
 	if (skcd->val) {
+		if (skcd->no_refcnt)
+			return;
 		/*
 		 * We might be cloning a socket which is left in an empty
 		 * cgroup and the cgroup might have already been rmdir'd.
-- 
2.25.1

