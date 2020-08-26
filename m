Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AFC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBE208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ORnFGTdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHZGf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:35:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37654 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHZGfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:35:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826063529euoutp01312cd6b672ce0fc960dc489cf37a0302~uvemxZ8r61717417174euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:35:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826063529euoutp01312cd6b672ce0fc960dc489cf37a0302~uvemxZ8r61717417174euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598423729;
        bh=vZSAZeP1Vfei8y043wYFoDE1kQ/3ClUQGnSPIgb7rlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ORnFGTdtkaU0Wnni3NhcP9Iyn9vPZhuMHsqY8uOTbg13hLoCrr+hUvdBA1XLkytw9
         7uKn5k8weYkfxJZF2yWfCjIZExBYk3xpdLD3KZIMSzlql6YZBD9kCCFWvFwDFMjbfW
         ydhRSE1x2Q8YB2uPk0/nHracDoYUTbt/lyS8PWQA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826063528eucas1p289c656f3ef14d247c6b181df73e16488~uvemdgP310402804028eucas1p2a;
        Wed, 26 Aug 2020 06:35:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.4D.06318.0B2064F5; Wed, 26
        Aug 2020 07:35:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826063528eucas1p1502c849c0fd337245541e1b31352d87f~uvemGl-s61803218032eucas1p19;
        Wed, 26 Aug 2020 06:35:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826063528eusmtrp1bfb6b96be83a09b2e38717a14e7948a0~uvemF5n7K1091110911eusmtrp1D;
        Wed, 26 Aug 2020 06:35:28 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-ca-5f4602b04aeb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.C0.06314.0B2064F5; Wed, 26
        Aug 2020 07:35:28 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200826063527eusmtip28ab83232986f8ae1bda3d490ae7fca75~uveldpj100092600926eusmtip28;
        Wed, 26 Aug 2020 06:35:27 +0000 (GMT)
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
Subject: [PATCH v9 02/32] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
Date:   Wed, 26 Aug 2020 08:32:46 +0200
Message-Id: <20200826063316.23486-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSazBUYRieb8/FWVlzLMY320V2Kl3JaJozbl2G5vSniybNmCltnDBY2nVJ
        KkrEumW32KExm9lJsS65ZYRYamlDE5ntQsSMS6RymdEYsg7173mf93m+533f+QiE34oJiGBx
        JCMRi0KFuCla+3qhe18F55jf/tr7e6iMrg4O9UxZjlHLtdkI1Ts3jVNPS15xKNVLV2q2d4hD
        VQ73YVRP/UOcKm3rN6Ee/apBqeTUxxjV8nMEo6ons7HD5rSmQAPoxnkVSlcWp+L08/lBjC7o
        OE1/TdNx6Cp1PP15aRihFYYiQL/4mIDTmdXFgK7Sx9EzlVtO8XxN3QKY0OBoRuLocdE0KGUq
        B4m4Y3VVU5CMJYA0Uga4BCQPQPXdFEQGTAk++QTAH1WNQAaIlWIWwD57lp8BUN0ygK8b8rU5
        gG0UAdhg0K0VK4aEoiVgVOGkE5RNyVYdVmQSgO0ZZkYRQqoQuDCTvCqyJP2hQj6NGjFKboep
        C32YEfNId9giH+OwcbawpKIZMWIu6QF1aVm48SFIfjKBGUmFazN5wrKaXoTFlnBCV23C4k1Q
        r0hHWUMigENdpSZskQ5gz20lYFWu8EvXH9y4NULuguX1jix9BI5rMlePAUlzaJiyMNLICpTX
        5iIszYMpyXxWvQPm6cr+xba8e782Dg07DTUoe6FsAAcm2pF7wDbvf5gKgGJgw0RJwwIZqbOY
        iXGQisKkUeJAB//wsEqw8rX0S7q5OtC0eEkLSAIIzXgq3MuPj4mipbFhWgAJRGjFO9qpv8Dn
        BYhirzGScD9JVCgj1YKNBCq04TkXjp/nk4GiSCaEYSIYyXqXQ3AFCcAr1yzI+6Ru9PLI4siH
        eR/Uhm9v5/Ltutw6MTQu2utN7i3rrfWGyenjTQf73B8MdlekLmUFv80ztxid8Dk3GrxT3aqo
        HzzLnbyxLDfLsdsWouCo93JjfMTfN58xDDJjJ/J9vd0afl9xaW7LnBZ06TcQ0TfTC5TK/kMC
        T0FdfFt/thCVBomcdiMSqegvl4MralYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7obmNziDRa1iVr0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xcKPW1ks2jqXsVoc
        /PCE1WLLm4msDnwea+atYfTY+20Bi8emVZ1sHtu/PWD1mHcy0ON+93Emj81L6j1u/3vM7DH5
        xnJGj903G9g8+rasYvTYfLra4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj
        81grI1MlfTublNSczLLUIn27BL2MjrfTmAtaRCrWzGtjbWDsFuhi5OSQEDCRmH1oGmMXIxeH
        kMBSRoneW29ZIBIyEienNbBC2MISf651sUEUfWKUePTrIhtIgk3AUKLrLURCRKCTUWJa90d2
        EIdZYAWzxKt9c8FGCQskShz58JQRxGYRUJXo/HkNbCyvgK3EwUkvmCBWyEus3nCAGcTmFLCT
        ON7dD7ZBCKjm9NoZzBMY+RYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjKNtx35u3sF4
        aWPwIUYBDkYlHt4FbK7xQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAp0
        1ERmKdHkfGCM55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYJy0
        qGBZ+hm19NNnWmu/Ln18PN3R/XDs6qxHDJyJEY73amXqdm9+FD/vuMvNs31m3W5/AyR9NBY8
        ZLkp1GZr+XT1FIPzgdfesH1RzHr8bt3RFO2sCTM26Xt0tGQH3az+taEh3VEyfsok/kfec1vy
        Lz08dqFvo/RUXq59czXjsqcwcjYvlVvzLE+JpTgj0VCLuag4EQBU2Jh7uQIAAA==
