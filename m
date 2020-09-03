Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFAC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E42720709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="wecxpxww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgICUTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:19:46 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0546C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:19:45 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h1so1943205qvo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5xig/eTqVrazs7e7noSaKBykCte9+bRmMrk95HOd24=;
        b=wecxpxwwyD4RACE8f0yMWLaLTMryAoXTP9h88/wYvuUBUm80bCYV+6ZiYhUIbjqLLE
         TigkzxOwLmWyZ/1vLfLLeAUiFuE3vLPiKMLZ6eXOqmCbWjPH+w2xoknPPrzWsciA9a6A
         i7TwS1XR8fMZ4e5Wwqq22coetU+ufEPNJh+c9+cDIS1nKLMhVJmM2FzX60EbkuT2tsLK
         u5l0PPrGgVdnEFbXyWqzrlAWK4SzmshJ0qoyDZ1zJ2bGR6GJd9y7WgG3nMwPGLs+XQLL
         wkZ5sEExMHJfvjYDX2qFsm1ucLLrIf6ASBAaXrhD2kKAQUzmiapoZVvcJreUNP5GQw6p
         hWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5xig/eTqVrazs7e7noSaKBykCte9+bRmMrk95HOd24=;
        b=XIGZoS3kxEmE4CZZwecae9oIRk7TCJ93U23jgE0jwb6WfoFl4mZivbCEBOL7COV5xk
         LH7ke8wjbALyPkn9tnE51rsCS8VY9UiUPelaJACNsBz9+7YqvcHM11g5RDvT6oCsQIlk
         NzGNbS/w7kIbgm8wGc1ar9b/zjTd/RlTq+wVEokde65Gn7INJkYdtPQdOgwOXYij5Uj/
         ZraTqsKW5yFdfyKeKgZ/px44Z9dktkLNqPl10pXFAbR+W+Tle4K72PeVIGxDaM7yI0Lo
         p0XrGj6CtBgg9+BBIlxJk8sf1tuJOJJJnPeIeAMtxOKtTX5wqQRA+2pmmOddfdzZ+3fY
         VoEQ==
X-Gm-Message-State: AOAM532dX/NDOSwcFC81wzycgx6WmxByk2kqLj0AzYwpuUtJOOXN8Sks
        zS4qo2bA6VUlGRSD7dd+RJTH5Q==
X-Google-Smtp-Source: ABdhPJwiVInAfEsPvAgHLbKg3L1qPZ9rU80DohPCbod5K6Hz/NSBEO+ccupDTKR20VfP+qt2/IonUw==
X-Received: by 2002:a0c:dc90:: with SMTP id n16mr4670097qvk.168.1599164385283;
        Thu, 03 Sep 2020 13:19:45 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
        by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:19:44 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas function
Date:   Thu,  3 Sep 2020 21:18:34 +0100
Message-Id: <20200903201839.7327-3-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to dma-iommu ops

Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
use the dma-iommu ops to free cached cpu iovas.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 include/linux/dma-iommu.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f69dc9467d71..33f3f4f5edc5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -50,6 +50,15 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 };
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+
+	free_cpu_cached_iovas(cpu, iovad);
+}
+
 static void iommu_dma_entry_dtor(unsigned long data)
 {
 	struct page *freelist = (struct page *)data;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2112f21f73d8..316d22a4a860 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+		struct iommu_domain *domain);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.20.1

