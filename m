Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA82720772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfwMdqRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgGAVsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgGAVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:48:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F18C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:48:11 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k15so14595128lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9rFOX4unP5nBgvG05w8Nh93w4oi+5njXBMQpyfTq0A=;
        b=WfwMdqRYyQR1/jAnjAn5QQHbnoCJQjpDegbdVUSnhOX32OS3xbA2a1JNGivlJZkdPf
         VbmVOGLoBvz0Qt2F+wKT8GB4cVCMVdvfUg9Q2rX7znhEk/X5A0L41onfb51/nql8UUSI
         eM04I+YdE6jnJBly6/jDOV3j34p/LMc5o48BjjkFBXuEscNC8Ez8ZdH3rIWVfotg/+3V
         OkIxmoN1bMTz6lxeuKxUVW7LZ/CQAzkZxRq0nszL6SgccG/WtdKX0xJA5wty6hhUWa38
         wtz5UruGLTp7gTSqtHkdJwdJo1Yej2pEAX1ika5ibQv6TiNWRY3OVxduug7xIKnS+xHf
         fsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9rFOX4unP5nBgvG05w8Nh93w4oi+5njXBMQpyfTq0A=;
        b=gWkdGukmEJoWm2q6ZIw0Q4zpH/u+6cHDK5SPnj2pS/cqj0tAy3PyTLxzwo2zWEvjQl
         ELYOkqP/gPX4c7CFluido/pPKDOCVdf1jQLKJAje8AFxPpR3DG8wRZFOV9Bs5z0d58dL
         sSuskj6CYQDYqT6X2ETesQSlW1Fl1rTbZC4owWr6JGOZQQPCB2Pt9KUs/5mJs5cMn6Az
         ytNjvRhs6YE69sxFdvVEUvsdqqKQUTCGXupm6PlFeO1QyVTJm2R005C4HbYZxLWGB7Mt
         m6uj8wewtyVKn/LPQ6K+1hDwY/vN6/kcNky7vClxxv8NB0RKdbIIXm/jFhxr0FzZ+PuU
         2/2g==
X-Gm-Message-State: AOAM532ttJ5bUQdjtKyqEm4D/yEzr2AEA5KwiIKc6yqUR35ej9IOsE9x
        lYTY6cvcEzX+yeZrA6DvOH0=
X-Google-Smtp-Source: ABdhPJx5Hl3zlIV7Nzlb1xZR+0N3fNWWyCqqAgo2mBQhcAuuNOkk7i5WAC9OS+1JbQrVF9XuoBqVGA==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr16457842lfk.173.1593640090094;
        Wed, 01 Jul 2020 14:48:10 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-241.NA.cust.bahnhof.se. [98.128.181.241])
        by smtp.gmail.com with ESMTPSA id d3sm2476812lfe.93.2020.07.01.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:48:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] virtio_console: Constify some static variables
Date:   Wed,  1 Jul 2020 22:09:50 +0200
Message-Id: <20200701200950.30314-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
References: <20200701200950.30314-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The id_table and feature_table pointers in struct virtio_driver are
pointers to const. Mark the corresponding static variables const to
allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  25447     713      76   26236    667c drivers/char/virtio_console.o

After:
   text    data     bss     dec     hex filename
  25488     673      76   26237    667d drivers/char/virtio_console.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 00c5e3acee46..896f0ba9ba3c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2112,24 +2112,24 @@ static int virtcons_probe(struct virtio_device *vdev)
 	return err;
 }
 
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-static unsigned int features[] = {
+static const unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
 	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
-static struct virtio_device_id rproc_serial_id_table[] = {
+static const struct virtio_device_id rproc_serial_id_table[] = {
 #if IS_ENABLED(CONFIG_REMOTEPROC)
 	{ VIRTIO_ID_RPROC_SERIAL, VIRTIO_DEV_ANY_ID },
 #endif
 	{ 0 },
 };
 
-static unsigned int rproc_serial_features[] = {
+static const unsigned int rproc_serial_features[] = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.27.0

