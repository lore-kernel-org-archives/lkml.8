Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2C3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12D205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442950;
	bh=OYEWaCPqZTDX9qCgwnlLOmEk8osMuwE31g8YAdQZNzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVwko4bOrYx3Ucy+EURalwV9ga4bnFoOhb/G8qkVA5fBHz0WxgT5k7XwTaHmKbea9
	 IS1cw0Kx5O7cddbvmh+c3K0Db1FxesIqJB5IdsYFYObIzfJwuC0blb96QS1EzZDfWc
	 iYNfq9IAl/O60ExWrQfzpAK2sYVPqFbXdiMll38Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgCQLC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgCQLCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:02:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EAE20658;
        Tue, 17 Mar 2020 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442945;
        bh=OYEWaCPqZTDX9qCgwnlLOmEk8osMuwE31g8YAdQZNzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lh3wsku4p94/ATgBv6fwdIYWztGBVOcOuK4Pfz904xqI/8Nq0XsSBNPj59JzZqcGj
         VZKb0k+yALx+YXBsx1rqi6BvxlaWbjWadiCAi9AYXEwRMLD5xQC6vJaAXE4laUqtsT
         Zr8UzCHXK4FnVp086A3eyVMnBSbp2Ixclqz3/eR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 044/123] net: taprio: add missing attribute validation for txtime delay
Date:   Tue, 17 Mar 2020 11:54:31 +0100
Message-Id: <20200317103312.321516007@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e13aaa0643da10006ec35715954e7f92a62899a5 ]

Add missing attribute validation for TCA_TAPRIO_ATTR_TXTIME_DELAY
to the netlink policy.

Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -774,6 +774,7 @@ static const struct nla_policy taprio_po
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
+	[TCA_TAPRIO_ATTR_TXTIME_DELAY]		     = { .type = NLA_U32 },
 };
 
 static int fill_sched_entry(struct nlattr **tb, struct sched_entry *entry,


