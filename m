Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354EC4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825DE20BED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564841;
	bh=AZz3kGExe54qMNtjzlX8yDezAXV9aXMaQ3MSx4rB2T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+ID396G0nnTZHFCie5J895GCLFUAtGf3NIRBG91sAJZMxS0FCXUPWj52HiKmBG8z
	 FKxv2d0R0G/VfbRt70TJO6JdWUCeRCkkG144HrIj9CXSImUqfuwazYLI7yNSfedHmA
	 DEE32cEivzyOyqcymXhcsUnm1mBp1bD4zOTRS1r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCRUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgCRUx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E892098B;
        Wed, 18 Mar 2020 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564836;
        bh=AZz3kGExe54qMNtjzlX8yDezAXV9aXMaQ3MSx4rB2T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zd3NB8dm3Rxw+4feXTaVxVJVW+LHWQU5QXdok+BXNMBScaedWy56za7rL4kFRxBWD
         Q9/XI7AjTtxfhqnGGxuQZPliggWYLolRMj9irG9S48BfRRAux+6ld2ZZj9vpukIpSw
         UVa0JPin/W+LMHkyrcqe9Z/BRrCurFN9IqIHjDvo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/73] can: add missing attribute validation for termination
Date:   Wed, 18 Mar 2020 16:52:40 -0400
Message-Id: <20200318205337.16279-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ab02ad660586b94f5d08912a3952b939cf4c4430 ]

Add missing attribute validation for IFLA_CAN_TERMINATION
to the netlink policy.

Fixes: 12a6075cabc0 ("can: dev: add CAN interface termination API")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 1c88c361938cc..3a33fb5034005 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -884,6 +884,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.20.1

