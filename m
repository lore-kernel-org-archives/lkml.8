Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4162EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10019207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMj7N53v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgETTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:55:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46675 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727040AbgETTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590004498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sqmyv9Uj/6QITFVDuBCzR+kX0VyYFXB5wU0RIVSK914=;
        b=dMj7N53vvtmqpk11IHAuQKZigZd+bsmbvU5GjlxD9W0uvSl04/LigX6feawLB1/Bf9TWl2
        lvD1fdaa//dXFpsHG8rbL+DnMc9hNORcuYvXVo+csbEf2GDOWMVSstugiAF+ujUJQFlVmG
        FTqK9zopJGzkgsmOUBXYdKfGSqM7nfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-5bhEgzfuPdatDtmzqzhxYQ-1; Wed, 20 May 2020 15:54:55 -0400
X-MC-Unique: 5bhEgzfuPdatDtmzqzhxYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22431100530A;
        Wed, 20 May 2020 19:54:54 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-91.ams2.redhat.com [10.36.112.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31EC41943D;
        Wed, 20 May 2020 19:54:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] virt: vbox: Fix some comments which talk about the "session spinlock"
Date:   Wed, 20 May 2020 21:54:40 +0200
Message-Id: <20200520195440.38759-8-hdegoede@redhat.com>
In-Reply-To: <20200520195440.38759-1-hdegoede@redhat.com>
References: <20200520195440.38759-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index e0e343d0ba93..d99c19551d04 100644
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

