Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA1D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moptvi0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgFHIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgFHIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:30:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DFEC08C5C3;
        Mon,  8 Jun 2020 01:30:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so5703890pje.4;
        Mon, 08 Jun 2020 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sr4O+in7E3S8yGpfVSAumnolrH/mtR4MAGw7n2lSUi4=;
        b=moptvi0DYUIGze0sxGapOFQzHdn34hE207jfRTpbHONsJVGMYclaW933o/av3oG8CG
         Vuv/KoVfx1AI8AGmzrW5DacLpYSDCCa9nfxWdTJwyxWjNDMDYdnICwZh5brGMM8r1ZiT
         OAA9MmaR4rVNiQXY9uRhwIOejfHm/uYYEGMUMgw3dT+TwileefpJNWtOdCYsC45kFOLa
         +DdgPWAS2I6SbIwUspfrAqofBTLRIzBZ2JSR4vR9FnTaCKrDiB0a5aLiuiXW1FhyfV3s
         pIksOg51djhWhTBVsnrpqMjoUtQFLHvgFgzCkrqu48gxnjaStKkSDhCPxHkBhKTk8KyV
         HoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sr4O+in7E3S8yGpfVSAumnolrH/mtR4MAGw7n2lSUi4=;
        b=FgSV7+SI9RZBR30+2NkkJ4j4MDuLqdjRVnla3BUKj3KijUYs8EvKw4aVCfS9j2h/Oh
         5ViNJQUJ395/HbmcB4bp9wd2VUCo3+X93OTjoYGmZZnBYxZoWdXk9vT71NhBPOOeY1Hh
         cj8NisUXjawBICGxERXSpxmtAG/N0pZLzIXzmPr9izAU3BHG7LeDh6z7mRWKUy0eyUZ8
         wdK0dcmjwtLrmQncCi457gDuZ5y9Bx3MK7RiuN2NM5sWLJ59l2ejH0+MmUBawkuRvgjd
         cupCNtskmcB79FQfi9ymS1sfPc7HomxS9mtrwCAFPQ6+nY1oeFSg+62526PFzqJZhzcj
         Y8Mw==
X-Gm-Message-State: AOAM5320FtajFDXIAeBgolqjzvEN3424ywaiPFxAd1M8dx3dwk3BaEYy
        tBM4Z/EWq2jfZZQ2wvqAWM8=
X-Google-Smtp-Source: ABdhPJwWeNEIRHE87XqxZWvoMrcDW/ma0+wwzJWzdrh9mEH1xMwsnwgl+Nww/37mNzaxFJbgWrKhDw==
X-Received: by 2002:a17:90a:cc5:: with SMTP id 5mr15552855pjt.112.1591605050563;
        Mon, 08 Jun 2020 01:30:50 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.42])
        by smtp.gmail.com with ESMTPSA id 27sm1210829pjg.19.2020.06.08.01.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:30:50 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux@armlinux.org.uk,
        vladimir.murzin@arm.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device support reserved memory
Date:   Mon,  8 Jun 2020 16:30:38 +0800
Message-Id: <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Currently, we use dma direct to request coherent memory for driver on armv7m
platform if 'cacheid' is zero, but dma_direct_can_mmap() is return false,
dma_direct_mmap() return -ENXIO for CONFIG_MMU undefined platform.

so we have to back to use 'arm_nommu_dma_ops', add use_reserved_mem() to check
if device support global or device corherent memory. if yes, then call
set_dma_ops()

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/mm/dma-mapping-nommu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 287ef898a55e..e1c213fec152 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -14,6 +14,7 @@
 #include <asm/cacheflush.h>
 #include <asm/outercache.h>
 #include <asm/cp15.h>
+#include <linux/of.h>
 
 #include "dma.h"
 
@@ -188,6 +189,31 @@ const struct dma_map_ops arm_nommu_dma_ops = {
 };
 EXPORT_SYMBOL(arm_nommu_dma_ops);
 
+static bool use_reserved_mem(struct device *dev)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/reserved-memory/linux,dma");
+
+	if (np &&
+		of_device_is_compatible(np, "shared-dma-pool") &&
+		of_property_read_bool(np, "no-map") &&
+		of_property_read_bool(np, "linux,dma-default")) {
+		/* has global corherent mem support */
+		of_node_put(np);
+		return true;
+	}
+
+	np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (np) {
+		/* has dev corherent mem support */
+		of_node_put(np);
+		return true;
+	}
+
+	return false;
+}
+
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
@@ -206,6 +232,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
 	}
 
-	if (!dev->archdata.dma_coherent)
+	if (!dev->archdata.dma_coherent || use_reserved_mem(dev))
 		set_dma_ops(dev, &arm_nommu_dma_ops);
 }
-- 
2.7.4

