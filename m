Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5400DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8262070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KgP6+/zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgFRPkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:40:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54540 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgFRPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154015euoutp011174f1d4fa41f20c3e7deb8bbf16323e~ZrZjbdA2v1845318453euoutp01n
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200618154015euoutp011174f1d4fa41f20c3e7deb8bbf16323e~ZrZjbdA2v1845318453euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494815;
        bh=W4NKiJ7uA8bl1MAJyGjdScNQkvl86q9xVFTZQgMq5p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgP6+/zg22/C7cB1UxkzN2OIZNfrzoJAizkLkZJ/zo+kZ9OPwF3K7SLtw8FURYBbg
         2uyZrkVoAIeyjGNtZUklDRo0JvIg+FKczSssYA2taTCY1PRwnMfHfL645rrzsooiAC
         ePrfHKzy2pbZ9iVEm+WtmZ40o1Wi3NA3EWzNdp3w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200618154014eucas1p1d5858721ceb67f05f442e556e60f66cb~ZrZjGWyPO1545815458eucas1p1G;
        Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.0F.61286.EDA8BEE5; Thu, 18
        Jun 2020 16:40:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de~ZrZi3la2C2603726037eucas1p1J;
        Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154014eusmtrp2b0aba09f053b39f98fb0cc065068ba6a~ZrZi27Ogw0370403704eusmtrp2X;
        Thu, 18 Jun 2020 15:40:14 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-b5-5eeb8adeecd1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.DE.08375.EDA8BEE5; Thu, 18
        Jun 2020 16:40:14 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154013eusmtip18a1a0a7ab10b25a1c4100d8648dc8cdf~ZrZiOVUuZ0701207012eusmtip15;
        Thu, 18 Jun 2020 15:40:13 +0000 (GMT)
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v6 01/36] drm: prime: add common helper to check scatterlist
 contiguity
Date:   Thu, 18 Jun 2020 17:39:22 +0200
Message-Id: <20200618153956.29558-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjuO2dnOw5npyn5oZawSCjwLnJAE2f9OCSh4Q/RyFp5mqKbsnkt
        KDE0nU4y89JQm2LezTaXlhHet2xppSZWXhL7kS3RvIws1DaP1r/nfS7v8/Hx4ii/F3PC46Up
        tEwqShSwuaxO/eao+6zCFOM1NO5PKkeHEVJT0Y6RO53FKDmxscwmm1qGEFLdE0CuT8wjpHZh
        EiPHuyvZZNvgDIes+fmURebm12Nk38pXjNT9KMaC7ajW6lZAvTSrWZS2OZ9NdZm/YFT18Hlq
        rsCAUB11t6jP2wsoVTLVAKgXH7PYVJGuGVAdxhvUmvZoOC+aGxhLJ8an0TLPoMvcuPrsLiRZ
        5ZzRlD2AZIGewwpgg0PCDw78GkAUgIvziUYATT2TqFXgE+sAtn1wZ4Q1ALUja9h+otTUgjJC
        A4CLVf17gyWh0uh3XWzCGyqWFGwrdiByAHyltLWaUEKNws21XGAV7IkoOP1o3RLAcRZxHK6a
        kqyQR5yC+Z03mTJX2PKkd/dFNkQQNBpyMOsaSExy4ODwfQ5jOgMLyrUIg+3hd4Nuj3eBO88f
        IkzgNoDzo20cZigEcDy7AjCuADg9+pttbUaJE7C925OhhVBjfrNLQ8IOTi0dstKoBd7rLEcZ
        mgfzcvmM2w2qDI//1fa9G9uzUFDR4Mh8aDGA32qT7wJX1f8qNQDNwJFOlUvEtNxbSqd7yEUS
        eapU7HE1SaIFlrsybhtWn4GNsSv9gMCBwJYXHGmK4WOiNHmmpB9AHBU48EJGjDF8Xqwo8zot
        S7okS02k5f3AGWcJHHm+tYsX+YRYlEIn0HQyLdtXEdzGKQu0C0OXA82zF3ziTHmavub3tVEl
        qoNYaGHZtZkVL2/PaZuwrQzoU5d8LN3P31zTeKBsqjVBGMjTva7W6DuKFv22qs/ySyPEd6bO
        neYIuJF+uj/RFS6hlW2fpBHr4o5W3G1OuOq65BFSN692bIwJO1L1IMPLSfBWqV721UvDlWkC
        ljxO5H0SlclFfwGpuhNOUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7r3ul7HGVycrW7Re+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgs/bmWxaOtcxmpx
        8MMTVostbyayOvB5rJm3htFj77cFLB6bVnWyeWz/9oDVY97JQI/73ceZPDYvqfe4/e8xs8fk
        G8sZPXbfbGDz6NuyitFj8+lqj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQyljVtZyqYJV2xsukwUwPjfrEuRk4OCQETiamvVzN3MXJx
        CAksZZS4cWgGK0RCRuLktAYoW1jiz7UuNoiiT4wSP9dMZQFJsAkYSnS9hUiICHQySkzr/sgO
        4jALrGCWeLVvLliVsEC4xN6nt4FsDg4WAVWJT6/zQUxeAVuJzm11EAvkJVZvOMAMYnMK2Emc
        Pt4KtlgIqOT5hza2CYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG0LZjPzfvYLy0
        MfgQowAHoxIP74uQ13FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCnTS
        RGYp0eR8YHznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgTCqo
        uLsg1XhO+OOlU25YVh8pVtzntrGyzJlt7+5/NS8W2HmflUuziNzUdXxVb+H0c2I/5y19t/en
        tEBQpOcK72W/atWlVMu1j/Snl+VNLi2Yo35piegVs2dV3r5qT750HF4eHv7i2GbTppM6Uzec
        Xflr7WlRJzOnO4++/nJdt20Ni3B+nKruCyWW4oxEQy3mouJEANmh6x+3AgAA
