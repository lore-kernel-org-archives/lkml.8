Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C2C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F47920719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC7iFwmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDGBLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:11:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58226 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbgDGBLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=LC7iFwmkYlw5Am1oWjbtbCxllEVPlaTthuiXvufhiXus4y1qiGOei8bqjdV73qpBxr/6NP
        854RelzkQ6apnTT+/d94b9dVveNjaJTxQOCBuJvui/33C2whh0QXYANBshUp/poVH4PZsB
        IqYq5HCIa8xb1PmFkS6MG+rst30Hp9U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-7MS7PKzQMz-rV0SmhUm_Ig-1; Mon, 06 Apr 2020 21:07:37 -0400
X-MC-Unique: 7MS7PKzQMz-rV0SmhUm_Ig-1
Received: by mail-wm1-f72.google.com with SMTP id l13so7131wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=UXJRCoVydDaRTUs5+YOYbJ7ZzRMIkBu1VWdDbNL6Ggk1+RVlUCHlX6ny429QnpGlUB
         1XpSX5GIZayXhg+Hz18OfDfrB1Q1Zdq2KkKB9R7cr5aC/kIuwXaLtd2X4hIfiJhA9NJV
         A4w4k9o0Fafq7bftXH2Zsu/YkxvHYvuSGaACm8XhDFmo0Oy7MglrB3zm2xY9ZvFYw+yY
         2RnN0t+9SR2RhAIFSYMMB/6HFaKxEN0jZu6Wq8UM3arSVh/xHKDphytlYNCNI5Bs991C
         wHvAkcRXR3OSycM2TyEKW/RE2wGtzaluo2iGsktBnHw+Dr+AcCjzEW0Xgwq5b5r2VU7e
         yD2g==
X-Gm-Message-State: AGi0PuaQf328UV94IXSDUVyhuHyZFiK3/ElcQr4gIHWAOrqRyaZAxWQJ
        Zotd5nXYFa6VnCPU1R+IGddW9nkJ5TcoP9uF1R9Xmo1JKQMDqMWtojWBSrJLlqxFmzQiUK2o272
        4HgEpMoW8e5yD6a47I7afVfZq
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1924685wmc.129.1586221656373;
        Mon, 06 Apr 2020 18:07:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1VPym0WV2AUNWF3nePrQ1HrbzKWkz96fRM10+GRgtdRjalH82OhlghtMpKVrLdSxpzpVYzw==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1924673wmc.129.1586221656136;
        Mon, 06 Apr 2020 18:07:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id p21sm78486wmg.34.2020.04.06.18.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:35 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matej Genci <matej.genci@nutanix.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 04/19] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20200407010700.446571-5-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
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

