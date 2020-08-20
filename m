Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FE820855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918591;
	bh=X1suX7Qlv6NKaP0F+j8HOT7oOO7Sv6ibjF/TiNE22J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lkXz0XLVdPYu5Ii5hhIyOxVK+lyTqyF9+iBje8nB5icqPtOA8SJABcHXR1OjnSVCO
	 +o8OAUtZ/Fnw2a52QxLbUthcZwPb6lHsegRgtj/hBeIx7q3ToBiMQH6CYW4E7/pkE9
	 v/0EagC3jdRTV633RD9JeNdXjL5i9m23f3/WjPJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgHTKQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgHTKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74752078D;
        Thu, 20 Aug 2020 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918545;
        bh=X1suX7Qlv6NKaP0F+j8HOT7oOO7Sv6ibjF/TiNE22J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYaaoYQCF0M8WVzHXYvqgAko+JGcRlRFx0sj8gGaDo2VcJMMf8MIVOPomyBvifaf3
         UTE3TWGgwun2oyxpo9bLWb3xh24cQy/fwgLwgjrZSP647ZKuxHMCu8KBYjKETLHIjw
         w6qB1LYZzx5T0YDhaFCObl/8nb+7Z/d4HpUZlG24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 208/228] i2c: rcar: avoid race when unregistering slave
Date:   Thu, 20 Aug 2020 11:23:03 +0200
Message-Id: <20200820091617.926678603@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit c7c9e914f9a0478fba4dc6f227cfd69cf84a4063 ]

Due to the lockless design of the driver, it is theoretically possible
to access a NULL pointer, if a slave interrupt was running while we were
unregistering the slave. To make this rock solid, disable the interrupt
for a short time while we are clearing the interrupt_enable register.
This patch is purely based on code inspection. The OOPS is super-hard to
trigger because clearing SAR (the address) makes interrupts even more
unlikely to happen as well. While here, reinit SCR to SDBS because this
bit should always be set according to documentation. There is no effect,
though, because the interface is disabled.

Fixes: 7b814d852af6 ("i2c: rcar: avoid race when unregistering slave client")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 07305304712e1..ed0f068109785 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -815,12 +815,14 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	WARN_ON(!priv->slave);
 
-	/* disable irqs and ensure none is running before clearing ptr */
+	/* ensure no irq is running before clearing ptr */
+	disable_irq(priv->irq);
 	rcar_i2c_write(priv, ICSIER, 0);
-	rcar_i2c_write(priv, ICSCR, 0);
+	rcar_i2c_write(priv, ICSSR, 0);
+	enable_irq(priv->irq);
+	rcar_i2c_write(priv, ICSCR, SDBS);
 	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
-	synchronize_irq(priv->irq);
 	priv->slave = NULL;
 
 	pm_runtime_put(rcar_i2c_priv_to_dev(priv));
-- 
2.25.1



