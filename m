Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4DD207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199843;
	bh=hVLeEUaOeMMSd2tkkAvEA9VjNWHrwdwc57q7m5N+ncE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XlZU9ieLZClLJTsQib+vQMlH0ETBZRSHtuSgWXY0p54nhe115+NLvNo/0B9Oe5k1K
	 kEu7Wzp7BtC/XvhxZB9CnN0VMX+CNsLOAQvYxbSHCC8BSCSBfq19ZRnUZBbStEmVQZ
	 60knZJ6/bKY07fPzBrTaDRS3U3j5nOfrW1PAfLnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbgAPRMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgAPRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B30A246AB;
        Thu, 16 Jan 2020 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194769;
        bh=hVLeEUaOeMMSd2tkkAvEA9VjNWHrwdwc57q7m5N+ncE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkVO47LnPojkPZzkoB5s+FH83RHkcqm6EElDRbtJlO63lq8s5Nal07DmrLnKUpMsf
         cRzJ9WlNAySIJpCzIC9RxKvWwWaIfnYdB+6QOffz7rtkWudVgCK+lH9v2WtY61mc54
         snEZnX+R+eBXW7Dd4IXDrP0uU9NWff9axV9doSMg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 588/671] act_mirred: Fix mirred_init_module error handling
Date:   Thu, 16 Jan 2020 12:03:46 -0500
Message-Id: <20200116170509.12787-325-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 11c9a7d38af524217efb7a176ad322b97ac2f163 ]

If tcf_register_action failed, mirred_device_notifier
should be unregistered.

Fixes: 3b87956ea645 ("net sched: fix race in mirred device removal")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_mirred.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 399e3beae6cf..a30c17a28281 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -445,7 +445,11 @@ static int __init mirred_init_module(void)
 		return err;
 
 	pr_info("Mirror/redirect action on\n");
-	return tcf_register_action(&act_mirred_ops, &mirred_net_ops);
+	err = tcf_register_action(&act_mirred_ops, &mirred_net_ops);
+	if (err)
+		unregister_netdevice_notifier(&mirred_device_notifier);
+
+	return err;
 }
 
 static void __exit mirred_cleanup_module(void)
-- 
2.20.1

