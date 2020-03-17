Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD8C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdii35CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQKdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:33:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20413 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgCQKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584441232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eOy9TskxxEsCdIzYH89n1iIguuWEe+XNl7wM6A1bFDk=;
        b=Wdii35CNV1QsVtqp8xFPyaW/0u2Hmu1KDbFDLzPEWgvu+VL3DUvcGzWquVKtr3a2fK93/q
        EWE+kQnPQ2LTJ9sZGyhH124DGgBUgIUgAayN7JZD6OSQ0N43h+pa1ZcWiMmfwJ8Uozvt/1
        icvviXSsfjJqrCvnQAPyCCdj63iXqQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-v69Xyi8eMXGPU6_IIDwINA-1; Tue, 17 Mar 2020 06:33:51 -0400
X-MC-Unique: v69Xyi8eMXGPU6_IIDwINA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E5F8010EC;
        Tue, 17 Mar 2020 10:33:50 +0000 (UTC)
Received: from localhost (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E96BD1001DC0;
        Tue, 17 Mar 2020 10:33:46 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, David.Laight@ACULAB.COM,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2] kernel/printk: add kmsg SEEK_CUR handling
Date:   Tue, 17 Mar 2020 07:33:44 -0300
Message-Id: <20200317103344.574277-1-bmeneg@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace libraries, e.g. glibc's dprintf(), perform a SEEK_CUR operation
over any file descriptor requested to make sure the current position isn'=
t
pointing to junk due to previous manipulation of that same fd. And whenev=
er
that fd doesn't have support for such operation, the userspace code expec=
ts
-ESPIPE to be returned.

However, when the fd in question references the /dev/kmsg interface, the
current kernel code state returns -EINVAL instead, causing an unexpected
behavior in userspace: in the case of glibc, when -ESPIPE is returned it
gets ignored and the call completes successfully, while returning -EINVAL
forces dprintf to fail without performing any action over that fd:

  if (_IO_SEEKOFF (fp, (off64_t)0, _IO_seek_cur, _IOS_INPUT|_IOS_OUTPUT) =
=3D=3D
  _IO_pos_BAD && errno !=3D ESPIPE)
    return NULL;

With this patch we make sure to return the correct value when SEEK_CUR is
requested over kmsg and also add some kernel doc information to formalize
this behavior.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
v2: add more documentation details to code, kernel doc and patch log

 Documentation/ABI/testing/dev-kmsg |  5 +++++
 kernel/printk/printk.c             | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testi=
ng/dev-kmsg
index f307506eb54c..1e6c28b1942b 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -56,6 +56,11 @@ Description:	The /dev/kmsg character device node provi=
des userspace access
 		  seek after the last record available at the time
 		  the last SYSLOG_ACTION_CLEAR was issued.
=20
+		Due to the record nature of this interface with a "read all"
+		behavior and the specific positions each seek operation sets,
+		SEEK_CUR is not supported, returning -ESPIPE (invalid seek) to
+		errno whenever requested.
+
 		The output format consists of a prefix carrying the syslog
 		prefix including priority and facility, the 64 bit message
 		sequence number and the monotonic timestamp in microseconds,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad4606234545..d1a219759ed3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -963,6 +963,16 @@ static loff_t devkmsg_llseek(struct file *file, loff=
_t offset, int whence)
 		user->idx =3D log_next_idx;
 		user->seq =3D log_next_seq;
 		break;
+	case SEEK_CUR:
+		/*
+		 * It isn't supported due to the record nature of this
+		 * interface: _SET _DATA and _END point to very specific
+		 * record positions, while _CUR would be more useful in case
+		 * of a byte-based log. Because of that, return the default
+		 * errno value for invalid seek operation.
+		 */
+		ret =3D -ESPIPE;
+		break;
 	default:
 		ret =3D -EINVAL;
 	}
--=20
2.24.1

