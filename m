Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A225C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D99206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjdZried"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIDElZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDElY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:41:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C2C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rw2SpJXmuuSf2V4HQI7ewnL26HiqL3Q6q6BfzMSHMoo=; b=VjdZriedxbMRubWGqXJhVsayF4
        CAqnuOxmGdoAmDy4h0pJ+oMpMO+2K5E8eUlW8miqHwQ6DvsGxdR2KPChmx8Spga/5rS/VMtx1pxXe
        BThZPNUkZm2GlCknYa3BdXRKw8yGg4BalTtpBCkeOjYZaPL8NxugrCq7rNYFLKvcytMHHYo0JSUwS
        FTmCvHTzwC3ddI7HpDli4t1qln9M8dJHCt/yxcF+nrJ8a2EjTimPA/aMklJplPHrmeSqrnEXJtMMj
        x9KZET7zwVvzjJB13mRuZtTi2AVKft6as+qhXnSiPCTFzQo15Y2oOAHnGoVWKqdQgA1cAbmnWEKa7
        94eLmA8Q==;
Received: from [2601:1c0:6280:3f0::351]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE3XE-0001PW-GT; Fri, 04 Sep 2020 04:41:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: xlnx: fix build warning & errors when DMADEVICES is not
 set
Message-ID: <1f7bdabb-e28b-2cc1-5fbd-92c381299ba9@infradead.org>
Date:   Thu, 3 Sep 2020 21:41:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warnings & build errors caused by DRM_ZYNQMP_DPSUB.

Any driver that selects DMA_ENGINE should make sure that
DMADEVICES is already enabled.
As is, this causes build errors in many other drivers.

See https://lore.kernel.org/lkml/202009020239.oUPh82Xc%25lkp@intel.com/
for the numerous build errors.

WARNING: unmet direct dependencies detected for DMA_ENGINE
  Depends on [n]: DMADEVICES [=n]
  Selected by [y]:
  - DRM_ZYNQMP_DPSUB [=y] && HAS_IOMEM [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && COMMON_CLK [=y] && DRM [=y] && OF [=y]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/xlnx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200903.orig/drivers/gpu/drm/xlnx/Kconfig
+++ linux-next-20200903/drivers/gpu/drm/xlnx/Kconfig
@@ -2,6 +2,7 @@ config DRM_ZYNQMP_DPSUB
 	tristate "ZynqMP DisplayPort Controller Driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on COMMON_CLK && DRM && OF
+	depends on DMADEVICES
 	select DMA_ENGINE
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER

