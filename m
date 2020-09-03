Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBAAC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86EA2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1r0dvYdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgICDmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:42:38 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBE5C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:42:37 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B3863806B5;
        Thu,  3 Sep 2020 15:42:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599104548;
        bh=JJ90luUH5F1pyN8w8r/5anGwlRHYrTL09INJPGDcfPA=;
        h=From:To:Cc:Subject:Date;
        b=1r0dvYdKPEg7ykHctSM4yi4FNI21DMauJkwAQWios3vBodFazE47tLeCF9pxU/edH
         uk+yqZ+OeUk1TbShcOxMsIeKyz1sFrQbfwoGE5Fm/kaZWK3tuW7SgPzy2Hhayo9Sv5
         8qS/iZafRTOEFoIGFsu7m+VbcChzYpqtqT0U7ADTgwR6wpbu7MYJEGR+pLHNtt4Jdq
         OJw35V6M4TzcdBgWRmbeTfuL6ozhPtTU4PJjrOumnxpfjf0t0yhzLq1CFdTC6AGu8O
         gXcweQDK1FKPHI49ct8enW/5VV898cM8N+bv5PXUWfOeFGERiYct/5a5UlnneysBxu
         ra6V8CM0Q6WUQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5066240000>; Thu, 03 Sep 2020 15:42:28 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id B14C513EEB7;
        Thu,  3 Sep 2020 15:42:27 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 7C46833EDFD; Thu,  3 Sep 2020 15:42:28 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     artem.bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] mtd: mtdoops: Don't write panic data twice
Date:   Thu,  3 Sep 2020 15:42:17 +1200
Message-Id: <20200903034217.23079-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If calling mtdoops_write, don't also schedule work to be done later.

Although this appears to not be causing an issue, possibly because the
scheduled work will never get done, it is confusing.

Fixes: 016c1291ce70 ("mtd: mtdoops: do not use mtd->panic_write directly"=
)
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/mtd/mtdoops.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 4ced68be7ed7..774970bfcf85 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -279,12 +279,13 @@ static void mtdoops_do_dump(struct kmsg_dumper *dum=
per,
 	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
 			     record_size - MTDOOPS_HEADER_SIZE, NULL);
=20
-	/* Panics must be written immediately */
-	if (reason !=3D KMSG_DUMP_OOPS)
+	if (reason !=3D KMSG_DUMP_OOPS) {
+		/* Panics must be written immediately */
 		mtdoops_write(cxt, 1);
-
-	/* For other cases, schedule work to write it "nicely" */
-	schedule_work(&cxt->work_write);
+	} else {
+		/* For other cases, schedule work to write it "nicely" */
+		schedule_work(&cxt->work_write);
+	}
 }
=20
 static void mtdoops_notify_add(struct mtd_info *mtd)
--=20
2.28.0

