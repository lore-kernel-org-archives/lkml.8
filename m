Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6593C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D1D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921606;
	bh=JK+0+0R0xfd40/TrQWbQaVCITRsNWHaVdvLiCnNvfa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/rRxGO5OilYnxBuEDYTmqq0sl8iF4FeXJVi2o1vzMOn3EEQH7hehYJ0YtOX6qXgQ
	 +aOMf5QZRtAFIVJz3ZzQZkOxz4wJm7hnPm6cggz8A2LYe03Q9RROvJg9N0Dcb81yI7
	 ZDPZm0C+iYViyGnzuQsmxyAMuGtDezNNcdXT0L6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgHTKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730956AbgHTKL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:11:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A3A206DA;
        Thu, 20 Aug 2020 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918288;
        bh=JK+0+0R0xfd40/TrQWbQaVCITRsNWHaVdvLiCnNvfa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA4iuHt58HsJE7a44oy/1psa2exX1tzucY7V5kP7HVm8h8jJp8Obfa7YBcV1AJFr6
         MC3xQGTy/YRNaIk/CcdBc34+07CdHZOWvoYyFZcQmC3qzq/7p/hsNSY7EdAbkvPXZZ
         Bq23QXv5qAPwNdSRWmSrNt+4Nm0I7k7oq2lEd3Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 116/228] net: dsa: mv88e6xxx: MV88E6097 does not support jumbo configuration
Date:   Thu, 20 Aug 2020 11:21:31 +0200
Message-Id: <20200820091613.391876638@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 0f3c66a3c7b4e8b9f654b3c998e9674376a51b0f ]

The MV88E6097 chip does not support configuring jumbo frames. Prior to
commit 5f4366660d65 only the 6352, 6351, 6165 and 6320 chips configured
jumbo mode. The refactor accidentally added the function for the 6097.
Remove the erroneous function pointer assignment.

Fixes: 5f4366660d65 ("net: dsa: mv88e6xxx: Refactor setting of jumbo frames")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 10ea01459a36b..f4268f0322663 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2450,7 +2450,6 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_egress_floods = mv88e6352_port_set_egress_floods,
 	.port_set_ether_type = mv88e6351_port_set_ether_type,
-	.port_set_jumbo_size = mv88e6165_port_set_jumbo_size,
 	.port_egress_rate_limiting = mv88e6095_port_egress_rate_limiting,
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
-- 
2.25.1



