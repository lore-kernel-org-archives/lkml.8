Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A776F2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiBDVzlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGJRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:44:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726977AbgGJRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594403072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qc023nhny6w6wkYHyPdwfmXQH84TOjG2Gsy5/9ekYpU=;
        b=WiBDVzlU3yxiEk6cwF0/3LUSfQsDjxnE7jGb7Z3pCcsBlrHYvHzFfx72Tn1QWjVKx/DGdr
        fnNgqg6UwzKadlhAA6EF2tTztrq08dSgaSq4WiuOaHXbr6/KLqp2l4Nmd3wWphA5BlRj71
        m75hK9k8gQVuFy0hocC7qt0HZvpDR/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-HcDM24aXMsKzcTD7-6iUIg-1; Fri, 10 Jul 2020 13:44:30 -0400
X-MC-Unique: HcDM24aXMsKzcTD7-6iUIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB68800FEB;
        Fri, 10 Jul 2020 17:44:29 +0000 (UTC)
Received: from localhost (ovpn-116-13.gru2.redhat.com [10.97.116.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D68766FEF8;
        Fri, 10 Jul 2020 17:44:25 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        torvalds@linux-foundation.org, Jason@zx2c4.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2] doc:kmsg: explictly state the return value in case of SEEK_CUR
Date:   Fri, 10 Jul 2020 14:44:23 -0300
Message-Id: <20200710174423.10480-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
handling"") reverted a change done to the return value in case a SEEK_CUR
operation was performed for kmsg buffer based on the fact that different
userspace apps were handling the new return value (-ESPIPE) in different
ways, breaking them.

At the same time -ESPIPE was the wrong decision because kmsg /does support/
seek() but doesn't follow the "normal" behavior userspace is used to.
Because of that and also considering the time -EINVAL has been used, it was
decided to keep this way to avoid more userspace breakage.

This patch adds an official statement to the kmsg documentation pointing to
the current return value for SEEK_CUR, -EINVAL, thus userspace libraries
and apps can refer to it for a definitive guide on what to expect.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
Changelog:
v2:
	- Changed wording to Documentation/ file and also added some doc
	directly to the code (suggested by Petr)

 Documentation/ABI/testing/dev-kmsg | 11 +++++++++++
 kernel/printk/printk.c             |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index f307506eb54c..79f007cdcd41 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -56,6 +56,17 @@ Description:	The /dev/kmsg character device node provides userspace access
 		  seek after the last record available at the time
 		  the last SYSLOG_ACTION_CLEAR was issued.
 
+		Other seek operations or offsets are not supported because of
+		the special behavior this device has. The device allows to read
+		or write only whole variable lenght messages (records) that are
+		stored in a ring buffer.
+
+		Because of the non-standard behavior also the error values are
+		non-standard. -ESPIPE is returned for non-zero offset. -EINVAL
+		is returned for other operations, e.g. SEEK_CUR. This behavior
+		and values are historical and could not be modified without the
+		risk of breaking userspace.
+
 		The output format consists of a prefix carrying the syslog
 		prefix including priority and facility, the 64 bit message
 		sequence number and the monotonic timestamp in microseconds,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b71eaf5f5a86..4c3a0822b705 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -943,6 +943,14 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+/*
+ * Be careful when modifying this function!!!
+ *
+ * Only few operations are supported because the device works only with the
+ * entire variable length messages (records). Non-standard values are
+ * returned in the other cases and has been this way for quite some time.
+ * User space applications might depend on this behavior.
+ */
 static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct devkmsg_user *user = file->private_data;
-- 
2.26.2

