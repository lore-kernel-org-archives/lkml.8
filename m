Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1642471F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195807;
	bh=v3livdS8vM+rdbLAzBYFHtfZ/IqjRpEO2jwm4V2eyJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QT/7YwBoj11CPqabwbfW7W+vyIsZigo2D5VG0PVpTv446qRlv2WcIoFYybwygM7zj
	 Hh8u6XGzJapRp2pJ366vvwM1kRRFdOZnDULysBO6fGVOOut8B0pIt7gcsgOTCLwlUI
	 MnB0cD3x3N4Pj8h2bSruwc6qNG9euxQDlg9TDpM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392963AbgAPRaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392903AbgAPRaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC9724718;
        Thu, 16 Jan 2020 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195802;
        bh=v3livdS8vM+rdbLAzBYFHtfZ/IqjRpEO2jwm4V2eyJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQUhy9HxB5HkhqjgWKOVNDiGZWgGtnDH0/86nuxlR67HeAi8LK+nfsE7uKKRfju4J
         pCVv9O0fPKDojhJpcMwk5jrz2Q8wBCOa8qwN42SerC49NxZ4vsbevjOcryT8nOc8ef
         MP/0QdhyIizO4qVD7B3TaILVMQf12C0cyLYEVZXs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 317/371] act_mirred: Fix mirred_init_module error handling
Date:   Thu, 16 Jan 2020 12:23:09 -0500
Message-Id: <20200116172403.18149-260-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
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
index 529bb064c4a4..dcfaa4f9c7c5 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -371,7 +371,11 @@ static int __init mirred_init_module(void)
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

