Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9454C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E1320823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csFmKv47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFEHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:00:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51581 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbgFEHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591340435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Psy0gAVP3y5zMhy6rzif6kvuC7aa4BFrXqt5hsHPNmU=;
        b=csFmKv47UtxgFKtlAv3PQNI5SVRrQCZ14FysUiczUL9HIKpz/sXJSw1j56Wme9gkh/mH1B
        roDTCH/9MWHYvpFk0+BimV8UbDH5xOuwItjejhXCNlT2UzBd9i4ur3vL5c5+FWU5E/n8po
        jw0T3BM3+UU1iuz33//cS9UmgbB+/kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-y-8uuF_6NqacZfhkA2f4MA-1; Fri, 05 Jun 2020 03:00:33 -0400
X-MC-Unique: y-8uuF_6NqacZfhkA2f4MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE469107ACCA;
        Fri,  5 Jun 2020 07:00:32 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-113-227.phx2.redhat.com [10.3.113.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6665D7CCE0;
        Fri,  5 Jun 2020 07:00:32 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu: add include/uapi/linux/iommu.h to MAINTAINERS file
Date:   Fri,  5 Jun 2020 00:00:25 -0700
Message-Id: <20200605070025.216124-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When include/uapi/linux/iommu.h was created it was never
added to the file list in MAINTAINERS.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1897ed32930..061648b6e393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8954,6 +8954,7 @@ F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
+F:	include/uapi/linux/iommu.h
 
 IO_URING
 M:	Jens Axboe <axboe@kernel.dk>
-- 
2.24.0

