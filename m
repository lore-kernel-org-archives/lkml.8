Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A025C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408AA21D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxlqnuPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDRKZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:25:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31969 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbgDRKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587205360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxTOiAZFQUIPQ7LwD9H8y4khOH4iGHG3F8Nhf2kTwbA=;
        b=SxlqnuPor74zXwloUO7I+4Ux612gJ2T0CP/71d8EyVhXKBhcHAfOEoTXblzsbDmWyKR92C
        SYNXYFOf7CHBiPJsEKaNbZ1pYOA3NPXcWucJaZK7X0GfwmWEOi/uTYOyKvG2kga87Tlmdk
        5XJucNXasQ6YSRmX7w3zVu5hmu0dwtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-YYG2JwGgNn2cI4pDjP6Vww-1; Sat, 18 Apr 2020 06:22:38 -0400
X-MC-Unique: YYG2JwGgNn2cI4pDjP6Vww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC99A8017F5;
        Sat, 18 Apr 2020 10:22:36 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-112-94.ams2.redhat.com [10.36.112.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76BCF1036D15;
        Sat, 18 Apr 2020 10:22:34 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm list <kvm@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v3 3/8] tools/virtio: Add --batch=random option
Date:   Sat, 18 Apr 2020 12:22:12 +0200
Message-Id: <20200418102217.32327-4-eperezma@redhat.com>
In-Reply-To: <20200418102217.32327-1-eperezma@redhat.com>
References: <20200418102217.32327-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can test with non-deterministic batches in flight.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 tools/virtio/virtio_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index c30de9088f3c..4a2b9d11f287 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -19,6 +19,8 @@
 #include <linux/virtio_ring.h>
 #include "../../drivers/vhost/test.h"
=20
+#define RANDOM_BATCH -1
+
 /* Unused */
 void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
=20
@@ -161,6 +163,7 @@ static void run_test(struct vdev_info *dev, struct vq=
_info *vq,
 	int r, test =3D 1;
 	unsigned len;
 	long long spurious =3D 0;
+	const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
 	r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >=3D 0);
 	for (;;) {
@@ -168,6 +171,9 @@ static void run_test(struct vdev_info *dev, struct vq=
_info *vq,
 		completed_before =3D completed;
 		started_before =3D started;
 		do {
+			if (random_batch)
+				batch =3D (random() % vq->vring.num) + 1;
+
 			while (started < bufs &&
 			       (started - completed) < batch) {
 				sg_init_one(&sl, dev->buf, dev->buf_size);
@@ -275,7 +281,7 @@ static void help(void)
 		" [--no-event-idx]"
 		" [--no-virtio-1]"
 		" [--delayed-interrupt]"
-		" [--batch=3DN]"
+		" [--batch=3Drandom/N]"
 		"\n");
 }
=20
@@ -312,9 +318,13 @@ int main(int argc, char **argv)
 			delayed =3D true;
 			break;
 		case 'b':
-			batch =3D strtol(optarg, NULL, 10);
-			assert(batch > 0);
-			assert(batch < (long)INT_MAX + 1);
+			if (0 =3D=3D strcmp(optarg, "random")) {
+				batch =3D RANDOM_BATCH;
+			} else {
+				batch =3D strtol(optarg, NULL, 10);
+				assert(batch > 0);
+				assert(batch < (long)INT_MAX + 1);
+			}
 			break;
 		default:
 			assert(0);
--=20
2.18.1

