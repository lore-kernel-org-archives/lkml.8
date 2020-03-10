Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A427C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515CC2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844405;
	bh=fCz1rFuYDIepk4HJUfU0Bzf10fDaokZwAGF0/oIXHeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNb5jVE2KxztYkghQwmybVdo2wPLdwAg/6iibjOsNJ2ewwzI4cR6G7YvURi/GuoUm
	 qN+3E+UjhS8sJ1K5nBHHcU1+PcYyAQ8eaq8JZ93ocaoZHcYCPTGVjoozjuiKvnjN4Z
	 WEaD4f5nSeHlSkvNkvD6Oag6U69RyypphF8gYnRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCJMqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbgCJMqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:46:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB4920674;
        Tue, 10 Mar 2020 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844399;
        bh=fCz1rFuYDIepk4HJUfU0Bzf10fDaokZwAGF0/oIXHeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2O32j7T2KTPZ3XBsTPe4+D6AeEBtASo+SmMwQHPcK8/LtpW01OG9rbo0iEoe6zO8k
         KWaIVl8ub+hlIHA5AUBEq5tw9mjNqQEveoJ+luXIpcgZ50DwWszvAENEnGSy3Sjtsz
         MGjvqN5K07j67oUehQQCjWn25zEYdQ2lJAA8tbVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 4.9 66/88] usb: core: hub: do error out if usb_autopm_get_interface() fails
Date:   Tue, 10 Mar 2020 13:39:14 +0100
Message-Id: <20200310123622.649468766@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 60e3f6e4ac5b0fda43dad01c32e09409ec710045 upstream.

Reviewing a fresh portion of coverity defects in USB core
(specifically CID 1458999), Alan Stern noted below in [1]:

On Tue, Feb 25, 2020 at 02:39:23PM -0500, Alan Stern wrote:
 > A revised search finds line 997 in drivers/usb/core/hub.c and lines
 > 216, 269 in drivers/usb/core/port.c.  (I didn't try looking in any
 > other directories.)  AFAICT all three of these should check the
 > return value, although a error message in the kernel log probably
 > isn't needed.

Factor out the usb_remove_device() change into a standalone patch to
allow conflict-free integration on top of the earliest stable branches.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.44L0.2002251419120.1485-100000@iolanthe.rowland.org

Fixes: 253e05724f9230 ("USB: add a "remove hardware" sysfs attribute")
Cc: stable@vger.kernel.org # v2.6.33+
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200226175036.14946-2-erosca@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -954,13 +954,17 @@ int usb_remove_device(struct usb_device
 {
 	struct usb_hub *hub;
 	struct usb_interface *intf;
+	int ret;
 
 	if (!udev->parent)	/* Can't remove a root hub */
 		return -EINVAL;
 	hub = usb_hub_to_struct_hub(udev->parent);
 	intf = to_usb_interface(hub->intfdev);
 
-	usb_autopm_get_interface(intf);
+	ret = usb_autopm_get_interface(intf);
+	if (ret < 0)
+		return ret;
+
 	set_bit(udev->portnum, hub->removed_bits);
 	hub_port_logical_disconnect(hub, udev->portnum);
 	usb_autopm_put_interface(intf);


