Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E901E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRWep9/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgG0QDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727116AbgG0QDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595865830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PzdX7wVbIx8ObG6INsApXS+qCsher40rhMpcw3UMWXc=;
        b=fRWep9/eDzx7Ww6z4zN62m+rTnXBNTYCOg7UuWVuOsuPf17ojus0npnfFNslirEqNBp0GD
        DhxnNcqh91EVD4gIY0ZAV6TvzGjcDazOfwHY04iqlTfr5Sai/0tcf0mS75P2YPjXMjF7BH
        12Xh1PcEEYssn4/Mk/n9R2d6eyic8TA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-xNh-l0k5P1acssznhjs_Xg-1; Mon, 27 Jul 2020 12:03:48 -0400
X-MC-Unique: xNh-l0k5P1acssznhjs_Xg-1
Received: by mail-wr1-f69.google.com with SMTP id h4so4107705wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PzdX7wVbIx8ObG6INsApXS+qCsher40rhMpcw3UMWXc=;
        b=WKrmNfNY7dq9ev+VdDCi/PN5EjQXTIOg/gkgDssVOH7nLwSy0Yhq59o6wTj6ZuxSw0
         dEqGaB/PzQWX0XRB6d3MNCQFVIcviYXNyHyI4+g6W/0HbC8X15Mo6o30ZJ1fHRkxWmNe
         MDZ+ZVLR/rthVRHwyXRMzQ0M1TlfrAKl3KKTyAztxMHwXkTwdQFtNj+HDSKP5nNRxcRt
         IZKgBPvu0Y1FuF6f+WnajthnulDPXHjVb3Wl8GfD+i7vakQeQxVYellWKQ/U56NkESZu
         4OSNdf3lDywk93vg+B1zKwEOZsAGuIrizTy37D8W0Q793ZkXEhruLRUlcsXpk7vmsKmr
         xfvA==
X-Gm-Message-State: AOAM5324rijOkNKAcGdUYsED1nS8/xvu62d6+fSy9RM7uqKdSvtmqZEr
        J1cKl2hyMKJC7m7j7qjC2YQ5W7jaJbiiZTbU+Nf2OVMrVHABzczwjpNivD81km+4G5ouXnonUiP
        SWmQ+iNdCJdmhYfut8aXE7ErI
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr22476416wra.118.1595865827382;
        Mon, 27 Jul 2020 09:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7Ef1D9xDtsNFK+f9eP9IKT0MLwb1s7S8Er/1M1xlErxN9gFMzZ7/LwGj3k9MKPcujJZ0e8g==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr22476396wra.118.1595865827149;
        Mon, 27 Jul 2020 09:03:47 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id z63sm111712wmb.2.2020.07.27.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:03:46 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:03:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Liang Li <liang.z.li@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        virtualization@lists.linux-foundation.org,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH] virtio_balloon: fix up endian-ness for free cmd id
Message-ID: <20200727160310.102494-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free cmd id is read using virtio endian, spec says all fields
in balloon are LE. Fix it up.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 774deb65a9bb..798ec304fe3e 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -578,10 +578,14 @@ static int init_vqs(struct virtio_balloon *vb)
 static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
 {
 	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
-			       &vb->config_read_bitmap))
+			       &vb->config_read_bitmap)) {
 		virtio_cread(vb->vdev, struct virtio_balloon_config,
 			     free_page_hint_cmd_id,
 			     &vb->cmd_id_received_cache);
+		/* Legacy balloon config space is LE, unlike all other devices. */
+		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
+			vb->cmd_id_received_cache = le32_to_cpu((__force __le32)vb->cmd_id_received_cache);
+	}
 
 	return vb->cmd_id_received_cache;
 }
-- 
MST

