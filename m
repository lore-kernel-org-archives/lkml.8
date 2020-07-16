Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8875DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 581A72064B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SspwcdTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGPXKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:10:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727025AbgGPXKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594941031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6Ur2fnt29zWLqlAHZnFwZ+08vVEEOwSdE8VzmyFXb6E=;
        b=SspwcdToGDYFNWYHjQspGeowsVobLLSB4SigjKQ45g8t9Ib82VQYq0UavDiXxi9DdKpSo7
        r5SB0hvYBTBBu/2NpN1A6A0ZgfAb3Ei1iV7VbWFoePX/7LMOED4tJrJDrxVnm6REgdylut
        MQwDB3rFRZ5cZhnM0ZeR6O+ts3l10Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213--Pjs1E5hP0anHHHr-5CWwQ-1; Thu, 16 Jul 2020 18:55:20 -0400
X-MC-Unique: -Pjs1E5hP0anHHHr-5CWwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59915107BEFF;
        Thu, 16 Jul 2020 22:55:19 +0000 (UTC)
Received: from lszubowi.redhat.com (ovpn-65-66.rdu2.redhat.com [10.10.65.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7581001B07;
        Thu, 16 Jul 2020 22:55:18 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de
Cc:     rjw@rjwysocki.net
Subject: [PATCH] configfs: Use flush file op to commit writes to a binary file
Date:   Thu, 16 Jul 2020 18:55:17 -0400
Message-Id: <20200716225517.29522-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the flush file operation instead of the release operation to commit
the prior writes to a configfs binary file. This allows any error
status from the commit to be returned as the status of the close.

Both flush and release are invoked during a close, but the status from
release is ignored by the file system layer because the release operation
is not supposed to fail.

For example, prior to this change no error is returned to user space
when acpi_configfs correctly fails a write that attempts to commit an
ACPI aml configfs binary file when kernel lockdown is in effect.
This patch allows an error status to get returned to user space instead
of a misleading success status.

Note that during a close, release is only called on the last reference to
the specified file struct whereas flush is called on every close.
Therefore, to preserve the prior behavior, configfs_flush_bin_file()
doesn't commit the prior writes if there are still multiple references.
Additionally, since configfs does not support the fsync file operation,
a configfs flush only occurs in the context of a close. This makes it
safe to move the commit from release to flush.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 fs/configfs/file.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index fb65b706cc0d..df0a76f7e62b 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -466,9 +466,28 @@ static int configfs_open_bin_file(struct inode *inode, struct file *filp)
 	return __configfs_open_file(inode, filp, CONFIGFS_ITEM_BIN_ATTR);
 }
 
-static int configfs_release_bin_file(struct inode *inode, struct file *file)
+/**
+ *	configfs_flush_bin_file - flush a binary attribute.
+ *	@file:	file pointer
+ *	@id:	pointer to files_struct
+ *
+ *	Flush is called during close and commits the buffered binary
+ *	writes when there are no more shared references to this file
+ *	struct.
+ *
+ *	Any error returned from the flush will be reflected in the
+ *	return value from the close.
+ */
+
+static int configfs_flush_bin_file(struct file *file, fl_owner_t id)
 {
 	struct configfs_buffer *buffer = file->private_data;
+	ssize_t len;
+	int ret = 0;
+
+	/* Only commit the data if no more shared refs to file */
+	if (file_count(file) > 1)
+		return 0;
 
 	buffer->read_in_progress = false;
 
@@ -478,10 +497,11 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 
 		down_read(&frag->frag_sem);
 		if (!frag->frag_dead) {
-			/* result of ->release() is ignored */
-			buffer->bin_attr->write(buffer->item,
+			len = buffer->bin_attr->write(buffer->item,
 					buffer->bin_buffer,
 					buffer->bin_buffer_size);
+			if (len < 0)
+				ret = len;
 		}
 		up_read(&frag->frag_sem);
 		/* vfree on NULL is safe */
@@ -491,8 +511,7 @@ static int configfs_release_bin_file(struct inode *inode, struct file *file)
 		buffer->needs_read_fill = 1;
 	}
 
-	configfs_release(inode, file);
-	return 0;
+	return ret;
 }
 
 
@@ -509,7 +528,8 @@ const struct file_operations configfs_bin_file_operations = {
 	.write		= configfs_write_bin_file,
 	.llseek		= NULL,		/* bin file is not seekable */
 	.open		= configfs_open_bin_file,
-	.release	= configfs_release_bin_file,
+	.flush		= configfs_flush_bin_file,
+	.release	= configfs_release,
 };
 
 /**
-- 
2.27.0

