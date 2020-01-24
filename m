Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71032208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860366;
	bh=rJ/lL4m4w1KTopWo0W1Sk5HqlrNqS6c9byRrO5s+47c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foLJoEAw+PTxJcRx+Krqgfj5XUO5qSKZvVaG0N4GxNmLzDqiPJSYEQrEbT1LrlD3g
	 gqGQAHIvG8SqlC1zXA9iSrKR0E71xPOpBSWeRfU9u13TLu2L3Hl6qNoJQc2AriJ2Zr
	 yrAFZR+VYmlQHBpKz/hLiX/2va3q4pBVKgtRiWr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbgAXKGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389265AbgAXKGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:06:02 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E4120704;
        Fri, 24 Jan 2020 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860361;
        bh=rJ/lL4m4w1KTopWo0W1Sk5HqlrNqS6c9byRrO5s+47c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ck4cGcqa9RrTbzxtAxdWXO4Hyj70VJdVqd2QZGbeOWifK5LT8f65/dv0PgACQdyvP
         sAX1pvWk6TiXM6nSjwKb92BCO8jnsaNh4pMHxAYmMsdZmpZZm5UJ+va2s008/GsGF7
         eNQvaLynS1mFDHY4C/aR6dvrlIsPfgL8cY/hzA9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 321/343] act_mirred: Fix mirred_init_module error handling
Date:   Fri, 24 Jan 2020 10:32:19 +0100
Message-Id: <20200124093002.034552677@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 529bb064c4a4d..dcfaa4f9c7c5b 100644
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



