Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DCD207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQSWyLhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgETTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:54:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727040AbgETTyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590004490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2qZg/O9cxDEpaBP3vOJlUtLVuqUz7F3/y2We4dXq68=;
        b=BQSWyLhep7aV8thzgoSFpywOAFysVX4R0R1fTY/jV44bq8LZXGNDsUUnPphh3ZKnbyfrO5
        N1XQfS1Xs4Y91H3aOTqcJQgeBHx/wwdW3IEwT0q3cz7Uzwu48TwG3RTzFBmmeSucbwYLV5
        vnX0C9zB7HmXqaDlT5xHlowEZh4K7NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-XfW7ZuhjP1meW6qnnKXFUA-1; Wed, 20 May 2020 15:54:49 -0400
X-MC-Unique: XfW7ZuhjP1meW6qnnKXFUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 052AE1005510;
        Wed, 20 May 2020 19:54:48 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 427FE1943D;
        Wed, 20 May 2020 19:54:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] virt: vbox: Rename guest_caps struct members to set_guest_caps
Date:   Wed, 20 May 2020 21:54:35 +0200
Message-Id: <20200520195440.38759-3-hdegoede@redhat.com>
In-Reply-To: <20200520195440.38759-1-hdegoede@redhat.com>
References: <20200520195440.38759-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename guest_caps[_tracker] struct members to set_guest_caps[_tracker]
this is a preparation patch for adding support for the
VBGL_IOCTL_GUEST_CAPS_ACQUIRE ioctl.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 20 ++++++++++----------
 drivers/virt/vboxguest/vboxguest_core.h |  9 +++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 18ebd7a6af98..aee5eff229f2 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -699,17 +699,17 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 	mutex_lock(&gdev->session_mutex);
 
 	/* Apply the changes to the session mask. */
-	previous = session->guest_caps;
-	session->guest_caps |= or_mask;
-	session->guest_caps &= ~not_mask;
+	previous = session->set_guest_caps;
+	session->set_guest_caps |= or_mask;
+	session->set_guest_caps &= ~not_mask;
 
 	/* If anything actually changed, update the global usage counters. */
-	changed = previous ^ session->guest_caps;
+	changed = previous ^ session->set_guest_caps;
 	if (!changed)
 		goto out;
 
-	vbg_track_bit_usage(&gdev->guest_caps_tracker, changed, previous);
-	or_mask = gdev->guest_caps_tracker.mask;
+	vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed, previous);
+	or_mask = gdev->set_guest_caps_tracker.mask;
 
 	if (gdev->guest_caps_host == or_mask || !req)
 		goto out;
@@ -726,9 +726,9 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 		if (session_termination)
 			goto out;
 
-		vbg_track_bit_usage(&gdev->guest_caps_tracker, changed,
-				    session->guest_caps);
-		session->guest_caps = previous;
+		vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed,
+				    session->set_guest_caps);
+		session->set_guest_caps = previous;
 	}
 
 out:
@@ -1452,7 +1452,7 @@ static int vbg_ioctl_change_guest_capabilities(struct vbg_dev *gdev,
 	if (ret)
 		return ret;
 
-	caps->u.out.session_caps = session->guest_caps;
+	caps->u.out.session_caps = session->set_guest_caps;
 	caps->u.out.global_caps = gdev->guest_caps_host;
 
 	return 0;
diff --git a/drivers/virt/vboxguest/vboxguest_core.h b/drivers/virt/vboxguest/vboxguest_core.h
index 77c3a9c8255d..dc745a033164 100644
--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -118,11 +118,12 @@ struct vbg_dev {
 	u32 event_filter_host;
 
 	/**
-	 * Usage counters for guest capabilities. Indexed by capability bit
+	 * Usage counters for guest capabilities requested through
+	 * vbg_set_session_capabilities(). Indexed by capability bit
 	 * number, one count per session using a capability.
 	 * Protected by session_mutex.
 	 */
-	struct vbg_bit_usage_tracker guest_caps_tracker;
+	struct vbg_bit_usage_tracker set_guest_caps_tracker;
 	/**
 	 * The guest capabilities last reported to the host (or UINT32_MAX).
 	 * Protected by session_mutex.
@@ -164,11 +165,11 @@ struct vbg_session {
 	 */
 	u32 event_filter;
 	/**
-	 * Guest capabilities for this session.
+	 * Guest capabilities set through vbg_set_session_capabilities().
 	 * A capability claimed by any guest session will be reported to the
 	 * host. Protected by vbg_gdev.session_mutex.
 	 */
-	u32 guest_caps;
+	u32 set_guest_caps;
 	/** VMMDEV_REQUESTOR_* flags */
 	u32 requestor;
 	/** Set on CANCEL_ALL_WAITEVENTS, protected by vbg_devevent_spinlock. */
-- 
2.26.2

