Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE21120716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGqYvyGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgFWO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:28:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732871AbgFWO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEWMgyOrOUVYfoYf3OoEWST90b9vqeJrWxOpfOm6MS8=;
        b=SGqYvyGL/nawBL1CQA79Wn4z1r3ulvxC9bsZ4WQBD2A7aZ5sM4RjB8Q7ZnT9pyeApFMXtO
        gt3Wayp6EMoj7BwEHODTaLbj6smRwYPb8VB/7ZsoIRusla6KymLEqrEw/wgdpaJ9SZR7Z8
        6aYELVaHkoKDoxFA/0mgoGj6pqyKZTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-b79PVLsRMwKJTO5TcvN64w-1; Tue, 23 Jun 2020 10:28:14 -0400
X-MC-Unique: b79PVLsRMwKJTO5TcvN64w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 471DE107ACCA;
        Tue, 23 Jun 2020 14:28:13 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BCBD891EC;
        Tue, 23 Jun 2020 14:28:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] virt: vbox: Add a few new vmmdev request types to the userspace whitelist
Date:   Tue, 23 Jun 2020 16:27:50 +0200
Message-Id: <20200623142752.4331-7-hdegoede@redhat.com>
In-Reply-To: <20200623142752.4331-6-hdegoede@redhat.com>
References: <20200623142752.4331-1-hdegoede@redhat.com>
 <20200623142752.4331-2-hdegoede@redhat.com>
 <20200623142752.4331-3-hdegoede@redhat.com>
 <20200623142752.4331-4-hdegoede@redhat.com>
 <20200623142752.4331-5-hdegoede@redhat.com>
 <20200623142752.4331-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream VirtualBox has defined and is using a few new request types for
vmmdev requests passed through /dev/vboxguest to the hypervisor.

Add the defines for these to vbox_vmmdev_types.h and add add them to the
whitelists of vmmdev requests which userspace is allowed to make.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1789545
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 2 ++
 include/uapi/linux/vbox_vmmdev_types.h  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 4f1addaa3f6f..ffd76b949276 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1299,7 +1299,9 @@ static int vbg_req_allowed(struct vbg_dev *gdev, struct vbg_session *session,
 	case VMMDEVREQ_VIDEO_ACCEL_ENABLE:
 	case VMMDEVREQ_VIDEO_ACCEL_FLUSH:
 	case VMMDEVREQ_VIDEO_SET_VISIBLE_REGION:
+	case VMMDEVREQ_VIDEO_UPDATE_MONITOR_POSITIONS:
 	case VMMDEVREQ_GET_DISPLAY_CHANGE_REQEX:
+	case VMMDEVREQ_GET_DISPLAY_CHANGE_REQ_MULTI:
 	case VMMDEVREQ_GET_SEAMLESS_CHANGE_REQ:
 	case VMMDEVREQ_GET_VRDPCHANGE_REQ:
 	case VMMDEVREQ_LOG_STRING:
diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
index c27289fd619a..f8a8d6b3c521 100644
--- a/include/uapi/linux/vbox_vmmdev_types.h
+++ b/include/uapi/linux/vbox_vmmdev_types.h
@@ -63,6 +63,7 @@ enum vmmdev_request_type {
 	VMMDEVREQ_SET_GUEST_CAPABILITIES       = 56,
 	VMMDEVREQ_VIDEMODE_SUPPORTED2          = 57, /* since version 3.2.0 */
 	VMMDEVREQ_GET_DISPLAY_CHANGE_REQEX     = 80, /* since version 4.2.4 */
+	VMMDEVREQ_GET_DISPLAY_CHANGE_REQ_MULTI = 81,
 	VMMDEVREQ_HGCM_CONNECT                 = 60,
 	VMMDEVREQ_HGCM_DISCONNECT              = 61,
 	VMMDEVREQ_HGCM_CALL32                  = 62,
@@ -92,6 +93,8 @@ enum vmmdev_request_type {
 	VMMDEVREQ_WRITE_COREDUMP               = 218,
 	VMMDEVREQ_GUEST_HEARTBEAT              = 219,
 	VMMDEVREQ_HEARTBEAT_CONFIGURE          = 220,
+	VMMDEVREQ_NT_BUG_CHECK                 = 221,
+	VMMDEVREQ_VIDEO_UPDATE_MONITOR_POSITIONS = 222,
 	/* Ensure the enum is a 32 bit data-type */
 	VMMDEVREQ_SIZEHACK                     = 0x7fffffff
 };
-- 
2.26.2

