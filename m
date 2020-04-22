Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF8C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C962073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552145;
	bh=teWoWnOgcSPlBj5vzx0uZY+S9BuzrPPocOvM7gkc/pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xNbgCG08L8Uwc02Xk9IDYxZ1L6xtkcIUVELkmqyqn/aEVECPmpcJmrDOiTsmdi3qI
	 wnHRIkE5T6ju+tnaKNnedRAktjOPJtN/HKPY4RTR4afpjpmDYt4Fh+M9uw9OFWhDqk
	 6c22eeMTj9Wv06OR2FZBdHyMaWBdK8T095eVfD9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgDVKmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgDVKTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30C320780;
        Wed, 22 Apr 2020 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550783;
        bh=teWoWnOgcSPlBj5vzx0uZY+S9BuzrPPocOvM7gkc/pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2GLSle0yKvM5Z+utrsYhhju1oZDlmVSH5RhoycOjiN9+ie+Z0IDLjFRQwpDrf2xP
         cAzE3E2Tm37WppGMTrpIkY4zP4kocVuxBwAMt/cs9UUuI6l1dmbt9GWygEaLGpgAyv
         HfG/oZw+A/367/P1XHYaBc55HL8cpQ+x/eg5IGJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/118] iommu/vt-d: Fix page request descriptor size
Date:   Wed, 22 Apr 2020 11:57:33 +0200
Message-Id: <20200422095046.443322368@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit 52355fb1919ef7ed9a38e0f3de6e928de1f57217 ]

Intel VT-d might support PRS (Page Reqest Support) when it's
running in the scalable mode. Each page request descriptor
occupies 32 bytes and is 32-bytes aligned. The page request
descriptor offset mask should be 32-bytes aligned.

Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3020506180c10..1d3816cd65d57 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -502,7 +502,7 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
-- 
2.20.1



