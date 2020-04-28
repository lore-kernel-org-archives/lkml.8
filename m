Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE34C83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB593206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GECXSzpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgD1NUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:20:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53260 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgD1NUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132032euoutp01d5297d07e17e8f1257a4049be2d62e77~J-mATJgrm1886418864euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200428132032euoutp01d5297d07e17e8f1257a4049be2d62e77~J-mATJgrm1886418864euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080032;
        bh=sWfi/eXeyWZAcptEggs4GLn6EK344x01WE+j6NQeSm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GECXSzpytLZrGxP60k7cZV1AetQWGJb8Br+pR3aZAe5yAr3J8D4k1RS1quHeg2GL+
         SV78GPOiU8IagpyoB5YBm1s4ViM2GUbBkFpw2fsh1POlSzoC/SmmvW2pGfoGpgspTy
         iSsWMoBGtbvAKiIBlojOoAJrXKd7T+UyU0Gw+S40=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200428132031eucas1p252d16f0ce0fc7b2ccd0f94ab72572f19~J-l-3cww22652726527eucas1p2T;
        Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.B4.61286.F9D28AE5; Tue, 28
        Apr 2020 14:20:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200428132031eucas1p1e7a72bf0de5acea2af652cd8337a8ed5~J-l-h1s-X1362813628eucas1p1K;
        Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200428132031eusmtrp2001aeb1bc176d4e71c0f9e654e73d2f0~J-l-hLeD92140221402eusmtrp2Y;
        Tue, 28 Apr 2020 13:20:31 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-88-5ea82d9f47d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.A6.08375.F9D28AE5; Tue, 28
        Apr 2020 14:20:31 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132030eusmtip202c8077137c7fc513878860328148b0a~J-l_3m_tD1180811808eusmtip2E;
        Tue, 28 Apr 2020 13:20:30 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC 15/17] drm: xen: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:20:03 +0200
Message-Id: <20200428132005.21424-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUwTQRzFM7vtdqktroWECRDRGiASuaIkk2A4IsY1xsgX/WAUrLIBhBZs
        KYqJAeqFBeT0iFyNitw3FgQMh2AFIhpADgWRQwIEULlUEkCWBfz2/m/ey+8/kyFxST3fnAxU
        hDFKhSxYSgh5+rd/P9hn2ef6OPVn2qH4jlYMZZdEC1DZ4xI+0jS1EWhNn4Sj7sUfBMoraMFQ
        WmIFhnT1rmihexhD5aM9fNRVk06gouZBAWr8OcZHbYPzAo+ddGFmIaBfL+l49EBPHUFXLX3j
        00OxBoyueB5Jf1kdxemUvhxA1/ZHEfT9ynxAz5fv9t5xVnjYjwkODGeUjm4XhAGGhHsgNI28
        Nv7SPgosElpgRELqENTqNbgWCEkJlQtg6vAE4IYFANs7FjA2JaHmASy8K91qrDz6hHGhHAAf
        5n8mthsPJqoAmyIoZ6id0W4wTKnbAL6LF7EhnNLjcCynWaAFJGlCHYNz09ZshkdZw55K1jYi
        xZQbnH32C3A0K1hQ2oCz2mjdzx75vgGDVKcAVkx83byEFxyq+SPgtAmcMlRuaku49ioL4wo3
        ARzuKBJwQxyAXZrHmwhXONCxTLAb4dR+WFLjyNmesK4hF2dtSBnDvpldrI2vy2T9o01bDGPu
        SLi0DXxiKN7GNn7sxDlNw6yUHj73QEkAtsX0E4nA6sl/mA6AfGDGqFVyf0blrGCuOqhkcpVa
        4e9wKUReDta/VfuqYa4aLHZebAIUCaQicako10fCl4WrIuRNAJK41FQ8EvDCRyL2k0VcZ5Qh
        vkp1MKNqAhYkT2omPvh08ryE8peFMUEME8oot04x0sg8Cpzhtdo7eaVqimJFxdNxJ9J/tziV
        2YAMMi3Pwta/68iSZYQ6UusZJkz3Q0g+F+0bc17z5vKyotGlROK+WLt3NlkYu6+YMNYd9xm8
        Ye3av+dUoUXQZIhNu4uHVe/KyQwzpfpAqJ1373uR4EW2+5T5UdME3bl91bdqTicH2F4ZP+ks
        5akCZM52uFIl+wfy1I6pUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7rzdVfEGbS8FbLoPXeSyWLp+kZ2
        i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
        e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
        yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
        RqZK+nY2Kak5mWWpRfp2CXoZx/s7GQtmc1Q826rbwPiVrYuRk0NCwETi7/SrTF2MXBxCAksZ
        JQ4s2M4EkZCRODmtgRXCFpb4c62LDaLoE6PExBWLwbrZBAwlut5CJEQEOhklpnV/ZAdxmAUO
        MEt0nz8JNIqDQ1jAXeLTG1WQBhYBVYlrW46wg9i8AnYS7xZ/ZITYIC+xesMBZhCbEyi+9NFT
        NpBWIQFbicstuRMY+RYwMqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjJ1tx35u3sF4aWPw
        IUYBDkYlHt4NPCvihFgTy4orcw8xSnAwK4nwPspYFifEm5JYWZValB9fVJqTWnyI0RToponM
        UqLJ+cC4ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKhR+57j
        csKto0w5yndivDgWVBru4nzg02oV+e3A2cS/gVWPpx+98b/P3Prjvtw+ebvAHHPFh78S9oqe
        vj7TY4/2WZfvrz1PVJ0/VXWd+/Dr7FY2F0ezi6e2q+Sx/zx9r53BlN3by+Uwh7Dy7embYwOU
        b5bp9Euf7peQPXRlk2P3M5lOl4ASUSWW4oxEQy3mouJEAEbx8fSzAgAA
X-CMS-MailID: 20200428132031eucas1p1e7a72bf0de5acea2af652cd8337a8ed5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132031eucas1p1e7a72bf0de5acea2af652cd8337a8ed5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132031eucas1p1e7a72bf0de5acea2af652cd8337a8ed5
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132031eucas1p1e7a72bf0de5acea2af652cd8337a8ed5@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index f0b85e0..ba4bdc5 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -215,7 +215,7 @@ struct drm_gem_object *
 		return ERR_PTR(ret);
 
 	DRM_DEBUG("Imported buffer of size %zu with nents %u\n",
-		  size, sgt->nents);
+		  size, sgt->orig_nents);
 
 	return &xen_obj->base;
 }
-- 
1.9.1

