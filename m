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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C1F20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxQezt9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbgFXGYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389139AbgFXGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B94C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so846396qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=So2/vu+EL+OrMb5JxMT9QwjF5FYYejn+1+Omdy+0Eak=;
        b=JxQezt9w39vQyvQ+aIYqYkcus1CujftpADe9rWdSWPYhV+GhDXM3gbFdHVmrM5GYp1
         rxTyuH+nkU/bvUko8gHiWmBMaZeKVjDVyGCOvzm9/SAVpkKHipzQslsP70cphMuofofP
         fANMd87yQ2gNV6tkKsuwPBuLkIWuYKdJ1sDv3OV+rYByzE4xwpzPv/7DZwgtmCWyCprW
         FB60+ZQKFheHuQez/lGMVU/UjSWadkDv2Wr2QRyvB/Jid3LyhUc9NmZE7DM6gpdFoXuX
         iSNF/0ZyrjmF4yNXTYvWLmq7WpTSMEj0Q41WVoFGN+E+yWpJK2m2yRUajpGo4OsL8Kcp
         BF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=So2/vu+EL+OrMb5JxMT9QwjF5FYYejn+1+Omdy+0Eak=;
        b=SFEuSQq0WMbu+14QumaPAiC1q9ov53gaA+AMHfrc4UHdo/SiN5Xmd2kP+thsn2yORB
         KaMPnyLyA5XKKSnok7apj6eAFiu0GVXmRWSVn2khdFWZGG51I9tY6QHnjNe734InywXN
         s4uFaYoRQblTPUN4DpIP7BID6DwjHTfkWJU+DSnY09tG7YHDdUqUrOk/n6OlzWCihUMJ
         Fl3DW7vYSNwj0FRXZe4qxld/69WJYq1GlCwCBmPx9qbF7YIVMXnGnKz0jqiAX1E4kU8Q
         3QcQIoBUhN7V/S6tIxcmnVT+I/PZZYu8TeXY4X0nn4Ip4xZAsRCsWPMmaVnCTlZToYY3
         VMUw==
X-Gm-Message-State: AOAM531ADalFaI5pe4+4Ofpg/2s6JEiQAG8/ATsTmwDcui9Muow3yjys
        0bToRpquKXaOnBaLhuwHUNg=
X-Google-Smtp-Source: ABdhPJwKQR+t/nHT6BBFIbQL5eKywbKwv9vmIT6XW3aFzkFZm7i4t9TMs0AVYUFbbfW2CFbrJrhSrA==
X-Received: by 2002:ac8:4e8c:: with SMTP id 12mr25311594qtp.20.1592979882301;
        Tue, 23 Jun 2020 23:24:42 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:41 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] powerpc/pseries/iommu: Make use of DDW even if it does not map the partition
Date:   Wed, 24 Jun 2020 03:24:10 -0300
Message-Id: <20200624062411.367796-6-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, if a DDW is created and can't map the whole partition, it's
removed and the default DMA window "ibm,dma-window" is used instead.

Usually this DDW is bigger than the default DMA window, so it would be
better to make use of it instead.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4fcf00016fb1..2d217cda4075 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -685,7 +685,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	const __be32 *dma_window = NULL;
+	const __be32 *dma_window = NULL, *alt_dma_window = NULL;
 
 	dn = pci_bus_to_OF_node(bus);
 
@@ -699,8 +699,13 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 			break;
 	}
 
+	/* If there is a DDW available, use it instead */
+	alt_dma_window = of_get_property(pdn, DIRECT64_PROPNAME, NULL);
+	if (alt_dma_window)
+		dma_window = alt_dma_window;
+
 	if (dma_window == NULL) {
-		pr_debug("  no ibm,dma-window property !\n");
+		pr_debug("  no ibm,dma-window nor linux,direct64-ddr-window-info property !\n");
 		return;
 	}
 
@@ -1166,16 +1171,19 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			  query.page_size);
 		goto out_failed;
 	}
+
 	/* verify the window * number of ptes will map the partition */
-	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
-			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-			  1ULL << page_shift);
-		goto out_failed;
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
+			max_addr, query.largest_available_block,
+			1ULL << page_shift);
+
+		len = order_base_2(query.largest_available_block << page_shift);
+	} else {
+		len = order_base_2(max_addr);
 	}
-	len = order_base_2(max_addr);
+
 	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
 	if (!win64) {
 		dev_info(&dev->dev,
@@ -1229,7 +1237,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	/* Only returns the dma_addr if DDW maps the whole partition */
+	if (len == order_base_2(max_addr))
+		dma_addr = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
-- 
2.25.4

