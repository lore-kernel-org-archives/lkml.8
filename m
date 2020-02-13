Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E548C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFCB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607920;
	bh=p6JrbT3CgbN40TmXB28kT1XvH8v/sceqsNnGlOEqp48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=goVVjbCglEPlyAYrw4bG/z62CaGf9qqw0qpBt3wFAtX185U9E+cs+IbD8UtUpZTOB
	 ca+b6ssKuZ1TIq/Pd5OKMT1oJ1lx2Q+xhpu31Li4EtRI7SRnvG9sHOTPmKv5NpGMIZ
	 88E5TQHvNzQRmpzvF3A/ZLDkHhHkfX05KNHCdM/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgBMPcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgBMP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:14 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F3A20661;
        Thu, 13 Feb 2020 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607693;
        bh=p6JrbT3CgbN40TmXB28kT1XvH8v/sceqsNnGlOEqp48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfmSWtJSYBEwfWc8JLh6z6ocN6iPHRyispd0/jUz9/2QLgRpt27zpJrkSJFU+Lj80
         ZkXFxtQF4PAENjymc5dp7NdKFQOLEVR3kYSLWa0dK6Iz8vXoY5u/Lfb8uZGjwciihJ
         9tQdHqagJwxJVK4AhyHEWj+QJZWrA0gT+To439kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wesley Sheng <wesley.sheng@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.5 016/120] PCI/switchtec: Use dma_set_mask_and_coherent()
Date:   Thu, 13 Feb 2020 07:20:12 -0800
Message-Id: <20200213151907.440481666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Sheng <wesley.sheng@microchip.com>

commit aa82130a22f77c1aa5794703730304d035a0c1f4 upstream.

Use dma_set_mask_and_coherent() instead of dma_set_coherent_mask() as the
Switchtec hardware fully supports 64bit addressing and we should set both
the streaming and coherent masks the same.

[logang@deltatee.com: reworked commit message]
Fixes: aff614c6339c ("switchtec: Set DMA coherent mask")
Link: https://lore.kernel.org/r/20200106190337.2428-2-logang@deltatee.com
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/switch/switchtec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1349,7 +1349,7 @@ static int switchtec_init_pci(struct swi
 	if (rc)
 		return rc;
 
-	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
 		return rc;
 


