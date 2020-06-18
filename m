Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34750C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC90208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592507774;
	bh=GKvyYGsgx2yaXPftx75dKRpr9bN/B2GO4AJDXtGC5gg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T8iQ0Nr4ZRJcgzU9O3knoMCqvr5QiBO8KmQztcuB08zvUHrkGfjWfDFENLGGcoDOR
	 id6SsM95c3gXMXd7xXJuQUxIbQ37RYvZfpYQy0AHy6/sNOLI3po65yMLkFBIi7Nxlj
	 JtgSnJN+ebiJ0iPuaguvA+wjUDboWTJQLteQrg6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFRTQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgFRTQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:16:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477BE207E8;
        Thu, 18 Jun 2020 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592507771;
        bh=GKvyYGsgx2yaXPftx75dKRpr9bN/B2GO4AJDXtGC5gg=;
        h=Date:From:To:Cc:Subject:From;
        b=uI3teB5B/fXNlwUMuCmt7oZL7V2rKZwgv11rCamXcgA0gCjDvXhESWovaTch6TRyT
         0SDa+oC2QyKAEFlS1klmR2RJsRA8hPrZ5TCWMyseoGh7+u3pnZgi6CMRypr2/Yx33V
         w64cO+I4FyeMU2oMFEzN1g46KH21YejZhgC/Zm3A=
Date:   Thu, 18 Jun 2020 14:21:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] vfio/type1: Use struct_size() helper
Message-ID: <20200618192134.GA30734@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5e556ac9102a..b7e71e10a169 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2493,7 +2493,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 		return 0;
 	}
 
-	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
+	size = struct_size(cap_iovas, iova_ranges, iovas);
 
 	cap_iovas = kzalloc(size, GFP_KERNEL);
 	if (!cap_iovas)
-- 
2.27.0

