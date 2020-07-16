Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B81C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B822067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcylmrG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGPHRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgGPHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:17:44 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:43 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a14so2268930qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXoTy1h4V7NJb4O+XXmTDMHlH/lLg962odT4Jny1J3o=;
        b=NcylmrG1390JPm0HVgxReAnsbpfxRFkncQoQ2+ihYB432hnVUkiUStvHlIqllyGsrF
         6lIlY/OOxjlCVZLGW4zY/UZf5vaymbGcVLPmqW4U4/QccME5iZacDg6z1jJlrz7PTe8G
         6tAdn4T+KTZX47/Gsxio13/Pw1P1+OLkKcG/vfSQs83xkMJfnXt6r/IATvuMCsVoZJ5O
         lNcVpkvrwKtrX3YBfWRoFHgW90jTcOxgGGmzXHWC8Ws3KJnJaLSCLMEeZ3Z+Rf5CKHAC
         nSXk7CSHUlCI94sBxJsAqk1T+WLJ4Hc5xbJHoX9onTqytSnas+uIcXqE0L9EuCZ3bRdI
         Bf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXoTy1h4V7NJb4O+XXmTDMHlH/lLg962odT4Jny1J3o=;
        b=lf6tX684MJwlh6GrErpdPpFbJnTm8UTXZ+mXbR0QhZDnPal3ZngRuuMY3VJk5xvcWL
         EO3nrWRMmZZxEWu98ToYvQ8FScpgb8vGGsBAFC+kkPK7BxqXuAd+7xblbBLbQ6JcgGaU
         jAMwszBTtnACXVhd4O+6CdfF/73zzE5LBqW7/VvqAP3wzjHWMYTI7cXCE5XHkhQyc7q7
         K+sp65zPLwSXM+zKmK5S7hIwdARFRlF89ejij9xWeFUM1TL9d1lW03fd6OVsLjW86q/p
         m5zlxVtba1UPfqkeJmcALR827nLqbDqSJtJgTu4fp8GYF47E1oj6kMUUvudrAF/GI9vd
         EJeg==
X-Gm-Message-State: AOAM531dO/rPBelTZ7cXAYOoy5kFuMskbAuh/CP8y3xBY9cIwtb/N1+x
        LQT6QK0D08okdL5/DZ/v5ro=
X-Google-Smtp-Source: ABdhPJxN6nicLFqpJlfCcP6jFOV7E5kTOM49yMkA9W5qvWRJir1dsdqIwPHNpUdpbMqzUWf6j1KvnA==
X-Received: by 2002:ad4:5511:: with SMTP id az17mr2954877qvb.159.1594883863178;
        Thu, 16 Jul 2020 00:17:43 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-239-31.dynamic.desktop.com.br. [200.236.239.31])
        by smtp.gmail.com with ESMTPSA id a5sm6637989qtd.84.2020.07.16.00.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:17:42 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] powerpc/pseries/iommu: Remove default DMA window before creating DDW
Date:   Thu, 16 Jul 2020 04:16:56 -0300
Message-Id: <20200716071658.467820-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716071658.467820-1-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
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
---
 arch/powerpc/platforms/pseries/iommu.c | 73 +++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4e33147825cc..fc8d0555e2e9 100644
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
+	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
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

