Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C1C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325AC207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588248103;
	bh=QHBgJX+bF1tiYlvZ2bwMjSrr69d3qjVxEKw5dkxCP/c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Soffy9FycIyX3xXmUXoswx18cUOZ4I6E9EbIDEKnMLu19JZ0c07dBJTs2CL5ejuf4
	 3KNZxp6pnrSiHaO/iXRXbqUfRduyx4L3l3byoheepgnWjD/PVhHLuu7QNw7aWKV9eV
	 uY2plFRun3c8HglVefh1YMt9Dx68bullXhUIu+9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgD3MBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgD3MBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:01:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9265320775;
        Thu, 30 Apr 2020 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588248101;
        bh=QHBgJX+bF1tiYlvZ2bwMjSrr69d3qjVxEKw5dkxCP/c=;
        h=From:To:Cc:Subject:Date:From;
        b=NZLQpPWef+GBjsg/pN3t91fyQ94VxV5o0/gImgoefZVdSqi5qzHAkNIJfTy7hZb/w
         X+VKGviFUl66UjhteoPhSeCjnWfpymRRCmjtS8nO1/jauLy64+H1VTorW01zC3fh+o
         UXjEWNgcdD3lfdgLnHTsbwBBefKMUZpryGU/LrzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] drivers/iommu: properly export iommu_group_get_for_dev
Date:   Thu, 30 Apr 2020 14:01:20 +0200
Message-Id: <20200430120120.2948448-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to
permit modular drivers") a bunch of iommu symbols were exported, all
with _GPL markings except iommu_group_get_for_dev().  That export should
also be _GPL like the others.

Cc: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: John Garry <john.garry@huawei.com>
Fixes: a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to permit modular drivers")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..1ecbc8788fe7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1428,7 +1428,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	return group;
 }
-EXPORT_SYMBOL(iommu_group_get_for_dev);
+EXPORT_SYMBOL_GPL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
-- 
2.26.2

