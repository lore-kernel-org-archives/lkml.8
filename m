Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E962071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 23:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnNW/doW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgEYX1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgEYX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 19:27:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:27:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so7916316pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YztR7HplbxQ7LgSZiF2gBF8J+ZDPdJj2iwdzAUHkXHE=;
        b=YnNW/doWLujhEydk8v0KvCVsf+LdytAaMcEaXtBFuaPRvTWr+gCrtNWWJstF3lP5Fr
         lh9K4N/kbzcjTLu/qgyaIODEKy9zFEVeqVew7ApNTYFB3eHrvRE6SJHg1PrLz6oYDTt9
         rlo4g3qAd/PJUs3IsoSHvtep5Mx6LJBnpio39kUxSA5C9u/CrsjtJYBURuYSwRqslrIi
         9nPraIqOhLiGGohW4Y+VUztPDGcvWQoZnn2CvWCzYnHo0xGZxl3/pSx2UEnuUqgwJgoh
         rkbgyH4AABJNnYApGIbmi3d11El4HNAdrepYyWVAN4lwEBlTOvRiyyN4/elwrCNm9hb7
         lB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YztR7HplbxQ7LgSZiF2gBF8J+ZDPdJj2iwdzAUHkXHE=;
        b=lpmiUAXOQGnkNchQc749wadEI5nrMbvre5AuNnaJYDNXgVXa2ZRvixEXMx3Si9xfmj
         vkPgu/1pj73LsAtUsFbYhrccbU5IbEEmaSXxlN4fGiROIRoHGPGaSlPQ+VpsL2czyUvj
         WhUFm9ZnwZYOfsL4obgLQhvD5pd4INCkGXiBFLOKhb/yj28s1Uuwgu1FcnKkinc4MoO8
         DEM6np0Rn5uyw/9mR9f7cJ7BKiygJi4LzLksVUr7K28awR+sVlPqWXwu7mMWu3+mOBCN
         q9LEzEhe7HoAALX8KLqI7gFSlhN0hn+TqPLuW/5/PUvZQFXVN5tUorrbE2/AeAtC97Sw
         WHGQ==
X-Gm-Message-State: AOAM531vrdlEM3zqQRdPP74jwbuacyq/gTjaHtwPpPx0RZDUxL+5X3am
        q6q0Qt/yzf9iy2QnDY0qE0U=
X-Google-Smtp-Source: ABdhPJzdk4UHRfMeaRg1LafDe/aiawXLaGPJQKCHj17G5Am/PSgTZbJ9/URNacXc6L2BhSWT02fd4A==
X-Received: by 2002:a17:902:fe04:: with SMTP id g4mr30225518plj.327.1590449262731;
        Mon, 25 May 2020 16:27:42 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id l10sm13815985pfd.70.2020.05.25.16.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 16:27:42 -0700 (PDT)
Date:   Mon, 25 May 2020 16:27:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] vt: keyboard: avoid signed integer overflow in k_ascii
Message-ID: <20200525232740.GA262061@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When k_ascii is invoked several times in a row there is a potential for
signed integer overflow:

UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c:888:19 signed integer overflow:
10 * 1111111111 cannot be represented in type 'int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 ubsan_epilogue+0xe/0x30 lib/ubsan.c:154
 handle_overflow+0xdc/0xf0 lib/ubsan.c:184
 __ubsan_handle_mul_overflow+0x2a/0x40 lib/ubsan.c:205
 k_ascii+0xbf/0xd0 drivers/tty/vt/keyboard.c:888
 kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
 kbd_event+0x888/0x3be0 drivers/tty/vt/keyboard.c:1495

While it can be worked around by using check_mul_overflow()/
check_add_overflow(), it is better to introduce a separate flag to
signal that number pad is being used to compose a symbol, and
change type of the accumulator from signed to unsigned, thus
avoiding undefined behavior when it overflows.

Reported-by: Kyungtae Kim <kt0755@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

- marking the patch as v3 as it is a successor of Kyungtae's patches.

 drivers/tty/vt/keyboard.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..568b2171f335 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -127,7 +127,11 @@ static DEFINE_SPINLOCK(func_buf_lock); /* guard 'func_buf'  and friends */
 static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static bool dead_key_next;
-static int npadch = -1;					/* -1 or number assembled on pad */
+
+/* Handles a number being assembled on the number pad */
+static bool npadch_active;
+static unsigned int npadch_value;
+
 static unsigned int diacr;
 static char rep;					/* flag telling character repeat */
 
@@ -845,12 +849,12 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		shift_state &= ~(1 << value);
 
 	/* kludge */
-	if (up_flag && shift_state != old_state && npadch != -1) {
+	if (up_flag && shift_state != old_state && npadch_active) {
 		if (kbd->kbdmode == VC_UNICODE)
-			to_utf8(vc, npadch);
+			to_utf8(vc, npadch_value);
 		else
-			put_queue(vc, npadch & 0xff);
-		npadch = -1;
+			put_queue(vc, npadch_value & 0xff);
+		npadch_active = false;
 	}
 }
 
@@ -868,7 +872,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
 
 static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 {
-	int base;
+	unsigned int base;
 
 	if (up_flag)
 		return;
@@ -882,10 +886,12 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
 		base = 16;
 	}
 
-	if (npadch == -1)
-		npadch = value;
-	else
-		npadch = npadch * base + value;
+	if (!npadch_active) {
+		npadch_value = 0;
+		npadch_active = true;
+	}
+
+	npadch_value = npadch_value * base + value;
 }
 
 static void k_lock(struct vc_data *vc, unsigned char value, char up_flag)
-- 
2.27.0.rc0.183.gde8f92d652-goog


-- 
Dmitry
