Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CF0222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846200;
	bh=/YWMA6UzFbrkQZoRfe9gmBWwA4nol1L1a3pn/jKWsC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9EiIXKNDvZWS/sksRLCDo4wvsqjlmUcLJj3NJsA1uRcn2jzGJFMJdqq2lFsNyM+H
	 7A1VeUYqSMlfg3ddwgzKTgM+V2eHlKXFWW6OqXSxxbUdminuEAej549v34WglvPGRY
	 RDsPWH5A2qgsAUvtQJ6R9W5P0ZUb11VYn0597xGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgCJNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbgCJNMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:12:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC80E20409;
        Tue, 10 Mar 2020 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845968;
        bh=/YWMA6UzFbrkQZoRfe9gmBWwA4nol1L1a3pn/jKWsC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJSTaH+dTGgjAl0uK0p+BOZHDo3ncH/lQGoBwGvSXCeEL2tVppkfH9IwNgEkNRUG9
         eTIYZKyr93EYDgxORP6COiDX6GGjMJjYeN5fPRkTPE2mEsQn9AogCzux/yOSLDF6QD
         PaagFZWmLVSsUAabzbx/IiksKaC4tSIfy/98iOpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 4.19 40/86] usb: core: port: do error out if usb_autopm_get_interface() fails
Date:   Tue, 10 Mar 2020 13:45:04 +0100
Message-Id: <20200310124532.950413038@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 1f8b39bc99a31759e97a0428a5c3f64802c1e61d upstream.

Reviewing a fresh portion of coverity defects in USB core
(specifically CID 1458999), Alan Stern noted below in [1]:

On Tue, Feb 25, 2020 at 02:39:23PM -0500, Alan Stern wrote:
 > A revised search finds line 997 in drivers/usb/core/hub.c and lines
 > 216, 269 in drivers/usb/core/port.c.  (I didn't try looking in any
 > other directories.)  AFAICT all three of these should check the
 > return value, although a error message in the kernel log probably
 > isn't needed.

Factor out the usb_port_runtime_{resume,suspend}() changes into a
standalone patch to allow conflict-free porting on top of stable v3.9+.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.44L0.2002251419120.1485-100000@iolanthe.rowland.org

Fixes: 971fcd492cebf5 ("usb: add runtime pm support for usb port device")
Cc: stable@vger.kernel.org # v3.9+
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20200226175036.14946-3-erosca@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/port.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -203,7 +203,10 @@ static int usb_port_runtime_resume(struc
 	if (!port_dev->is_superspeed && peer)
 		pm_runtime_get_sync(&peer->dev);
 
-	usb_autopm_get_interface(intf);
+	retval = usb_autopm_get_interface(intf);
+	if (retval < 0)
+		return retval;
+
 	retval = usb_hub_set_port_power(hdev, hub, port1, true);
 	msleep(hub_power_on_good_delay(hub));
 	if (udev && !retval) {
@@ -256,7 +259,10 @@ static int usb_port_runtime_suspend(stru
 	if (usb_port_block_power_off)
 		return -EBUSY;
 
-	usb_autopm_get_interface(intf);
+	retval = usb_autopm_get_interface(intf);
+	if (retval < 0)
+		return retval;
+
 	retval = usb_hub_set_port_power(hdev, hub, port1, false);
 	usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
 	if (!port_dev->is_superspeed)


