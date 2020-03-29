Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB6C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E4820714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 08:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQu+EVoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgC2I45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 04:56:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2I45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 04:56:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so14536267ljp.9;
        Sun, 29 Mar 2020 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j9mujlxbObmOJIv9aY8Pv9+f4Diabo1dscBEk1uTFZ8=;
        b=LQu+EVoLSJKX0tHv/setWOeqwKWK+bWXztDRZ5UJroVq+XxYPRIhA9sSrTKTT2ibEY
         yB/6BCgeWRViYpqnPuBKAerGApUXQnxeG+X0WoOXn5axXbeok3hIPq11BbkPWdqDreNy
         /THe8rlu1cI4/e6WfTUHpVqpotR7Dd2kDsVzvcEwWWDOrSWFxb3Ds6YKGThFJab8ivoO
         daDXvYPXRAlZnzHQkB1KpdXtMB27sAdYXiBCqIHlCU7kRjveZm5jDb8J670PFFxPt6uL
         QZDBl8oREV/wjQydRKzSSOW2PiVRbx1TEAU8mPdrUnCkZsHza59pbO832vXPFQSv8D2S
         Vpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9mujlxbObmOJIv9aY8Pv9+f4Diabo1dscBEk1uTFZ8=;
        b=UeZNDZoG9lVqwRuuvTroGUnrGmT8JFLm4RGCz/IGwN2dH1qQduP6If64RWUz6oJ7po
         9AVLJvTacHPWVlgwWckLl8jmhM2m2nyRL5r9kog3VGuGssr6x44c5mf2laHYe8CqjQ3R
         zmgb2io9zw/inau6balF54ECJuc4WAcLudt1ibGaoWBaQxI3a8DbZoXDLK3uAUJ+EHZ3
         3ItOYI6/z+gChCQj8ZUKVjesSoKwhAHAG1Tjbh5AteN7O6qytaQ7awDKCWu0U3eTkFhc
         j8mfeA2c8truX0nb2wDsicCidLQKzyX+VZbDpMjXusMak92l0D5sbkOlEk97l8XI4SPk
         Bu7Q==
X-Gm-Message-State: AGi0PuZ+74ys6IDemHrKRQ2U3YqhGnPwZ2lW7XcOkF04XWiqYzDI8xLD
        UFlZyx1zDQax3QEG/jVlQkI=
X-Google-Smtp-Source: APiQypILmyETDoZAWXoLBcXENwr7izGJwTkjiZlQpOLwdm0cfT9q3DBAk44CF2QOzRRtVdc3Nvj7nA==
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr4072521ljo.198.1585472214451;
        Sun, 29 Mar 2020 01:56:54 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id g18sm3797574lfh.1.2020.03.29.01.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 01:56:53 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     daniel.vetter@ffwll.ch, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, daniel.thompson@linaro.org, ghalat@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] fbcon: fix null-ptr-deref in fbcon_switch
Date:   Sun, 29 Mar 2020 16:56:47 +0800
Message-Id: <20200329085647.25133-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set logo_shown to FBCON_LOGO_CANSHOW when the vc was deallocated.

syzkaller report: https://lkml.org/lkml/2020/3/27/403
general protection fault, probably for non-canonical address
0xdffffc000000006c: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
RIP: 0010:fbcon_switch+0x28f/0x1740
drivers/video/fbdev/core/fbcon.c:2260

Call Trace:
redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
vc_do_resize+0xfe7/0x1360 drivers/tty/vt/vt.c:1295
fbcon_init+0x1221/0x1ab0 drivers/video/fbdev/core/fbcon.c:1219
visual_init+0x305/0x5c0 drivers/tty/vt/vt.c:1062
do_bind_con_driver+0x536/0x890 drivers/tty/vt/vt.c:3542
do_take_over_console+0x453/0x5b0 drivers/tty/vt/vt.c:4122
do_fbcon_takeover+0x10b/0x210 drivers/video/fbdev/core/fbcon.c:588
fbcon_fb_registered+0x26b/0x340 drivers/video/fbdev/core/fbcon.c:3259
do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1664 [inline]
register_framebuffer+0x56e/0x980 drivers/video/fbdev/core/fbmem.c:1832
dlfb_usb_probe.cold+0x1743/0x1ba3 drivers/video/fbdev/udlfb.c:1735
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374

accessing vc_cons[logo_shown].d->vc_top causes the bug.

Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bb6ae995c2e5..5eb3fc90f9f6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1283,6 +1283,9 @@ static void fbcon_deinit(struct vc_data *vc)
 	if (!con_is_bound(&fb_con))
 		fbcon_exit();
 
+	if (vc->vc_num == logo_shown)
+		logo_shown = FBCON_LOGO_CANSHOW;
+
 	return;
 }
 
-- 
2.17.1

