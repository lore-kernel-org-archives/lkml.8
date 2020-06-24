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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC16C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B9720768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnIaqCxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbgFXGYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbgFXGYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so887992qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N10+Pl+gOu4SRdVCuPEwIFjCanYEHvINmOUco6mnksM=;
        b=PnIaqCxbQhnFAmJ4SHRKyyXB3hXczKTrf+1hinuFIOaCleQEnhfbAoz1on6TOAbXsZ
         LRI7LFZj5eJIlJwL7gnzlu7t6b5KG7bJOLp7oQGRB6mXiahgt43va5x/3xLImJf6Odg0
         j3ey5JKaHxbk3sjtdci+KWcdFb5jL0UoeBGaIvU3+A+OkDLhR3TLrOVLRrcRaisc0M94
         fbJHxnTVuON0goVl25TLFsmkSBGI4f59s14Y0raqEflqEiqAeK6HhQGxK+lKWTYY9qQb
         TL7GOWQ87GoGhID9oHQHk3wxZyJJqAkc1CYhLCWvEF+jC3gMCY2Bia4j7YZ3Y9/ERU/y
         Tgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N10+Pl+gOu4SRdVCuPEwIFjCanYEHvINmOUco6mnksM=;
        b=WT5+om1bwb749wZ8mjbG+/xiqpmX3zZz93yZKj5v7Z5oZlSKgUj1CFiuQh7nIFwgql
         d/8UyLC56GBKiJkqz5GpwgvqtIxsFsP2tBE1YMLacif4BOcbqGD7LW0IhhOyv0a/8lTS
         OTSNofNlyvGpfyLy5SU7blO0DUdOgp2XT+BIrWTn6d7fW2++LFrXqh1bipq+M6Ow/yNj
         xL8xVL7tq1wT7qW5UbkNq5PLc3soplzTS7DdK/j8uFwTBnJuLWc/j0m1QrtqMUjpdPK3
         BTt4TM4lJ9n98jKbkhFkCiTG+x5gt88XasREd0Y3Ra/cmxItB6813Jg2gCmYCqYsELPY
         lumQ==
X-Gm-Message-State: AOAM532vYvgRo1LuPujp4w67nwTCR70GhDLwHuNY9HsiSz3sDLvyLS4e
        4zc0TFh+Cy3meRx8EoenAZY=
X-Google-Smtp-Source: ABdhPJwxoT0vKhWBynRYyaDEfIsChaZUQLTNLN1fuHnEAOSZkkIRfg9zum2U1I9g7O/w+XwSq3L25Q==
X-Received: by 2002:a37:4c0d:: with SMTP id z13mr12702783qka.170.1592979874849;
        Tue, 23 Jun 2020 23:24:34 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:34 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] powerpc/pseries/iommu: Move window-removing part of remove_ddw into remove_dma_window
Date:   Wed, 24 Jun 2020 03:24:08 -0300
Message-Id: <20200624062411.367796-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
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
index 558e5441c355..a8840d9e1c35 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -776,25 +776,14 @@ static int __init disable_ddw_setup(char *str)
 
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
@@ -816,10 +805,30 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
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

