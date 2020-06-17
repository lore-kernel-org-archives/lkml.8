Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20B0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7220D20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abUfTcNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQKsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:48:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27669 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgFQKsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592390889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rL7vM9X5R7rzCkf4aWP47i5M17Wpex2MeAc4fEf3LAk=;
        b=abUfTcNoO47gXlT3I4YRJmGySvKNZnfH3cflo4QIpn7uAykmSvZLdV6jkYR06Wj0gZvTHG
        m5DEFAssk2CaE++a+vZBtCLt0GLPQzz9FCEi0kcoP3LCD/YWzELZou5z6rsR/8wi68ZMne
        r9GFzRjgaooEeUUGnWHCl3z3+KQVURU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-trWxPL4hMDG7xdUqBz0QUA-1; Wed, 17 Jun 2020 06:48:06 -0400
X-MC-Unique: trWxPL4hMDG7xdUqBz0QUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3694680B71D;
        Wed, 17 Jun 2020 10:48:05 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-122.ams2.redhat.com [10.36.112.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B85065D9D3;
        Wed, 17 Jun 2020 10:47:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1] MAINTAINERS: add URL for virtio-mem
Date:   Wed, 17 Jun 2020 12:47:56 +0200
Message-Id: <20200617104756.6312-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add the status/info page, which is still under construction, however,
already contains valuable documentation/information.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 301330e02bca7..3470c5bfbdc7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18234,6 +18234,7 @@ VIRTIO MEM DRIVER
 M:	David Hildenbrand <david@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
+W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h
 
-- 
2.26.2

