Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E313C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175A42078B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHq8U/6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:28:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57061 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732897AbgFWO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXSYCQku6hDUfwftTBuEyyKPUCg57oRe3/VJDnhv99o=;
        b=GHq8U/6tbE8uZxlzssWSZMgUSq80I0gE5u+ckb4Vbobq9lhd5YbhVqHaD+AOm8SfDM29rL
        7EqHVY8OCnlWaYYuvHojeS6Vn3wKnKptHGZif/T7dCKhECowPxxuprdiP0DzXgsvmtFEwS
        1qtzflQmyto93ne6A/lfau0QvQGOFs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-1GcWxE7mPYS6D9BrTNupIw-1; Tue, 23 Jun 2020 10:28:21 -0400
X-MC-Unique: 1GcWxE7mPYS6D9BrTNupIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18175107ACF2;
        Tue, 23 Jun 2020 14:28:20 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 995AF891DE;
        Tue, 23 Jun 2020 14:28:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] virt: vbox: Fix some comments which talk about the "session spinlock"
Date:   Tue, 23 Jun 2020 16:27:52 +0200
Message-Id: <20200623142752.4331-9-hdegoede@redhat.com>
In-Reply-To: <20200623142752.4331-8-hdegoede@redhat.com>
References: <20200623142752.4331-1-hdegoede@redhat.com>
 <20200623142752.4331-2-hdegoede@redhat.com>
 <20200623142752.4331-3-hdegoede@redhat.com>
 <20200623142752.4331-4-hdegoede@redhat.com>
 <20200623142752.4331-5-hdegoede@redhat.com>
 <20200623142752.4331-6-hdegoede@redhat.com>
 <20200623142752.4331-7-hdegoede@redhat.com>
 <20200623142752.4331-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The session lock is a mutex, not a spinlock, fix the comments to match.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index c5dfcd42fd07..0b43efddea22 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -559,7 +559,7 @@ static int vbg_reset_host_event_filter(struct vbg_dev *gdev,
  * Changes the event filter mask for the given session.
  *
  * This is called in response to VBG_IOCTL_CHANGE_FILTER_MASK as well as to
- * do session cleanup. Takes the session spinlock.
+ * do session cleanup. Takes the session mutex.
  *
  * Return: 0 or negative errno value.
  * @gdev:			The Guest extension device.
@@ -811,7 +811,7 @@ static int vbg_acquire_session_capabilities(struct vbg_dev *gdev,
 }
 
 /**
- * Sets the guest capabilities for a session. Takes the session spinlock.
+ * Sets the guest capabilities for a session. Takes the session mutex.
  * Return: 0 or negative errno value.
  * @gdev:			The Guest extension device.
  * @session:			The session.
-- 
2.26.2

