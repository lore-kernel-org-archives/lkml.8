Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF4FC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B1520679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273791;
	bh=HsmyTgW75idF7iuMGXUO1k5TzyWMjEjPkqXtRHcA6M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJ/X7dTTOmlrc4GHYr+7EdlG2+lml/KY1tVE5VOOpepkPTkulgOHHGXdAGUZ1EHWb
	 4w6M4uwHw9h/xDf1j71/5kRCQYOvFlwqWunHMEXDloKy7XJi0pXaUXrzSTIE2D/Pal
	 tzR/GIZ+Wv4PaqYrJqm+a2YGs/XmF8Ogj8wUKNs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgBUIQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732822AbgBUIQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:16:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F0E24670;
        Fri, 21 Feb 2020 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273007;
        bh=HsmyTgW75idF7iuMGXUO1k5TzyWMjEjPkqXtRHcA6M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ebTMRZE0PuYKq0LQODxDeTLrpntNizfh5lRZh1eAEFUgOxVd3l9e02mIq8VFQjkh
         ei38PjaBc1cWc6tKbQs7Tc3mMiE5TcdvIP0HNNur6JzjnKuH1KenXjJh2a1Tvroe9i
         WjaENbyWl7mt8MBA7iV+0esLNRIzCtonkLtzvbRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 005/191] net/sched: matchall: add missing validation of TCA_MATCHALL_FLAGS
Date:   Fri, 21 Feb 2020 08:39:38 +0100
Message-Id: <20200221072251.539666828@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 1afa3cc90f8fb745c777884d79eaa1001d6927a6 ]

unlike other classifiers that can be offloaded (i.e. users can set flags
like 'skip_hw' and 'skip_sw'), 'cls_matchall' doesn't validate the size
of netlink attribute 'TCA_MATCHALL_FLAGS' provided by user: add a proper
entry to mall_policy.

Fixes: b87f7936a932 ("net/sched: Add match-all classifier hw offloading.")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_matchall.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -137,6 +137,7 @@ static void *mall_get(struct tcf_proto *
 static const struct nla_policy mall_policy[TCA_MATCHALL_MAX + 1] = {
 	[TCA_MATCHALL_UNSPEC]		= { .type = NLA_UNSPEC },
 	[TCA_MATCHALL_CLASSID]		= { .type = NLA_U32 },
+	[TCA_MATCHALL_FLAGS]		= { .type = NLA_U32 },
 };
 
 static int mall_set_parms(struct net *net, struct tcf_proto *tp,


