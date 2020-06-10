Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77ABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB76920760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgFJLsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:48:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgFJLsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:48:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0839AE63;
        Wed, 10 Jun 2020 11:48:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] syscalls: fix offset type of ksys_ftruncate
Date:   Wed, 10 Jun 2020 13:48:51 +0200
Message-Id: <20200610114851.28549-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit below, truncate on i586 uses ksys_ftruncate. But
ksys_ftruncate truncates the offset to unsigned long. So switch the type
of offset to loff_t which is what the lower do_sys_ftruncate expects.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 121b32a58a3a (x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments)
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 63ffa6dc9da3..e97ca179d0dc 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1370,7 +1370,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
-static inline long ksys_ftruncate(unsigned int fd, unsigned long length)
+static inline long ksys_ftruncate(unsigned int fd, loff_t length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
-- 
2.27.0

