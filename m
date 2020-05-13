Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB6C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390AF221F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E6iAh7oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgEMNe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:34:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38237 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbgEMNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133320euoutp022dce1fa6b592b14f9ebaf8991fa7d0fc~Omcd-29AW3216632166euoutp02P
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200513133320euoutp022dce1fa6b592b14f9ebaf8991fa7d0fc~Omcd-29AW3216632166euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376800;
        bh=f33otPT6DOcOeLl0Wl3ABs4zD3ZmT52B/iGlsE1Ehiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6iAh7oJ0Ugdzmq5fH31Gk9nbdpLLrHS1hwIGRMrOPD0kEGaRIqxSE+BRP0V0xFSR
         FL70VDjrE48JYQvLq+qE9uGbu9tTfUKK5qWqRK744qZapqD2h6MPm9cNTxmOTUBj0v
         Cb+TMyeLykLcOnbFLp89XZkbQjadS2QDgScnVdf0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200513133320eucas1p238f7c2d468dcb4322b9908f86ae9b64b~Omcdi7sx22029120291eucas1p2l;
        Wed, 13 May 2020 13:33:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.D5.61286.027FBBE5; Wed, 13
        May 2020 14:33:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200513133319eucas1p2eaae7e606163ec1b211a07a80a52655d~OmcdJV3VD1009610096eucas1p2T;
        Wed, 13 May 2020 13:33:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133319eusmtrp1e9453a6aa118cc06986aae2b66588d44~OmcdIhu9s1050610506eusmtrp1a;
        Wed, 13 May 2020 13:33:19 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-79-5ebbf720de7a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.2A.08375.F17FBBE5; Wed, 13
        May 2020 14:33:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133318eusmtip1d8476743c7e5537dc0f4e87e16e8aa14~OmccMjpFT3222032220eusmtip1F;
        Wed, 13 May 2020 13:33:18 +0000 (GMT)
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
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org
Subject: [PATCH v5 31/38] staging: ion: remove dead code
Date:   Wed, 13 May 2020 15:32:38 +0200
Message-Id: <20200513133245.6408-31-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzH973fYw/Hr5P5LjZ2lk1bpbH5Wh5K/vhiw8ZfRhz9djVd5X6V
        aOOKM51EMhJxylN1uVS7rEupuENpJ+m5SPmjptKzorjrd/jv9Xm/P5/v+7PPviwhG6G82Iio
        WF4dpYiU066kyTLd4Ltiyhy6piudRpca3kjQ8OwnGj3NNFIoaWgl+m1KJ1BF/QyDmiaGaXQ2
        10ijvIJXEqSvCkQPNd4or+KHBI039UhQcW8zhT6U36ZR4csuBpkMGgpVf++j0NuuMQbpm2eY
        IE9sMpsobLhjAHg2e4TA3ZW1JH4+qSfxvdEJCnc2V9C4bPIzhauyDQz+dNEqwSX3z+COuV4C
        Z7Q+AtjcpqHxcOVHGqeV5oM9HvtdN4bxkRHxvNp/82HX8BT9CyrmizSh2mIiNWDITQdcWMit
        g8bKXqADrqyMewxgyeUUSizGAUy7NuJ0xgDsT71K/h1Jq81yGo8AbLFOMf9G3s0ZaUcXzQVA
        3aBunj05LYCvL7k7mggulYL9RUXzxiIOwaTZccrBJOcNpyztwMFSbhPUmeudccthQdELwsEu
        dn2gs8qpZ7MwZSJR5G1QW/gViLwIDlhLGZGXwbqMVNIRDLmzAPY0FDJikQrgh+RM50Qg7GyY
        sW/E2tdbDY3l/g6EXDCsuxAi4gLYOujhaCbseNV0gxBlKbxwXia+sQpmWZ/8S622NRIiY9hn
        bHIeqxZAS0opcwUsz/qfpQcgHyzh4wSVkhcCovgTfoJCJcRFKf2ORquKgf0j1s1ZR5+BicYj
        NYBjgdxditrNoTJKES+cVNUAyBJyT+kuo12ShilOnuLV0YfUcZG8UAOWsqR8iXRtTv9BGadU
        xPLHeD6GV/91JayLlwacm23VWrrdElQ2eY8v7jDezenYYlm8/nhS2233hSHKoV6P97s37Hzw
        9qdPVVnxDIptlBR7Hg3+VhlkO7V2w6/cvedkucp1W4cSk28l2ZaSY0f2uuSE27putuwIDjh9
        /eYBi0fbdtNd7XRWhFConV49OZieV98dmqE3eMf/yjQce75PTgrhigAfQi0o/gCt2DPrhAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7ry33fHGSx7qmbRe+4kk8X7v/fZ
        LDbOWM9q0fhO2eL/tonMFnvO/GK3uPL1PZtF8+L1bBYrVx9lsliw39piWYOqxco9P5gsvlx5
        yGSx6fE1VovLu+awWaw9cpfdYtuaBlaLgx+esFqcuvuZ3WLBtV/sDiIe23ZvY/VYM28No8ff
        uR+ZPe7tO8zisffbAhaPhZ++snrcubaHzWP7twesHvvnrmH3uN99nMlj85J6j9v/HjN7TL6x
        nNFj980GNo/3+66yefRtWcUYIBilZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5egl9G54ABrwSPeioPHtrE0ML7j7mLk5JAQMJHoOzyLsYuRi0NIYCmj
        xLyuN8wQCRmJk9MaWCFsYYk/17rYIIo+MUqsfX2QCSTBJmAo0fUWIiEi0MkoMa37IzuIwyww
        g1Vi3YF77CBVwgIWEo1/v4CNYhFQlfh+7BYjiM0rYCvRtfsMC8QKeYnVGw6AreYEir+6sx8s
        LiSQL7F38T62CYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG6LZjPzfvYLy0MfgQ
        owAHoxIPr8Wt3XFCrIllxZW5hxglOJiVRHj91gOFeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0
        OR+YPvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCqJfYtk3ie
        06H49L3fTsGqzR7/qi893jJ5WeiSjQ+8dJwa5p1Z9aha+bzFR3unq6XPW9v5/jod0emOb9JT
        bLvDrdKhbdW6lk3meOctk6Pv310v6Ox6+fg1+/WrK/4F1grOSVIw+6Y/ZX/qigCfVSfTNluW
        5MjO6Q08si1V9XA7/4Yyl7WMfWZKLMUZiYZazEXFiQAXpYPF5wIAAA==
