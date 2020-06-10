Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49628C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274D0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRuhn5aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgFJLhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728742AbgFJLgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591788997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEosg1cbEhe9hhKHYKqZg2N/D89Ri/A+CQJLw8Cq4Bg=;
        b=NRuhn5aZWJTbFcxQIgI38iMSwyMb2tshI1jQd38v65QpOHsV+dAAaHohYcLICgyeU5zyZc
        lrT9wR+AaSoOZyhpXZmU+OkoWXZIyjkIaRtZ1ZM4OKwLmLkf5DjDrRK3QLdvifGNbobE6x
        sX5zUlocIIwsK0ZeSnFfoJVnFEGQw24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-SfQ42bn_Ma6J1AjiR052gg-1; Wed, 10 Jun 2020 07:36:34 -0400
X-MC-Unique: SfQ42bn_Ma6J1AjiR052gg-1
Received: by mail-wr1-f72.google.com with SMTP id c14so957737wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEosg1cbEhe9hhKHYKqZg2N/D89Ri/A+CQJLw8Cq4Bg=;
        b=D66vCdKRywSNIxK3KsQkbOlecMEMmzfJFiv5aQX/KqFJ/nDm9o2yr6u/op1ipiexf7
         PxOkzwEAbbxQUXzIjuXxWzIInOObRxwL+PcH1U7dmWcP+qBwiKWABNEb46Ta3RqLGqFx
         vnlU78SAc26XSozkbXX1LT42Mga4FhJJqYlmHOjR7Cwi0R2+YiZlSCBxxbfEtCYskNMI
         VsL6hXjPZvDjlRJO/pCXd7m9TQZV/uQ510txxLEhXrxggy7LDSPTMUHP3d9At6zEUTTO
         et2YPXn10jLyO8hQBBF/H5GIrwTJ+2p7BetOJpxz0oHdn6zFgkVV/KYCEtWi0Qq/THnX
         SmVg==
X-Gm-Message-State: AOAM530RGRSHJnpyDDcf7oUH84MPIxIeJgKrIVFOSVhqPNCp5KkIAbWe
        N9kGdckMeKXl/yWLtas8eGT1GOXGZ1VPnQkO+C9GKmbf6nq7XpAHsJB/f6rqOmlNw74cP4adZjh
        ckzxzPdH2He9QCp95E2DBjLyq
X-Received: by 2002:a05:600c:645:: with SMTP id p5mr2706631wmm.156.1591788993079;
        Wed, 10 Jun 2020 04:36:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwILwbhe48IqgvIMdBk87XXEqvw7WkIjeF+xwxu1AVsMzWmysnuJrztuEZ4mW7XzCxYzVz5BQ==
X-Received: by 2002:a05:600c:645:: with SMTP id p5mr2706609wmm.156.1591788992842;
        Wed, 10 Jun 2020 04:36:32 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
        by smtp.gmail.com with ESMTPSA id e15sm6867215wme.9.2020.06.10.04.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:36:32 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:36:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RFC v7 13/14] vhost/vsock: switch to the buf API
Message-ID: <20200610113515.1497099-14-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A straight-forward conversion.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a483cec31d5c..61c6d3dd2ae3 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -103,7 +103,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		unsigned out, in;
 		size_t nbytes;
 		size_t iov_len, payload_len;
-		int head;
+		struct vhost_buf buf;
+		int ret;
 
 		spin_lock_bh(&vsock->send_pkt_list_lock);
 		if (list_empty(&vsock->send_pkt_list)) {
@@ -117,16 +118,17 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		list_del_init(&pkt->list);
 		spin_unlock_bh(&vsock->send_pkt_list_lock);
 
-		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
-					 &out, &in, NULL, NULL);
-		if (head < 0) {
+		ret = vhost_get_avail_buf(vq, &buf,
+					  vq->iov, ARRAY_SIZE(vq->iov),
+					  &out, &in, NULL, NULL);
+		if (ret < 0) {
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
 			spin_unlock_bh(&vsock->send_pkt_list_lock);
 			break;
 		}
 
-		if (head == vq->num) {
+		if (!ret) {
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
 			spin_unlock_bh(&vsock->send_pkt_list_lock);
@@ -186,7 +188,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		buf.in_len = sizeof(pkt->hdr) + payload_len;
+		vhost_put_used_buf(vq, &buf);
 		added = true;
 
 		pkt->off += payload_len;
@@ -440,7 +443,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
 						 dev);
 	struct virtio_vsock_pkt *pkt;
-	int head, pkts = 0, total_len = 0;
+	int ret, pkts = 0, total_len = 0;
+	struct vhost_buf buf;
 	unsigned int out, in;
 	bool added = false;
 
@@ -461,12 +465,13 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			goto no_more_replies;
 		}
 
-		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
-					 &out, &in, NULL, NULL);
-		if (head < 0)
+		ret = vhost_get_avail_buf(vq, &buf,
+					  vq->iov, ARRAY_SIZE(vq->iov),
+					  &out, &in, NULL, NULL);
+		if (ret < 0)
 			break;
 
-		if (head == vq->num) {
+		if (!ret) {
 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
 				vhost_disable_notify(&vsock->dev, vq);
 				continue;
@@ -494,7 +499,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			virtio_transport_free_pkt(pkt);
 
 		len += sizeof(pkt->hdr);
-		vhost_add_used(vq, head, len);
+		buf.in_len = len;
+		vhost_put_used_buf(vq, &buf);
 		total_len += len;
 		added = true;
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
-- 
MST

