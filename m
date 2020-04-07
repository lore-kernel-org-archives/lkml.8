Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA04C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5191420768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UelDHPHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDGBQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgDGBQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=UelDHPHwrbnEcsET/cwKnFImfmGkTX1YAXB919PUZZlpRkKC5/2IdkLzcZZ4r2vLlaui92
        3GfKd23PJT1HXtqWSvg64j1zXuW4P+Jw2uIh3FDvZd2ghcdzLDkPMG+rGf2TUDitrnCXPy
        QjkH9SWySJN3WILv/v3vperzCkH8Wv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-ZDU1urk7PPi36BAsKZBhWg-1; Mon, 06 Apr 2020 21:16:38 -0400
X-MC-Unique: ZDU1urk7PPi36BAsKZBhWg-1
Received: by mail-wm1-f70.google.com with SMTP id v8so13240wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=UvjH87xewCBU78TpFe6vkVcTT02nL7Mo+K9APdCnXRZRpkzylmI1fp+cHrbQipq8cD
         iZJlQX4+o838pdWppBWfsDcObltcDVRgPs/lXfaU4h2RRKhirv657RJXLhbwuKGC9ZvK
         lFBh2b7FCDPMKdGdxtv+PYWrhAn19f2Z4ttk0iWszCUrVep9gxLIXokSJ7geTiKbSf7u
         /eb8zod56hr0QekYPidQdNFamUbZjWiFpVbaFPeP9CKiCo4B1A0DRONpQgzYuw756HtV
         wTmtZd8RNVSVAIdS91JIBmy7sl82+alWsJmR/rBQhajSqpVlWGiJtn+wm8sLTN4/t2db
         mUqw==
X-Gm-Message-State: AGi0PuZIz4vLuHyaTrdVAMNv1i78VWHkfHm7AqPlOgcbOxmHRQb5iji2
        rXpA0LmL5KpEFCTTb081KX4jiuTRqqMVRhy63CyFVfEfX33gxphcoe/0iQxthvg20/sbdku7EJX
        +/egrDyEtZpeuJZ7oHgITZQJD
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2048649wmq.169.1586222197143;
        Mon, 06 Apr 2020 18:16:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIzBMyKPWUK7kodkLb2Qg8aZfq7m2tt5u6B0Jpm9XZOtZrUL8QvMMUAmGtTWn7vvPaz0udVuQ==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2048633wmq.169.1586222196879;
        Mon, 06 Apr 2020 18:16:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v16sm107723wml.30.2020.04.06.18.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:36 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matej Genci <matej.genci@nutanix.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 04/19] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20200407011612.478226-5-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
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

