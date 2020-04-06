Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06EEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90D22076E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihw3xHW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDFVfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54312 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726708AbgDFVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=ihw3xHW6n5XyOPsMfiO5vgNLdVgacymqxbzs8fN3AeXSEEFpV/fyE3kR5AqZFTzE2WufRd
        S2KlpEgsqwy1AoU2dGTbIaBAIsWAA3nLrQA3EbqmEl65S6Yq2/dZLDnnp/Y7CAmWDEGC2G
        o+z8GPRUxh7mLDdL8h2IBHFvDKc6wsw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-i9jgeozLO5a6ULb8I1lRRg-1; Mon, 06 Apr 2020 17:35:03 -0400
X-MC-Unique: i9jgeozLO5a6ULb8I1lRRg-1
Received: by mail-wr1-f70.google.com with SMTP id g6so577153wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=YtH+p6ufq4A4FmppkX3/5ygDNZRREtlRpEeI6wJ3udWQZtV7i4r5VcY9USsX1mp5vZ
         UequlHqvQtdjoXm1fHABgGtbbZpzwgEj9VJHKoylhGyHT61Ao57XRRAQmSnrOfbfQmLE
         ps1jWju0Te2Vh3BAzteB9i0M/EKOfstwMa7SsvsemiSFeFbF726HVxbufuqbdS9hNCgx
         EaP6ZaOQV8jFsv1mlBFamNxciB9CMP8XJ8re1CmoVYTF4cJchTbU8pIzZ0aLEKKSni6n
         uTnHn9NLIno9XPUkp1QOB9PaQL7egLCCH4FC+T+KtX28MVmBHWUxB3dVXKPQW7v+YtRp
         zR7g==
X-Gm-Message-State: AGi0PuZe+nf92fHopFztJ6WHGUEyVZb5Q24QGnvJ3bnNJHu4tIHxKc+F
        gjkhapCmdtsW7xBYha8WF/dSwI/kFIBATxN0LFQ1e2sK9SZRz3XUZY4sI/NJN3G6aYcrGnjkVHk
        sMYwztImRDjD1psM7HIRYPPCx
X-Received: by 2002:a1c:6189:: with SMTP id v131mr1379078wmb.69.1586208902287;
        Mon, 06 Apr 2020 14:35:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGMFjC6JEE4rj0+kmWXxAPv5VbkaMdS8mzLAfjCwSQ+lPL71eAN+wnTMem5IdlA9ywESErYA==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr1379063wmb.69.1586208902051;
        Mon, 06 Apr 2020 14:35:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id u17sm31576241wra.63.2020.04.06.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:01 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matej Genci <matej.genci@nutanix.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 04/12] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20200406213314.248038-5-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
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

