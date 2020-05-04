Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3BCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E38206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615455;
	bh=zOlGqC9+C1xUenmbvMRYr2ASQHTqrqZDZyomtHP8jXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6S+w3VNwN8oWsTYO918uIMbgJed4kiHEHneUMEjursmnXcR0ABrMnvKWxiVAm6iO
	 r5X/YCa/CwHxeidO5buuhgaPBi1GpCYSfOk7fgDMDov7cHHEJc2M3cUy8c6eVjHH82
	 UX7a2FB66PzoM5nc8c9YJ70zhrP8wBOgUp4Rv0qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgEDSEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbgEDSEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:04:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0C42073E;
        Mon,  4 May 2020 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615449;
        bh=zOlGqC9+C1xUenmbvMRYr2ASQHTqrqZDZyomtHP8jXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDKWbdxyuNLeWNkNe9E8gdle/x0FlFNpxMBuNinB9dbwMEdCXEi3T5g5btGvWzZue
         UUk4w7nZ0j4pXpnlEWpz3K4JDM6ncFoHVc/ZaHnqEvkCdiPXqE/bdxykZ18JuKx4RR
         w9wZrCQXd+QP1ZHFxFnMX0wQ1AN5K14oz28BHedk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5.4 44/57] vfio: avoid possible overflow in vfio_iommu_type1_pin_pages
Date:   Mon,  4 May 2020 19:57:48 +0200
Message-Id: <20200504165500.152788410@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

commit 0ea971f8dcd6dee78a9a30ea70227cf305f11ff7 upstream.

add parentheses to avoid possible vaddr overflow.

Fixes: a54eb55045ae ("vfio iommu type1: Add support for mediated devices")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/vfio_iommu_type1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -593,7 +593,7 @@ static int vfio_iommu_type1_pin_pages(vo
 			continue;
 		}
 
-		remote_vaddr = dma->vaddr + iova - dma->iova;
+		remote_vaddr = dma->vaddr + (iova - dma->iova);
 		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn[i],
 					     do_accounting);
 		if (ret)


