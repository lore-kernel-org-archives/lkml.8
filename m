Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BC208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577399;
	bh=AZXRnUQiR7NIYwkJcV2POYehmcsjZIUlWrylzvrWpH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVNSC5jF41Ozbpsh2l4510ZHRyVbIYZxFMYmDzcfCEnNmx6h3aU0kpkXV6tCaQRW1
	 KWkvtAdYzxGNFXo2LhdD040OJsgOuT+H6QCQ5JqLZ/lwhZZkFr+Qpo/5I+HMJmA/k8
	 5AExxDRBxWe2SGpQwpQnKMt8UUWZejNY1iffUmDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbgFSOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgFSOg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0946220CC7;
        Fri, 19 Jun 2020 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577385;
        bh=AZXRnUQiR7NIYwkJcV2POYehmcsjZIUlWrylzvrWpH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsAd4P2Cy/RVIvq7GYAJHENlCM5aeSRohZ6FRUX93E7k8VyK9JPomH1NzBHm0G3nX
         KuooS2umG8isxSSzUaWfC/WqX1cvImiNilcy6EtuknVa1Q45pBimNjls3KLHlzBj+t
         nmMtqo0zXfsuvK11KVrTLe8heYyM4PXTnIBh9Wds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 029/101] spi: Fix controller unregister order
Date:   Fri, 19 Jun 2020 16:32:18 +0200
Message-Id: <20200619141615.616804814@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 84855678add8aba927faf76bc2f130a40f94b6f7 ]

When an SPI controller unregisters, it unbinds all its slave devices.
For this, their drivers may need to access the SPI bus, e.g. to quiesce
interrupts.

However since commit ffbbdd21329f ("spi: create a message queueing
infrastructure"), spi_destroy_queue() is executed before unbinding the
slaves.  It sets ctlr->running = false, thereby preventing SPI bus
access and causing unbinding of slave devices to fail.

Fix by unbinding slaves before calling spi_destroy_queue().

Fixes: ffbbdd21329f ("spi: create a message queueing infrastructure")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.4+
Cc: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e5460d84ed08..57001f8f727a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1922,11 +1922,12 @@ void spi_unregister_master(struct spi_master *master)
 			dev_err(&master->dev, "queue remove failed\n");
 	}
 
+	device_for_each_child(&master->dev, NULL, __unregister);
+
 	mutex_lock(&board_lock);
 	list_del(&master->list);
 	mutex_unlock(&board_lock);
 
-	device_for_each_child(&master->dev, NULL, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
-- 
2.25.1



