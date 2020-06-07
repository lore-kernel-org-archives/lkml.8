Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F5DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471A4206A4
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eusb5MSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgFGOML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:12:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgFGOL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 10:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591539114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEosg1cbEhe9hhKHYKqZg2N/D89Ri/A+CQJLw8Cq4Bg=;
        b=eusb5MSkzrORkdydXEDg4qxqfPYCydhbcUAKqCBKFCSzhuE7W3BSPonFwGdd6Btrv+0glc
        z4O2vkSDehnC6DY4mP4U2uHWqQCroiIyv0SQi8xOWyu4+PO5NAylG30cdLYrgvi7omdHiW
        BcDKeW8Ie9GwD3IRj6yKQvX6Dc4sbtw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-R7XbJOtHNFeCtybGGNnWTg-1; Sun, 07 Jun 2020 10:11:52 -0400
X-MC-Unique: R7XbJOtHNFeCtybGGNnWTg-1
Received: by mail-wr1-f69.google.com with SMTP id c14so6015267wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 07:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEosg1cbEhe9hhKHYKqZg2N/D89Ri/A+CQJLw8Cq4Bg=;
        b=TQqP+ME0QNnp/OUwzFgben1CigCK+S9kGZ4mv73dqbS+f1ehPreGJbk/PYRsYvyeN1
         yqMkbJlDh+WAaUxqyAVA2TdA6jJ/MklREaz9O8edvNoUZKy2VjZB2aS10X7ubfgY6OZu
         BfEF0MBZ39J0Z0UZ1vYTBmvql2S/MIKW/TjCUuietMFs3j6dbalsr7wol3A++kxHaLzc
         7/PqqgJrpY0ELxo7JMEBroY2L4fEEHDcDn1IzFhwwx6gMOIPmvqeG0ccnkla7O4ma+H2
         SwXIGy7QCWoPz1q0qUDGyePebD3HgGPffUj3hGkLTQywwyQnTHm40KFwSmVsRrBejkK2
         HbgA==
X-Gm-Message-State: AOAM533u2lGoHhdX3okwnrDugLFJsDQ2zZG5T/a0dhMx/ioHvpr4HWdN
        JMcgfo3pbzi1NIfHSMzqG74WoEYOlBpftlbf5Ml/NsPoebt+oj3ZqEm/bKKjrdA0u1GhBGv4+l6
        s/AQ0nCLZlJoVvYFfC2jbyAl9
X-Received: by 2002:a5d:500c:: with SMTP id e12mr19107231wrt.359.1591539111403;
        Sun, 07 Jun 2020 07:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWm7fzH3GrdTvffSzx7586DHu5PzZq1QUCLkQIW8gnb+63gz4UqKFoDHZvxyrR4qeM53Cywg==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr19107213wrt.359.1591539111193;
        Sun, 07 Jun 2020 07:11:51 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id i10sm19790175wrw.51.2020.06.07.07.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:11:50 -0700 (PDT)
Date:   Sun, 7 Jun 2020 10:11:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RFC v5 12/13] vhost/vsock: switch to the buf API
Message-ID: <20200607141057.704085-13-mst@redhat.com>
References: <20200607141057.704085-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607141057.704085-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
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

