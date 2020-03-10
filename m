Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F42EC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6763024686
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0JP3FUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJLy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgCJLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583841264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8ZrT3AGCzTG+Qy7MOUd23n+FQWkwGC2qeOIFrLWjTqo=;
        b=g0JP3FUAORsSYol2Ql+cDkfMsaNhG56ahuvjcRw0mbcWWvjaijVX5AZjq19uNlNCGbwGk4
        6Zmc2+Gi4CDRwOpEiwYJjarujdJIRR2W5ifArubb6xFlUkpuqQWsboSwMUzf8DXkAQ6PJX
        RzLoVRP7vjxIyWSkz1fODAY5zTvPp+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-vglXSBiuN_2Pq7iSbeCokA-1; Tue, 10 Mar 2020 07:54:23 -0400
X-MC-Unique: vglXSBiuN_2Pq7iSbeCokA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCD56100F287;
        Tue, 10 Mar 2020 11:54:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48CB95C28D;
        Tue, 10 Mar 2020 11:54:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Luiz Capitulino <lcapitulino@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] MAINTAINERS: Add myself as virtio-balloon co-maintainer
Date:   Tue, 10 Mar 2020 12:54:11 +0100
Message-Id: <20200310115411.12760-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
While at it, also add "include/linux/balloon_compaction.h" to the file
list.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c555f4be8c4e..da9f53a05d0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17800,6 +17800,15 @@ F:	drivers/block/virtio_blk.c
 F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
+
+VIRTIO BALLOON
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	David Hildenbrand <david@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_balloon.c
+F:	include/uapi/linux/virtio_balloon.h
+F:	include/linux/balloon_compaction.h
 F:	mm/balloon_compaction.c
=20
 VIRTIO BLOCK AND SCSI DRIVERS
--=20
2.24.1

