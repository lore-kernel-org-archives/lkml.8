Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B7D20663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY/MGP0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgFDHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:31:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35783 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727768AbgFDHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591255907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ScSOSv2NtMOfy/k7kNuH62249T1/AmnJUmlOdYJpg9M=;
        b=XY/MGP0xDTzKnmsh8orfkQCDBpZyFPrEdWbY4FD5qpjbUiRG0JGPx4g2I9f99ktS8C516J
        eLgCEhnkFnn6BHpKOJ0MoBpGXuJsMS2vMmfeszhrEeB90sjyq48JmzFTDjfmx8TSiwDSN5
        8Dwc4D39d5EPgxy6x2fSjNnEdMHMoIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-nCNyXAvDNe6LobAjFOmQpg-1; Thu, 04 Jun 2020 03:31:45 -0400
X-MC-Unique: nCNyXAvDNe6LobAjFOmQpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53FA119057A1;
        Thu,  4 Jun 2020 07:31:44 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-113-227.phx2.redhat.com [10.3.113.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DC9C2DE74;
        Thu,  4 Jun 2020 07:31:43 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu: Don't attach deferred device in iommu_group_do_dma_attach
Date:   Thu,  4 Jun 2020 00:31:42 -0700
Message-Id: <20200604073142.74701-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching a deferred device should be delayed until dma api is called.

Cc: iommu@lists.linux-foundation.org
Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
If you already have thrown a patch together, then ignore this. Also
feel free to swap out the signed-off-by with your's since
this is more your patch than mine. You can put a reviewed-by
and tested-by instead for me.

 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b5ea203f6c68..d43120eb1dc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
+	int ret = 0;
 
-	return __iommu_attach_device(domain, dev);
+	if (!iommu_is_attach_deferred(domain, dev))
+		ret = __iommu_attach_device(domain, dev);
+
+	return ret;
 }
 
 static int __iommu_group_dma_attach(struct iommu_group *group)
-- 
2.24.0

