Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E45D20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXgvbwzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbgFXGYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbgFXGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5954AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v19so838060qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeFAcmlPcFBcL391CclzBcYNZ0kQLKelbZVf7iyXvbQ=;
        b=bXgvbwzErNnmUR/gkVDFaUZUc5XjS262NZ0VGDMNQ+SbagcfH8Ax4pUrOVqJrrk8qf
         a36EPVt0pmNbcxo0TVbFBFj65HbbQOwA9towtA4H99YYcwAk/q2cO39sN4L/ZjB6Vo++
         hpkA1AK+yaRjFmMCe6i7JqBLDsyygG1EDhYv37rS8vUP5cnE+PD7y6HRC3wy0vBmkozb
         1iZYlHPtMBCni9V841A0MefnIEXWWhB+8bKO+T9yX4OEUspOpNdF3uGes1kIPF/etmvs
         s85IQB04JVaN16wOeHsQ7jB7XYW90NAHGfhu/3q/PVVLLX3gvTgOHC/xoTCxB1G9MAG8
         DSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeFAcmlPcFBcL391CclzBcYNZ0kQLKelbZVf7iyXvbQ=;
        b=m9fc/BxNaTDhhLygoS3fvXuKsb6gMX53k/sUWS6XvhkMtR2cHMo6YBxnj9nDIQuFAq
         dt0A3MBMvLTJjc8O2PmTUn4wWyz2z4N3Mt6IQ7eEsMIs8Grf+x0kGLxYLx79tcJLYY43
         u/rBEQhgqrczjUb77aV788xQy22pMkMtA96YnSfEbWFDZWAjsL0qU1akmLwIOaeU0OFo
         A9QFRQvhKYp1RWszFLUlqAakTgW0P854WJKIZi0Pf8rN4GG/YV3EFDd0h/ctvP5BdWvy
         r8rQ5aQi23ifOb9MqIvK2UgFrvr8hcQJTLUvfKyd1hfVCVts4my05JN0uqYyY8VhK2Lt
         +jDw==
X-Gm-Message-State: AOAM533K6yRCI300jD67f1h1RL3VxFA03N5WvFqVzYv9gFdjrAhO93yw
        FLR1g9IIoCWFknxO3OpqEa+yR0zA
X-Google-Smtp-Source: ABdhPJzx2OQdVTNaGxL2nQJh7sRK2WoX08r1vEI6T415SLqFmTjUWi/FkyUAeMt1OIxexMFzviiSxA==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr24168464qtb.80.1592979885652;
        Tue, 23 Jun 2020 23:24:45 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:45 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] powerpc/pseries/iommu: Avoid errors when DDW starts at 0x00
Date:   Wed, 24 Jun 2020 03:24:11 -0300
Message-Id: <20200624062411.367796-7-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, enable_ddw() will return a non-null DMA address if the
created DDW maps the whole partition. If the address is valid,
iommu_bypass_supported_pSeriesLP() will consider iommu bypass enabled.

This can cause some trouble if the DDW happens to start at 0x00.

Instead if checking if the address is non-null, check directly if
the DDW maps the whole partition, so it can bypass iommu.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 2d217cda4075..967634a379b0 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1078,7 +1078,8 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
  *
  * returns the dma offset for use by the direct mapped DMA code.
  */
-static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
+static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
+		      bool *maps_partition)
 {
 	int len, ret;
 	struct ddw_query_response query;
@@ -1237,9 +1238,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	/* Only returns the dma_addr if DDW maps the whole partition */
 	if (len == order_base_2(max_addr))
-		dma_addr = be64_to_cpu(ddwprop->dma_base);
+		*maps_partition = true;
+	dma_addr = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
@@ -1324,6 +1325,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct device_node *dn = pci_device_to_OF_node(pdev), *pdn;
 	const __be32 *dma_window = NULL;
+	bool ret = false;
 
 	/* only attempt to use a new window if 64-bit DMA is requested */
 	if (dma_mask < DMA_BIT_MASK(64))
@@ -1344,13 +1346,10 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 			break;
 	}
 
-	if (pdn && PCI_DN(pdn)) {
-		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
-		if (pdev->dev.archdata.dma_offset)
-			return true;
-	}
+	if (pdn && PCI_DN(pdn))
+		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn, &ret);
 
-	return false;
+	return ret;
 }
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
-- 
2.25.4

