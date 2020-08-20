Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF495C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC72078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597917279;
	bh=+wJePM7tFVWHEgDK9v3I9eBY8WSJUwrrp6TR6uB9qXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxX5Njs7EhOpgHPPfh3x8hOd/QGAot3tJmwEZO0EwMGd44xTgwyqQqKJpo/2/AAt2
	 1nVUqWm/5nAwUqrQAzaBvxf1hae0/lEaGD0tdUvSZsXj7NmUcTjHzllBTtjeuutBsH
	 7U3W5GBBlFTTwPH8omGDoWBtnrRSlDXj0WfNYinY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgHTJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgHTJye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:54:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7D820855;
        Thu, 20 Aug 2020 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917273;
        bh=+wJePM7tFVWHEgDK9v3I9eBY8WSJUwrrp6TR6uB9qXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7aS5i2dAKLf0oIX6HhOS2U9V/zcFh2amh2UcIGWCQ0gLZNyj0aXQZ0L7/FKjkIDR
         oDlzDSka4nu1vp4uPh9RJ4k7i4n7IDEjz4s6GvBP9zTJ4KTv9Bn44eN8Y+BncSx2CW
         avOC8ugaU/gKVz1NmpO/RF6/diJcw5eCLLelYeZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 64/92] iommu/vt-d: Enforce PASID devTLB field mask
Date:   Thu, 20 Aug 2020 11:21:49 +0200
Message-Id: <20200820091540.934456104@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

[ Upstream commit 5f77d6ca5ca74e4b4a5e2e010f7ff50c45dea326 ]

Set proper masks to avoid invalid input spillover to reserved bits.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20200724014925.15523-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/intel-iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1b4411b4c6b8..539f4a84412f4 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -308,8 +308,8 @@ enum {
 
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
-#define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
-#define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
+#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
+#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
 #define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
-- 
2.25.1



