Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1329FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4BC24677
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996467;
	bh=7nSfkzHlu6vL9griYCjsQC/oYr3HPCCl7oqBuNu1L1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFJoOM7QeakjkKwG/R3NuAN0n2opDD7mVb3i0OyMfQN8tjZDlvhF4ushMhR2AhJU1
	 yqZ/GqQ+Z5Gt3TQ/0CMCv4bTNdHko2JnU1aAnjAlLft6PbW7XkFl771Z3Kjb+5KI5x
	 VY7wGDU4fJh6Fa9RL88M881ZV+guP5RL6b7XQ1Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgANKHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgANKHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB2C24677;
        Tue, 14 Jan 2020 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996462;
        bh=7nSfkzHlu6vL9griYCjsQC/oYr3HPCCl7oqBuNu1L1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMSD7mJYpqJmDp/7VLrD2PNEgoPYBmhM4xsuyEl/xPGkB3j5T+Xa40rVWGuyCF1d0
         aIoE1aR5uh8j7eCyhnbUez3XWaqUWw98nN7oPc1hk8AvUclq+Y10yQkMZ309VaceSa
         nnDgCpMmNJpIjPBj2xIZ3+5k6N+cOKnDggogLzlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.19 25/46] staging: vt6656: set usb_set_intfdata on driver fail.
Date:   Tue, 14 Jan 2020 11:01:42 +0100
Message-Id: <20200114094345.538530223@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit c0bcf9f3f5b661d4ace2a64a79ef661edd2a4dc8 upstream.

intfdata will contain stale pointer when the device is detached after
failed initialization when referenced in vt6656_disconnect

Provide driver access to it here and NULL it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/6de448d7-d833-ef2e-dd7b-3ef9992fee0e@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/device.h   |    1 +
 drivers/staging/vt6656/main_usb.c |    1 +
 drivers/staging/vt6656/wcmd.c     |    1 +
 3 files changed, 3 insertions(+)

--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -259,6 +259,7 @@ struct vnt_private {
 	u8 mac_hw;
 	/* netdev */
 	struct usb_device *usb;
+	struct usb_interface *intf;
 
 	u64 tsf_time;
 	u8 rx_rate;
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -955,6 +955,7 @@ vt6656_probe(struct usb_interface *intf,
 	priv = hw->priv;
 	priv->hw = hw;
 	priv->usb = udev;
+	priv->intf = intf;
 
 	vnt_set_options(priv);
 
--- a/drivers/staging/vt6656/wcmd.c
+++ b/drivers/staging/vt6656/wcmd.c
@@ -99,6 +99,7 @@ void vnt_run_command(struct work_struct
 		if (vnt_init(priv)) {
 			/* If fail all ends TODO retry */
 			dev_err(&priv->usb->dev, "failed to start\n");
+			usb_set_intfdata(priv->intf, NULL);
 			ieee80211_free_hw(priv->hw);
 			return;
 		}


