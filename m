Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42315C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBAF206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDr30cOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgHEDFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:05:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:05:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t23so29541573qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHVfOCrTYMIyp/yDwtpHYrzGhqVPdI+0ppzTBFsHaGA=;
        b=SDr30cOrPPrZYzCmHSo4oEPMGN3I5/rZsla9OZMOm9PntE/t1BJHvFMlXcRk6+mjZD
         Kncqs0o0wYrUJ6ull6q1DDNHqUKZdUCsDq997qoQTmh9OqIMEzjnNB2ZviJiCQ0CU7H5
         MC49G2KZ59LLpJOCQvGQZugxqR60osZDVU4wjOycCAaOClvspfKizKF97OguRvHv29ms
         crJlF1rPmmMGQzqb1Y8xf+RmwLLP4dKeO5xvoHFyEDLqVcgX50dryHE6ryOz4/oBK6HA
         UqesV4EUjDyulEMRlGs4Kmwd4/bXPTQ090k4f6VucU6g9Qyb3fdHpAI8co3277hsPbCJ
         OMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHVfOCrTYMIyp/yDwtpHYrzGhqVPdI+0ppzTBFsHaGA=;
        b=aFpT/FcDTqoa6CIeN9LD4MeaeGd4V9pCY9AtLoYJwvhrhOsZWXzEAyZrHXPezJBgvB
         cp/xFWeXIpO1WvIiCUZf3qOdQuvnPANMSKcOnGbG4Hu2kTK+IFyqo5O/iJehA5Kle1oJ
         j1JIBekRv+9BNLsMVbTCqBC5EbB7SNsI+sp2rZ3+lX+ma/xj57gy2IYS4Ch2aoE3YaEC
         RawRn8pDzZMre6IWB/fp25/nsAzVCxLyFus7zNT7BohnZlzsW8eX6g0izWJEQkatXaXy
         h9MuRAjuj/Wqqw5An6Rb5V0vVTTcpPDrtQzHE2BBQgzTkPjlFW4fTg5YM27Sf8lB8IyS
         pmpw==
X-Gm-Message-State: AOAM532W+unbtzAY0MvEZ+Qvzp92mD65p4aFqcUhrTI5V7WNlShb5iZk
        9N2CKP5VDXznEKc11V2/qn8=
X-Google-Smtp-Source: ABdhPJzNtehPgt1cATjgfHbP2JS1QBrBnY1eNrCAtHYIpCI11soyyzLkI8wwF29/EsW7yYjTEPmXdQ==
X-Received: by 2002:ac8:4741:: with SMTP id k1mr1259519qtp.41.1596596722106;
        Tue, 04 Aug 2020 20:05:22 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-154-168.dynamic.desktop.com.br. [179.125.154.168])
        by smtp.gmail.com with ESMTPSA id n4sm869946qtr.73.2020.08.04.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:05:21 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] powerpc/pseries/iommu: Allow bigger 64bit window by removing default DMA window
Date:   Wed,  5 Aug 2020 00:04:55 -0300
Message-Id: <20200805030455.123024-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
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

This is a requirement for using DDW on devices in which hypervisor
allows only one DMA window.

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
Tested-by: David Dai <zdai@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 73 +++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4e33147825cc..e4198700ed1a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1066,6 +1066,38 @@ static phys_addr_t ddw_memory_hotplug_max(void)
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
+	u32 cfg_addr, reset_dma_win;
+	u64 buid;
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	ret = ddw_read_ext(par_dn, DDW_EXT_RESET_DMA_WIN, &reset_dma_win);
+	if (ret)
+		return;
+
+	dn = pci_device_to_OF_node(dev);
+	pdn = PCI_DN(dn);
+	buid = pdn->phb->buid;
+	cfg_addr = (pdn->busno << 16) | (pdn->devfn << 8);
+
+	ret = rtas_call(reset_dma_win, 3, 1, NULL, cfg_addr, BUID_HI(buid),
+			BUID_LO(buid));
+	if (ret)
+		dev_info(&dev->dev,
+			 "ibm,reset-pe-dma-windows(%x) %x %x %x returned %d ",
+			 reset_dma_win, cfg_addr, BUID_HI(buid), BUID_LO(buid),
+			 ret);
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1090,6 +1122,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
 	struct failed_ddw_pdn *fpdn;
+	bool default_win_removed = false;
 
 	mutex_lock(&direct_window_init_mutex);
 
@@ -1133,14 +1166,38 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
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
+		struct property *default_win;
+		int reset_win_ext;
+
+		default_win = of_find_property(pdn, "ibm,dma-window", NULL);
+		if (!default_win)
+			goto out_failed;
+
+		reset_win_ext = ddw_read_ext(pdn, DDW_EXT_RESET_DMA_WIN, NULL);
+		if (reset_win_ext)
+			goto out_failed;
+
+		remove_dma_window(pdn, ddw_avail, default_win);
+		default_win_removed = true;
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
 	if (query.page_size & 4) {
 		page_shift = 24; /* 16MB */
@@ -1231,6 +1288,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	kfree(win64);
 
 out_failed:
+	if (default_win_removed)
+		reset_dma_window(dev, pdn);
 
 	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
 	if (!fpdn)
-- 
2.25.4

