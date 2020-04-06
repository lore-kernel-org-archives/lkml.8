Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A6AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECE120768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijQCpYRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDFVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20498 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgDFVCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=ijQCpYRLff04Kz4gzKbwhtd1SDAHUUFQPTFDlVnC3+sqAB5JdXb8lP7KVz1cxYr4uhrCms
        Y6tj3ezjAvivhLJf6PHSRcxb+d2m2PrwHAfG7NtAib0uXnIPV6HDjleFCznBPob4zlvn/8
        cXZB6eitnbAOTmQrmorpto9yYiwX6e0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-wO9jBLiuPLmvtKU_UNTy-A-1; Mon, 06 Apr 2020 17:02:02 -0400
X-MC-Unique: wO9jBLiuPLmvtKU_UNTy-A-1
Received: by mail-wr1-f70.google.com with SMTP id a10so542956wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWI++drUheRLgJRLP25chFJvpGmbc+MWUzzhPso8aKg=;
        b=aCO9OCcsHR2+v/RlXsR7BlPh7z9gpEDa/7azuVVwsB4+s7pqTHL8XXUXLvRIaRvp9K
         GWlU0a+46ILSdRZvn+XTHOb6i//+ofVtdIbU56Pr2TKfD6waUccjAtssUs1/IENFmgYI
         /Yyt1rOeEifzG2WVZNyA0bNWiANdEaaAoiC/50IT4uvPhGzcVj4uheC/Q5XrLEcHbBbH
         tFyo2WZW53axBHRMR/1nZRRHtTRF5vZMifmw+KDY9LC8/5X67lgx7/zoyMlrBwZ/s55Q
         4KXpEHNHWXnCN8V0XvKR0J1wVzWTx/EMMRqLH+uepSrc0N1D3xQHNeSruRCgGOBBAyCq
         2G7Q==
X-Gm-Message-State: AGi0PubvoymkSO9ErqYCDhXPs+A4qDM6hBdhqVOtGewn+eKMjGi9gsrd
        bHJq8EvEJuupWPi6xpfwvI2j0YFDl/Y9fQ/KS03fVpc0csQa5oyjCJ6/QNJ9is8HyHHAZ+FOiJq
        o1cNXSOEnig+V7YzNC80ctdnC
X-Received: by 2002:adf:b649:: with SMTP id i9mr1142447wre.293.1586206921463;
        Mon, 06 Apr 2020 14:02:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEUYmfMYe/JzPrGlq7UBZFq2PWhrh/0jswkaT4g7tdTKSXDPxWMZEEhPI5nnJzrSDsMC4jLQ==
X-Received: by 2002:adf:b649:: with SMTP id i9mr1142431wre.293.1586206921274;
        Mon, 06 Apr 2020 14:02:01 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f3sm1037368wmj.24.2020.04.06.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:00 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:01:59 -0400
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

