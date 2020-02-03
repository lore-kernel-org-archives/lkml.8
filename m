Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B013C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1321582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747980;
	bh=sC8I2Dcnh5vaB3VrbsvG6h94w3grYvNROZ0DczkC6rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emdp+lwfvYPkta1IHz5rwTl8nRA7QNjzPNucC/4NF5XR38aX80qmjJsZWmvBogQSM
	 ig/iSkIrieDcBeWHRcN8kkvjl0p3M3PPwp02OIQfO70aghHm4/D1Ia1JY55MMspupf
	 bz8m43bRgoYAZJ/38cdKo8ZwHN+IaNx0k8nfaEI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbgBCQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731325AbgBCQh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:27 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA0A2082E;
        Mon,  3 Feb 2020 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747846;
        bh=sC8I2Dcnh5vaB3VrbsvG6h94w3grYvNROZ0DczkC6rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zjLULpKQ223ZSdhVr1Q7S5gmfdWictjxXhH4UFr17DVnnRDeQu5+ywrwY7MxYiRMz
         Ep6FirqSyvLejKJNvz0hX5v8hCii8r4eCMXocrNDKDBghOnRDqUi/vYjFDNC2hZN9C
         l/7SsQ7MNYIuYFe7YmTlv288F7Whog8KSLDRWJ/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 64/90] Input: evdev - convert kzalloc()/vzalloc() to kvzalloc()
Date:   Mon,  3 Feb 2020 16:20:07 +0000
Message-Id: <20200203161925.352904126@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

[ Upstream commit 7f439bc2d7e8c8cc4e1bab08ab7fe1bb73c9b268 ]

We observed a large(order-3) allocation in evdev_open() and it may
cause an OOM kernel panic in kzalloc(), before we getting to the
vzalloc() fallback.

Fix it by converting kzalloc()/vzalloc() to kvzalloc() to avoid the
OOM killer logic as we have a vmalloc fallback.

InputReader invoked oom-killer: gfp_mask=0x240c2c0
(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO), nodemask=0, order=3,
oom_score_adj=-900
...
(dump_backtrace) from (show_stack+0x18/0x1c)
(show_stack) from (dump_stack+0x94/0xa8)
(dump_stack) from (dump_header+0x7c/0xe4)
(dump_header) from (out_of_memory+0x334/0x348)
(out_of_memory) from (__alloc_pages_nodemask+0xe9c/0xeb8)
(__alloc_pages_nodemask) from (kmalloc_order_trace+0x34/0x128)
(kmalloc_order_trace) from (__kmalloc+0x258/0x36c)
(__kmalloc) from (evdev_open+0x5c/0x17c)
(evdev_open) from (chrdev_open+0x100/0x204)
(chrdev_open) from (do_dentry_open+0x21c/0x354)
(do_dentry_open) from (vfs_open+0x58/0x84)
(vfs_open) from (path_openat+0x640/0xc98)
(path_openat) from (do_filp_open+0x78/0x11c)
(do_filp_open) from (do_sys_open+0x130/0x244)
(do_sys_open) from (SyS_openat+0x14/0x18)
(SyS_openat) from (__sys_trace_return+0x0/0x10)
...
Normal: 12488*4kB (UMEH) 6984*8kB (UMEH) 2101*16kB (UMEH) 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 139440kB
HighMem: 206*4kB (H) 131*8kB (H) 42*16kB (H) 2*32kB (H) 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2608kB
...
Kernel panic - not syncing: Out of memory and no killable processes...

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/evdev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f918fca9ada32..cb6e3a5f509c8 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -484,10 +484,7 @@ static int evdev_open(struct inode *inode, struct file *file)
 	struct evdev_client *client;
 	int error;
 
-	client = kzalloc(struct_size(client, buffer, bufsize),
-			 GFP_KERNEL | __GFP_NOWARN);
-	if (!client)
-		client = vzalloc(struct_size(client, buffer, bufsize));
+	client = kvzalloc(struct_size(client, buffer, bufsize), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 
-- 
2.20.1



