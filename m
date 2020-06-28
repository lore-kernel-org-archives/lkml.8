Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8600DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3A2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgF1EcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 00:32:21 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34318 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgF1Ebr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:31:47 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9C4E32970B; Sun, 28 Jun 2020 00:31:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <754cddfa045e5bfa53e5da199831de02e7d2f27f.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 5/9] macintosh/via-macii: Handle poll replies correctly
Date:   Sun, 28 Jun 2020 14:23:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace applications may use /dev/adb to send Talk requests. Such
requests always have req->reply_expected == 1. The same is true of Talk
requests sent by the kernel, except for poll requests queued internally
by the via-macii driver. Those requests have req->reply_expected == 0.

Consequently, poll reply packets get treated like autopoll reply packets.
(It doesn't make sense to try to distinguish them.) Always enter 'reading'
state after a poll request, so that the reply gets collected and passed
to adb_input(), and none go missing.

All Talk replies passed to adb_input() come from polling or autopolling,
so call adb_input() with the autopoll parameter set to 1.

Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index d29c87943ca46..8d5ef77b4a435 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -463,6 +463,21 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 
 				via[ACR] &= ~SR_OUT;
 				x = via[SR];
+			} else if ((req->data[1] & OP_MASK) == TALK) {
+				macii_state = reading;
+
+				reading_reply = 0;
+				reply_ptr = reply_buf;
+				*reply_ptr = req->data[1];
+				reply_len = 1;
+
+				via[ACR] &= ~SR_OUT;
+				x = via[SR];
+
+				req->complete = 1;
+				current_req = req->next;
+				if (req->done)
+					(*req->done)(req);
 			} else {
 				macii_state = idle;
 
@@ -510,8 +525,9 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 					current_req = req->next;
 					if (req->done)
 						(*req->done)(req);
-				} else if (reply_len && autopoll_devs) {
-					adb_input(reply_buf, reply_len, 0);
+				} else if (reply_len && autopoll_devs &&
+					   reply_buf[0] == last_poll_cmd) {
+					adb_input(reply_buf, reply_len, 1);
 				}
 				break;
 			}
-- 
2.26.2

