Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E839C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6816720771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3CfCBJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgFSFHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFSFHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:07:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32306C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so7924098qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZWHywc52cviZOQW6ek0RtSh6QP+MlDxWWlDIcWpXS0=;
        b=m3CfCBJp02nLZBDTRsA/5HYP8t2gdeC/WNGp1nYgNuA1eP5A9Vzj0JMCEdZdcdD9dW
         qVbwUWrjTugynkvqr3rBx9HbMjLy2NxJzl9ndaj2AHkn9fPZF7xaeF1fAlniP03nWZT4
         xIwQpa+X5CoZcf3Uv8URzgvT02fX4hsgU1sBWFCtuhFyQej6HqUfAM8pUiba4oElKDW4
         WEVkmIBcwgPh6OB9rqLXkZMuTU3lAKg4+GXaiDLqICfx3Lf6NWtA1dDGAuQg83aOAsIh
         R5+Pea4XRYhaBG+d6TUmKfXJrtCdeWOgUo5nLYExFP6nWg75ibsVsf9hW9utwswQfBdh
         Y+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZWHywc52cviZOQW6ek0RtSh6QP+MlDxWWlDIcWpXS0=;
        b=FhB32483KmnU3A7xy0he3U3pPHGMu0cabKkSrVxLk0gxAEdO+gyRaoVU5YS/kwCagj
         mT1lw+tHoASXYwYzxwH8l2dLKV+0rx1BxhzGjPtL4lPDTe5j7jPQrUJYhBW6KMc6sxEY
         SlKR1CJ/425SMywx3rKAaxrmnQ/SVzZK6GEZipIBaMIKdTd3scvxOjSkm7GsJtxjiz03
         NS1uFn8wlACrkIf2odk1oA5wlQUbB0Oej+vv7ZwffU8l1thSUihxxRxH27EgbDDJ/4TU
         u2a92VMtjcfhwz3QqugUpL+/H+nQxXyR8MGvB7vfSvcHNjg5LuS7GKm/aLAQ2zd7rxH0
         wUtA==
X-Gm-Message-State: AOAM530eZLGuTjDT7VgAR1WGcQhiKSaywgSSkB71g4uSeYwsnBAWi+ww
        zaeWltiePqriQgtuVDIygEo=
X-Google-Smtp-Source: ABdhPJxDgz6Dn9Cou/Too189l+3G7fnOB9PvggY/UzExeYsNdqY2JbNlgA13FI2VibV8+nzgsAEx8w==
X-Received: by 2002:a37:f505:: with SMTP id l5mr1819705qkk.118.1592543251507;
        Thu, 18 Jun 2020 22:07:31 -0700 (PDT)
Received: from LeoBras.ibmuc.com (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id o6sm5235503qtd.59.2020.06.18.22.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 22:07:30 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] powerpc/pseries/iommu: Implement ibm,reset-pe-dma-windows rtas call
Date:   Fri, 19 Jun 2020 02:06:18 -0300
Message-Id: <20200619050619.266888-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619050619.266888-1-leobras.c@gmail.com>
References: <20200619050619.266888-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms supporting the DDW option starting with LoPAR level 2.7 implement
ibm,ddw-extensions. The first extension available (index 2) carries the
token for ibm,reset-pe-dma-windows rtas call, which is used to restore
the default DMA window for a device, if it has been deleted.

It does so by resetting the TCE table allocation for the PE to it's
boot time value, available in "ibm,dma-window" device tree node.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e5a617738c8b..5e1fbc176a37 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1012,6 +1012,39 @@ static phys_addr_t ddw_memory_hotplug_max(void)
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
+	u32 cfg_addr, ddw_ext[3];
+	u64 buid;
+	struct device_node *dn;
+	struct pci_dn *pdn;
+
+	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
+					 &ddw_ext[0], 3);
+	if (ret)
+		return;
+
+	dn = pci_device_to_OF_node(dev);
+	pdn = PCI_DN(dn);
+	buid = pdn->phb->buid;
+	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
+
+	ret = rtas_call(ddw_ext[1], 3, 1, NULL, cfg_addr,
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
-- 
2.25.4

