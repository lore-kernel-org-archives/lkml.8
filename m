Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB87C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 05:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3D32068E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 05:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8QrbHkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFNFyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 01:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgFNFyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 01:54:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057AFC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:54:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o84so16657671ybg.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=otdX70bz2YIi8N5w4rKF0s6D9LcxXuBVYPPx+zpGPno=;
        b=C8QrbHkBy6a8AJ+AlBLdblPvmdd6cdbCl6/dXQfGJBCYmaEhOfoq7YrkgeeRZzz/c8
         RanA2Ail3Hwu8/xw12exkyofWZybBZI9IBEcc9OJM8x67lWkxsMYIEx/NsHtRfqCbe8j
         mlZtT2r/ia2x+6XAFmXE4OGEZG+aghV4NauThpFTlUr3pOwOkA5aYdJtyLJLNKYC+eZq
         EotCsfpaXiICE1er5NL/Uyl96va0v1l4hZK2lctTHA770c6f9Sywa08+FtagatAM42A+
         /wsgK2ZdhfEOdP2F2EHF4JGGm+viPoI8fZtQsj1ACsBfRjLukp7J3xXZWau5ZQK6Mu5Y
         TQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=otdX70bz2YIi8N5w4rKF0s6D9LcxXuBVYPPx+zpGPno=;
        b=T2kBIxc+elY90FYOZChXcAkfXy05pInkjLZlHCVxyIoYuxgsydm75VgR+rixUJgyRH
         BP4NKFhX777r3C67oKJV8nZOzXzIPzxpsQpzbA/A0mkBkcVl00wk0LAXky6LPSuKUNpQ
         9r6Xke4tAGO3ahw0sDDn4nCL3fVfEwvLRtatnneTIkntnE44yYcMjLwXcdBBCEvtLY+6
         eddgPfQnIckT//iRJozF4CwoRkaCuGI9rNx1bFgCuHP4ZoFSi1Yp0do5zJu0HgSz/cJH
         NH/pOqe8GYCp2x7I/iu0w0VPiGmSwwgYrv7tKJRUNuSUNb8E1U/6xFBHjN2v3udWlzex
         LUBQ==
X-Gm-Message-State: AOAM533HkwG3k7yT3Z3bJszllrGQqrval/WiQR2NSzhNbZOQuG4/JSks
        9+TKTsBtG3OjvyAbNydfj4m5nLoOC1rr
X-Google-Smtp-Source: ABdhPJyOLly4XuglNWi7b9HgglmYKgBk4jq2k9V8yBsUa6I6YUUAZG3V5TvZRcuw2m2Nk5Xg7lRSUPIuzeuD
X-Received: by 2002:a5b:942:: with SMTP id x2mr27173587ybq.273.1592114060922;
 Sat, 13 Jun 2020 22:54:20 -0700 (PDT)
Date:   Sat, 13 Jun 2020 22:54:18 -0700
Message-Id: <20200614055418.33497-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] powerpc/powernv/pci: add ifdef to avoid dead code
From:   Greg Thelen <gthelen@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
CONFIG_IOMMU_API see:
  arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used

Add CONFIG_IOMMU_API ifdef guard to avoid dead code.

Fixes: dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE configuration")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 73a63efcf855..f7762052b7c4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1885,6 +1885,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 	return false;
 }
 
+#ifdef CONFIG_IOMMU_API
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1897,6 +1898,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
+#endif
 
 static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
 						     bool real_mode)
-- 
2.27.0.290.gba653c62da-goog

