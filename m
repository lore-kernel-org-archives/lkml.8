Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E1206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhrBn9o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHKC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:57:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgHKC5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597114643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB1D7C4hvQqDFOcHKw0JNPnq0YeyU1fjAmMz+o7ISzU=;
        b=EhrBn9o4Vcu64CiDb7TLgPTe41PPmUaBQKjhsQ03auZCIjvt/2C9MXwHZCfxF2T/UpoL51
        Ya9YvxabSatfSNmEzpE50pCYs9uy0Fw934f/UZrPCTSTwo0I+xLJXzSYnWqrXSKcruhFKz
        DKOBZSkNZs8OzxnhmbyvWyy9M972Br8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-3uLo0afoNNalLgNZdUqtJQ-1; Mon, 10 Aug 2020 22:57:21 -0400
X-MC-Unique: 3uLo0afoNNalLgNZdUqtJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B1E57;
        Tue, 11 Aug 2020 02:57:20 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3191A7CF;
        Tue, 11 Aug 2020 02:57:17 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     Eli Cohen <eli@mellanox.com>
Subject: [PATCH 2/2] vDPA: add Eli Cohen as mellanox vDPA driver supporter
Date:   Tue, 11 Aug 2020 10:57:10 +0800
Message-Id: <20200811025710.7775-2-jasowang@redhat.com>
In-Reply-To: <20200811025710.7775-1-jasowang@redhat.com>
References: <20200811025710.7775-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Eli Cohen <eli@mellanox.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 314398f0e276..ed1851413fcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18186,6 +18186,12 @@ S:	Maintained
 F:	drivers/vdpa/
 F:	include/linux/vdpa.h
 
+MELLANOX VDPA DRIVERS
+M:	Eli Cohen <eli@mellanox.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Supported
+F:	drivers/vdpa/mlx5/
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
-- 
2.20.1

