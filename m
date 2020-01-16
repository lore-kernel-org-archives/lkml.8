Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321EF2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCR5b4G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436496AbgAPSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:18:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37696 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404213AbgAPSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579198691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LP60/34E9bpmTo0YvyONW5BNSwA1vtrUNhAbAktUFEI=;
        b=dCR5b4G7HC/O0RXNQZ+1lYVASBef924MCK1l7Xncr8Rpj/lYMxm0Odb+ORttflCX6eNyI2
        dl09liHM86Y5beY3kAl56NwgT0lliGU4hcGCm4pCnuCK49XDjKpMM5UwNEVv9u+c0YNtYs
        XyvGBf0LNqjbQJ55V1EzAht12QUtJEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-CqNHnw9EMeGDxSYvVUjxCA-1; Thu, 16 Jan 2020 13:18:09 -0500
X-MC-Unique: CqNHnw9EMeGDxSYvVUjxCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C29D01088380;
        Thu, 16 Jan 2020 18:18:08 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B5085D9C9;
        Thu, 16 Jan 2020 18:18:06 +0000 (UTC)
Subject: [RFC PATCH 2/3] vfio/type1: Replace obvious read lock instances
From:   Alex Williamson <alex.williamson@redhat.com>
To:     yan.y.zhao@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Jan 2020 11:18:05 -0700
Message-ID: <157919868571.21002.6651113746893305820.stgit@gimli.home>
In-Reply-To: <157919849533.21002.4782774695733669879.stgit@gimli.home>
References: <157919849533.21002.4782774695733669879.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace some instances where no internal state is changed to read locks.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7ae58350af5b..e78067cc74b3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -830,10 +830,10 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 	struct vfio_domain *domain;
 	unsigned long bitmap = ULONG_MAX;
 
-	down_write(&iommu->lock);
+	down_read(&iommu->lock);
 	list_for_each_entry(domain, &iommu->domain_list, next)
 		bitmap &= domain->domain->pgsize_bitmap;
-	up_write(&iommu->lock);
+	up_read(&iommu->lock);
 
 	/*
 	 * In case the IOMMU supports page sizes smaller than PAGE_SIZE
@@ -2115,14 +2115,14 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	struct vfio_domain *domain;
 	int ret = 1;
 
-	down_write(&iommu->lock);
+	down_read(&iommu->lock);
 	list_for_each_entry(domain, &iommu->domain_list, next) {
 		if (!(domain->prot & IOMMU_CACHE)) {
 			ret = 0;
 			break;
 		}
 	}
-	up_write(&iommu->lock);
+	up_read(&iommu->lock);
 
 	return ret;
 }
@@ -2156,7 +2156,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	size_t size;
 	int iovas = 0, i = 0, ret;
 
-	down_write(&iommu->lock);
+	down_read(&iommu->lock);
 
 	list_for_each_entry(iova, &iommu->iova_list, list)
 		iovas++;
@@ -2190,7 +2190,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 
 	kfree(cap_iovas);
 out_unlock:
-	up_write(&iommu->lock);
+	up_read(&iommu->lock);
 	return ret;
 }
 

