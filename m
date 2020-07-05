Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14D8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEE42073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nzMMeeQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8K3ycUSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGEPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:47:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgGEPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:47:50 -0400
Date:   Sun, 05 Jul 2020 15:46:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593964069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DRB2pMLaXPlhgSpwFzYAKgzL8JjfxqYnPI2LiwmZh3o=;
        b=2nzMMeeQwWUolck/VuCz3OrQ+vhUMTiP6uAhoTkzqf/X60Xgg0DnPObJc5CpaBzhT2lIdW
        y393CYyTKWwVRbgF2/SlC7+quL+O0CCjDZikjd9BSVUnJS2InKuX2hNxyf/FmVJn35xsbu
        VFc1Is06fXMp/Dcb/7jBwVvzed2kLlF1YqWDOtJOWb0fK5ijk0+Zu59FC7UPJJvn5psts3
        K2p3zb0Fzf0vk/DQ5IY/jSdwbm6kwiaRYZYQab1gGHAVVRD8u2Cy+rPI47WensRUxKTZ6e
        AErWdqjKO0G1X9QKzMkdcXAnefsRwBmHmxy45PkDXXXBIB4OYh6fqJKRzXZk+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593964069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DRB2pMLaXPlhgSpwFzYAKgzL8JjfxqYnPI2LiwmZh3o=;
        b=8K3ycUSPIyOgXsGb1OZkFX3RA9zAtf/ahwJPrP3vIYfcsM3OLXLwjPoJqvusbNtvknmOGX
        Pcli7c3c8wbrAEDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.8-rc4
Message-ID: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-07-05

up to:  5fdeefa053df: Merge branch 'urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/urgent

A single fix for a printk format warning in RCU.

Thanks,

	tglx

------------------>
Kefeng Wang (1):
      rcuperf: Fix printk format warning


 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6b7c09..9eb39c20082c 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -723,7 +723,7 @@ kfree_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);

