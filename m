Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70E322D07
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuGfFuJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHER0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:26:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728754AbgHERPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9jhUCzJG3d5qzZf8hbOT7t6D5kO04BfJCWtdPEBjeI=;
        b=EuGfFuJ98jJiI4vsrkwF3s3H/97E3GQGNHLc8xOsNdA2dYfWXvBrvIgwRsaLz+uot22U4A
        FSM0hzYQCHeot5QW9HB0gYDZWrIN4/VvZZ2Ul5C4AhemnHlcC0ENiK1ffFheILhTQ4cuy1
        udItHAzhDwtC+rrIkIXG4pCNYriKHEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-wCXaPYhgNDObTGfCwAs9Uw-1; Wed, 05 Aug 2020 09:43:35 -0400
X-MC-Unique: wCXaPYhgNDObTGfCwAs9Uw-1
Received: by mail-wr1-f69.google.com with SMTP id m7so13584758wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9jhUCzJG3d5qzZf8hbOT7t6D5kO04BfJCWtdPEBjeI=;
        b=IMk7g9XwQgBLeCnW3liIY4JwJKqmp47hmkTI3R4i8qv+alomDxDF0NFAi9RcnGEA/s
         1cVFJ3DLJyS65efrpKS802SrEVakC5HgHdL0aZubtjEfjvq0ePGCfX17X5YLHypw5n0N
         f3USVmB5bZhgmyuFoIOQHoIib2GWahpS7VvwDhZKBkapE0BtbSz+quWVbBS1k/ma24gL
         cgXTkocBJYaTLtFY/nHGbJi0OeNQxBe6N2E74rO7x1YUhR5hsdUwPseyqypVFA4xhU/T
         YieNP9U6DIGNEMN0nFurnHHs4cpT8IyIPdieRi5B2c2SSr1QKmYUX5fACyTN4zyNaBTj
         xOfg==
X-Gm-Message-State: AOAM5305L72KFefwnaFbOBclkDynzCLIltDDZ6HO1o1eYRbA35FpTDcc
        7MxewTvjzXxRI2A/5WJatFtecsZ4b5wxSwq6t8a/oyWDrIRG9KlP39n91soU0SLGXqfe1PQcyDW
        gtkfPJd2M+2rn8UqrGcOGEwVc
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2969673wrn.10.1596635013754;
        Wed, 05 Aug 2020 06:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfXfkwVyl/Yt6AwMxy0nKXq0LBvruLr2Su9H68DLB9XOWjMZCC4BO0f4hY/ktMSHKoTxRjuA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2969643wrn.10.1596635013338;
        Wed, 05 Aug 2020 06:43:33 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id y203sm2956845wmc.29.2020.08.05.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 06/38] virtio_blk: correct tags for config space fields
Message-ID: <20200805134226.1106164-7-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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

