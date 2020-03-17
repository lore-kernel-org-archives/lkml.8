Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CEC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C44C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442669;
	bh=slp8IlgZx8qngddPVVEAVbFUZ8WlJCrVYZu9ViaRb0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YdG4zacRpHuJDoOA+7iDTGHZo2FosfgNxbND5byEI9qdAuyiRNqzgWim16uu6MNah
	 Zg9vfeK+p818Kupeyk4/Iwe5/txi4x+liQcleSZlCRQylSV1urTXqyIkRvHrqDipJY
	 oHnfiDAojWtOUMkGORpoxoig+fqRuSF3kgkpuHhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgCQK5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgCQK5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB272071C;
        Tue, 17 Mar 2020 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442662;
        bh=slp8IlgZx8qngddPVVEAVbFUZ8WlJCrVYZu9ViaRb0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghhZGI1GtXS95DcnlVfUeLp8e+rlzfSvsTWkF6eIOU2uTs0m4FHWbny9ZWufGCyQ5
         nab2rmhqQYtCX9ygHYBp2ILlkvSwWQZVj9hrX/lJC4JsY3afX0S+sA0L9zuSXuId4I
         HmVB5lTt8eN37M42AKJSIfIcV4GuFsdGaX/iBOvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 40/89] tipc: add missing attribute validation for MTU property
Date:   Tue, 17 Mar 2020 11:54:49 +0100
Message-Id: <20200317103304.622382091@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 213320a67962ff6e7b83b704d55cbebc341426db ]

Add missing attribute validation for TIPC_NLA_PROP_MTU
to the netlink policy.

Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -110,7 +110,8 @@ const struct nla_policy tipc_nl_prop_pol
 	[TIPC_NLA_PROP_UNSPEC]		= { .type = NLA_UNSPEC },
 	[TIPC_NLA_PROP_PRIO]		= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_TOL]		= { .type = NLA_U32 },
-	[TIPC_NLA_PROP_WIN]		= { .type = NLA_U32 }
+	[TIPC_NLA_PROP_WIN]		= { .type = NLA_U32 },
+	[TIPC_NLA_PROP_MTU]		= { .type = NLA_U32 }
 };
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {


