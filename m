Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F3D2495B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861957;
	bh=lHcDsf8DgDBNTZUBIkHebiPXdVo6277JtxAmbgo6gl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IK4dJlMtkockpnWcea0Am+Jez99f8aW84UbnOBg+WSDiEMoAqvZyll4f3jEnRXCUE
	 ZIXbYyoYLh+aYRtXKZP16vq66virff0+62cpPTnSfHtt0nIdwCRKeRi4XYhVyFTvqa
	 ZwJbx95ZzW2WcT3zGJWEHzGNzGFofXI0aKrj36Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgEGOcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgEGO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C8424953;
        Thu,  7 May 2020 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861787;
        bh=lHcDsf8DgDBNTZUBIkHebiPXdVo6277JtxAmbgo6gl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTBndM20TVRfu07yMP7ymb6Kjm7/Q3zi4Y6/Tgta+mnJG0C/1i0aLhPJ5LCi/sD/6
         mbHNH5A1S87W9Hz5+f4oovmwN00A0YI0acE1NJnuk1r1drW76XUF25N5OSAlpbecRX
         HQb7qxqYJ2ha23Te+4pbI6Q9X9Ed8oww0asouEcs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/16] vfio: avoid possible overflow in vfio_iommu_type1_pin_pages
Date:   Thu,  7 May 2020 10:29:30 -0400
Message-Id: <20200507142943.26848-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142943.26848-1-sashal@kernel.org>
References: <20200507142943.26848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

[ Upstream commit 0ea971f8dcd6dee78a9a30ea70227cf305f11ff7 ]

add parentheses to avoid possible vaddr overflow.

Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f77a9b3370b5f..690ae081eedc7 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -591,7 +591,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 			continue;
 		}
 
-		remote_vaddr = dma->vaddr + iova - dma->iova;
+		remote_vaddr = dma->vaddr + (iova - dma->iova);
 		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn[i],
 					     do_accounting);
 		if (ret)
-- 
2.20.1

