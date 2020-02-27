Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973BC3F353
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7701A20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811416;
	bh=hePArWvNd0YntJvOJGHNGpd2fPqBYIzBU74YRz3DtHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMbrLqfYaLiEGCG4XQKI5OcAGprLG5sdt9JZ5Akj/FqjEX5+gw3XczRg4FGsvrbXA
	 82kkIt5lNSZzvzXtJN3JVXrMKSSTlJ58/pdCX6Mm0cu7AHPveKLxEWSRH1ZAi7V+cs
	 DRZYjyrq58/U7kg83uUYUiCCmPUxepLJ6UP/02tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgB0NuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbgB0NuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDE320578;
        Thu, 27 Feb 2020 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811401;
        bh=hePArWvNd0YntJvOJGHNGpd2fPqBYIzBU74YRz3DtHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaYH78eppYZNvWm8j0oU3FPw6NYg3YhKUJK4J9bL3IlioVnSn3X1GAPy5NsFIm/Po
         rA6C+5SK71Ly/ddn/LmztHWQbwbf0fiAqesi/38QDmj96p1kboaxqgoQleSaEjB7Zo
         tsK5s+xFKYVH01znxTj8t7M7jg3CxU/8slYn35tA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 117/165] net/sched: matchall: add missing validation of TCA_MATCHALL_FLAGS
Date:   Thu, 27 Feb 2020 14:36:31 +0100
Message-Id: <20200227132248.184302027@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
@@ -111,6 +111,7 @@ static unsigned long mall_get(struct tcf
 static const struct nla_policy mall_policy[TCA_MATCHALL_MAX + 1] = {
 	[TCA_MATCHALL_UNSPEC]		= { .type = NLA_UNSPEC },
 	[TCA_MATCHALL_CLASSID]		= { .type = NLA_U32 },
+	[TCA_MATCHALL_FLAGS]		= { .type = NLA_U32 },
 };
 
 static int mall_set_parms(struct net *net, struct tcf_proto *tp,