X-CMS-MailID: 20200826063528eucas1p1502c849c0fd337245541e1b31352d87f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826063528eucas1p1502c849c0fd337245541e1b31352d87f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063528eucas1p1502c849c0fd337245541e1b31352d87f
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
        <CGME20200826063528eucas1p1502c849c0fd337245541e1b31352d87f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the current hand-crafted code for extracting pages and DMA
addresses from the given scatterlist by the much more robust
code based on the generic scatterlist iterators and recently
introduced sg_table-based wrappers. The resulting code is simple and
easy to understand, so the comment describing the old code is no
longer needed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 4ed5ed1f078c..5d181bf60a44 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -990,45 +990,26 @@ EXPORT_SYMBOL(drm_gem_prime_import);
 int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
 				     dma_addr_t *addrs, int max_entries)
 {
-	unsigned count;
-	struct scatterlist *sg;
-	struct page *page;
-	u32 page_len, page_index;
-	dma_addr_t addr;
-	u32 dma_len, dma_index;
-
-	/*
-	 * Scatterlist elements contains both pages and DMA addresses, but
-	 * one shoud not assume 1:1 relation between them. The sg->length is
-	 * the size of the physical memory chunk described by the sg->page,
-	 * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
-	 * described by the sg_dma_address(sg).
-	 */
-	page_index = 0;
-	dma_index = 0;
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
-		page_len = sg->length;
-		page = sg_page(sg);
-		dma_len = sg_dma_len(sg);
-		addr = sg_dma_address(sg);
-
-		while (pages && page_len > 0) {
-			if (WARN_ON(page_index >= max_entries))
+	struct sg_dma_page_iter dma_iter;
+	struct sg_page_iter page_iter;
+	struct page **p = pages;
+	dma_addr_t *a = addrs;
+
+	if (pages) {
+		for_each_sgtable_page(sgt, &page_iter, 0) {
+			if (p - pages >= max_entries)
 				return -1;
-			pages[page_index] = page;
-			page++;
-			page_len -= PAGE_SIZE;
-			page_index++;
+			*p++ = sg_page_iter_page(&page_iter);
 		}
-		while (addrs && dma_len > 0) {
-			if (WARN_ON(dma_index >= max_entries))
+	}
+	if (addrs) {
+		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
+			if (a - addrs >= max_entries)
 				return -1;
-			addrs[dma_index] = addr;
-			addr += PAGE_SIZE;
-			dma_len -= PAGE_SIZE;
-			dma_index++;
+			*a++ = sg_page_iter_dma_address(&dma_iter);
 		}
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
-- 
2.17.1

