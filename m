Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86479C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4872064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260119;
	bh=eIg5zlpARQ0ncoOVYVLpaBxwWN3Nt8ngvgaUr4OFHAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVUNiGWVFxFtK2xyRAdjKaW3yd46CKKEbYTpB4k4ciakfElTCvgdncUAdYr4f6HkF
	 jgR9mDRg6XQbDGr3RZcRJvlR4mqH6VccVZn7X9m/XTXs8+cj79QUn9Uhcr9sxIxWuS
	 O0pHMOILSmjNeKJstZ0fI+N8lm5P9FnicBk2iBiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGTPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgGTPsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:48:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67D02064B;
        Mon, 20 Jul 2020 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260114;
        bh=eIg5zlpARQ0ncoOVYVLpaBxwWN3Nt8ngvgaUr4OFHAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhklUwDIfq3JkxRp/iokbC+Gn9J+rzTWI03p4peT58ovj0G+XfFAgYotV/eYi6tsh
         Cn3+UE6yeBixo27QVVgmYBJn/KOyBikGV7Pog9JwoN+um0eohHv38XodjrMJVU4eEX
         j7swkURabs29rwjWvs8ggDlHvXfOUpKQntWIs28I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <esben@geanix.com>
Subject: [PATCH 4.14 111/125] uio_pdrv_genirq: fix use without device tree and no interrupt
Date:   Mon, 20 Jul 2020 17:37:30 +0200
Message-Id: <20200720152808.387691137@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>

commit bf12fdf0ab728ca8e5933aac46dd972c0dd0421e upstream.

While e3a3c3a20555 ("UIO: fix uio_pdrv_genirq with device tree but no
interrupt") added support for using uio_pdrv_genirq for devices without
interrupt for device tree platforms, the removal of uio_pdrv in
26dac3c49d56 ("uio: Remove uio_pdrv and use uio_pdrv_genirq instead")
broke the support for non device tree platforms.

This change fixes this, so that uio_pdrv_genirq can be used without
interrupt on all platforms.

This still leaves the support that uio_pdrv had for custom interrupt
handler lacking, as uio_pdrv_genirq does not handle it (yet).

Fixes: 26dac3c49d56 ("uio: Remove uio_pdrv and use uio_pdrv_genirq instead")
Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200701145659.3978-3-esben@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio_pdrv_genirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -148,7 +148,7 @@ static int uio_pdrv_genirq_probe(struct
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
 		uioinfo->irq = ret;
-		if (ret == -ENXIO && pdev->dev.of_node)
+		if (ret == -ENXIO)
 			uioinfo->irq = UIO_IRQ_NONE;
 		else if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get IRQ\n");


