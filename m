Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD0C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565202;
	bh=vM5NMFqNJZ1Kv3zv1Kv+95r4zD2nUkGuANljRNoa/lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3c5p1MZgkkQLEBIgNln0keQ7Mmp9OqD7htCC8Yl/610cuMKgYutNYZqmpxr66vgH
	 5HjUqzozY/VO+xJfCWvN/YNitTFRt/+Gq/TCUw/UTzBxyVhujN+JX6YibpCS09tjet
	 D1Dl/kAMnVt2jI2QiRW/uI1DH+uu+jyyp/WSGJmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgCRU4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgCRU4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCFD208E4;
        Wed, 18 Mar 2020 20:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564966;
        bh=vM5NMFqNJZ1Kv3zv1Kv+95r4zD2nUkGuANljRNoa/lA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUPgenYaa1m6/+vPXoTZVUikDobWgh3PZ7X6ElWpDJf0qeSVg28x/qYNwCgw6KVxB
         vf2AuSV247FWjtjKQcQBCOa8RNaxpgEZtpuW4suK1LIM9ZK2hc4teRImLckaB1JeDY
         kPi/XRgoyvOVbxl4YQtHcjjFlRJxES7wFjGxi4Rk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/28] can: add missing attribute validation for termination
Date:   Wed, 18 Mar 2020 16:55:36 -0400
Message-Id: <20200318205555.17447-9-sashal@kernel.org>
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
index d92113db4fb97..05ad5ed145a3a 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -867,6 +867,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.20.1

