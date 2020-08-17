Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B939C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1319420674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693074;
	bh=oNeBCv8ItFrue9lWTMGqDB+sAfUUQCb7GaGg120hWAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Egsqbo7M9d3KXdCj9I36fX8O2KSu11kW81KA2nFPVUIox+EWPOlA3AWpS2LJU+mps
	 h/vXeTi9NKnScH+LN1i906WtSWDNCm8UXtRDl3VE9TRjNCpOt5p3+jzFJ9sIOeD7Lb
	 rmcVjNYIIU7fwB6zmecIJhoY8ut/wkhg6ldfywFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgHQThx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgHQP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EB922DBF;
        Mon, 17 Aug 2020 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678050;
        bh=oNeBCv8ItFrue9lWTMGqDB+sAfUUQCb7GaGg120hWAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQact6wFtGk9VxVVkserP+Gf+gZ6MyCd35sll1WySeOU9yIRDfAPNxe6L6JvIm+3A
         nBpzrZSXr7VyaGK4TDJ19ryUxpQOEj8aPnNJ8ey6KXjk4CawenSP2MArYMcuuRvwTU
         mpn4dsuqe7O0jr7CKSJVU/p6jC1T0BPcyCnQeS/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 202/464] scsi: eesox: Fix different dev_id between request_irq() and free_irq()
Date:   Mon, 17 Aug 2020 17:12:35 +0200
Message-Id: <20200817143843.497713662@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 86f2da1112ccf744ad9068b1d5d9843faf8ddee6 ]

The dev_id used in request_irq() and free_irq() should match. Use 'info' in
both cases.

Link: https://lore.kernel.org/r/20200626040553.944352-1-christophe.jaillet@wanadoo.fr
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arm/eesox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/eesox.c b/drivers/scsi/arm/eesox.c
index 6e204a2e0c8d7..591ae2a6dd74f 100644
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -571,7 +571,7 @@ static int eesoxscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 
 	if (info->info.scsi.dma != NO_DMA)
 		free_dma(info->info.scsi.dma);
-	free_irq(ec->irq, host);
+	free_irq(ec->irq, info);
 
  out_remove:
 	fas216_remove(host);
-- 
2.25.1



