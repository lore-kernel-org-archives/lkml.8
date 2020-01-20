Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169D820684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC42xYd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgATKAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:00:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbgATKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579514422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A5GcFGtVAQWVAj/IjmTO+b/muvDYD9pVj8U6MMH/3YE=;
        b=NC42xYd9N+jq7GCvssjVvkbHqA/j/WnlyYgxAEVF7h9/j3qYiSotPBRrY9gxx3yrWoVuDq
        za/VWA79JsM+qLwof3q2oXq5rd46pALC6v6cq+6lEbIz+A7O4Vk0FIgG56HeY/nKUlDdA7
        7ZOvhKymFcat4x43JEepVu8NMs4fq1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-YPaqEMN3PyiBcHX6c_McOw-1; Mon, 20 Jan 2020 05:00:19 -0500
X-MC-Unique: YPaqEMN3PyiBcHX6c_McOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39584800590;
        Mon, 20 Jan 2020 10:00:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com [10.36.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C398910013A7;
        Mon, 20 Jan 2020 10:00:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 124DB16E36; Mon, 20 Jan 2020 11:00:14 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     marmarek@invisiblethingslab.com, Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: wait for references go away
Date:   Mon, 20 Jan 2020 11:00:13 +0100
Message-Id: <20200120100014.23488-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: do_unregister_framebuffer() might return before the device is
fully cleaned up, due to userspace having a file handle for /dev/fb0
open.  Which can result in drm driver not being able to grab resources
(and fail initialization) because the firmware framebuffer still holds
them.  Reportedly plymouth can trigger this.

Fix this by trying to wait until all references are gone.  Don't wait
forever though given that userspace might keep the file handle open.

Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
index d04554959ea7..2ea8ac05b065 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -35,6 +35,7 @@
 #include <linux/fbcon.h>
 #include <linux/mem_encrypt.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
=20
 #include <asm/fb.h>
=20
@@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb_i=
nfo)
=20
 static void do_unregister_framebuffer(struct fb_info *fb_info)
 {
+	int limit =3D 100;
+
 	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
@@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_in=
fo *fb_info)
 	fbcon_fb_unregistered(fb_info);
 	console_unlock();
=20
+	/* try wait until all references are gone */
+	while (atomic_read(&fb_info->count) > 1 && --limit > 0)
+		msleep(10);
+
 	/* this may free fb info */
 	put_fb_info(fb_info);
 }
--=20
2.18.1

