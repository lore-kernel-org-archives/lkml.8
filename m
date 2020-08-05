Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12110206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3HlkJLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgHET2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728401AbgHERL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dHJWpRpe+SGCeKRCL7RrX1ymnMkDIH+g5Ri3pUQbvw=;
        b=H3HlkJLAUu8Lj6wSmGqSXHK1Z16X0UOdIw6G5//tPXHPiA/SYC2lPKex5611TUcNN8i41J
        Gq/SmKgA3bw4tjcV4VLfffguIrGEL6c6HidkyuhRyIcHOBjoB6jcrLJJKK9oboLJdi3rH7
        tAIs8JNJSIgsS/M2cv0TuMf2qu0dX70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-RB_ERJMfOrmN89RTL3nP2g-1; Wed, 05 Aug 2020 09:44:38 -0400
X-MC-Unique: RB_ERJMfOrmN89RTL3nP2g-1
Received: by mail-wm1-f71.google.com with SMTP id c184so1973887wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dHJWpRpe+SGCeKRCL7RrX1ymnMkDIH+g5Ri3pUQbvw=;
        b=UwneuivqsJqQCNTRKIdODC/cBCSA3Y9zcJS35mowRVCuzdjlkYV3hvydqF1Gulh1I/
         sPLnL+SRrxL7/jBzIwjRC+YTRlAzV+rtzOFQ8xJPvhG62ID3eRrqU9bYBm/OmYY8ZBcT
         MIXnt2h+Nm0mXM+aWWsp1NBC3TakWc4Boy/1Z2NVt1lzPPVBwOhlFpxFofLe1Z1Bb4ag
         WhgnVvBWpEdk6ig18fyQr6G3ovite1VH0oCnEIT2Kfly7Getr0Ey0b5cir1a1sol29qh
         mlxPRzVyDaErwKdwXEU9xkcfsdVI3jG9jnqF4QOJ4p2IvoppOieMB7htukS3mD/qKnfz
         zxlw==
X-Gm-Message-State: AOAM530d++m+h80cWq7FR1PWe/nOg2hOEaI3GO33VaCXQF1wiCkgme1i
        xEev9xjOxL9InPies5Fif1XUhibRjCe8zmyhySQT37YYHqi2EyB0MjGUtsc7ZoMBbelV8qFojWH
        CHbg5aSPRsZfRwnHKVtOgMhTr
X-Received: by 2002:adf:b441:: with SMTP id v1mr2885514wrd.61.1596635076657;
        Wed, 05 Aug 2020 06:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQGdbl54JNx1KvL4TiD4XZk3a0G829i0AZqCQq/0GXJ2UmmPCnIhNjqrC/ljNwKlqjr429kg==
X-Received: by 2002:adf:b441:: with SMTP id v1mr2885496wrd.61.1596635076408;
        Wed, 05 Aug 2020 06:44:36 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id o2sm3136755wrh.70.2020.08.05.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:35 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 29/38] virtio_balloon: use LE config space accesses
Message-ID: <20200805134226.1106164-30-mst@redhat.com>
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

Balloon is LE, it's cleaner to access it as such directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8bc1704ffdf3..31cc97f2f515 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -398,12 +398,9 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	s64 target;
 	u32 num_pages;
 
-	virtio_cread(vb->vdev, struct virtio_balloon_config, num_pages,
-		     &num_pages);
-
 	/* Legacy balloon config space is LE, unlike all other devices. */
-	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-		num_pages = le32_to_cpu((__force __le32)num_pages);
+	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
+			&num_pages);
 
 	target = num_pages;
 	return target - vb->num_pages;
@@ -462,11 +459,8 @@ static void update_balloon_size(struct virtio_balloon *vb)
 	u32 actual = vb->num_pages;
 
 	/* Legacy balloon config space is LE, unlike all other devices. */
-	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-		actual = (__force u32)cpu_to_le32(actual);
-
-	virtio_cwrite(vb->vdev, struct virtio_balloon_config, actual,
-		      &actual);
+	virtio_cwrite_le(vb->vdev, struct virtio_balloon_config, actual,
+			 &actual);
 }
 
 static void update_balloon_stats_func(struct work_struct *work)
@@ -579,12 +573,10 @@ static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
 {
 	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
 			       &vb->config_read_bitmap)) {
-		virtio_cread(vb->vdev, struct virtio_balloon_config,
-			     free_page_hint_cmd_id,
-			     &vb->cmd_id_received_cache);
 		/* Legacy balloon config space is LE, unlike all other devices. */
-		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
-			vb->cmd_id_received_cache = le32_to_cpu((__force __le32)vb->cmd_id_received_cache);
+		virtio_cread_le(vb->vdev, struct virtio_balloon_config,
+				free_page_hint_cmd_id,
+				&vb->cmd_id_received_cache);
 	}
 
 	return vb->cmd_id_received_cache;
@@ -987,8 +979,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		if (!want_init_on_free())
 			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
 
-		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
-			      poison_val, &poison_val);
+		virtio_cwrite_le(vb->vdev, struct virtio_balloon_config,
+				 poison_val, &poison_val);
 	}
 
 	vb->pr_dev_info.report = virtballoon_free_page_report;
-- 
MST

