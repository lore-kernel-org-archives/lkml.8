Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537B820768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg8Vj/gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgDFVfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37406 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726708AbgDFVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=Mg8Vj/gSwdhlNbgAr3FwEyVtVnfFe74j6FkXKNpo6Y2sjrAryV6/F4irQ13Be0WTFVUAhv
        lWcVu+JJxAZgM6Ytf0vWZCow0mw15mJVmY0l3o0WS4bjLspxtR6Rxqjmas6Eo61scFXvbV
        qAeX7jQ7RqgwNwLXI3x0f4r/Dl0WfrI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-jcIKQg4EMUS0ydXkX2N4Dw-1; Mon, 06 Apr 2020 17:35:08 -0400
X-MC-Unique: jcIKQg4EMUS0ydXkX2N4Dw-1
Received: by mail-wr1-f70.google.com with SMTP id m15so592439wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+P99eoGOE59dzJri6nDdYTRF/iHp1rUM821OiEBSWI=;
        b=h3R0xVQbs2Yt4+eed13BoVTFAlkZn0NoKek9VwcnQxuiuHRze44ag//OHP3IBirF/b
         GawYRLM2GcrLHsvChPZaJu5Krbnh4/trQDJ/KYd2mhK0ooZ6RRoELJtcuD9fz3PqSCGw
         ANIH5XjXLMCrQVF9Oab/vhDsmsziBLa2HbNM/+83QtKWMabVo40QnQfsgP3vCub4SsNy
         cdPSElV8IuXeeghvQyqUNVyF7OkzMfr9C1bO5ThgokuracOWsu7W/LtfU11oofb8/jIB
         Mu72t47JuhBPQZl3wwOEcyayVAe2JC5JlTVMRxy6j2aXEy4p0YLzN2+UzpIDJ1LlPYie
         Gx9g==
X-Gm-Message-State: AGi0PuYv6LnJIzklTdLTMuiF541B5boYS6nK8xS9VYiH990SINOzJdN/
        KSINqyyKoorXeEKYR5x52Ew7T9acvtkY9Gy/9VjH8/x+doFbn9nF5PHSISqgYN+nlgvtHGY7bDa
        tR3axlpenEytAwSBw2SLBELb5
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr1417296wrs.39.1586208907584;
        Mon, 06 Apr 2020 14:35:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcIiWn1HPwA+vMFpmabnpjQIkpeHu9tKG3iwnUgYRQLaqvdB7lSYnAh68ff+ai34FiHnYBKA==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr1417269wrs.39.1586208907340;
        Mon, 06 Apr 2020 14:35:07 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id u22sm1003113wmu.43.2020.04.06.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:06 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v5 06/12] vhost: force spec specified alignment on types
Message-ID: <20200406213314.248038-7-mst@redhat.com>
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

The ring element addresses are passed between components with different
alignments assumptions. Thus, if guest/userspace selects a pointer and
host then gets and dereferences it, we might need to decrease the
compiler-selected alignment to prevent compiler on the host from
assuming pointer is aligned.

This actually triggers on ARM with -mabi=apcs-gnu - which is a
deprecated configuration, but it seems safer to handle this
generally.

I verified that the produced binary is exactly identical on x86.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.h       |  6 +++---
 include/linux/virtio_ring.h | 24 +++++++++++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 11680e74761a..c3f9ca054250 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,14 +60,32 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
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
 struct vring {
 	unsigned int num;
 
-	struct vring_desc *desc;
+	vring_desc_t *desc;
 
-	struct vring_avail *avail;
+	vring_avail_t *avail;
 
-	struct vring_used *used;
+	vring_used_t *used;
 };
 
 /*
-- 
MST

