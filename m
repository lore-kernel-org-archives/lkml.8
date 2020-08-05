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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A52070A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2qN9dqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHEDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:05:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:05:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 6so32703588qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1QuQfa0AlBLlK+lh3SXPgl8VOAIvXOvZyydTehW8ec=;
        b=o2qN9dqvLp4T354UyM8u0kWQ7Uvuy3vmSsowvT/0MMculB6VqMhApKgSGyfpCtYG2M
         NhNoi0gXz883M9RAr0NnuidSwWwI+8xN4QlcUZqjEoyvcXT+q6YY3LG6KCCSAiJcx8ns
         B7YMHbyWt7I2G6SkjNczbtgYroHOApmihm0LMgD9J1aD9tMiDX5JNpsE1944BAXyuVJ5
         XB2bdcjruuXwppSSkOahNGGnmOcQeP4P3NoXtf1nNlPto6rGudq7bG70XFgg6ZgQl8+b
         ZhlihaGLN716kq4DkmAEEkgmSlS3RQq3b1aw/YQ4oqWwUsI2XGHWbLU+EuDcdUXT5tn4
         qsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1QuQfa0AlBLlK+lh3SXPgl8VOAIvXOvZyydTehW8ec=;
        b=JBJVNNyRx/B0AKWccrFA1w4LmyHCFMQ9ZWITiW97Gvx+83L7DrOgkOoHTywVcryTdz
         Wbr+/kht1Ja2fwjWEb7SISrBxTsPz1GC730djOpkHxYL4V6uM5HXUBvIBShkU0wWuwG6
         wuysmqdk+T2N8Fy7cdE7yvOC1x0o1tcc4nDPrzlkDCb3UGN9lQNbtA+Ps3l1SJJQbwsX
         iIzG0xf7dvHDdO3PR/m0ExayKapFt6NtgMzSTSAe4+wXtrA5lbIo32eGSw50px90raQI
         ISPhtzDMMli30kGju8u7uHWWK2IXRBOpbMgZaKEIZNa6C19H4Mjeo+Hpona0KU1VC5cq
         rsUA==
X-Gm-Message-State: AOAM531IsDd29U1xhqfHc5eaUUtvGvOBMFyYd7qV9QUsDzVhmRxKVt5a
        Pb+jH6s7Iq/uvXCdfCqWrNY=
X-Google-Smtp-Source: ABdhPJxarL3aPQiMgRMk8JODPnNh5wb3Bb4G09CsPOZAMdsyeMcw/hNTOILb64gKI1xr8dUFndQ29g==
X-Received: by 2002:aed:3b57:: with SMTP id q23mr1315880qte.150.1596596717840;
        Tue, 04 Aug 2020 20:05:17 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-154-168.dynamic.desktop.com.br. [179.125.154.168])
        by smtp.gmail.com with ESMTPSA id n4sm869946qtr.73.2020.08.04.20.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:05:17 -0700 (PDT)
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
Subject: [PATCH v5 3/4] powerpc/pseries/iommu: Move window-removing part of remove_ddw into remove_dma_window
Date:   Wed,  5 Aug 2020 00:04:54 -0300
Message-Id: <20200805030455.123024-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the window-removing part of remove_ddw into a new function
(remove_dma_window), so it can be used to remove other DMA windows.

It's useful for removing DMA windows that don't create DIRECT64_PROPNAME
property, like the default DMA window from the device, which uses
"ibm,dma-window".

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Tested-by: David Dai <zdai@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 45 +++++++++++++++-----------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 1a933c4e8bba..4e33147825cc 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -781,25 +781,14 @@ static int __init disable_ddw_setup(char *str)
 
 early_param("disable_ddw", disable_ddw_setup);
 
-static void remove_ddw(struct device_node *np, bool remove_prop)
+static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
+			      struct property *win)
 {
 	struct dynamic_dma_window_prop *dwp;
-	struct property *win64;
-	u32 ddw_avail[DDW_APPLICABLE_SIZE];
 	u64 liobn;
-	int ret = 0;
-
-	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
-					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
-
-	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
-	if (!win64)
-		return;
-
-	if (ret || win64->length < sizeof(*dwp))
-		goto delprop;
+	int ret;
 
-	dwp = win64->value;
+	dwp = win->value;
 	liobn = (u64)be32_to_cpu(dwp->liobn);
 
 	/* clear the whole window, note the arg is in kernel pages */
@@ -821,10 +810,30 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 		pr_debug("%pOF: successfully removed direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
 			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
+}
+
+static void remove_ddw(struct device_node *np, bool remove_prop)
+{
+	struct property *win;
+	u32 ddw_avail[DDW_APPLICABLE_SIZE];
+	int ret = 0;
+
+	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
+					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
+	if (ret)
+		return;
+
+	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
+	if (!win)
+		return;
+
+	if (win->length >= sizeof(struct dynamic_dma_window_prop))
+		remove_dma_window(np, ddw_avail, win);
+
+	if (!remove_prop)
+		return;
 
-delprop:
-	if (remove_prop)
-		ret = of_remove_property(np, win64);
+	ret = of_remove_property(np, win);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window property: %d\n",
 			np, ret);
-- 
2.25.4

