Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D90C2BB54
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D422078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4VIHn8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDFW0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgDFW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586212005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=Z4VIHn8tCLGJ2XVkPFFmOY5ktk2t9BBHzw6QN0WKQXnlDx+Ytam344d7zxwL39w8DT4f/S
        cF73FA4VRnplLvE6f2Xy+ebqANjGAcO2MRxf8i+Y5gMoi8aHOiWFP0c3xzugulNlBc6HR0
        Rthng8fEdv+vxpmwGnvDAvaYxB4BYIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-yGl7crbFOniGuGorniovxw-1; Mon, 06 Apr 2020 18:26:39 -0400
X-MC-Unique: yGl7crbFOniGuGorniovxw-1
Received: by mail-wr1-f70.google.com with SMTP id k11so639014wrm.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=eRGkNIuJgK5KtsnR0nd+vw3sNGlyDCNxrGVrQYheBWDgRmoSnn8q54Q4EqV1Q2p550
         D/QtLCat2Q5TPRrXBwOSVgKMNOjiPEJyY54RO2NrknH26/sXnleSj6le2KKFvAKh1xmK
         6qs4JpGu1IlrYFejtafVNq9cnC0+G/ufpPbZlXfHl9lYCRCAkLRdfcAWoqyGe3+4/jN3
         v5bubwOQY6BJEXBg+cxIYPEcf/ni7XnS8mEF9Fq1e0ExdKZWZOu/NbBqJAYEh9w9OiF3
         AKzo2c42Clctsp+3SsTKYfvC+ayN95z9aIfdQx6h5N2lttcWKBkYVdwg2NahFX9XvXdT
         NB9g==
X-Gm-Message-State: AGi0PuZQuT8zEE9jbC7ea51ItvPXiP1gwV0eUgYpndD+fMkwp/rlCzfC
        2EHRB0B+ti4slb8yFtVVUuK3MhfLXOWK0ObFJd+z0ej6iqe8VS9/r6wr7Zbmv4Y+G7FHh1ITgYz
        f0O92TIxooyhl6n4KW+TCjJ8S
X-Received: by 2002:a5d:6204:: with SMTP id y4mr1590912wru.410.1586211998045;
        Mon, 06 Apr 2020 15:26:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypITDhGNQZa99ndk04hNA7xG8SlNGaI/jBhEo5PQXjQ1+zaBzfx8Hh0Zv03WWW0lajc0/UW2QQ==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr1590896wru.410.1586211997853;
        Mon, 06 Apr 2020 15:26:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f3sm1304116wmj.24.2020.04.06.15.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:37 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matej Genci <matej.genci@nutanix.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 04/12] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20200406222507.281867-5-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matej Genci <matej.genci@nutanix.com>

Add macro to disable legacy vring functions.

Signed-off-by: Matej Genci <matej.genci@nutanix.com>
Link: https://lore.kernel.org/r/20190911124942.243713-1-matej.genci@nutanix.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 1 +
 include/uapi/linux/virtio_ring.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7abcc50838b8..db93cedd262f 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -16,6 +16,7 @@
 
 #include <linux/delay.h>
 #define VIRTIO_PCI_NO_LEGACY
+#define VIRTIO_RING_NO_LEGACY
 #include "virtio_pci_common.h"
 
 /*
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 559f42e73315..9223c3a5c46a 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -135,6 +135,8 @@ struct vring {
 #define VRING_USED_ALIGN_SIZE 4
 #define VRING_DESC_ALIGN_SIZE 16
 
+#ifndef VIRTIO_RING_NO_LEGACY
+
 /* The standard layout for the ring is a continuous chunk of memory which looks
  * like this.  We assume num is a power of 2.
  *
@@ -181,6 +183,8 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
 
+#endif /* VIRTIO_RING_NO_LEGACY */
+
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other side, if
  * we have just incremented index from old to new_idx,
-- 
MST

