Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5999AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305BC20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5CFWnuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgFWOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:24:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732888AbgFWOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXSYCQku6hDUfwftTBuEyyKPUCg57oRe3/VJDnhv99o=;
        b=i5CFWnuZutE0gz9Q4wCKdhDW2Xi55mJYRKGctA71PgKJTqAUoMjBC/394+X6bwIlbFzP7J
        86myFZiAzPJYfAjHxIfUXbdM5KkkQ4aRuppu4m45jiLhhyUHfPd6T8VpYsrZP05RA7DsBQ
        is0QZAarKK9N+LlPCileikBFmNpky1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Ctmv8XYfOC6AWS9K2ahSOg-1; Tue, 23 Jun 2020 10:24:23 -0400
X-MC-Unique: Ctmv8XYfOC6AWS9K2ahSOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC601005512;
        Tue, 23 Jun 2020 14:24:22 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC6855D9DA;
        Tue, 23 Jun 2020 14:24:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] virt: vbox: Fix some comments which talk about the "session spinlock"
Date:   Tue, 23 Jun 2020 16:24:01 +0200
Message-Id: <20200623142401.3742-9-hdegoede@redhat.com>
In-Reply-To: <20200623142401.3742-1-hdegoede@redhat.com>
References: <20200623142401.3742-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

