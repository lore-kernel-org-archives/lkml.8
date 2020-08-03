Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E365C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E7322C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZiu2XqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgHCVAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:00:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50030 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729163AbgHCVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+p73nl+scMLErwVWZPy2fCb3efmQTrWaZiPCg4cXlI=;
        b=JZiu2XqQ33YzTnDft6q/pJwazFo/2uxUC8iRHMlqkuN4Fq8xiMly2Ld52bbOTaT/4gqFkW
        oBHIsqnh+bjUjB6zfzivkwX44275kSfXvnpGghWVxDtRQo8jLdW6P2UwHBJm+zE+jghNLv
        fWvEj/Os3Q8nCGh3Su/B9AG6uwe3tYo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-WF_PfxhrMNWlmPEZAEFbZg-1; Mon, 03 Aug 2020 16:59:58 -0400
X-MC-Unique: WF_PfxhrMNWlmPEZAEFbZg-1
Received: by mail-qk1-f199.google.com with SMTP id z1so21355492qkg.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+p73nl+scMLErwVWZPy2fCb3efmQTrWaZiPCg4cXlI=;
        b=hlIT9HfJnkHBC02IOdYJYoWqGIvdqMd8rbvVDIXA0cNUF8qWldp6Us5rIKf/+D/8F2
         ezXSfVXviTWiceEvMfMD+N/8F2m7XqovkIr+IcqQo9h1LW4FaPywddw7QNpWdHTXSNk4
         JLG00UyqDAtW5TANyVitA1t/uV3R8nzs9cjYeIXVuEA2AEwQ0VKJcIiOZ2JGP65KJsJP
         QypA5g+aEkvyUbCrfKopWRTkYTucMCnAmjJiRaXSAeSURdo/YY6akKui58N79RGwa1nT
         JK2lqtQY+q7vXy1O7OUNI4cCjWKrSY6HKLCkKNKkkDNRVw40pv2iOMgiqGP4HG6rLIS2
         LG+g==
X-Gm-Message-State: AOAM531oIZ1b3ncQPM/SHf+JfjLiwyP9UcPwfIWbS2L4XUW1oavoxH1+
        PnC2nlX+6ZDCLkbGcqy+C7a6L8sJ5m0PjDtHw+q5rDcwa0qnOT2OnwKfV47w8nf/B9heffRJcNt
        XDf9XW63gyX3pCsGbi0ue4SQP
X-Received: by 2002:a37:8a06:: with SMTP id m6mr17949042qkd.191.1596488397675;
        Mon, 03 Aug 2020 13:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+kFhyjENOmK99izI/iD0vLcf7qIDUTr7k6L/7ugA+5BkNdYKwj7GdM+Gahf0BqUL5tx7Xeg==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr17949024qkd.191.1596488397469;
        Mon, 03 Aug 2020 13:59:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id t35sm23436618qth.79.2020.08.03.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:56 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 16/24] virtio_scsi: correct tags for config space fields
Message-ID: <20200803205814.540410-17-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c       |  4 ++--
 include/uapi/linux/virtio_scsi.h | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e0910c5b942..c36aeb9a1330 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -746,14 +746,14 @@ static struct scsi_host_template virtscsi_host_template = {
 
 #define virtscsi_config_get(vdev, fld) \
 	({ \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val; \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val; \
 		virtio_cread(vdev, struct virtio_scsi_config, fld, &__val); \
 		__val; \
 	})
 
 #define virtscsi_config_set(vdev, fld, val) \
 	do { \
-		typeof(((struct virtio_scsi_config *)0)->fld) __val = (val); \
+		__virtio_native_type(struct virtio_scsi_config, fld) __val = (val); \
 		virtio_cwrite(vdev, struct virtio_scsi_config, fld, &__val); \
 	} while(0)
 
diff --git a/include/uapi/linux/virtio_scsi.h b/include/uapi/linux/virtio_scsi.h
index cc18ef8825c0..0abaae4027c0 100644
--- a/include/uapi/linux/virtio_scsi.h
+++ b/include/uapi/linux/virtio_scsi.h
@@ -103,16 +103,16 @@ struct virtio_scsi_event {
 } __attribute__((packed));
 
 struct virtio_scsi_config {
-	__u32 num_queues;
-	__u32 seg_max;
-	__u32 max_sectors;
-	__u32 cmd_per_lun;
-	__u32 event_info_size;
-	__u32 sense_size;
-	__u32 cdb_size;
-	__u16 max_channel;
-	__u16 max_target;
-	__u32 max_lun;
+	__virtio32 num_queues;
+	__virtio32 seg_max;
+	__virtio32 max_sectors;
+	__virtio32 cmd_per_lun;
+	__virtio32 event_info_size;
+	__virtio32 sense_size;
+	__virtio32 cdb_size;
+	__virtio16 max_channel;
+	__virtio16 max_target;
+	__virtio32 max_lun;
 } __attribute__((packed));
 
 /* Feature Bits */
-- 
MST

