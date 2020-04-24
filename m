Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C6C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD020706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzurbsJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgDXPJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:09:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33569 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727929AbgDXPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587740939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARp1QaZyc6uSRKz56nM+3cPhl3dHwuu6PrNTP1aVNwk=;
        b=hzurbsJFfPu3BKCkx3LJ2B/hxXMYN4C5POjzICpd6nzFd62CK48h01bv7fPGQxLq0tjBRk
        wYBrYeMegsYV9Y3QOReSKPGWo2OFEkn4q1PFCCZw1x4D6KjXMbNGgwkySOJitfvuKP1q2m
        qrgbCtpuiabH1zLpi6qucjszjZJ0/ZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-DmiyAjRKOj64EzmUgW8ULQ-1; Fri, 24 Apr 2020 11:08:57 -0400
X-MC-Unique: DmiyAjRKOj64EzmUgW8ULQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F8F3100A8D3;
        Fri, 24 Apr 2020 15:08:39 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-43.ams2.redhat.com [10.36.114.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 324695D750;
        Fri, 24 Apr 2020 15:08:37 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH net v2 2/2] vsock/virtio: fix multiple packet delivery to monitoring devices
Date:   Fri, 24 Apr 2020 17:08:30 +0200
Message-Id: <20200424150830.183113-3-sgarzare@redhat.com>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
References: <20200424150830.183113-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtio_transport.c, if the virtqueue is full, the transmitting
packet is queued up and it will be sent in the next iteration.
This causes the same packet to be delivered multiple times to
monitoring devices.

We want to continue to deliver packets to monitoring devices before
it is put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

This patch fixes the issue, adding a new flag (tap_delivered) in
struct virtio_vsock_pkt, to check if the packet is already delivered
to monitoring devices.

In vhost/vsock.c, we are splitting packets, so we must set
'tap_delivered' to false when we queue up the same virtio_vsock_pkt
to handle the remaining bytes.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c                   | 6 ++++++
 include/linux/virtio_vsock.h            | 1 +
 net/vmw_vsock/virtio_transport_common.c | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 18aff350a405..11f066c76a25 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -196,6 +196,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsoc=
k,
 		 * to send it with the next available buffer.
 		 */
 		if (pkt->off < pkt->len) {
+			/* We are queueing the same virtio_vsock_pkt to handle
+			 * the remaining bytes, and we want to deliver it
+			 * to monitoring devices in the next iteration.
+			 */
+			pkt->tap_delivered =3D false;
+
 			spin_lock_bh(&vsock->send_pkt_list_lock);
 			list_add(&pkt->list, &vsock->send_pkt_list);
 			spin_unlock_bh(&vsock->send_pkt_list_lock);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 71c81e0dc8f2..dc636b727179 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -48,6 +48,7 @@ struct virtio_vsock_pkt {
 	u32 len;
 	u32 off;
 	bool reply;
+	bool tap_delivered;
 };
=20
 struct virtio_vsock_pkt_info {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
index 709038a4783e..69efc891885f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -157,7 +157,11 @@ static struct sk_buff *virtio_transport_build_skb(vo=
id *opaque)
=20
 void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
 {
+	if (pkt->tap_delivered)
+		return;
+
 	vsock_deliver_tap(virtio_transport_build_skb, pkt);
+	pkt->tap_delivered =3D true;
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
=20
--=20
2.25.3