X-CMS-MailID: 20200513133319eucas1p2eaae7e606163ec1b211a07a80a52655d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133319eucas1p2eaae7e606163ec1b211a07a80a52655d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133319eucas1p2eaae7e606163ec1b211a07a80a52655d
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133319eucas1p2eaae7e606163ec1b211a07a80a52655d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ion_heap_pages_zero() function is not used at all, so remove it to
simplify the ion_heap_sglist_zero() function later.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/staging/android/ion/ion.h      | 1 -
 drivers/staging/android/ion/ion_heap.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 74914a2..c199e88 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -177,7 +177,6 @@ struct ion_heap {
 int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 		      struct vm_area_struct *vma);
 int ion_heap_buffer_zero(struct ion_buffer *buffer);
-int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
 
 /**
  * ion_heap_init_shrinker
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 0755b11..9c23b23 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -145,15 +145,6 @@ int ion_heap_buffer_zero(struct ion_buffer *buffer)
 	return ion_heap_sglist_zero(table->sgl, table->nents, pgprot);
 }
 
-int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot)
-{
-	struct scatterlist sg;
-
-	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, size, 0);
-	return ion_heap_sglist_zero(&sg, 1, pgprot);
-}
-
 void ion_heap_freelist_add(struct ion_heap *heap, struct ion_buffer *buffer)
 {
 	spin_lock(&heap->free_lock);
-- 
1.9.1

