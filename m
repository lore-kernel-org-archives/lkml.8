Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43764C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0F821841
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJhH2W2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEGKdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:33:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32624 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbgEGKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588847605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQtsM9rlGIYjjg7oqEaBydjSspz/FpyGtnFDW5OTOqc=;
        b=NJhH2W2kDM+n88wYT+0CfvqWdVhwjoTjVQEQGUiPKkjQq5OagaVrM54fbnhAEDVig5SniD
        u9iQLR51XZ8W9vQHDRXuVfP2g+m4KS0a+cBmV5A/3cAx1gR1Tr/ksdRH+fTrYHhC6qBHMW
        HpzvlFzQVkl7Dk2WXEJagfJIwtKGvPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-s9hSVP4bOumFxldwsRcXmw-1; Thu, 07 May 2020 06:33:24 -0400
X-MC-Unique: s9hSVP4bOumFxldwsRcXmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E761319200C5;
        Thu,  7 May 2020 10:33:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A59115D9C5;
        Thu,  7 May 2020 10:33:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 10/15] MAINTAINERS: Add myself as virtio-mem maintainer
Date:   Thu,  7 May 2020 12:31:14 +0200
Message-Id: <20200507103119.11219-11-david@redhat.com>
In-Reply-To: <20200507103119.11219-1-david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 4d43ea5468b5..ad2b34f4dd66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18037,6 +18037,13 @@ S:	Maintained
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
2.25.3

