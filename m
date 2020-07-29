Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E582070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgG2HCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgG2HCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:02:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8C71AB55;
        Wed, 29 Jul 2020 07:03:02 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     b.zolnierkie@samsung.com
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?=E5=BC=A0=E4=BA=91=E6=B5=B7?= <zhangyunhai@nsfocus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <greg@kroah.com>, Solar Designer <solar@openwall.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Anthony Liguori <aliguori@amazon.com>,
        Security Officers <security@kernel.org>,
        linux-distros@vs.openwall.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Date:   Wed, 29 Jul 2020 09:02:49 +0200
Message-Id: <20200729070249.20892-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current vgacon's scroll up implementation uses a circural buffer
in vgacon_scrollback_cur. It always advances tail to prepare it for the
next write and caps it to zero if the next ->vc_size_row bytes won't fit.

But when we change the VT size (e.g. by VT_RESIZE) in the meantime, the new
line might not fit to the end of the scrollback buffer in the next
attempt to scroll. This leads to various crashes as
vgacon_scrollback_update writes out of the buffer:
 BUG: unable to handle page fault for address: ffffc900001752a0
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 RIP: 0010:mutex_unlock+0x13/0x30
...
 Call Trace:
  n_tty_write+0x1a0/0x4d0
  tty_write+0x1a0/0x2e0

Or to KASAN reports:
BUG: KASAN: slab-out-of-bounds in vgacon_scroll+0x57a/0x8ed

So check whether the line fits in the buffer and wrap if needed. Do it
before the loop as console_sem is held and ->vc_size_row cannot change
during the execution of vgacon_scrollback_cur. If it does change, we
need to ensure it does not change elsewhere, not here.

Also, we do not split the write of a line into chunks as that would
break the consumers of the buffer. They expect ->cnt, ->tail and ->size
to be in harmony and advanced by ->vc_size_row.

I found few reports of this in the past, some with patches included,
some even 2 years old:
https://lore.kernel.org/lkml/CAEAjamsJnG-=TSOwgRbbb3B9Z-PA63oWmNPoKYWQ=Z=+X49akg@mail.gmail.com/
https://lore.kernel.org/lkml/1589336932-35508-1-git-send-email-yangyingliang@huawei.com/

This fixes CVE-2020-14331.

Big thanks to guys mentioned in the Reported-and-debugged-by lines below
who actually found the root cause.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-and-debugged-by: 张云海 <zhangyunhai@nsfocus.com>
Reported-and-debugged-by: Yang Yingliang <yangyingliang@huawei.com>
Reported-by: Kyungtae Kim <kt0755@gmail.com>
Fixes: 15bdab959c9b ([PATCH] vgacon: Add support for soft scrollback)
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>
Cc: Solar Designer <solar@openwall.com>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: Security Officers <security@kernel.org>
Cc: linux-distros@vs.openwall.org
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/console/vgacon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f0f3d573f848..13194bb246f8 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -250,6 +250,11 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 
 	p = (void *) (c->vc_origin + t * c->vc_size_row);
 
+	/* vc_size_row might have changed by VT_RESIZE in the meantime */
+	if ((vgacon_scrollback_cur->tail + c->vc_size_row) >=
+			vgacon_scrollback_cur->size)
+		vgacon_scrollback_cur->tail = 0;
+
 	while (count--) {
 		scr_memcpyw(vgacon_scrollback_cur->data +
 			    vgacon_scrollback_cur->tail,
-- 
2.28.0

