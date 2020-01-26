Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13346C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE71D2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbgAZKZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:25:52 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:20555 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgAZKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:25:51 -0500
Received: from localhost.localdomain ([92.140.214.230])
        by mwinf5d67 with ME
        id uyRn210074ypjRG03yRo0l; Sun, 26 Jan 2020 11:25:49 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Jan 2020 11:25:49 +0100
X-ME-IP: 92.140.214.230
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     snelson@pensando.io, drivers@pensando.io,
        jakub.kicinski@netronome.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ionic: Fix rx queue allocation in 'ionic_lif_alloc()'
Date:   Sun, 26 Jan 2020 11:25:40 +0100
Message-Id: <20200126102540.14812-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct ionic' has a 'nrxqs_per_lif' field. So use it instead of
using two times the value of 'ntxqs_per_lif'.

Note that with the current implementation, this patch is a no-op because
both fields are set to the same value in 'ionic_lifs_size()' which
is called before reaching 'ionic_lif_alloc()'.

However, it is more future-proof.

Fixes: 1a58e196467f ("ionic: Add basic lif support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Another alternative could be to use 'alloc_etherdev_mq()' if really using
the same value for both fields is what is expected.
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 60fd14df49d7..96d3b3e993ad 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1663,7 +1663,7 @@ static struct ionic_lif *ionic_lif_alloc(struct ionic *ionic, unsigned int index
 	int err;
 
 	netdev = alloc_etherdev_mqs(sizeof(*lif),
-				    ionic->ntxqs_per_lif, ionic->ntxqs_per_lif);
+				    ionic->ntxqs_per_lif, ionic->nrxqs_per_lif);
 	if (!netdev) {
 		dev_err(dev, "Cannot allocate netdev, aborting\n");
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

