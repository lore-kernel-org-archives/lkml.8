Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA1C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813492074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7GjHmY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDGU3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:29:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27397 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586291344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zk1012gzAvIBdJE5HTKwuZBYt2+UO/CryxBo1Cp7uNE=;
        b=H7GjHmY1QYovqS/sALIA65/ho+HHvfbZcVMycDaibUm/iE5cVV3oKFQ7PV8d4PgWrjlSN+
        AmzT6Jhf/NJVxvS4sMU6VE990taeHrGC/s+j0NE3r/wvUKsf7jEbY9+s+4uQbzVoqu1BO3
        JEnWGco950qe5JPquMZtT6RYHHzQrNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-PEd1Lrc8Mm2hyfvy8GwhLw-1; Tue, 07 Apr 2020 16:29:00 -0400
X-MC-Unique: PEd1Lrc8Mm2hyfvy8GwhLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92247800D50;
        Tue,  7 Apr 2020 20:28:58 +0000 (UTC)
Received: from localhost (unknown [10.36.110.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7D001BC6D;
        Tue,  7 Apr 2020 20:28:54 +0000 (UTC)
From:   =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, joerd.simons@collabora.co.uk,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        alex.dewar@gmx.co.uk,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] um: add a generic "fd" vector transport
Date:   Tue,  7 Apr 2020 22:28:53 +0200
Message-Id: <20200407202853.1791218-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Learn to take a pre-opened file-descriptor for vector IO.

Instead of teaching the driver to open a FD in multiple ways, it can
rely on management layer to do it on its behalf. For example, this
allows inheriting a preconfigured device fd or a simple socketpair()
setup, without further arguments, privileges or system access by UML.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 arch/um/drivers/vector_user.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.=
c
index 29fae0456ade..45c1550dbb37 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -29,6 +29,7 @@
 #include <netdb.h>
 #include <stdlib.h>
 #include <os.h>
+#include <limits.h>
 #include <um_malloc.h>
 #include "vector_user.h"
=20
@@ -42,6 +43,9 @@
 #define TRANS_RAW "raw"
 #define TRANS_RAW_LEN strlen(TRANS_RAW)
=20
+#define TRANS_FD "fd"
+#define TRANS_FD_LEN strlen(TRANS_FD)
+
 #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
 #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
 #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=3D%i"
@@ -347,6 +351,59 @@ static struct vector_fds *user_init_unix_fds(struct =
arglist *ifspec, int id)
 	return NULL;
 }
=20
+static int strtofd(const char *nptr)
+{
+	long fd;
+	char *endptr;
+
+	if (nptr =3D=3D NULL)
+		return -1;
+
+	errno =3D 0;
+	fd =3D strtol(nptr, &endptr, 10);
+	if (nptr =3D=3D endptr ||
+		errno !=3D 0 ||
+		*endptr !=3D '\0' ||
+		fd < 0 ||
+		fd > INT_MAX) {
+		return -1;
+	}
+	return fd;
+}
+
+static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
+{
+	int fd =3D -1;
+	char *fdarg =3D NULL;
+	struct vector_fds *result =3D NULL;
+
+	fdarg =3D uml_vector_fetch_arg(ifspec, "fd");
+	fd =3D strtofd(fdarg);
+	if (fd =3D=3D -1) {
+		printk(UM_KERN_ERR "fd open: bad or missing fd argument");
+		goto fd_cleanup;
+	}
+
+	result =3D uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result =3D=3D NULL) {
+		printk(UM_KERN_ERR "fd open: allocation failed");
+		goto fd_cleanup;
+	}
+
+	result->rx_fd =3D fd;
+	result->tx_fd =3D fd;
+	result->remote_addr_size =3D 0;
+	result->remote_addr =3D NULL;
+	return result;
+
+fd_cleanup:
+	if (fd >=3D 0)
+		os_close_file(fd);
+	if (result !=3D NULL)
+		kfree(result);
+	return NULL;
+}
+
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
 	int rxfd =3D -1, txfd =3D -1;
@@ -578,6 +635,8 @@ struct vector_fds *uml_vector_user_open(
 		return user_init_socket_fds(parsed, ID_L2TPV3);
 	if (strncmp(transport, TRANS_BESS, TRANS_BESS_LEN) =3D=3D 0)
 		return user_init_unix_fds(parsed, ID_BESS);
+	if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) =3D=3D 0)
+		return user_init_fd_fds(parsed);
 	return NULL;
 }
=20
--=20
2.26.0.106.g9fadedd637

