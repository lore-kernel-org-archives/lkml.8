Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13262C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1294208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565091;
	bh=vbsnVur4lvljTik9l516vSEogUmTcpdKtY8HlintBzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0zdDUeuPpkUnAsgwB4agfJqi37fBmKO3YDmKGZmFt/DFFOgrNrtT+a00IB65+vOo
	 tnPZVTxP2aGh9iGEqzsy1nmj1ARv2s3OXl42287KFkDSVYFYU/ZaHBaR6ZjeLY6ubD
	 ppc1hjsIftpTvnSygzEtwr8QPVlZek02ho/uJOOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgCRU5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgCRU4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93D621473;
        Wed, 18 Mar 2020 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565012;
        bh=vbsnVur4lvljTik9l516vSEogUmTcpdKtY8HlintBzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmAtZz0Y+78BybnuniLfvUfC/h3lHcWRhyfmInuH8Xv4wv0IhPyTgyEtwf6bxJ6f0
         lL4DDHvF5z/Lcv6KIU656thfr3oUlzROdoCdEPtjuD0bxruf6Nu/BOB4IUCRHUgCqV
         RN5/gBnVCQXUaX+QIUXtI4EjiS5Q2u5Z4itBA2CQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/12] fib: add missing attribute validation for tun_id
Date:   Wed, 18 Mar 2020 16:56:39 -0400
Message-Id: <20200318205648.17937-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205648.17937-1-sashal@kernel.org>
References: <20200318205648.17937-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 4c16d64ea04056f1b1b324ab6916019f6a064114 ]

Add missing netlink policy entry for FRA_TUN_ID.

Fixes: e7030878fc84 ("fib: Add fib rule match on tunnel id")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/fib_rules.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 59160de702b68..99ae8ac65ecad 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -85,6 +85,7 @@ struct fib_rules_ops {
 	[FRA_OIFNAME]	= { .type = NLA_STRING, .len = IFNAMSIZ - 1 }, \
 	[FRA_PRIORITY]	= { .type = NLA_U32 }, \
 	[FRA_FWMARK]	= { .type = NLA_U32 }, \
+	[FRA_TUN_ID]	= { .type = NLA_U64 }, \
 	[FRA_FWMASK]	= { .type = NLA_U32 }, \
 	[FRA_TABLE]     = { .type = NLA_U32 }, \
 	[FRA_SUPPRESS_PREFIXLEN] = { .type = NLA_U32 }, \
-- 
2.20.1

