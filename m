Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C8524676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996751;
	bh=mtKLXxFEnGPm48CN0waeK598N3Inza2HibBee1soN8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmS7x1cK0vc6PjY3ZIYUkf1OLjCysUvxJ67ZRKHHg6Eqdp06TbHYajoqqUKopTMnN
	 tr/CCGz5+8co3kKoGMQ09TSOVQcpgapjuMlgJucWlfQyWBYG0gO5EGPOEcnl4wNKb4
	 Kj2zcNg8whwcXdA/TBVjq659+/YG0KS2pFKzEctU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgANKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733064AbgANKM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:12:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689D5207FF;
        Tue, 14 Jan 2020 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996746;
        bh=mtKLXxFEnGPm48CN0waeK598N3Inza2HibBee1soN8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TG9nUxIfW1z1TqvTGvZ1BIT9H4N3bJSM42q111F1jSF+3SJvhMoh8+3TSYwIdxL2f
         DdbykPq2SlCUze7kcNSq3f7OUy3zi0gMYSLmLi/cKOrRBxEDUlfRswEB/siVBswfON
         nR5GwX4DZwx5eBwxGB1UAZvN2g5+YbV5zPemW/W0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c769968809f9359b07aa@syzkaller.appspotmail.com,
        syzbot+76f3a30e88d256644c78@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 10/28] Input: add safety guards to input_set_keycode()
Date:   Tue, 14 Jan 2020 11:02:12 +0100
Message-Id: <20200114094341.515504421@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.845958665@linuxfoundation.org>
References: <20200114094336.845958665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit cb222aed03d798fc074be55e59d9a112338ee784 upstream.

If we happen to have a garbage in input device's keycode table with values
too big we'll end up doing clear_bit() with offset way outside of our
bitmaps, damaging other objects within an input device or even outside of
it. Let's add sanity checks to the returned old keycodes.

Reported-by: syzbot+c769968809f9359b07aa@syzkaller.appspotmail.com
Reported-by: syzbot+76f3a30e88d256644c78@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20191207212757.GA245964@dtor-ws
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/input.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -851,16 +851,18 @@ static int input_default_setkeycode(stru
 		}
 	}
 
-	__clear_bit(*old_keycode, dev->keybit);
-	__set_bit(ke->keycode, dev->keybit);
-
-	for (i = 0; i < dev->keycodemax; i++) {
-		if (input_fetch_keycode(dev, i) == *old_keycode) {
-			__set_bit(*old_keycode, dev->keybit);
-			break; /* Setting the bit twice is useless, so break */
+	if (*old_keycode <= KEY_MAX) {
+		__clear_bit(*old_keycode, dev->keybit);
+		for (i = 0; i < dev->keycodemax; i++) {
+			if (input_fetch_keycode(dev, i) == *old_keycode) {
+				__set_bit(*old_keycode, dev->keybit);
+				/* Setting the bit twice is useless, so break */
+				break;
+			}
 		}
 	}
 
+	__set_bit(ke->keycode, dev->keybit);
 	return 0;
 }
 
@@ -916,9 +918,13 @@ int input_set_keycode(struct input_dev *
 	 * Simulate keyup event if keycode is not present
 	 * in the keymap anymore
 	 */
-	if (test_bit(EV_KEY, dev->evbit) &&
-	    !is_event_supported(old_keycode, dev->keybit, KEY_MAX) &&
-	    __test_and_clear_bit(old_keycode, dev->key)) {
+	if (old_keycode > KEY_MAX) {
+		dev_warn(dev->dev.parent ?: &dev->dev,
+			 "%s: got too big old keycode %#x\n",
+			 __func__, old_keycode);
+	} else if (test_bit(EV_KEY, dev->evbit) &&
+		   !is_event_supported(old_keycode, dev->keybit, KEY_MAX) &&
+		   __test_and_clear_bit(old_keycode, dev->key)) {
 		struct input_value vals[] =  {
 			{ EV_KEY, old_keycode, 0 },
 			input_value_sync


