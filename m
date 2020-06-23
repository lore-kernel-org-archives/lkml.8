Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D41C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79A52072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnVUUrxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgFWO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:28:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42790 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732849AbgFWO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0HSB2xwLqaVXxqbBGXRp8ndfIo45vyt9Y6aLnffm3U=;
        b=LnVUUrxW8h2bt3CVhqBzDGjVkMIqJIiZWiw24WVKQdUdIN1ktK7t7038RHoATxi7OFO0nh
        1WQwbas8SrbjfryEvuRFgArKFY5KQXqjvB2exwTdnihr8plCVAqSyhVHLv4MLhea0dvdtK
        aAhdBCDXwwqFqNFf02DZJOpFcQxREdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-jPTOBW5BM_WrA3g52VMhbA-1; Tue, 23 Jun 2020 10:28:19 -0400
X-MC-Unique: jPTOBW5BM_WrA3g52VMhbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51863DB4F;
        Tue, 23 Jun 2020 14:28:18 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9E0891DE;
        Tue, 23 Jun 2020 14:28:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] virt: vbox: Log unknown ioctl requests as error
Date:   Tue, 23 Jun 2020 16:27:51 +0200
Message-Id: <20200623142752.4331-8-hdegoede@redhat.com>
In-Reply-To: <20200623142752.4331-7-hdegoede@redhat.com>
References: <20200623142752.4331-1-hdegoede@redhat.com>
 <20200623142752.4331-2-hdegoede@redhat.com>
 <20200623142752.4331-3-hdegoede@redhat.com>
 <20200623142752.4331-4-hdegoede@redhat.com>
 <20200623142752.4331-5-hdegoede@redhat.com>
 <20200623142752.4331-6-hdegoede@redhat.com>
 <20200623142752.4331-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every now and then upstream adds new ioctls without notifying us,
log unknown ioctl requests as an error to catch these.

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

