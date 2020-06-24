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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1DA20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9ruBgD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbgFXGYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389139AbgFXGYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34302C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so877477qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3h0KTMR9rrY+WXnWaCQphxLTyQkuBGaHlmGU+VwrxV0=;
        b=I9ruBgD7pERXLviff6ATkAVtBywsITDmX7utLtD0yNx0W5312ifHN6SRRt2QfY29Vi
         c0/UvEuaBpI5dWvZsdyIwKvBk+KGSrE/MtQf7XZydEwuOlwJfHbOx82CnNa8lUAPE4fG
         BLSGIkJWy7FGk8B9va2o1mIHtc9XeSWYHAZVUGqIm4fkvJhHbFk+fYDdlMM5Yf31uUZB
         3cHsCLNhwpLSB9ZA92HIRfn/xGpaZJztuu8zJMNp4VBs9vqx8yKDQ0k3VrstcSYGmw34
         Ef9K2WBZ/gS33sRgK4A0Ib7XtnuHP/qbnc2mb0t3VIe+mo/gcXj1XllT1QyjnyRIXMVp
         gTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3h0KTMR9rrY+WXnWaCQphxLTyQkuBGaHlmGU+VwrxV0=;
        b=nr6m/3ybvsc1fCwM9/6+trm4F/3BO6J7hR6ejeuCmQAAZ9yltkOMY3JvqxuygHA60g
         6QVgdSo+NOIXZO3DDSQuEi/AUL5VDH8sam4l/iJB6IGaYFaop4pyf0kgnERVy/oirPmA
         RO3TfIkBlxYEE4zp1C8RH4ji+RR5gMq2U2NoI63O7t0G0gNwsoERO0UMHqzw4lRZUURj
         XZx9I9LutvqBwXXT2o8LzMfCpiJrvNkEqyJFyRUzE5VC0xctpUkQZXsUHNxD4IQ7PNEL
         OwM2VmfH+zxLul0HM/wVQaq9ukW0PRSW9T0xVe1sjAQiNdomiFJIYZuoS1QESrlKx45U
         oYpg==
X-Gm-Message-State: AOAM5306CpJCKTMBgK/kd3peuWuhTMxfZ0X8ZnppL+KvCa5oP1g0R3P6
        eIu9Ixtoink+w7L/Nn47daY=
X-Google-Smtp-Source: ABdhPJzKRz8npfnViE6IjSP51EsOWFHmBTAKpeXYkNOq2hRZy58E/HIu6AW+thOxNw8wKVPXNv2lwA==
X-Received: by 2002:ac8:7587:: with SMTP id s7mr6494145qtq.304.1592979878403;
        Tue, 23 Jun 2020 23:24:38 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:37 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] powerpc/pseries/iommu: Remove default DMA window before creating DDW
Date:   Wed, 24 Jun 2020 03:24:09 -0300
Message-Id: <20200624062411.367796-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On LoPAR "DMA Window Manipulation Calls", it's recommended to remove the
default DMA window for the device, before attempting to configure a DDW,
in order to make the maximum resources available for the next DDW to be
created.

This is a requirement for some devices to use DDW, given they only
allow one DMA window.

If setting up a new DDW fails anywhere after the removal of this
default DMA window, it's needed to restore the default DMA window.
For this, an implementation of ibm,reset-pe-dma-windows rtas call is
needed:

Platforms supporting the DDW option starting with LoPAR level 2.7 implement
ibm,ddw-extensions. The first extension available (index 2) carries the
token for ibm,reset-pe-dma-windows rtas call, which is used to restore
the default DMA window for a device, if it has been deleted.

It does so by resetting the TCE table allocation for the PE to it's
boot time value, available in "ibm,dma-window" device tree node.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 70 ++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a8840d9e1c35..4fcf00016fb1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1029,6 +1029,39 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 	return max_addr;
 }
 
+/*
+ * Platforms supporting the DDW option starting with LoPAR level 2.7 implement
+ * ibm,ddw-extensions, which carries the rtas token for
+ * ibm,reset-pe-dma-windows.
+ * That rtas-call can be used to restore the default DMA window for the device.
+ */
+static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
+{
+	int ret;
+	u32 cfg_addr, ddw_ext[DDW_EXT_RESET_DMA_WIN + 1];
+	u64 buid;
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
+					 &ddw_ext[0], DDW_EXT_RESET_DMA_WIN + 1);
+	if (ret)
+		return;
+
+	dn = pci_device_to_OF_node(dev);
+	pdn = PCI_DN(dn);
+	buid = pdn->phb->buid;
+	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
+
+	ret = rtas_call(ddw_ext[DDW_EXT_RESET_DMA_WIN], 3, 1, NULL, cfg_addr,
+			BUID_HI(buid), BUID_LO(buid));
+	if (ret)
+		dev_info(&dev->dev,
+			 "ibm,reset-pe-dma-windows(%x) %x %x %x returned %d ",
+			 ddw_ext[1], cfg_addr, BUID_HI(buid), BUID_LO(buid),
+			 ret);
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1049,8 +1082,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
 	u32 ddw_avail[DDW_APPLICABLE_SIZE];
+
 	struct direct_window *window;
-	struct property *win64;
+	struct property *win64, *default_win = NULL, *ddw_ext = NULL;
 	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
 
@@ -1085,7 +1119,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret)
 		goto out_failed;
 
-       /*
+	/*
 	 * Query if there is a second window of size to map the
 	 * whole partition.  Query returns number of windows, largest
 	 * block assigned to PE (partition endpoint), and two bitmasks
@@ -1096,15 +1130,31 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret != 0)
 		goto out_failed;
 
+	/*
+	 * If there is no window available, remove the default DMA window,
+	 * if it's present. This will make all the resources available to the
+	 * new DDW window.
+	 * If anything fails after this, we need to restore it, so also check
+	 * for extensions presence.
+	 */
 	if (query.windows_available == 0) {
-		/*
-		 * no additional windows are available for this device.
-		 * We might be able to reallocate the existing window,
-		 * trading in for a larger page size.
-		 */
-		dev_dbg(&dev->dev, "no free dynamic windows");
-		goto out_failed;
+		default_win = of_find_property(pdn, "ibm,dma-window", NULL);
+		ddw_ext = of_find_property(pdn, "ibm,ddw-extensions", NULL);
+		if (default_win && ddw_ext)
+			remove_dma_window(pdn, ddw_avail, default_win);
+
+		/* Query again, to check if the window is available */
+		ret = query_ddw(dev, ddw_avail, &query, pdn);
+		if (ret != 0)
+			goto out_failed;
+
+		if (query.windows_available == 0) {
+			/* no windows are available for this device. */
+			dev_dbg(&dev->dev, "no free dynamic windows");
+			goto out_failed;
+		}
 	}
+
 	if (query.page_size & 4) {
 		page_shift = 24; /* 16MB */
 	} else if (query.page_size & 2) {
@@ -1194,6 +1244,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 
 out_failed:
+	if (default_win && ddw_ext)
+		reset_dma_window(dev, pdn);
 
 	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
 	if (!fpdn)
-- 
2.25.4

