Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDBC22B49
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHUH63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:58:29 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:35967 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHUH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:58:27 -0400
Received: from localhost.localdomain ([93.22.37.159])
        by mwinf5d23 with ME
        id J7yN2300H3S18rh037yPUT; Fri, 21 Aug 2020 09:58:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Aug 2020 09:58:25 +0200
X-ME-IP: 93.22.37.159
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in 'nvmet_fc_fod_op_done()'
Date:   Fri, 21 Aug 2020 09:58:19 +0200
Message-Id: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
in this function.

Use 'spin_lock_irqsave()' also here, as there is no guarantee that
interruptions are disabled at that point, according to surrounding code.

Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not tested, only based on what looks logical to me according to
surrounding code
---
 drivers/nvme/target/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 55bafd56166a..e6861cc10e7d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 			return;
 		if (fcpreq->fcp_error ||
 		    fcpreq->transferred_length != fcpreq->transfer_length) {
-			spin_lock(&fod->flock);
+			spin_lock_irqsave(&fod->flock, flags);
 			fod->abort = true;
-			spin_unlock(&fod->flock);
+			spin_unlock_irqrestore(&fod->flock, flags);
 
 			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
 			return;
-- 
2.25.1

