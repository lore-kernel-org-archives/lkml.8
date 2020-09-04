Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2076C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AAF20684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Etf7a8Y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgIDODh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:03:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44936 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgIDNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133508euoutp01b3e9bd1ee54db5b2a0634da57d997193~xmAlH9ej10722107221euoutp01v
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133508euoutp01b3e9bd1ee54db5b2a0634da57d997193~xmAlH9ej10722107221euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226508;
        bh=y8XiqPQs8/1IzXK7H+MMTYb8kGMuWtVP33aXQuilFtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Etf7a8Y5FjKgDoLQNLsvt3x0NkfZ41pqpCz4DTjEgRigL8QlJnWW4/c4qc1QBdhTt
         6ioolpyjYGRMdx74udJwL2mbzvM6GmyXBSaIs+7IVFW5j6e1XS1Qk8/cCTFFpV/thq
         4OockXCrA/hinZvLJ5fPpDO9g9VMBHczREHG7xhY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200904133507eucas1p295c82eee7f3f5f66d185e12641b0be97~xmAkzCyXP0693606936eucas1p2V;
        Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.66.05997.B82425F5; Fri,  4
        Sep 2020 14:35:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133507eucas1p1d164b469647e3904da7f272413341e4c~xmAkgIgJA0116001160eucas1p14;
        Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133507eusmtrp2ab02774ebff16dbcbbecb63ac6c157f3~xmAkfTyF50977009770eusmtrp2V;
        Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-72-5f52428bb5c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.A0.06017.B82425F5; Fri,  4
        Sep 2020 14:35:07 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133507eusmtip148cedeecc0144c4e071b05b3336969ca~xmAj72YGi1939819398eusmtip17;
        Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v10 23/30] drm: host1x: fix common struct sg_table related
 issues
Date:   Fri,  4 Sep 2020 15:17:04 +0200
Message-Id: <20200904131711.12950-24-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvTPT6VCoDoXIDQgkTTDRRBbFOAaCSAxOeCIYl2AEC4xAWNMC
        Ai+iIkIpBDQG0hhANCK0bAVZ6tqqFEULyi6yCTEgEJBNUAJ2GJC37/znP/c/ObkEKmrk2RKR
        sQmMNFYSLcYFWEPLavuhbJ+AYNfJD8eoHON7hKotrOZRGw35KNW1NItT5ap3CFXyyoNa7BpF
        KM1YD4/q1N7HqaxFJU5Vvh3kU7q5cR61qi3CvIW0ukgN6BfLJRjdrBzk043LIzx6ONuA0HWP
        rtED62MofbevDNDP+tNwOre+AtALGgd/80CBZxgTHZnESF28Lgsi1P19aHyvXXL9whqSBu7t
        lQMzApLusDtvGmVZRD4BcEnvJAcCEy8CONzRhnPFAoB/MxTo9oR6ZRTjGmUAquTd+M7I9SyM
        deGkG5TPyHGWrclbALbmWLAmlPyOwKzez5tPWZFnoDa9F7CMkU4wu6lgUxeSXnB0Mh3n4hyh
        qub1pm5m0p8WjvPYhyDZwocvlTqMM52CzdU9W2wFfxrq+RzvgxvNxQg3cBPAUWMlnysUAHbe
        KAScywN+M/4xxRGm/Q7Aaq0LJ5+Ec49vY6wMyd2wb8aSlVET3mlgF2VlIczMEHHu/VBpqPof
        q+v4snUuGk61GlHuQvkAzg+t43nAUbkTVgJABbBhEmUx4YzscCxz1VkmiZElxoY7h8bFaIDp
        O7WtGxabgHYtRA9IAogthLtOBASLeJIkWUqMHkACFVsLfT61BYmEYZKUVEYaFyxNjGZkemBH
        YGIb4ZHSyUsiMlySwEQxTDwj3e4ihJltGqjAokKKpx+qzsenmQ/bT/T8mBB7lCncNVNf3U/v
        +bhRUDmr8Us2iNNhfEKgT5HxQq5DYb3OV4BQpW1H/Zdov9mhUKRFd7bWO6h9pTIqzzudiG5R
        1Kl5A/N1rliiZU1kVSZ1sVrhlFwed4Wa+OXbbf9An+qpfP7meNM5z5HfwWJMFiFxO4hKZZJ/
        XKXwiEoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rdTkHxBiduqlj0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs+j8MovNYu2Ru+wWBz88YbX4
        uWseiwOvx5p5axg99n5bwOKxc9Zddo/t3x6wetzvPs7ksXlJvcftf4+ZPSbfWM7osftmA5tH
        35ZVjB6fN8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSW
        pRbp2yXoZay5eYO54Lp0xZbPf5gaGKeKdTFyckgImEis+fGQpYuRi0NIYCmjxKdFS1khEjIS
        J6c1QNnCEn+udbFBFH1ilNh14jUjSIJNwFCi6y1EQkSgk1FiWvdHdhCHWeAVk8SHP61gVcIC
        gRLXp9xmArFZBFQlundMZwaxeQXsJB6+bGGDWCEvsXrDAbA4J1B864wnYKuFBGwlPsxZzDKB
        kW8BI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwGjZduznlh2MXe+CDzEKcDAq8fAy2AfF
        C7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQUROZpUST84GRnFcSb2hq
        aG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbHu0A2e9b2HO8Xljx259kXq
        jdq1MMmwjUZa8TwHRItVN+Xc6XZvux7S8lJZW06kVSBsOttVoVlr7/vX/Gi9JRtqsPG81yOd
        Z0ULf7d3ehmvPmCp/OVudvXfJSe8jaZ8nXyYV8Lx8c/txfLP/H6IcJxZJiwz51DGpkxBkT7/
        gnLXF0VvP17YdFqJpTgj0VCLuag4EQDLA0werAIAAA==
