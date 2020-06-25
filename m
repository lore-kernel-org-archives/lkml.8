Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F9206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405026AbgFYNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404839AbgFYNIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:43 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26897C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:08:43 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B92BC44A; Thu, 25 Jun 2020 15:08:38 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 05/13] iommu/rockchip: Use dev_iommu_priv_get/set()
Date:   Thu, 25 Jun 2020 15:08:28 +0200
Message-Id: <20200625130836.1916-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Remove the use of dev->archdata.iommu and use the private per-device
pointer provided by IOMMU core code instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index d25c2486ca07..e5d86b7177de 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -836,7 +836,7 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
-	struct rk_iommudata *data = dev->archdata.iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
 
 	return data ? data->iommu : NULL;
 }
@@ -1059,7 +1059,7 @@ static struct iommu_device *rk_iommu_probe_device(struct device *dev)
 	struct rk_iommudata *data;
 	struct rk_iommu *iommu;
 
-	data = dev->archdata.iommu;
+	data = dev_iommu_priv_get(dev);
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
@@ -1073,7 +1073,7 @@ static struct iommu_device *rk_iommu_probe_device(struct device *dev)
 
 static void rk_iommu_release_device(struct device *dev)
 {
-	struct rk_iommudata *data = dev->archdata.iommu;
+	struct rk_iommudata *data = dev_iommu_priv_get(dev);
 
 	device_link_del(data->link);
 }
@@ -1100,7 +1100,7 @@ static int rk_iommu_of_xlate(struct device *dev,
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data->iommu = platform_get_drvdata(iommu_dev);
-	dev->archdata.iommu = data;
+	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
 
-- 
2.27.0

