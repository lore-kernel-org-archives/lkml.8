Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A347C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF5D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgFOLj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:39:57 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:55796 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOLj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:39:56 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 07:39:56 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 515BF18191042;
        Mon, 15 Jun 2020 13:34:23 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dOA46q-Td_kF; Mon, 15 Jun 2020 13:34:22 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HUAf7wxJjGOH; Mon, 15 Jun 2020 13:34:22 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH] nandsim: Fix return code testing of ns_find_operation()
Date:   Mon, 15 Jun 2020 13:34:04 +0200
Message-Id: <20200615113404.25447-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ns_find_operation() returns 0 on success.

Fixes: 052a7a5374bc ("mtd: rawnand: nandsim: Clean error handling")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/raw/nandsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsi=
m.c
index 0a5cb77966cc..f5a53aac3c5f 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1761,7 +1761,7 @@ static void ns_switch_state(struct nandsim *ns)
=20
 		NS_DBG("switch_state: operation is unknown, try to find it\n");
=20
-		if (!ns_find_operation(ns, 0))
+		if (ns_find_operation(ns, 0))
 			return;
=20
 		if ((ns->state & ACTION_MASK) &&
--=20
2.26.2

