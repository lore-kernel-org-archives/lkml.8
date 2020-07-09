Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2924C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A072074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+DITdhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGIMJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:09:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727775AbgGIMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfqzY8t/qD9qb7tKq0QFXQRv/H0BIw8xYY7YrQUWrqk=;
        b=L+DITdhg+L8/Evdja5nvF/Mf+xdIzXVTNAqfqx9XasgLyDXmtfQVWzs2xXL92a5mdd/H7W
        dEIuqw23j+0X+YrKRu58kFwZZ5+hgTptziwg5TZYWpvj2ezLiqrM4QMoEvYrXz5ZjW6EFK
        mLwTaBCRKKmwAgE8cdjLMVBJFAN5Dn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-yhNG12U9NACrd-r7HxIkSw-1; Thu, 09 Jul 2020 08:09:11 -0400
X-MC-Unique: yhNG12U9NACrd-r7HxIkSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2FB88C79B;
        Thu,  9 Jul 2020 12:09:10 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-29.ams2.redhat.com [10.36.115.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4951053B28;
        Thu,  9 Jul 2020 12:09:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend v2 4/8] virt: vbox: Add vbg_set_host_capabilities() helper function
Date:   Thu,  9 Jul 2020 14:08:54 +0200
Message-Id: <20200709120858.63928-5-hdegoede@redhat.com>
In-Reply-To: <20200709120858.63928-1-hdegoede@redhat.com>
References: <20200709120858.63928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbg_set_host_capabilities() helper function,  this is a preparation
patch for adding support for the VBGL_IOCTL_GUEST_CAPS_ACQUIRE ioctl.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 79 ++++++++++++++-----------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index aee5eff229f2..15b3cb618c6e 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -661,6 +661,48 @@ static int vbg_reset_host_capabilities(struct vbg_dev *gdev)
 	return vbg_status_code_to_errno(rc);
 }
 
+/**
+ * Set guest capabilities on the host.
+ * Must be called with gdev->session_mutex hold.
+ * Return: 0 or negative errno value.
+ * @gdev:			The Guest extension device.
+ * @session:			The session.
+ * @session_termination:	Set if we're called by the session cleanup code.
+ */
+static int vbg_set_host_capabilities(struct vbg_dev *gdev,
+				     struct vbg_session *session,
+				     bool session_termination)
+{
+	struct vmmdev_mask *req;
+	u32 caps;
+	int rc;
+
+	WARN_ON(!mutex_is_locked(&gdev->session_mutex));
+
+	caps = gdev->set_guest_caps_tracker.mask;
+
+	if (gdev->guest_caps_host == caps)
+		return 0;
+
+	/* On termination the requestor is the kernel, as we're cleaning up. */
+	req = vbg_req_alloc(sizeof(*req), VMMDEVREQ_SET_GUEST_CAPABILITIES,
+			    session_termination ? VBG_KERNEL_REQUEST :
+						  session->requestor);
+	if (!req) {
+		gdev->guest_caps_host = U32_MAX;
+		return -ENOMEM;
+	}
+
+	req->or_mask = caps;
+	req->not_mask = ~caps;
+	rc = vbg_req_perform(gdev, req);
+	vbg_req_free(req, sizeof(*req));
+
+	gdev->guest_caps_host = (rc >= 0) ? caps : U32_MAX;
+
+	return vbg_status_code_to_errno(rc);
+}
+
 /**
  * Sets the guest capabilities for a session. Takes the session spinlock.
  * Return: 0 or negative errno value.
@@ -678,23 +720,8 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 					u32 or_mask, u32 not_mask,
 					bool session_termination)
 {
-	struct vmmdev_mask *req;
 	u32 changed, previous;
-	int rc, ret = 0;
-
-	/*
-	 * Allocate a request buffer before taking the spinlock, when
-	 * the session is being terminated the requestor is the kernel,
-	 * as we're cleaning up.
-	 */
-	req = vbg_req_alloc(sizeof(*req), VMMDEVREQ_SET_GUEST_CAPABILITIES,
-			    session_termination ? VBG_KERNEL_REQUEST :
-						  session->requestor);
-	if (!req) {
-		if (!session_termination)
-			return -ENOMEM;
-		/* Ignore allocation failure, we must do session cleanup. */
-	}
+	int ret = 0;
 
 	mutex_lock(&gdev->session_mutex);
 
@@ -709,23 +736,10 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 		goto out;
 
 	vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed, previous);
-	or_mask = gdev->set_guest_caps_tracker.mask;
-
-	if (gdev->guest_caps_host == or_mask || !req)
-		goto out;
-
-	gdev->guest_caps_host = or_mask;
-	req->or_mask = or_mask;
-	req->not_mask = ~or_mask;
-	rc = vbg_req_perform(gdev, req);
-	if (rc < 0) {
-		ret = vbg_status_code_to_errno(rc);
-
-		/* Failed, roll back (unless it's session termination time). */
-		gdev->guest_caps_host = U32_MAX;
-		if (session_termination)
-			goto out;
 
+	ret = vbg_set_host_capabilities(gdev, session, session_termination);
+	/* Roll back on failure, unless it's session termination time. */
+	if (ret < 0 && !session_termination) {
 		vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed,
 				    session->set_guest_caps);
 		session->set_guest_caps = previous;
@@ -733,7 +747,6 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
-- 
2.26.2

