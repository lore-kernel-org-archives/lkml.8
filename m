Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D5C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF3620A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565005;
	bh=h8qI3TUvyEaVDgUUv50i3tEfzr3ss5KSUl9j5hb/Ews=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUxDIfAdWUOYGB6Zr6l7VtfB/+/i0aLOwJzC/HSgAV6LxHd8kClGig65Up7ytzuU4
	 UxwvNU8PlLi71XbeECAQIf9yR5QWod5pfSi48HP78JZCqc1TADLH+1GmqG9DIldETB
	 hekKM/14XBA8AfDE7iaRUKvtAKzWQp6Vw4cJfuRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgCRU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgCRU4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E351D21973;
        Wed, 18 Mar 2020 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564967;
        bh=h8qI3TUvyEaVDgUUv50i3tEfzr3ss5KSUl9j5hb/Ews=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGj4ebar36wMKYMZZECgozq9JcGV8WT6QQTEv0bFpg/xdNwdf2nm6Y6J6/Qfyysc2
         MFgWaopE4PpZFKQGYvweIlBN4+9L86w00da+8Jszi53eYUzheL17iT62v3hv00FKez
         kS4xOGWj9hyfB5bNC8MGq0Fy3qkilSeO1agw4XiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/28] macsec: add missing attribute validation for port
Date:   Wed, 18 Mar 2020 16:55:37 -0400
Message-Id: <20200318205555.17447-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205555.17447-1-sashal@kernel.org>
References: <20200318205555.17447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 31d9a1c524964bac77b7f9d0a1ac140dc6b57461 ]

Add missing attribute validation for IFLA_MACSEC_PORT
to the netlink policy.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9bb65e0af7dd7..d6c92263bebef 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2974,6 +2974,7 @@ static const struct device_type macsec_type = {
 
 static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_SCI] = { .type = NLA_U64 },
+	[IFLA_MACSEC_PORT] = { .type = NLA_U16 },
 	[IFLA_MACSEC_ICV_LEN] = { .type = NLA_U8 },
 	[IFLA_MACSEC_CIPHER_SUITE] = { .type = NLA_U64 },
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
-- 
2.20.1

