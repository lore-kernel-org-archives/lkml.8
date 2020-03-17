Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25834C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22D320658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443354;
	bh=9HK5uQds0fKQgS11ZT/CoSN65Hm3Jm7/jecpwJYLWfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4TMPBOcBs0vT1+NMkCxnP4htiAUUvXQNXUMCUQl/yqOzhPdRGdTH+CCMB7Rdj0fI
	 oL0kXBiAqPKqMBED0WqUie6U0H3BJko0iHxr7vUfZRz17RhM+3RU2uxgMwfjOJV3HI
	 FE2g0yu5zBwZp45jRI7iSGjUDV0rOCY9qp2adqXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgCQLJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgCQLJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 173A6205ED;
        Tue, 17 Mar 2020 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443343;
        bh=9HK5uQds0fKQgS11ZT/CoSN65Hm3Jm7/jecpwJYLWfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXTAaW3Xqydf3sK0KWKYrWQEHxvyntdSI97cWqX2e2/J1y/Yb0+ud+nLQpwd9u1Tj
         E8pyaBljVCXCYUA84+64aUY86f2tDrqNwe2/D6Lyqbr45LqvEUttc8lZIo3cM0KsYb
         u0tZHnGd8ehaU3EXPleAQ4X0Tcjc1Fa5Xy3sN4F4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 051/151] can: add missing attribute validation for termination
Date:   Tue, 17 Mar 2020 11:54:21 +0100
Message-Id: <20200317103330.207773226@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
@@ -883,6 +883,7 @@ static const struct nla_policy can_polic
 				= { .len = sizeof(struct can_bittiming) },
 	[IFLA_CAN_DATA_BITTIMING_CONST]
 				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
 };
 
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],


