Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E234A20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3w9XaZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgFWOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:24:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732882AbgFWOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0USsO4OAfyA0Rib2bQap/oCXtEpVCchT8eYakLR9fg=;
        b=c3w9XaZ07bXVaCyGtsE7TqRjQYPhIWsnzzncysTuKn8Uv+NLVjDbSmKgyDUG9q/9eJuNbZ
        SWOMrTqRiVeXCfCxm7fkMADrOUWQK9ufQGidbhwF02rBBO0xiKsSto6Tg3D7l3abF70rmO
        7V5bkDUm009Uk6vs3E1AX8pGaPTzKtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-s6VhCw-aPIWPTS2NpbwsZw-1; Tue, 23 Jun 2020 10:24:15 -0400
X-MC-Unique: s6VhCw-aPIWPTS2NpbwsZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFEFB8035AF;
        Tue, 23 Jun 2020 14:24:13 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A80415D9DA;
        Tue, 23 Jun 2020 14:24:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] virt: vbox: Add vbg_set_host_capabilities() helper function
Date:   Tue, 23 Jun 2020 16:23:57 +0200
Message-Id: <20200623142401.3742-5-hdegoede@redhat.com>
In-Reply-To: <20200623142401.3742-1-hdegoede@redhat.com>
References: <20200623142401.3742-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbg_set_host_capabilities() helper function,  this is a preparation
patch for adding support for the VBGL_IOCTL_GUEST_CAPS_ACQUIRE ioctl.

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

