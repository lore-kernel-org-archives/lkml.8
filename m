Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3201C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C6920753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS2iEsHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDFVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726483AbgDFVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=eS2iEsHMzm9ZmBP6Ua5zNRksvzk81IrHQuM5e3ZnV5mBaW2SoATu+aDMY9xyzvF2t8efKD
        2E/eSmO7w8s971AIKYb4pqSMz2oibr+HRpHv5kUGRfW4EJJz0IiN3vYJ8Fy0byOyqHWRLn
        Q5ZBIsU7MwZ161W0dWeLtcFv5/ou5vI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-SCXHc7dsMPqYce9c6WSivQ-1; Mon, 06 Apr 2020 17:34:36 -0400
X-MC-Unique: SCXHc7dsMPqYce9c6WSivQ-1
Received: by mail-wm1-f72.google.com with SMTP id z24so408304wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=JeyAlbcs3lTsf4sJtgW4hb7rbqlFf9js/OplK35ap+5biWakqsxyKha444L4uDHQfu
         zYSMEzOE/NTJAhO7kg979z1NIcRNvdAQoYBQfDKH0FnygFF36zESrQYMAq6r6s5LVJ47
         XMIzbDxbodBURNw/lpB//enmM3azO77/xJibZhohpQHrW5Ugm5wwk78ymZl8rnCn67NO
         zcaW6gGYqvPEnPKtxsEPY/r15FrxdztgZlDPoxchTbJAWtmRvn7RVYoGV6oAKGHEhObT
         Ymj0/iS/+DbYPCsHZyY0e4SlTLZITQF+y8fd/9ROD2TAnJqJjj8VOzBsAdQVCwTZAe+2
         n2Tg==
X-Gm-Message-State: AGi0Pub+idS5tlU19YcLU3nocQ/5eJ9gnOFXM2YYyONVbdshjHbB5PGB
        ho7bpWXNyS+jo/tBmDAx5c5NL7h2D/opvyPSFeQY+41Pf5pmwX9e7CDR/VrlsShyQ4D/FTzy7g/
        MQ8gkvZiKc2kDwjEJafrHSj6k
X-Received: by 2002:a7b:c402:: with SMTP id k2mr1101238wmi.21.1586208875349;
        Mon, 06 Apr 2020 14:34:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyqEDlE/IL49G3Pxv/kJijKYUNeWb/9wixH2WnadTfCvyxI9caTl+yxyLpMNSiBi9358S8Fg==
X-Received: by 2002:a7b:c402:: with SMTP id k2mr1101230wmi.21.1586208875148;
        Mon, 06 Apr 2020 14:34:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v21sm994848wmh.26.2020.04.06.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:34 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matej Genci <matej.genci@nutanix.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 04/12] virtio: add VIRTIO_RING_NO_LEGACY
Message-ID: <20200406210108.148131-5-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200406213433.VUB_g4fWLezg91cjLPIKB3xmTcGY1aokrNoYj76XchU@z>

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

