Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83499C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C527214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865069;
	bh=uKfMRB8NddX5TTMWrBMiI8uFkS0llxEn0+7f7d0cg5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f5OldcHCmd/1wq9dTjQ7haRa/WFdJwrOP/mCZ0bApNU869IRg1NXVK+j+D7/LeepW
	 kSbochwO+D0Q8vT+ojkGT7Gv+ey6rHjPyAkuRmWQfWMRlgPEKL+wwvGj/zqMZJnkK7
	 eQ1IzTUBBKRdZs32i0w/Nolt9dhY5axxkE8jTzMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbgAXLY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgAXLYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:24:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99F720704;
        Fri, 24 Jan 2020 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865065;
        bh=uKfMRB8NddX5TTMWrBMiI8uFkS0llxEn0+7f7d0cg5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2CrGJMWqqCQ6ityow3zGxKIca+Yc5fGKdgkivLXwyutLBtzj+XGTGdjUJvTrBOE9h
         I+zZLzuPAZYRImkdvLT7WFKd3BeQ1AYxloKgsns7JQcknVojxMM2EHdOylx3uJhg6/
         Zp0dXzE4fSgjTYVcniGp7o0M4cXS54UzHMub2TG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 443/639] net/sched: cbs: Fix error path of cbs_module_init
Date:   Fri, 24 Jan 2020 10:30:13 +0100
Message-Id: <20200124093142.539507834@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 45d5cb137c3638b3a310f41b31d8e79daf647f14 ]

If register_qdisc fails, we should unregister
netdevice notifier.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 81f84cb5dd23b..b3c8d04929df2 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -552,12 +552,17 @@ static struct notifier_block cbs_device_notifier = {
 
 static int __init cbs_module_init(void)
 {
-	int err = register_netdevice_notifier(&cbs_device_notifier);
+	int err;
 
+	err = register_netdevice_notifier(&cbs_device_notifier);
 	if (err)
 		return err;
 
-	return register_qdisc(&cbs_qdisc_ops);
+	err = register_qdisc(&cbs_qdisc_ops);
+	if (err)
+		unregister_netdevice_notifier(&cbs_device_notifier);
+
+	return err;
 }
 
 static void __exit cbs_module_exit(void)
-- 
2.20.1



