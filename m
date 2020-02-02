Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5756C3524A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A45720658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgBBOXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 09:23:50 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:42844 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBBOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:23:50 -0500
Received: from localhost.localdomain ([93.22.39.62])
        by mwinf5d09 with ME
        id xqPl2100G1LTYWM03qPmkl; Sun, 02 Feb 2020 15:23:47 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Feb 2020 15:23:47 +0100
X-ME-IP: 93.22.39.62
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     macro@linux-mips.org, ralf@linux-mips.org, davem@davemloft.net,
        akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] defxx: Fix a sentinel at the end of a 'eisa_device_id' structure
Date:   Sun,  2 Feb 2020 15:23:41 +0100
Message-Id: <20200202142341.22124-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct eisa_device_id' must be ended by an empty string, not a NULL
pointer. Otherwise, a NULL pointer dereference may occur in
'eisa_bus_match()'.

Also convert some spaces to tab to please 'checkpatch.pl'.

Fixes: e89a2cfb7d7b ("[TC] defxx: TURBOchannel support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/fddi/defxx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/fddi/defxx.c b/drivers/net/fddi/defxx.c
index 077c68498f04..7ef0c57f07c6 100644
--- a/drivers/net/fddi/defxx.c
+++ b/drivers/net/fddi/defxx.c
@@ -3768,11 +3768,11 @@ static void dfx_pci_unregister(struct pci_dev *pdev)
 
 #ifdef CONFIG_EISA
 static const struct eisa_device_id dfx_eisa_table[] = {
-        { "DEC3001", DEFEA_PROD_ID_1 },
-        { "DEC3002", DEFEA_PROD_ID_2 },
-        { "DEC3003", DEFEA_PROD_ID_3 },
-        { "DEC3004", DEFEA_PROD_ID_4 },
-        { }
+	{ "DEC3001", DEFEA_PROD_ID_1 },
+	{ "DEC3002", DEFEA_PROD_ID_2 },
+	{ "DEC3003", DEFEA_PROD_ID_3 },
+	{ "DEC3004", DEFEA_PROD_ID_4 },
+	{ "" }
 };
 MODULE_DEVICE_TABLE(eisa, dfx_eisa_table);
 
-- 
2.20.1

