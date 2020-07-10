Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A776820748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0N/o/dD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:48:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727848AbgGJKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594378127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iyQ7Mdq+cHsZNfXMcFEBHnbLg0y1+f956n6Psm19Z3A=;
        b=L0N/o/dDA9BtB6LrSwMQ4QcfzgaemIdtoSuR/SBKBlkHh9wc8mdtpZ1TFmPtz6fFoSWUk0
        YowyTqMk9/XIwQIEsIFX2YWB+SH5Fs5NsnpWLf5UjAFg0at587GMYNPNaDkLhWrdMaIvA9
        9zh4L7N8ooRb08j/bEbdJN4+yneF1z4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-bapRcGWQPQKWgDpilhJ9rA-1; Fri, 10 Jul 2020 06:48:45 -0400
X-MC-Unique: bapRcGWQPQKWgDpilhJ9rA-1
Received: by mail-wm1-f70.google.com with SMTP id c124so6287004wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iyQ7Mdq+cHsZNfXMcFEBHnbLg0y1+f956n6Psm19Z3A=;
        b=J2VFouLy9Cc0eBmT7+oe3KlA/LoKSGX4dBrhfKtw6GMeWolAyqi+uSAoPqjEduwFip
         yW4VDSuqljMUsexnp+CDA2Z/FaP+zhLIuC2J4wxB2JOCEO3KNjP7y/uCOPyws13n7zhr
         hzobvBcxLMbPhhgpDyo2F4XJBFLSmZbBCKNO1LQx5o8yvVM9WPFgDOORkj7ElgU8pvLy
         QpiDrRLAuu5ctOyRprmPp6gYWy7t4jHhrlKwmdIslXnwDeM82Oz4mlEH5yn17bnsVI5Z
         3LVGlAHaXH06+bdaVJ92teBHD3zIvN0gx6vs58ZErkZx9qK8o2g+22gBH4IG0ABmbA2f
         tKuw==
X-Gm-Message-State: AOAM530R7pD0TvPWY8itHIpDGmS2wHZ9yz7bEpxRCUMCwFfEXb4IiMJ7
        oM5G4VlVeB8bu/ItFav7gsv4y83jict1o8S5IZCZYRqjpv0KjL+jyYbdUu+EG40D6/zN6xsq5sd
        im+SAL/0LA9vXo6mM7VzhG6D1
X-Received: by 2002:a1c:7306:: with SMTP id d6mr4281126wmb.113.1594378123167;
        Fri, 10 Jul 2020 03:48:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnW96UmADFr3lBKu+J51FwC7hW91yxrY9fm+6R2FmCNMnZCpNPJGpddYdjDEzeRnojHSJuXQ==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr4281109wmb.113.1594378123028;
        Fri, 10 Jul 2020 03:48:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id w13sm9528434wrr.67.2020.07.10.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 03:48:42 -0700 (PDT)
Date:   Fri, 10 Jul 2020 06:48:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_balloon: fix sparse warning
Message-ID: <20200710104837.405966-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

balloon uses virtio32_to_cpu instead of cpu_to_virtio32
to convert a native endian number to virtio.
No practical difference but makes sparse warn.
Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fc7301406540..5d4b891bf84f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -596,7 +596,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 	while (virtqueue_get_buf(vq, &unused))
 		;
 
-	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
+	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
 					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
-- 
MST

