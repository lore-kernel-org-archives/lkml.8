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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A5120771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXHxk/1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgFSFHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgFSFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:07:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A2C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so7889644qkn.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4XvSLCXsG3KEJ31YG4hc0m/oIhqsd2EwdwB1kSl5Yo=;
        b=XXHxk/1GGLKtf9qg8q6h7tF7TiLwEHqMaphmitAiBQWxO8+CWRfXixxgxx8IqJbukb
         2mzbCY/tDkfsSdSwawvxWuTzS+Qn01CC2gcUh2ah/eYgo6bflvKen35Wuy/2TVT88UwJ
         sCdzQdM3iLo8Vnd/MZAOXL1v1PQMs3D346h2myQJQlyW0V44NxvujyJ/oGjCBRkoypX4
         zyuaSEvRbFSVdHlHaJWFE+wGGR4T9iHJQnqI9/4+DLJoIUZCtxSStGolrkQevKD20tTO
         aLRZH1F9Fg9Cy71g1CsTYHe/eevsA0GAkBjViksLxVQAukMMdciOKSibhwVXCLz5DdV0
         JKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4XvSLCXsG3KEJ31YG4hc0m/oIhqsd2EwdwB1kSl5Yo=;
        b=qF9uomQbLuqXUarGJUv1uWUp3Njv2uxiieSX85si7oElniWzuKu9lCjeJYhhdjr5qE
         NLgCROjsiHxp99OoeDm/SG7xgSGmR9GeLSLLIWBh9cVgOx3GE4e5rwj8KYHpHrEc5Ky6
         hOJnT1nPHnTfUE1eX1M5+A7F1QA4WLpjzdRp+YVX3Z73AlAKw8j5WFd5lPQIwmdcUl1q
         uT0ZrLyZx5FtIGS2M5B7FXDFg0g+cT6M40wpu9MEQXDt2/NW/7sUJ9N2srkET2CwX00e
         GDzGglPQepWb9OqsnAbnez/jEw9ZNYGJpimlV2iZu5Gkka/p0+w+VQKdClT8YnZY0iN0
         HE/A==
X-Gm-Message-State: AOAM533rAgOBH6z5wyj1LWi8Rvzb06xXxQx7PT6cDmDge04PJ0clJ4cl
        fMGbutFn+CpQ1QWBCuUX5LU=
X-Google-Smtp-Source: ABdhPJy/LZ/1+ZSPv6KSZiafpBMQw9OTc/8dwWFGA6ckWc4RWltAakdqfQ+qvGJvBbaHpLfeAuFF9Q==
X-Received: by 2002:a05:620a:4fa:: with SMTP id b26mr1868937qkh.63.1592543255204;
        Thu, 18 Jun 2020 22:07:35 -0700 (PDT)
Received: from LeoBras.ibmuc.com (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id o6sm5235503qtd.59.2020.06.18.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 22:07:34 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of remove_ddw into remove_dma_window
Date:   Fri, 19 Jun 2020 02:06:19 -0300
Message-Id: <20200619050619.266888-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619050619.266888-1-leobras.c@gmail.com>
References: <20200619050619.266888-1-leobras.c@gmail.com>
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
---
 arch/powerpc/platforms/pseries/iommu.c | 53 +++++++++++++++-----------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 5e1fbc176a37..de633f6ae093 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -767,25 +767,14 @@ static int __init disable_ddw_setup(char *str)
 
 early_param("disable_ddw", disable_ddw_setup);
 
-static void remove_ddw(struct device_node *np, bool remove_prop)
+static void remove_dma_window(struct device_node *pdn, u32 *ddw_avail,
+			      struct property *win)
 {
 	struct dynamic_dma_window_prop *dwp;
-	struct property *win64;
-	u32 ddw_avail[3];
 	u64 liobn;
-	int ret = 0;
-
-	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
-					 &ddw_avail[0], 3);
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
@@ -793,24 +782,44 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
 	if (ret)
 		pr_warn("%pOF failed to clear tces in window.\n",
-			np);
+			pdn);
 	else
 		pr_debug("%pOF successfully cleared tces in window.\n",
-			 np);
+			 pdn);
 
 	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
 	if (ret)
 		pr_warn("%pOF: failed to remove direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			pdn, ret, ddw_avail[2], liobn);
 	else
 		pr_debug("%pOF: successfully removed direct window: rtas returned "
 			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
-			np, ret, ddw_avail[2], liobn);
+			pdn, ret, ddw_avail[2], liobn);
+}
+
+static void remove_ddw(struct device_node *np, bool remove_prop)
+{
+	struct property *win;
+	u32 ddw_avail[3];
+	int ret = 0;
+
+	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
+					 &ddw_avail[0], 3);
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

