Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB54C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1213A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686263;
	bh=8ZGoBqju/lye+2LTT4VSSUJ0uHKgnw6J0Qizfb+cNtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oj4ZpdbM8t1RBjVR2iejUq6LJmkazhQ3FoIET/AC0zWLa7lZDxtR4KH4NOl0XpQ72
	 jJFibANPVGjj5CKgSc0pDybjxSUT7z0pLGrzqLvrbxB5VxeJ++q1PhT2fGK9iJFrvu
	 8NbXuFDm2VO4XmYggssczU8EOiBKOtfOfvdM57/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgHQRoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbgHQQO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:14:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980C923108;
        Mon, 17 Aug 2020 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680895;
        bh=8ZGoBqju/lye+2LTT4VSSUJ0uHKgnw6J0Qizfb+cNtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uX5vftjKOgghVbHH9Dk3XVR/sH8UghPzlXXA7jsc2rC9J6WcA+jp9I/yZwwrdozKh
         v9dIM6MpuRKmoWZJ17v/f/wT9kDoJINtMlJsffJ1BhAeFBn5Mrgt/wUFAULXQb9HyB
         XTs4PpdJ46GCq7W0ezHRslvBR3QZ675QKqwIXd6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/168] scsi: powertec: Fix different dev_id between request_irq() and free_irq()
Date:   Mon, 17 Aug 2020 17:16:41 +0200
Message-Id: <20200817143737.207280782@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d179f7c763241c1dc5077fca88ddc3c47d21b763 ]

The dev_id used in request_irq() and free_irq() should match. Use 'info' in
both cases.

Link: https://lore.kernel.org/r/20200626035948.944148-1-christophe.jaillet@wanadoo.fr
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arm/powertec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/powertec.c b/drivers/scsi/arm/powertec.c
index 79aa88911b7f3..b5e4a25ea1ef3 100644
--- a/drivers/scsi/arm/powertec.c
+++ b/drivers/scsi/arm/powertec.c
@@ -382,7 +382,7 @@ static int powertecscsi_probe(struct expansion_card *ec,
 
 	if (info->info.scsi.dma != NO_DMA)
 		free_dma(info->info.scsi.dma);
-	free_irq(ec->irq, host);
+	free_irq(ec->irq, info);
 
  out_release:
 	fas216_release(host);
-- 
2.25.1



