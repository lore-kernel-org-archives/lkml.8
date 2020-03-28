Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE18C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B38206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgC1B71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:59:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgC1B71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:59:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B23F35A41A0DCB2F016E;
        Sat, 28 Mar 2020 09:59:20 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 09:59:13 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <daniel.vetter@ffwll.ch>, <sam@ravnborg.org>,
        <b.zolnierkie@samsung.com>, <lukas@wunner.de>, <ghalat@redhat.com>,
        <nico@fluxnic.net>, <kilobyte@angband.pl>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH next] vt: fix a warning when kmalloc alloc large memory
Date:   Sat, 28 Mar 2020 10:13:40 +0800
Message-ID: <20200328021340.27315-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory size that use kmalloc() to allocate exceed MAX_ORDER pages,
it will hit the WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN)), so add memory
allocation flag __GFP_NOWARN to silence a warning, othervise, it will
cause panic if panic_on_warn is enable.

The calltrace is:

WARNING: CPU: 1 PID: 6298 at mm/page_alloc.c:4713 __alloc_pages_nodemask+0x339/0x7d0 mm/page_alloc.c:4713

Call Trace:
__alloc_pages_nodemask+0x339/0x7d0 mm/page_alloc.c:4713
alloc_pages_current+0xac/0x1e0 mm/mempolicy.c:2211
alloc_pages include/linux/gfp.h:532 [inline]
kmalloc_order+0x21/0xf0 mm/slab_common.c:1324
kmalloc_order_trace+0x18/0x150 mm/slab_common.c:1340
kmalloc include/linux/slab.h:560 [inline]
vc_uniscr_alloc+0x2b/0xb0 drivers/tty/vt/vt.c:353
vc_do_resize+0x319/0x12b0 drivers/tty/vt/vt.c:1203
vt_ioctl+0xa5f/0x29a0 drivers/tty/vt/vt_ioctl.c:840
tty_ioctl+0x27d/0x1420 drivers/tty/tty_io.c:2660
vfs_ioctl fs/ioctl.c:47 [inline]
ksys_ioctl+0xee/0x120 fs/ioctl.c:763
__do_sys_ioctl fs/ioctl.c:772 [inline]
__se_sys_ioctl fs/ioctl.c:770 [inline]
__x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
do_syscall_64+0xa1/0x540 arch/x86/entry/common.c:294
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bbc26d73209a..2b000b31a351 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -350,7 +350,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	/* allocate everything in one go */
 	memsize = cols * rows * sizeof(char32_t);
 	memsize += rows * sizeof(char32_t *);
-	p = kmalloc(memsize, GFP_KERNEL);
+	p = kmalloc(memsize, GFP_KERNEL | __GFP_NOWARN);
 	if (!p)
 		return NULL;
 
-- 
2.17.1

