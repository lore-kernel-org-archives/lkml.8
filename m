Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB446C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E18321556
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623695;
	bh=RE5W+tFIdCQqPmd5iZo/ToXXrWmRp8UwN2v1IsJrIhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHVb4sPmO5GNL4t3LCknjKn+Wk2H2ZrMcNdH54wGEKXMMaV0Nx67RkXb6cYvIcdwL
	 UcEsb/ZVQKbXwltQTErN4gKjdV2k3tAY1oIq2Jhc5JuKxGGWNJDnJuy9PGqrAIQskP
	 ZcjVjnOMToVVkt8V4IG43AsTu0MM29j3bd1OzQj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgCSNOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbgCSNOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:14:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59B5206D7;
        Thu, 19 Mar 2020 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623691;
        bh=RE5W+tFIdCQqPmd5iZo/ToXXrWmRp8UwN2v1IsJrIhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdDqnJIvYALxfPc58e8XD5zUSlmzKUs+lChzP9KHWNrWH+uEqgxt5Aj/8kyz8DlUN
         qcla8XVLeT1OC1DfwEpSvw+0MO9A1ICtGzrVNBbOr6t9wX4vFncxaaCmbUmPwU177m
         gmUM8XLc07ygsTfCzitvF8n9uhJWonN2DWwpFloo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 21/99] can: add missing attribute validation for termination
Date:   Thu, 19 Mar 2020 14:02:59 +0100
Message-Id: <20200319123948.143871159@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/dev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -867,6 +867,7 @@ static const struct nla_policy can_polic
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],


