Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C314C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50221739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihIvwAFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCBNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:53:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41724 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbgCBNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583157210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhbhIkhXjn/AwJ4ncntCvKScFqYIEEVt6rsSJbYgZY8=;
        b=ihIvwAFtRED4ISeqobpxiezcwh+ulsWCKT5QzQ+kLZoXxZ7wR2NjKOBszQMjAaFfqsvm4T
        /uGqSkwIOhBEuCbP7s2Er+sq9mra7ATk0r1OJ+PUyw9KUzkYzpresgng6ZfEfvzsI7EAKm
        Tbtbof8BVn2CxO1vjS/1DtsY4U6SUag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-LijAYyNSPC-rwnsAlvjscA-1; Mon, 02 Mar 2020 08:53:29 -0500
X-MC-Unique: LijAYyNSPC-rwnsAlvjscA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCF1F1005512;
        Mon,  2 Mar 2020 13:53:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-114.ams2.redhat.com [10.36.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E179B19C4F;
        Mon,  2 Mar 2020 13:53:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 11/11] MAINTAINERS: Add myself as virtio-mem maintainer
Date:   Mon,  2 Mar 2020 14:49:41 +0100
Message-Id: <20200302134941.315212-12-david@redhat.com>
In-Reply-To: <20200302134941.315212-1-david@redhat.com>
References: <20200302134941.315212-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make sure patches/bug reports find the right person.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1636ce4613e3..fc7371c4b7eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17855,6 +17855,13 @@ S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
 F:	include/uapi/linux/virtio_iommu.h
=20
+VIRTIO MEM DRIVER
+M:	David Hildenbrand <david@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_mem.c
+F:	include/uapi/linux/virtio_mem.h
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
--=20
2.24.1

