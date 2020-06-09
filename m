Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5483D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhdNibbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgFIJzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:55:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgFIJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591696499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4uQuFZE858ZtA1kxzlQrkbfz4UDM1Xi81yVG0teJSpc=;
        b=fhdNibbVykWH6CZReVgtTXcHOKJ9bHRwxmOuzv0WGKH9XZYGLrg+onnPHNUIs/lmUBgbgE
        2DPONsv8b3XpLZJyoRPyKinAt9SofC+3/WEJcEhv9ykqcKadLgMfSlM409mFb05Q67XNb3
        IGwFDsjDbk8ukuuIikAPMoSjtV6LuFc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-qmJb0TeXOvqln5FPBtqVbQ-1; Tue, 09 Jun 2020 05:54:58 -0400
X-MC-Unique: qmJb0TeXOvqln5FPBtqVbQ-1
Received: by mail-wr1-f70.google.com with SMTP id n6so8408483wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4uQuFZE858ZtA1kxzlQrkbfz4UDM1Xi81yVG0teJSpc=;
        b=VS+PzeUW0+PzOmDbu+y7fHgsb7AQ1HPT2e1aVYy+8Vu0XhyDhnbPq4uMOGUee5vyDp
         tsEzcMNKUlk7WP1dJ27BtvgbhDabnPBDHiR5FpFua4uHCFnpbh05oqGho3xHTkD99vGg
         Fjjq87YzmbtjWRnBuowB0yFz5G0DTU13lA+c0fZ4bB/3GIYy5zv9hbaFzn00+ii4GNbY
         vcP6m44yBwMrPgZEgaRa5LevJ/BInG0EvscdkTmHLSTa8dHJrgLWaV1er1q7kZ5FPW4D
         5l0MtBv+7HTs5wzGffU0+LUqjPC0ehyfShNm9yAyzw6gASMWlltrIRxpaZI4ob1PR6Mn
         UxeQ==
X-Gm-Message-State: AOAM530uIa3TLda+ZJDsYGUUVhoh+5S53o6Oq67vTxDO6XnYmco0VRJU
        7Avz3OSSUXJ7hif9UfYKJe6jEyKPHPvtNHk19nMVIlx3YIArtR4uDvcNzdfo5MEx7j2WnEUTN1N
        zrTIb8vbtoeo0QVFQ5bhwxcJH
X-Received: by 2002:adf:f552:: with SMTP id j18mr3307191wrp.279.1591696496853;
        Tue, 09 Jun 2020 02:54:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCbImdPZKhsgwExIy/WRmfb9dy+Hxq4t3PJbaH5t/zLpLqfOCP8FZP3A9tvZhzrBR8Z4U76w==
X-Received: by 2002:adf:f552:: with SMTP id j18mr3307186wrp.279.1591696496718;
        Tue, 09 Jun 2020 02:54:56 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id x186sm2380539wmg.8.2020.06.09.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 02:54:56 -0700 (PDT)
Date:   Tue, 9 Jun 2020 05:54:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_mem: fix printk format
Message-ID: <20200609095453.865827-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 676fa9ba893e ("virtio_mem: convert device block size into 64bit")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 7b1bece8a331..50c689f25045 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1717,8 +1717,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 (unsigned long long)vm->device_block_size);
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
-	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
-		 vm->subblock_size);
+	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
+		 (unsigned long long)vm->subblock_size);
 	if (vm->nid != NUMA_NO_NODE)
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
-- 
MST

