Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3648EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE7205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTGbH6It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCMAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:35:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726898AbgCMAfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584059744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zevsMC0uowAKEZtQLATwyqk885Y78IJeVZqy5nvGUjY=;
        b=CTGbH6ItRUldNME4Pe3Kiy9LW19wcgZLHsM0qUICc4Y5cW5ej1tHM34WKMJ87JY+bg3Sbo
        QHCTl5EmwUmnfosCe9MvGl+BPvGLt1YNM+rhO8JWAuG2Q33k6NYbUS8jm2fHtpiYnozVqe
        qmmmEczlny3AK8RatW02RyluoW9PnC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-JKPR12MkNUy4Gv_xan9-CA-1; Thu, 12 Mar 2020 20:35:40 -0400
X-MC-Unique: JKPR12MkNUy4Gv_xan9-CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE5EA107ACC7;
        Fri, 13 Mar 2020 00:35:38 +0000 (UTC)
Received: from localhost (ovpn-121-102.rdu2.redhat.com [10.10.121.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C667F60C63;
        Fri, 13 Mar 2020 00:35:35 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH] kernel/printk: add kmsg SEEK_CUR handling
Date:   Thu, 12 Mar 2020 21:35:33 -0300
Message-Id: <20200313003533.2203429-1-bmeneg@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace libraries, e.g. glibc's dprintf(), expect the default return va=
lue
for invalid seek situations: -ESPIPE, but when the IO was over /dev/kmsg =
the
current state of kernel code was returning the generic case of an -EINVAL=
.
Hence, userspace programs were not behaving as expected or documented.

With this patch we add SEEK_CUR case returning the expected value and als=
o a
simple mention of it in kernel's documentation for those relying on that =
for
guidance.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/ABI/testing/dev-kmsg | 2 ++
 kernel/printk/printk.c             | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testi=
ng/dev-kmsg
index f307506eb54c..8533d28e6fda 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -56,6 +56,8 @@ Description:	The /dev/kmsg character device node provid=
es userspace access
 		  seek after the last record available at the time
 		  the last SYSLOG_ACTION_CLEAR was issued.
=20
+		While SEEK_CUR sets -ESPIPE (invalid seek) to errno.
+
 		The output format consists of a prefix carrying the syslog
 		prefix including priority and facility, the 64 bit message
 		sequence number and the monotonic timestamp in microseconds,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad4606234545..d02606723d2d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -963,6 +963,10 @@ static loff_t devkmsg_llseek(struct file *file, loff=
_t offset, int whence)
 		user->idx =3D log_next_idx;
 		user->seq =3D log_next_seq;
 		break;
+	case SEEK_CUR:
+		/* return the default errno for invalid seek */
+		ret =3D -ESPIPE;
+		break;
 	default:
 		ret =3D -EINVAL;
 	}
--=20
2.24.1

