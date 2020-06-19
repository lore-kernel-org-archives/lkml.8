Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB10C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C25C21548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577661;
	bh=HwItb0NGNEg9UwG1oYmP/wCzufz/JPcQD8B+RWpXbKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NF6sOHpCs5j69pE2+FCRRbRH0n+Aht4CrM+y1hjrhdTdsFbVtsgxtU0csl071+8sW
	 bmaEki7ZWkXPCmK67rZFuSISApulKcRYl01BP+CoMfgENXMcaurYSaX4K6S0dBRuNp
	 R4ypMNzasfFrDCTqmLQ3A+9/i13NnB+V4nalcq6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbgFSOk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbgFSOkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A324020A8B;
        Fri, 19 Jun 2020 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577645;
        bh=HwItb0NGNEg9UwG1oYmP/wCzufz/JPcQD8B+RWpXbKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=at2NgB/EqUPV9PJqFq0JWE5UtVB/npWiHZ8ZB1ZETtRGsVkBQDmEak7Tj5kEoLzVN
         3VcdqtRaJ2W4+C/xt9QvOxTwLU1XoKDoF+nVTL/LcqmfxAIM5skl0jqTn3MuXnvJyP
         TNnobP/F2ScoCoOenxcO/8uOa8Uto0HwnbQQQwCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 032/128] spi: Fix controller unregister order
Date:   Fri, 19 Jun 2020 16:32:06 +0200
Message-Id: <20200619141621.863086232@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
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
index 7fec76dd532f..3fadc564d781 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2030,11 +2030,12 @@ void spi_unregister_master(struct spi_master *master)
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



