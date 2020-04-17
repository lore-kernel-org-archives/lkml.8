Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0263EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40DB20644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGZyQaCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgDQH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:59:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729570AbgDQH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587110383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pttTsXfJsO5qd96fUX4GjjyN7BeuHWmaGEZtAEZg4sw=;
        b=JGZyQaCF22GjlcWxgvZ6EnJNTdgDPjQ31Nz+rZ4wATTlWBnFX1tXBvHWf0DXl2Lh7iLe+M
        rxHxjEuEPMib4Lskrzjwf/uLCBUcMd8I+MpfaHTCSOm1ySRC0lx1F39okbm3bFnNwRQNa1
        PVYnewiFl1NmpF92UahNSyUQb8Q1w74=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-h7Ug2J4yO0Ow-2xyHZWPCg-1; Fri, 17 Apr 2020 03:59:39 -0400
X-MC-Unique: h7Ug2J4yO0Ow-2xyHZWPCg-1
Received: by mail-wr1-f69.google.com with SMTP id u4so599165wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pttTsXfJsO5qd96fUX4GjjyN7BeuHWmaGEZtAEZg4sw=;
        b=jWhec4fkwGo1FNKZi/ZNWh7ggU0jGIDlAtfGtsh5OdLfFm6ULlEk3YQ3L9U0I6GVmj
         OVNay0DDK3hLEDCxY2n0jNZIHL3HXX74cXbgyG7HImYhgCk/cLpZZL7S9vpge17ZhoBO
         GimlNJpahMDDmyNSoarq35+LqJA5jK6+t9Jpfy+J7vNSjbupfVEX5oitFlLGTyZPxoHv
         yOLxDS4F0jMn4y55wCWTin3RNh13+rDrOa6FQ84VPoqI+tbKuksFr1HQAxy08A4b3oGo
         zyRrZ6ehTtUrc74r5j57e1h0fH1Ek5wJvvOmdkRG2ArtUIepYCfdSsLIRQZZNQ9MDav9
         Tviw==
X-Gm-Message-State: AGi0PuaV5K8vr5pS15fTuo3C16PFigWGKYAvEZhOafngExAOLBoVj2ru
        Iy8qLcOyjFUp16sVmgl2x0zgQYRHqVJTgNIkKOOHCE6Xkcc+A2kpB3knZjuK4zwfU4b98FmuHSg
        x2tXq+p5NExOhaYyf1Q7Fyz4t
X-Received: by 2002:a1c:9d84:: with SMTP id g126mr1898737wme.184.1587110378074;
        Fri, 17 Apr 2020 00:59:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7JfXhE5vFVj1kJeWaNlkc8YDs13yjfj3N/sFo8oSVy/wgjrWfOFrSOQ9Dg05aWCm/T5Fq4A==
X-Received: by 2002:a1c:9d84:: with SMTP id g126mr1898718wme.184.1587110377796;
        Fri, 17 Apr 2020 00:59:37 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
        by smtp.gmail.com with ESMTPSA id o28sm16416939wra.84.2020.04.17.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:59:37 -0700 (PDT)
Date:   Fri, 17 Apr 2020 03:59:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v9] virtio: force spec specified alignment on types
Message-ID: <20200417075551.12291-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring element addresses are passed between components with different
alignments assumptions. Thus, if guest/userspace selects a pointer and
host then gets and dereferences it, we might need to decrease the
compiler-selected alignment to prevent compiler on the host from
assuming pointer is aligned.

This actually triggers on ARM with -mabi=apcs-gnu - which is a
deprecated configuration, but it seems safer to handle this
generally.

Note that userspace that allocates the memory is actually OK and does
not need to be fixed, but userspace that gets it from guest or another
process does need to be fixed. The later doesn't generally talk to the
kernel so while it might be buggy it's not talking to the kernel in the
buggy way - it's just using the header in the buggy way - so fixing
header and asking userspace to recompile is the best we can do.

I verified that the produced kernel binary on x86 is exactly identical
before and after the change.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I am still not sure this is even needed. Does compiler make
optimizations based on ABI alignment assumptions?


Changes from v8:
	- better commit log
	- go back to vring in UAPI

 drivers/vhost/vhost.h            |  6 ++---
 include/uapi/linux/virtio_ring.h | 38 +++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f8403bd46b85..60cab4c78229 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -67,9 +67,9 @@ struct vhost_virtqueue {
 	/* The actual ring of buffers. */
 	struct mutex mutex;
 	unsigned int num;
-	struct vring_desc __user *desc;
-	struct vring_avail __user *avail;
-	struct vring_used __user *used;
+	vring_desc_t __user *desc;
+	vring_avail_t __user *avail;
+	vring_used_t __user *used;
 	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
 	struct file *kick;
 	struct eventfd_ctx *call_ctx;
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9223c3a5c46a..177227f0d9cd 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -118,16 +118,6 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
-struct vring {
-	unsigned int num;
-
-	struct vring_desc *desc;
-
-	struct vring_avail *avail;
-
-	struct vring_used *used;
-};
-
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -135,6 +125,34 @@ struct vring {
 #define VRING_USED_ALIGN_SIZE 4
 #define VRING_DESC_ALIGN_SIZE 16
 
+/*
+ * The ring element addresses are passed between components with different
+ * alignments assumptions. Thus, we might need to decrease the compiler-selected
+ * alignment, and so must use a typedef to make sure the __aligned attribute
+ * actually takes hold:
+ *
+ * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
+ *
+ * When used on a struct, or struct member, the aligned attribute can only
+ * increase the alignment; in order to decrease it, the packed attribute must
+ * be specified as well. When used as part of a typedef, the aligned attribute
+ * can both increase and decrease alignment, and specifying the packed
+ * attribute generates a warning.
+ */
+typedef struct vring_desc __aligned(VRING_DESC_ALIGN_SIZE) vring_desc_t;
+typedef struct vring_avail __aligned(VRING_AVAIL_ALIGN_SIZE) vring_avail_t;
+typedef struct vring_used __aligned(VRING_USED_ALIGN_SIZE) vring_used_t;
+
+struct vring {
+	unsigned int num;
+
+	vring_desc_t *desc;
+
+	vring_avail_t *avail;
+
+	vring_used_t *used;
+};
+
 #ifndef VIRTIO_RING_NO_LEGACY
 
 /* The standard layout for the ring is a continuous chunk of memory which looks
-- 
MST

