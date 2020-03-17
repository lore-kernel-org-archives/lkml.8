Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B3820714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443129;
	bh=x/iwEgPCjqg1vr+Jo85dKncNW7v4aqB6+4VNxqJquD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JyZjmqyAEnw/SZJ+LKYjL04fViYjm+QfSEAON2FdMMmYRlYnxZSIe8xqsH2ZwXPtk
	 Ql2Jsru3JPs9DF9P9E9uMVsbNLwqG3jNaOb4kE1dNoiTVqZMne82OYacuTJDHRrF42
	 rJKJA/1UBezZEDM5hgVVs0l5JYWEnJH5iXWC9eMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgCQLF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgCQLFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055DE20736;
        Tue, 17 Mar 2020 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443117;
        bh=x/iwEgPCjqg1vr+Jo85dKncNW7v4aqB6+4VNxqJquD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rOYSmPgslhsUtz9n6PlW2cFSepmZtR00xu/Nrx1iMArPaXBLvPuGBi+32HIJfIOd
         hZZj+3UH4TfPifbhueHXni06KeoPluvzrnXstUlM0RDGfdml0PZgYfXnVd4m7+Wq1l
         hDbNvupEl1gd3XoCxAvEBNyMd6fMqg59VQquid3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5.4 101/123] virtio_ring: Fix mem leak with vring_new_virtqueue()
Date:   Tue, 17 Mar 2020 11:55:28 +0100
Message-Id: <20200317103317.968666344@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

commit f13f09a12cbd0c7b776e083c5d008b6c6a9c4e0b upstream.

The functions vring_new_virtqueue() and __vring_new_virtqueue() are used
with split rings, and any allocations within these functions are managed
outside of the .we_own_ring flag. The commit cbeedb72b97a ("virtio_ring:
allocate desc state for split ring separately") allocates the desc state
within the __vring_new_virtqueue() but frees it only when the .we_own_ring
flag is set. This leads to a memory leak when freeing such allocated
virtqueues with the vring_del_virtqueue() function.

Fix this by moving the desc_state free code outside the flag and only
for split rings. Issue was discovered during testing with remoteproc
and virtio_rpmsg.

Fixes: cbeedb72b97a ("virtio_ring: allocate desc state for split ring separately")
Signed-off-by: Suman Anna <s-anna@ti.com>
Link: https://lore.kernel.org/r/20200224212643.30672-1-s-anna@ti.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2203,10 +2203,10 @@ void vring_del_virtqueue(struct virtqueu
 					 vq->split.queue_size_in_bytes,
 					 vq->split.vring.desc,
 					 vq->split.queue_dma_addr);
-
-			kfree(vq->split.desc_state);
 		}
 	}
+	if (!vq->packed_ring)
+		kfree(vq->split.desc_state);
 	list_del(&_vq->list);
 	kfree(vq);
 }


