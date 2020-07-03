Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07812C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B4A204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPPVhUdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGCGUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:20:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97ABC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:20:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so27932057qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXuvSewgZzGQToJSuOXn5GH8wcApBjTtF70wFJu0qAc=;
        b=fPPVhUdpY1M9DbysIaIXL23XoeWqWNbUIJJdsAw+dVE2uhOXL6oGxhvObrJYJUaEoU
         h2XnVBwNwdVM6ZvENmdI7EMo/B91TjXOBK1ypWF6rC0rvFealR2/FIq5bgJ+ioCu1HoN
         IMABQTarVBT93UKjySO1f8rVjQ2JUWqHxw6OqTlzdSRvpl0dpZczI0PkbsSs6iBnHMD6
         JRecBvN+y+wl24G+4heFYchW8GWxEc4McwX+rA1qY0C/aAHrlukUyuLnl2arz+zU6H8u
         bnHFOg1YrvWl64oyTLH6pKzeFotJt3/9i0kdFRQO4Rn4iC4mJoCA3XG2hejqcCXmhDSr
         kemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXuvSewgZzGQToJSuOXn5GH8wcApBjTtF70wFJu0qAc=;
        b=NSgYZUtIJsGQPG4ufdNEjBRgQG524yVII3Ajj0N9GWBqdH/KhKkhDZsMFlSkFKlPDo
         JgTJhB+y5PgPkArMVJuz+CjF5nicI+vDhhoBhbXTgJb6G3to9qPvK1kANBimrZ3WHJgo
         vvDy6s8qdxypUrEa0trLfKAK0M5htQLLhcQMQ/nkRX4C3p5u21yg1f6D+qVf/r+VDR6n
         i++vK8dht6W8EzUKuG5E9wGdtiTAaZT+6c2neUCbKLuCx+3TVzo3DXlLQPYkS8Rcejmy
         dFFlsw+ll27qORbBr1tEMhXChkJGY4ZGLiJqumTrgDjhOX+qWazwTWnDYKfHIsFo9CoW
         NKSA==
X-Gm-Message-State: AOAM533wEnO5JgV5qa3xBPWOx08meLGgvUSE49oRnuQsSS6TLYjqe/TT
        boB0kfyRxD04M6VSbY0v7EY=
X-Google-Smtp-Source: ABdhPJz9/pHgqjuttvL+DI0gX6GQ9OGCp4TgP29zV7EXLqJaTpdw/wzKHtFVCQI/uJqRgvK4BpPSQA==
X-Received: by 2002:ae9:ea13:: with SMTP id f19mr27890229qkg.331.1593757208178;
        Thu, 02 Jul 2020 23:20:08 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id n28sm11165288qtf.8.2020.07.02.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:20:07 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] powerpc/pseries/iommu: Move window-removing part of remove_ddw into remove_dma_window
Date:   Fri,  3 Jul 2020 03:18:41 -0300
Message-Id: <20200703061844.111865-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703061844.111865-1-leobras.c@gmail.com>
References: <20200703061844.111865-1-leobras.c@gmail.com>
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