X-CMS-MailID: 20200904133507eucas1p1d164b469647e3904da7f272413341e4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133507eucas1p1d164b469647e3904da7f272413341e4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133507eucas1p1d164b469647e3904da7f272413341e4c
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133507eucas1p1d164b469647e3904da7f272413341e4c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/host1x/job.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 89b6c14b7392..82d0a60ba3f7 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -170,11 +170,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dev, sgt, dir, 0);
+			if (err)
 				goto unpin;
-			}
 
 			job->unpins[job->num_unpins].dev = dev;
 			job->unpins[job->num_unpins].dir = dir;
@@ -228,7 +226,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 		}
 
 		if (host->domain) {
-			for_each_sg(sgt->sgl, sg, sgt->nents, j)
+			for_each_sgtable_sg(sgt, sg, j)
 				gather_size += sg->length;
 			gather_size = iova_align(&host->iova, gather_size);
 
@@ -240,9 +238,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto put;
 			}
 
-			err = iommu_map_sg(host->domain,
+			err = iommu_map_sgtable(host->domain,
 					iova_dma_addr(&host->iova, alloc),
-					sgt->sgl, sgt->nents, IOMMU_READ);
+					sgt, IOMMU_READ);
 			if (err == 0) {
 				__free_iova(&host->iova, alloc);
 				err = -EINVAL;
@@ -252,12 +250,9 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 			job->unpins[job->num_unpins].size = gather_size;
 			phys_addr = iova_dma_addr(&host->iova, alloc);
 		} else if (sgt) {
-			err = dma_map_sg(host->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (!err) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(host->dev, sgt, DMA_TO_DEVICE, 0);
+			if (err)
 				goto put;
-			}
 
 			job->unpins[job->num_unpins].dir = DMA_TO_DEVICE;
 			job->unpins[job->num_unpins].dev = host->dev;
@@ -660,8 +655,7 @@ void host1x_job_unpin(struct host1x_job *job)
 		}
 
 		if (unpin->dev && sgt)
-			dma_unmap_sg(unpin->dev, sgt->sgl, sgt->nents,
-				     unpin->dir);
+			dma_unmap_sgtable(unpin->dev, sgt, unpin->dir, 0);
 
 		host1x_bo_unpin(dev, unpin->bo, sgt);
 		host1x_bo_put(unpin->bo);
-- 
2.17.1

