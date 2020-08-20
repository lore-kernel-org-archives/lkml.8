Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61070C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9720658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919432;
	bh=+Ap2wQZ5CvXjKST15Vs/LrwEjznqAVZjmrVx/SdkBzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HHpk3WTOcfnoagXIcwua/hQzYSVs5YEODiymXYFsh5Uf+TEgXkwAn8raTfnd83CCQ
	 XiE9AtKxRq5emlhwGDlpzNBN+SXg2EPMPO4NsPZzpcjvwITxNPYoJpkEDd/TNZGrEK
	 GZ7erha3/hKK+0LUZj1dLYfEg7pnm5UZEch4weiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgHTKUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgHTKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31C720658;
        Thu, 20 Aug 2020 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918842;
        bh=+Ap2wQZ5CvXjKST15Vs/LrwEjznqAVZjmrVx/SdkBzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reAYrC1KF5ZMYbw0JPbhDHx9CA6WJ/VomuQBccamckSaYSkw7hw2htUTR6EywSDS6
         w2ttvZACdpDPyybj4MfDnUwDMwmXOHGvGdyTo9Gn9i9khhi5PlBk1j9zT4k1pnBNJU
         gX468lvKdADn9dLT2zFh7ryWpG3niMswsYCVi3mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 087/149] scsi: eesox: Fix different dev_id between request_irq() and free_irq()
Date:   Thu, 20 Aug 2020 11:22:44 +0200
Message-Id: <20200820092129.940896936@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
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
index a8ad6880dd914..cf01442d91363 100644
--- a/drivers/scsi/arm/eesox.c
+++ b/drivers/scsi/arm/eesox.c
@@ -575,7 +575,7 @@ static int eesoxscsi_probe(struct expansion_card *ec, const struct ecard_id *id)
 
 	if (info->info.scsi.dma != NO_DMA)
 		free_dma(info->info.scsi.dma);
-	free_irq(ec->irq, host);
+	free_irq(ec->irq, info);
 
  out_remove:
 	fas216_remove(host);
-- 
2.25.1



