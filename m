Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2761206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263383;
	bh=jDnIlYH0uSogkRrPRf6JMxXDSYXeT5AkPJW6Ms+M9ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gE7CqaEeHG23+lEeAZztdO+4mTNQYS9EoXO93dUS0tzDZTWFpYzo6i89jeFBbWV2t
	 j6owo11MQ7qADWdycQXh7LY8XmydLSKyBKxRJj1M/GAKY5k1q6QUrugOn/tx4FS7t1
	 FYUv41Uph+5bqdel2ulyh82JbPG1cwXkmz3sWgR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgGTQnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbgGTPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:42:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795602176B;
        Mon, 20 Jul 2020 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259767;
        bh=jDnIlYH0uSogkRrPRf6JMxXDSYXeT5AkPJW6Ms+M9ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfq3MbPoIyAhzRVh7xOfs7sIVY7pfTMkwvezoKsq3eJ8l96Vs1Wh1/5pXkEmQiubh
         t1muz39nUK/ifd+6Duem+8WodP/kA5dTwPpad7mJbeMEGtTFTkdCnWAB7xDN+s06Hl
         m4S933gNilL8pmy/qGVBUfpvFAUMp2lfpSPt8ECs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Lobakin <alobakin@pm.me>,
        Amit Shah <amit@kernel.org>
Subject: [PATCH 4.9 73/86] virtio: virtio_console: add missing MODULE_DEVICE_TABLE() for rproc serial
Date:   Mon, 20 Jul 2020 17:37:09 +0200
Message-Id: <20200720152756.861659882@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>

commit 897c44f0bae574c5fb318c759b060bebf9dd6013 upstream.

rproc_serial_id_table lacks an exposure to module devicetable, so
when remoteproc firmware requests VIRTIO_ID_RPROC_SERIAL, no uevent
is generated and no module autoloading occurs.
Add missing MODULE_DEVICE_TABLE() annotation and move the existing
one for VIRTIO_ID_CONSOLE right to the table itself.

Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Amit Shah <amit@kernel.org>
Link: https://lore.kernel.org/r/x7C_CbeJtoGMy258nwAXASYz3xgFMFpyzmUvOyZzRnQrgWCREBjaqBOpAUS7ol4NnZYvSVwmTsCG0Ohyfvta-ygw6HMHcoeKK0C3QFiAO_Q=@pm.me
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2161,6 +2161,7 @@ static struct virtio_device_id id_table[
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(virtio, id_table);
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
@@ -2173,6 +2174,7 @@ static struct virtio_device_id rproc_ser
 #endif
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(virtio, rproc_serial_id_table);
 
 static unsigned int rproc_serial_features[] = {
 };
@@ -2325,6 +2327,5 @@ static void __exit fini(void)
 module_init(init);
 module_exit(fini);
 
-MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio console driver");
 MODULE_LICENSE("GPL");


