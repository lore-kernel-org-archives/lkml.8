Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF62065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261652;
	bh=dfSo/QP5zeIS5qIsUXzFXCdzFyh8OX64kBCuA7fdD/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u6MKkeCeYm0F0pNcuAfE/6znfXi0YvTexe9gJdM3RW2MRYNk6+kNUVl+gI00aNd3H
	 7KM1M+ZAgJbduXUt6xd+Jo25iFQ+ortJ/UB73nFIk1lehQDTsOyMFcLhDqi1Zhq5O/
	 Jogg5JsaXLWpQn6Bgoe5+/1mCTKWJvTIT+ueYKyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgGTQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388183AbgGTQOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5792065E;
        Mon, 20 Jul 2020 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261644;
        bh=dfSo/QP5zeIS5qIsUXzFXCdzFyh8OX64kBCuA7fdD/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mk7v+Nwt7t7tmBxYD08TOG8scAZ2njFkn5zAxKjolaruNYerumOhrkUwt/u02JOEk
         vFANivLkGSrTAJwUePSGyhNOWT8XdFAFqrembmU617i2ZHmM107cVC+OCzEV9rZEmH
         y6joDNh9wqedvhpav1JS9WV3i8aDanYOlLn/AkWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <esben@geanix.com>
Subject: [PATCH 5.7 191/244] uio_pdrv_genirq: Remove warning when irq is not specified
Date:   Mon, 20 Jul 2020 17:37:42 +0200
Message-Id: <20200720152834.925997767@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>

commit 324ac45f25e634eca6346953ae531e8da3e0c73d upstream.

Since e3a3c3a20555 ("UIO: fix uio_pdrv_genirq with device tree but no
interrupt"), the uio_pdrv_genirq has supported use without interrupt,
so the change in 7723f4c5ecdb ("driver core: platform: Add an error
message to") added false warnings for those cases.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200701145659.3978-2-esben@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio_pdrv_genirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -159,7 +159,7 @@ static int uio_pdrv_genirq_probe(struct
 	priv->pdev = pdev;
 
 	if (!uioinfo->irq) {
-		ret = platform_get_irq(pdev, 0);
+		ret = platform_get_irq_optional(pdev, 0);
 		uioinfo->irq = ret;
 		if (ret == -ENXIO && pdev->dev.of_node)
 			uioinfo->irq = UIO_IRQ_NONE;


