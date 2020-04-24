Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B98C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8468A2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfxldEHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgDXPIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:08:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbgDXPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587740933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9R6yjveOElwyTut93FZB4NDQJHLkZZ8HkoqOG3/TEPw=;
        b=AfxldEHyqAO66NENX9TzZ/wnF3442YOYGLZz7bUKzK0vZ5VbdbcasYGTLNpiZ0jVsM9BX1
        B99hK5zKBjq4tEetgyV90cCt1RBto2dERj/BqW0m4fZhWThNnV2DrPEj24lgrgO0RzXbCr
        0S+FMFN0qEp426NFer90q40MotEVvrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-iTW-gitIMiyiT6Du8TpJbg-1; Fri, 24 Apr 2020 11:08:51 -0400
X-MC-Unique: iTW-gitIMiyiT6Du8TpJbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD7E1005510;
        Fri, 24 Apr 2020 15:08:36 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-43.ams2.redhat.com [10.36.114.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71AC55D70C;
        Fri, 24 Apr 2020 15:08:34 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     davem@davemloft.net
Cc:     Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH net v2 1/2] vhost/vsock: fix packet delivery order to monitoring devices
Date:   Fri, 24 Apr 2020 17:08:29 +0200
Message-Id: <20200424150830.183113-2-sgarzare@redhat.com>
In-Reply-To: <20200424150830.183113-1-sgarzare@redhat.com>
References: <20200424150830.183113-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to deliver packets to monitoring devices before it is
put in the virtqueue, to avoid that replies can appear in the
packet capture before the transmitted packet.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 97669484a3f6..18aff350a405 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -181,14 +181,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vso=
ck,
 			break;
 		}
=20
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
-		added =3D true;
-
-		/* Deliver to monitoring devices all correctly transmitted
-		 * packets.
+		/* Deliver to monitoring devices all packets that we
+		 * will transmit.
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
=20
+		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		added =3D true;
+
 		pkt->off +=3D payload_len;
 		total_len +=3D payload_len;
=20
--=20
2.25.3

