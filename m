Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C6C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65120842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738865;
	bh=fJaa5o09fCgQTBNPT8YkXmQOZiywcmZuGpBya/G1H18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fDPF55all67ixuhNKEMFgEdWlkowWF26swVEpmu+SGmaPkvKIEX8XucpkPL2EhMK/
	 ogOyZbbDwvRDMj6d+cqXjq+jhI7yKdHJc847zC2jf601E+8yEJMh7Mel+oZymAyJsw
	 tkrsZ/a5Rtknq/zUbhFx2mKFeCMlefsnR/mzyHXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgAKKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbgAKKeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:34:22 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0987420842;
        Sat, 11 Jan 2020 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738861;
        bh=fJaa5o09fCgQTBNPT8YkXmQOZiywcmZuGpBya/G1H18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcWRiKi5M7CjghkIfhWlKo/WgMtsMEXEiixfhWv8ZWevK3zkqX/yt/7Bf/1Gv2kfL
         zPf1M6uYuLnDYiIEUchjQpYvQtUtbM+0u1SSLc46n5bGBdnAnXbjqx2dIgZ7eXl60F
         i1YmLxCqCFdmA/JabLPZOZ7RduHiXqwsTcznx7M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 161/165] net/mlx5: DR, Init lists that are used in rules member
Date:   Sat, 11 Jan 2020 10:51:20 +0100
Message-Id: <20200111094942.991002165@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erez Shitrit <erezsh@mellanox.com>

[ Upstream commit df55c5586e5185f890192a6802dc5b46fddd3606 ]

Whenever adding new member of rule object we attach it to 2 lists,
These 2 lists should be initialized first.

Fixes: 41d07074154c ("net/mlx5: DR, Expose steering rule functionality")
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -638,6 +638,9 @@ static int dr_rule_add_member(struct mlx
 	if (!rule_mem)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&rule_mem->list);
+	INIT_LIST_HEAD(&rule_mem->use_ste_list);
+
 	rule_mem->ste = ste;
 	list_add_tail(&rule_mem->list, &nic_rule->rule_members_list);
 


