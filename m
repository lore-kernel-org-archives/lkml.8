Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B933CC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD9122D03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261060;
	bh=Y/zWR9qtvEQbATV+qXey+DSENWV9ufEwXodCAcF07go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=miDu13uzkFHpy+0ipV8pENr12WNaeXmvq7pWF77uaWJ13vykyUlJTzS0h4BmB3f0Y
	 VZP107e+xH8ivRr6GNi+zSzurK+FAD/t9xO+DwPELr5AKR7odyLmmfvjtjbhCRakVn
	 +tCYUaa4yQTpZdEYtuAMZ3/HMXT22IrbjcIKcxaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbgGTQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732823AbgGTQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:04:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D606720672;
        Mon, 20 Jul 2020 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261054;
        bh=Y/zWR9qtvEQbATV+qXey+DSENWV9ufEwXodCAcF07go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrsH4lvSKvJABojcrRVSoDM+a+TTdcFfuB+ilW7n89XktRfFx5rnlWNs9NEKdp2+0
         If/5D3lkHHcJuC7FS/7LxjKyoQYcx9aLqMx4FrgEKMboYoy9KZ5aO+bNnjNHVfTnOq
         dVS4J4jrLOTlYQCjGZSooljr5r1H6yZrOd3eCE9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.4 165/215] virt: vbox: Fix guest capabilities mask check
Date:   Mon, 20 Jul 2020 17:37:27 +0200
Message-Id: <20200720152828.031839401@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 59d1d2e8e1e7c50d2657d5e4812b53f71f507968 upstream.

Check the passed in capabilities against VMMDEV_GUEST_CAPABILITIES_MASK
instead of against VMMDEV_EVENT_VALID_EVENT_MASK.
This tightens the allowed mask from 0x7ff to 0x7.

Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
Cc: stable@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200709120858.63928-3-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_core.c |    2 +-
 drivers/virt/vboxguest/vmmdev.h         |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -1443,7 +1443,7 @@ static int vbg_ioctl_change_guest_capabi
 	or_mask = caps->u.in.or_mask;
 	not_mask = caps->u.in.not_mask;
 
-	if ((or_mask | not_mask) & ~VMMDEV_EVENT_VALID_EVENT_MASK)
+	if ((or_mask | not_mask) & ~VMMDEV_GUEST_CAPABILITIES_MASK)
 		return -EINVAL;
 
 	ret = vbg_set_session_capabilities(gdev, session, or_mask, not_mask,
--- a/drivers/virt/vboxguest/vmmdev.h
+++ b/drivers/virt/vboxguest/vmmdev.h
@@ -206,6 +206,8 @@ VMMDEV_ASSERT_SIZE(vmmdev_mask, 24 + 8);
  * not.
  */
 #define VMMDEV_GUEST_SUPPORTS_GRAPHICS                      BIT(2)
+/* The mask of valid capabilities, for sanity checking. */
+#define VMMDEV_GUEST_CAPABILITIES_MASK                      0x00000007U
 
 /** struct vmmdev_hypervisorinfo - Hypervisor info structure. */
 struct vmmdev_hypervisorinfo {


