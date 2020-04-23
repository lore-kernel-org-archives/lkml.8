Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D30C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191D120780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDWXKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:10:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50388 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728600AbgDWXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:53 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvf-0004sZ-9R; Fri, 24 Apr 2020 00:06:47 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvb-00E70v-1M; Fri, 24 Apr 2020 00:06:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+c769968809f9359b07aa@syzkaller.appspotmail.com,
        syzbot+76f3a30e88d256644c78@syzkaller.appspotmail.com,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date:   Fri, 24 Apr 2020 00:07:21 +0100
Message-ID: <lsq.1587683028.915720247@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 214/245] Input: add safety guards to input_set_keycode()
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/input.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -841,16 +841,18 @@ static int input_default_setkeycode(stru
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
 
@@ -906,9 +908,13 @@ int input_set_keycode(struct input_dev *
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

