Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551CC217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFQTyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:54:09 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:35432 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgFQTyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:54:03 -0400
Received: from localhost.localdomain ([93.23.15.97])
        by mwinf5d07 with ME
        id sKtu2200R25enVZ03KtvV2; Wed, 17 Jun 2020 21:54:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Jun 2020 21:54:00 +0200
X-ME-IP: 93.23.15.97
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@dominikbrodowski.net, akpm@linux-foundation.org,
        peterz@infradead.org, olof@lixom.net, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] pcmcia/electra_cf: Fix some return values in 'electra_cf_probe()' in case of error
Date:   Wed, 17 Jun 2020 21:53:26 +0200
Message-Id: <20200617195326.732863-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'status' is known to be 0 at this point. It must be set to a meaningful
value in order to return an error code if one of the 'of_get_property()'
call fails.

Return -EINVAL in such a case.

Fixes: 2b571a066a2f("pcmcia: CompactFlash driver for PA Semi Electra boards")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pcmcia/electra_cf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 35158cfd9c1a..40a5cffe24a4 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -229,6 +229,8 @@ static int electra_cf_probe(struct platform_device *ofdev)
 
 	cf->socket.pci_irq = cf->irq;
 
+	status = -EINVAL;
+
 	prop = of_get_property(np, "card-detect-gpio", NULL);
 	if (!prop)
 		goto fail1;
-- 
2.25.1

