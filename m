Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E41B22CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUFb27gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgHCU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728605AbgHCU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ksnf9HBHraqrjZuwYMeAj9n5YSqFyP9eX0KH8vvwtbE=;
        b=LUFb27gnW7hye5vuw1DPf26hA/mi8EyXgxBsWmZOabdSnMCVoKAXkX5RGY/zHzMeu7Bp4M
        IK1Gx3ba9WL1CWFWkREm6xzctwZQrVS6rTejfJUa8YKuK/M8IakWczgL7ss/Y06R5w5TNk
        +8TCCCUkjzQArj/vUVd7/4ouPwh4k7I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-EIuZ82bIM0a-IraJbIcr8Q-1; Mon, 03 Aug 2020 16:59:05 -0400
X-MC-Unique: EIuZ82bIM0a-IraJbIcr8Q-1
Received: by mail-qt1-f200.google.com with SMTP id w30so12257740qte.14
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ksnf9HBHraqrjZuwYMeAj9n5YSqFyP9eX0KH8vvwtbE=;
        b=bngHqFar43AfpWs/C+kbZIhE3P28AeqZ0q3QW82qcE4Y3dqHUDIKU2Ox7xiTm9haUG
         gxS5Xrcsr4aJBAILtfukFKLZlIXuLFTxnNqVk82evUtWcq6c2lQu1CQiKeXlC9mucEp0
         8yLRg98baalcVI+NvWVBzCU6Wh0Egl/k6hHeSAIniv6UUqcMsyAovSd1U3xuGfL2ZtEj
         YOGRPfigQEhXSZNRE5OyhRpXedAdaYqsNn5mVM7i+gEp9OtmS9LMuyL/S8laIGq19UUt
         zMeWBcHW6QX7wGvlGNSngB/Ki2Sc1bItPurrmYlDky7qPNq7f6AvZ8yPOVk0JvqzGslY
         vCHw==
X-Gm-Message-State: AOAM532RSLtuWlqG8YARX+rgG1pK80IE8yVeKlvb6/umNGKfduMTOauc
        unhPdZa0ffrM91xQeG1nMlwQg0ly0WFenkbtgQ2HqiGYsagbB+q42USAOVWcqdOBXZr2TmIkdzI
        wsxikPLcsnWqaOSDhMgo9cQDG
X-Received: by 2002:a37:6442:: with SMTP id y63mr18063649qkb.104.1596488344327;
        Mon, 03 Aug 2020 13:59:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9IYdEeh2Xy0HETgWh/0dS6kL2ee/OlcIiyLeyR5/FPEsY7IGKatLylONrDcpjuvaLFPh86Q==
X-Received: by 2002:a37:6442:: with SMTP id y63mr18063622qkb.104.1596488343966;
        Mon, 03 Aug 2020 13:59:03 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id w20sm4939699qki.108.2020.08.03.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:03 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 06/24] virtio_blk: correct tags for config space fields
Message-ID: <20200803205814.540410-7-mst@redhat.com>
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
 include/uapi/linux/virtio_blk.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 0f99d7b49ede..d888f013d9ff 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -57,20 +57,20 @@
 
 struct virtio_blk_config {
 	/* The capacity (in 512-byte sectors). */
-	__u64 capacity;
+	__virtio64 capacity;
 	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
-	__u32 size_max;
+	__virtio32 size_max;
 	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
-	__u32 seg_max;
+	__virtio32 seg_max;
 	/* geometry of the device (if VIRTIO_BLK_F_GEOMETRY) */
 	struct virtio_blk_geometry {
-		__u16 cylinders;
+		__virtio16 cylinders;
 		__u8 heads;
 		__u8 sectors;
 	} geometry;
 
 	/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
-	__u32 blk_size;
+	__virtio32 blk_size;
 
 	/* the next 4 entries are guarded by VIRTIO_BLK_F_TOPOLOGY  */
 	/* exponent for physical block per logical block. */
@@ -78,42 +78,42 @@ struct virtio_blk_config {
 	/* alignment offset in logical blocks. */
 	__u8 alignment_offset;
 	/* minimum I/O size without performance penalty in logical blocks. */
-	__u16 min_io_size;
+	__virtio16 min_io_size;
 	/* optimal sustained I/O size in logical blocks. */
-	__u32 opt_io_size;
+	__virtio32 opt_io_size;
 
 	/* writeback mode (if VIRTIO_BLK_F_CONFIG_WCE) */
 	__u8 wce;
 	__u8 unused;
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
-	__u16 num_queues;
+	__virtio16 num_queues;
 
 	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
 	/*
 	 * The maximum discard sectors (in 512-byte sectors) for
 	 * one segment.
 	 */
-	__u32 max_discard_sectors;
+	__virtio32 max_discard_sectors;
 	/*
 	 * The maximum number of discard segments in a
 	 * discard command.
 	 */
-	__u32 max_discard_seg;
+	__virtio32 max_discard_seg;
 	/* Discard commands must be aligned to this number of sectors. */
-	__u32 discard_sector_alignment;
+	__virtio32 discard_sector_alignment;
 
 	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
 	/*
 	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
 	 * one segment.
 	 */
-	__u32 max_write_zeroes_sectors;
+	__virtio32 max_write_zeroes_sectors;
 	/*
 	 * The maximum number of segments in a write zeroes
 	 * command.
 	 */
-	__u32 max_write_zeroes_seg;
+	__virtio32 max_write_zeroes_seg;
 	/*
 	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
 	 * deallocation of one or more of the sectors.
-- 
MST

