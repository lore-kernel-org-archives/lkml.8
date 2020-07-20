Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E61C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEAF22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260398;
	bh=Aihqj2G1CcrclDKLANFP6p4KfviTl4EpP8X/Jv6kJzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=smhi9E3ZeZcOBzGF6azFbpQc8KDOTJuZTEgmaW/tL4JelEIITlSZqcVWAtla7AVPt
	 s6mRz9T+RH3NtpKf9DaZFo90yyKxZxLCjUQ0LIcYtxfcP5qD+PwmAy9ytA4unK5+o2
	 /ReRwS8ac5oKjqjhLxGrWQN5EAAp8qXqnyIzzlfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbgGTPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731444AbgGTPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCCF2065E;
        Mon, 20 Jul 2020 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260388;
        bh=Aihqj2G1CcrclDKLANFP6p4KfviTl4EpP8X/Jv6kJzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLMwjeWFtLeCABgUyhITYye8GE3RdWyCYwTmdlrsKGqOsHRoJchSYRbcMPV3qTmbl
         cn5nnfM4auGnzuAj9HgKYTTWD5JBT6rrKvvnaQwB8z5YZaOXrNoNIYogD2ApSYDOQe
         xpw+U2H1DpDkl5479km98Cp9LQx1+tsnL9dns6uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 084/133] HID: quirks: Ignore Simply Automated UPB PIM
Date:   Mon, 20 Jul 2020 17:37:11 +0200
Message-Id: <20200720152807.766452953@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hilliard <james.hilliard1@gmail.com>

commit 1ee1369b46de1083238fced60ff718f59de4b8aa upstream.

As this is a cypress HID->COM RS232 style device that is handled
by the cypress_M8 driver we also need to add it to the ignore list
in hid-quirks.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h    |    2 ++
 drivers/hid/hid-quirks.c |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -973,6 +973,8 @@
 #define USB_DEVICE_ID_ROCCAT_RYOS_MK_PRO	0x3232
 #define USB_DEVICE_ID_ROCCAT_SAVU	0x2d5a
 
+#define USB_VENDOR_ID_SAI		0x17dd
+
 #define USB_VENDOR_ID_SAITEK		0x06a3
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -876,6 +876,7 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETZL, USB_DEVICE_ID_PETZL_HEADLAMP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PHILIPS, USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAI, USB_DEVICE_ID_CYPRESS_HIDCOM) },
 #if IS_ENABLED(CONFIG_MOUSE_SYNAPTICS_USB)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_INT_TP) },


