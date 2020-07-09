Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2945C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896A92074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnKL+AUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGIMJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:09:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbgGIMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANzAaQA0RDQoc37pvfjR56zqR+JY28pzYl21poSaN8w=;
        b=dnKL+AUKDqS5UX7RaOdRJPx3Hx1cCpVBJyMFLvFZ2PUWplhnxnoLzor0r1GXU4aA2v0ZGE
        ZZQgGb+rWHTXbWd+27tOxjJ5dIYrrO+YBDOKnjV0N0vEIia548MfmyxFbVIA+dNXBvOEYO
        JrVD5ULvi0Mu4z/9dyolfhdJnVf9Sw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-XgvaZDooPQKT1va-CAorhw-1; Thu, 09 Jul 2020 08:09:21 -0400
X-MC-Unique: XgvaZDooPQKT1va-CAorhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3927D100F78F;
        Thu,  9 Jul 2020 12:09:20 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-29.ams2.redhat.com [10.36.115.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA25106F95E;
        Thu,  9 Jul 2020 12:09:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend v2 7/8] virt: vbox: Log unknown ioctl requests as error
Date:   Thu,  9 Jul 2020 14:08:57 +0200
Message-Id: <20200709120858.63928-8-hdegoede@redhat.com>
In-Reply-To: <20200709120858.63928-1-hdegoede@redhat.com>
References: <20200709120858.63928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every now and then upstream adds new ioctls without notifying us,
log unknown ioctl requests as an error to catch these.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rate-limit the error logging to avoid userspace potentially DOS-ing the log
---
 drivers/virt/vboxguest/vboxguest_core.c  | 2 +-
 drivers/virt/vboxguest/vboxguest_utils.c | 1 +
 include/linux/vbox_utils.h               | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index ffd76b949276..c5dfcd42fd07 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1739,7 +1739,7 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
 		return vbg_ioctl_log(data);
 	}
 
-	vbg_debug("VGDrvCommonIoCtl: Unknown req %#08x\n", req);
+	vbg_err_ratelimited("Userspace made an unknown ioctl req %#08x\n", req);
 	return -ENOTTY;
 }
 
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 7396187ee32a..ea05af41ec69 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -59,6 +59,7 @@ EXPORT_SYMBOL(name)
 VBG_LOG(vbg_info, pr_info);
 VBG_LOG(vbg_warn, pr_warn);
 VBG_LOG(vbg_err, pr_err);
+VBG_LOG(vbg_err_ratelimited, pr_err_ratelimited);
 #if defined(DEBUG) && !defined(CONFIG_DYNAMIC_DEBUG)
 VBG_LOG(vbg_debug, pr_debug);
 #endif
diff --git a/include/linux/vbox_utils.h b/include/linux/vbox_utils.h
index ff56c443180c..db8a7d118093 100644
--- a/include/linux/vbox_utils.h
+++ b/include/linux/vbox_utils.h
@@ -16,6 +16,7 @@ struct vbg_dev;
 __printf(1, 2) void vbg_info(const char *fmt, ...);
 __printf(1, 2) void vbg_warn(const char *fmt, ...);
 __printf(1, 2) void vbg_err(const char *fmt, ...);
+__printf(1, 2) void vbg_err_ratelimited(const char *fmt, ...);
 
 /* Only use backdoor logging for non-dynamic debug builds */
 #if defined(DEBUG) && !defined(CONFIG_DYNAMIC_DEBUG)
-- 
2.26.2

