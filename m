Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEEC4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4020409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565445;
	bh=+wqXQMP6BQQqicEzBHUxYGlxNVU+mw9vgsEUq7O3Fzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQ1H90gC6igzworz0tz+Tz3eaTjXvthKI1Nhp6dSUcvPxHAoMgqh8uieIF+EtJ/me
	 yOuzWTog3sZFQ2Xhn4SIMQjBKt7Fbnj1NNrexoIpjW1siriECC6Y7Xv6eeVtjjFQ4H
	 PzbUzIKgmIHLPFzm4iW0GK789FNTVfsEGBrd/Hec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgCRVEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgCRUz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE0520B1F;
        Wed, 18 Mar 2020 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564926;
        bh=+wqXQMP6BQQqicEzBHUxYGlxNVU+mw9vgsEUq7O3Fzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Av4SJGBE7aoTWySTwOeFsV98+hZ2fesyFCuzUDpiYL/tu1jQ0R89mVjc38mxrDP1S
         Qj7uInamp0Q2aesIDn4nCMbFU3xZYKfnNmc32GStrAakgr/DQD3DCjxubfP8O459DN
         156rW8GMCdSf0ahq8rY5gd0TUVoRt1pb4PbF8xI8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/37] team: add missing attribute validation for array index
Date:   Wed, 18 Mar 2020 16:54:46 -0400
Message-Id: <20200318205509.17053-14-sashal@kernel.org>
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

[ Upstream commit 669fcd7795900cd1880237cbbb57a7db66cb9ac8 ]

Add missing attribute validation for TEAM_ATTR_OPTION_ARRAY_INDEX
to the netlink policy.

Fixes: b13033262d24 ("team: introduce array options")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 472641b5afd3e..95524c06e64c2 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2216,6 +2216,7 @@ team_nl_option_policy[TEAM_ATTR_OPTION_MAX + 1] = {
 	[TEAM_ATTR_OPTION_TYPE]			= { .type = NLA_U8 },
 	[TEAM_ATTR_OPTION_DATA]			= { .type = NLA_BINARY },
 	[TEAM_ATTR_OPTION_PORT_IFINDEX]		= { .type = NLA_U32 },
+	[TEAM_ATTR_OPTION_ARRAY_INDEX]		= { .type = NLA_U32 },
 };
 
 static int team_nl_cmd_noop(struct sk_buff *skb, struct genl_info *info)
-- 
2.20.1

