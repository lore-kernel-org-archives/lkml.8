Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FCDC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8DC207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996590;
	bh=i9XHjjTBZozC+H537XEIoVLL6Sfq7UH+oCXKnUHsGxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQAHYBPvCPrSrUy3g/kalcz22j1frcbit00s2uAuofFaDaUfTOIR24bqWXedkAXf4
	 ybOEyhN/iSv7C/Ug5u3pDW5tRL+phYCCIPfIsnBz+79XKeMjTNnaGhKy/I56zhtinP
	 mdQW6XT9LQXtFNuQ4vPrH5C6z9nEmxCNp6If71uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgANKJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgANKJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:09:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F37520678;
        Tue, 14 Jan 2020 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996584;
        bh=i9XHjjTBZozC+H537XEIoVLL6Sfq7UH+oCXKnUHsGxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjXvUy2e1iZo3zS3JSRLva/HsSQzI3OerFBxJUw2whNPXJ/TZF0TeTgv4s9O3c0MF
         ZVzKQ93BACgwxCqH4XB8tlP4q+A9rFSlB75aoLQkGlOfyWZF19XIw9XzcRPfh+kSDk
         pV0zgVckDAEJW+/9qFb5pEl0RsmQUKxFY7sHJ+8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+19340dff067c2d3835c0@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 21/39] HID: hid-input: clear unmapped usages
Date:   Tue, 14 Jan 2020 11:01:55 +0100
Message-Id: <20200114094343.740254763@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 4f3882177240a1f55e45a3d241d3121341bead78 upstream.

We should not be leaving half-mapped usages with potentially invalid
keycodes, as that may confuse hidinput_find_key() when the key is located
by index, which may end up feeding way too large keycode into the VT
keyboard handler and cause OOB write there:

BUG: KASAN: global-out-of-bounds in clear_bit include/asm-generic/bitops-instrumented.h:56 [inline]
BUG: KASAN: global-out-of-bounds in kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
BUG: KASAN: global-out-of-bounds in kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
Write of size 8 at addr ffffffff89a1b2d8 by task syz-executor108/1722
...
 kbd_keycode drivers/tty/vt/keyboard.c:1411 [inline]
 kbd_event+0xe6b/0x3790 drivers/tty/vt/keyboard.c:1495
 input_to_handler+0x3b6/0x4c0 drivers/input/input.c:118
 input_pass_values.part.0+0x2e3/0x720 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:949 [inline]
 input_set_keycode+0x290/0x320 drivers/input/input.c:954
 evdev_handle_set_keycode_v2+0xc4/0x120 drivers/input/evdev.c:882
 evdev_do_ioctl drivers/input/evdev.c:1150 [inline]

Cc: stable@vger.kernel.org
Reported-by: syzbot+19340dff067c2d3835c0@syzkaller.appspotmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1116,9 +1116,15 @@ static void hidinput_configure_usage(str
 	}
 
 mapped:
-	if (device->driver->input_mapped && device->driver->input_mapped(device,
-				hidinput, field, usage, &bit, &max) < 0)
-		goto ignore;
+	if (device->driver->input_mapped &&
+	    device->driver->input_mapped(device, hidinput, field, usage,
+					 &bit, &max) < 0) {
+		/*
+		 * The driver indicated that no further generic handling
+		 * of the usage is desired.
+		 */
+		return;
+	}
 
 	set_bit(usage->type, input->evbit);
 
@@ -1176,9 +1182,11 @@ mapped:
 		set_bit(MSC_SCAN, input->mscbit);
 	}
 
-ignore:
 	return;
 
+ignore:
+	usage->type = 0;
+	usage->code = 0;
 }
 
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)