X-CMS-MailID: 20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154014eucas1p12812b08c65f53bb216f8ac8751a309de@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a common operation done by DRM drivers to check the contiguity
of the DMA-mapped buffer described by a scatterlist in the
sg_table object. Let's add a common helper for this operation.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 23 +++--------------------
 drivers/gpu/drm/drm_prime.c          | 26 ++++++++++++++++++++++++++
 include/drm/drm_prime.h              |  2 ++
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 06a5b9ee1fe0..41566a15dabd 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -471,26 +471,9 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
 {
 	struct drm_gem_cma_object *cma_obj;
 
-	if (sgt->nents != 1) {
-		/* check if the entries in the sg_table are contiguous */
-		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
-		struct scatterlist *s;
-		unsigned int i;
-
-		for_each_sg(sgt->sgl, s, sgt->nents, i) {
-			/*
-			 * sg_dma_address(s) is only valid for entries
-			 * that have sg_dma_len(s) != 0
-			 */
-			if (!sg_dma_len(s))
-				continue;
-
-			if (sg_dma_address(s) != next_addr)
-				return ERR_PTR(-EINVAL);
-
-			next_addr = sg_dma_address(s) + sg_dma_len(s);
-		}
-	}
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size)
+		return ERR_PTR(-EINVAL);
 
 	/* Create a CMA GEM buffer. */
 	cma_obj = __drm_gem_cma_create(dev, attach->dmabuf->size);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index bbfc713bfdc3..0784969894c1 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -825,6 +825,32 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
 }
 EXPORT_SYMBOL(drm_prime_pages_to_sg);
 
+/**
+ * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
+ * @sgt: sg_table describing the buffer to check
+ *
+ * This helper calculates the contiguous size in the DMA address space
+ * of the the buffer described by the provided sg_table.
+ *
+ * This is useful for implementing
+ * &drm_gem_object_funcs.gem_prime_import_sg_table.
+ */
+unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
+{
+	dma_addr_t expected = sg_dma_address(sgt->sgl);
+	struct sg_dma_page_iter dma_iter;
+	unsigned long size = 0;
+
+	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+		if (sg_page_iter_dma_address(&dma_iter) != expected)
+			break;
+		expected += PAGE_SIZE;
+		size += PAGE_SIZE;
+	}
+	return size;
+}
+EXPORT_SYMBOL(drm_prime_get_contiguous_size);
+
 /**
  * drm_gem_prime_export - helper library implementation of the export callback
  * @obj: GEM object to export
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index 9af7422b44cf..47ef11614627 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -92,6 +92,8 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
 struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 				     int flags);
 
+unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
+
 /* helper functions for importing */
 struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
 						struct dma_buf *dma_buf,
-- 
2.17.1

