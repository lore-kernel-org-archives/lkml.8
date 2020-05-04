Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09163C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10AC24959
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616059;
	bh=W3hrg99HdUaydIIDdtTvU7hWkGdFODXPzdfM8iQNwGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YYosIfpbWBGcq7ECHQhQtr9XWk1Qmkj9WJCCdbw1cGxjvaZwVOPE7mGNe5oNviUWC
	 1OLK6cWeZkDFeYwi6tJSrqqCj+3Uy2wTE2KBkOJtkZhpicwvccPEM7wI7hHSQQ0+XO
	 JOtfE3mqdCUzx1gl8aG9AzWs1E5y822XS4L9CsCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgEDSAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbgEDSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9983020721;
        Mon,  4 May 2020 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615229;
        bh=W3hrg99HdUaydIIDdtTvU7hWkGdFODXPzdfM8iQNwGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELwdYho+JNhlakCp0mEztx/uNfZjptDZ7GwFgy08wvV72h7cneHhslH8zxCgc6tjQ
         qk0NIqcskeI2gax4feSUVukTi3XobKh07G3A74MVpeWIzopL7Dnu8z69jP5cRhlxAz
         qJpmkb88OrvSWKCuTlgPI7jC+vqobKESzQgDUcTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.14 18/26] vfio: avoid possible overflow in vfio_iommu_type1_pin_pages
Date:   Mon,  4 May 2020 19:57:32 +0200
Message-Id: <20200504165446.465935417@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
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
@@ -591,7 +591,7 @@ static int vfio_iommu_type1_pin_pages(vo
 			continue;
 		}
 
-		remote_vaddr = dma->vaddr + iova - dma->iova;
+		remote_vaddr = dma->vaddr + (iova - dma->iova);
 		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn[i],
 					     do_accounting);
 		if (ret)


