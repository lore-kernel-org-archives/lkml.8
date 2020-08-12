Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A6DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337442076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4tikoCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHLKSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHLKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:18:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06700C061787
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so1408623wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1Vr1yo44hS8sLU0GBf2oPC124a0EHlxQvnx2X3QACg=;
        b=H4tikoCoeV5Xo/3UEN2bcG4dVhfiIkjoIsAzpR+7V5debM+znY0hSbIOvkkEI9/Nvw
         bqBwu8ioenFVPl6YthzNbNGte5chPUfzo2RMNOZpQGXL8E2FKAiE0AT6Yq3rzvkNj4oL
         FtmtpBY7+fAFmz9sQ5y/HJqSRorzR/BCpusQIozaxbAd/VkCzfHCdVA2ZersgsyoV70A
         YuJPA/GVzGcktX42xIKwchyMsuLfeDW328GLtdxMneckRO0ffSXiTxhT8DlI8r2OcSXl
         Hf3qbNiXkxWysVPES/AKZ+hI5EBqE9LX4xhD1iqzdtafKzTUd2xtORsKIzI0RByUr3on
         cVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1Vr1yo44hS8sLU0GBf2oPC124a0EHlxQvnx2X3QACg=;
        b=G1VQJd3uoRF7ZpMyZO3GDGJc/IB/BFyPsXVnROWnlXZSKvFny5TyrTzBT3gzHDnvlv
         c0Ei3HtU7TxknnMZ8RGLRY+uFYoUyObL/oMKNLl1OvrXrT8WKEk67caTMoPiBVrF4zJB
         6JeVkQ3zm5ce6jzYE+kfGWv+0lRoKd4821XUgbLOXc/t4kJabTkt9sJbtjAWDLKnqyjf
         f7jtfHzDWgAdIhNz2/IaTXSzDsK2V/87io5QsVfQWPw5wFbBBwlxOATKoSvMpQGgU/oO
         lz6NJ/pXiE00gyUMF9DLS4BRirttP4Wj+TRU3NLrnqDk0k148IB2ME1/GNPcyyJwDVmQ
         2o9w==
X-Gm-Message-State: AOAM531teHUOcJFBTeT6hObIvhE+Ft5SRrFQ+EdQxp9IJhnxL0bXKAKL
        oEMoAAZkKCToOQlh8qCtEpl5uUoi
X-Google-Smtp-Source: ABdhPJyCHXB1mUl70KcKIycA/L1sVfqlTx8QLFjTBeWTou/4lmU6JHyitanHa297LjWTcLLeTbxJ6w==
X-Received: by 2002:a1c:b145:: with SMTP id a66mr8324887wmf.133.1597227527367;
        Wed, 12 Aug 2020 03:18:47 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w64sm3429714wmb.26.2020.08.12.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 03:18:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/3] habanalabs: correctly report inbound pci region cfg error
Date:   Wed, 12 Aug 2020 13:18:39 +0300
Message-Id: <20200812101839.31233-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812101839.31233-1-oded.gabbay@gmail.com>
References: <20200812101839.31233-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

During inbound iATU configuration we can get errors while
configuring PCI registers, there is a certain scenario in which these
errors are not reflected and driver is loaded with wrong configuration.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/pci.c b/drivers/misc/habanalabs/common/pci.c
index b8184cb49034..2770f03b6cbb 100644
--- a/drivers/misc/habanalabs/common/pci.c
+++ b/drivers/misc/habanalabs/common/pci.c
@@ -227,7 +227,7 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 	}
 
 	/* Point to the specified address */
-	rc = hl_pci_iatu_write(hdev, offset + 0x14,
+	rc |= hl_pci_iatu_write(hdev, offset + 0x14,
 			lower_32_bits(pci_region->addr));
 	rc |= hl_pci_iatu_write(hdev, offset + 0x18,
 			upper_32_bits(pci_region->addr));
-- 
2.17.1

