Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E33C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28F120775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565457;
	bh=UwniKDGeUU73Sf0JXCV7za0k/OEPDIGoi5TlxQxh8Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nD5lj8jFRxO9LwpvQon8gCA+41lGbbh/TRmgsNnDJs+RsWzQVv+Rax+fOeaA8Cki+
	 u21vT60gYhRfutGJOWU3idiDOFJhBqx7ezB6L83MvS0D2gnqYDKi2Be/jjVElkhEj8
	 P0WmwJSRRucqeS0JFOEld46wwmDLTpamAHilF2AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCRVEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgCRUzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D78C208FE;
        Wed, 18 Mar 2020 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564922;
        bh=UwniKDGeUU73Sf0JXCV7za0k/OEPDIGoi5TlxQxh8Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbOW0yLgdBlXXXJ97RH117/jY3SuExU/qqQp4rwoUHfKFnn1uXBAhusywQMbbll12
         Y9nsToPeRLUB5TYQZ9rhWYEbEVTlzUSkKfs1tD2rYo0DrBD5y2BR7ipJH7kcVQuyRl
         Gdh4qZnlDFohxIczVgQCD5OqDTwYuCViKhBOnhMU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/37] fib: add missing attribute validation for tun_id
Date:   Wed, 18 Mar 2020 16:54:42 -0400
Message-Id: <20200318205509.17053-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205509.17053-1-sashal@kernel.org>
References: <20200318205509.17053-1-sashal@kernel.org>
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
index b473df5b95121..10886c19cfc58 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -107,6 +107,7 @@ struct fib_rule_notifier_info {
 	[FRA_OIFNAME]	= { .type = NLA_STRING, .len = IFNAMSIZ - 1 }, \
 	[FRA_PRIORITY]	= { .type = NLA_U32 }, \
 	[FRA_FWMARK]	= { .type = NLA_U32 }, \
+	[FRA_TUN_ID]	= { .type = NLA_U64 }, \
 	[FRA_FWMASK]	= { .type = NLA_U32 }, \
 	[FRA_TABLE]     = { .type = NLA_U32 }, \
 	[FRA_SUPPRESS_PREFIXLEN] = { .type = NLA_U32 }, \
-- 
2.20.1

