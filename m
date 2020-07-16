Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451732071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594879622;
	bh=a/Z2jsgBCNcbRZRS+qs+lrfIqcjK6kvbiG2Pc7fwMOI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=K4faJUw/aYVk++zaiHh89LElIdroiRDvR8iC6uwJwZ9O2YEqJMW7qpJo1jVsITdKC
	 EYrz4x24lKUoX32S2YAbF8Idx+/gLMDmFjB/tu/CEbgqWpw17LkyUOUZWTw5LlIkDh
	 9YiamokiEKzMFcTPvXVpwt7bUY8hoH4cqwDDT8iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGPGHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgGPGHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:07:00 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB060206F4;
        Thu, 16 Jul 2020 06:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594879620;
        bh=a/Z2jsgBCNcbRZRS+qs+lrfIqcjK6kvbiG2Pc7fwMOI=;
        h=From:To:Cc:Subject:Date:From;
        b=Z70WgQlPscY4H4F+i9ex3im3FQ6W8Mc6JPHEtn0+JjRMnO9oDgTZ05k4ChRDB/HSS
         R5xn5ORr6e/O+PwdWFS+LdBY63MnpaFRxc9nnDNZKPUbnepRjnvjlwOrP0vkBtCKLI
         w/4siG6RlDUraAaUbD7C7vtcSeVFmaDBHmWLYNJo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] /dev/mem: Add missing memory barriers for devmem_inode
Date:   Wed, 15 Jul 2020 23:05:53 -0700
Message-Id: <20200716060553.24618-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

WRITE_ONCE() isn't the correct way to publish a pointer to a data
structure, since it doesn't include a write memory barrier.  Therefore
other tasks may see that the pointer has been set but not see that the
pointed-to memory has finished being initialized yet.  Instead a
primitive with "release" semantics is needed.

Use smp_store_release() for this.

The use of READ_ONCE() on the read side is still potentially correct if
there's no control dependency, i.e. if all memory being "published" is
transitively reachable via the pointer itself.  But this pairing is
somewhat confusing and error-prone.  So just upgrade the read side to
smp_load_acquire() so that it clearly pairs with smp_store_release().

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the region")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/char/mem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 934c92dcb9ab..687d4af6945d 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -814,7 +814,8 @@ static struct inode *devmem_inode;
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res)
 {
-	struct inode *inode = READ_ONCE(devmem_inode);
+	/* pairs with smp_store_release() in devmem_init_inode() */
+	struct inode *inode = smp_load_acquire(&devmem_inode);
 
 	/*
 	 * Check that the initialization has completed. Losing the race
@@ -1028,8 +1029,11 @@ static int devmem_init_inode(void)
 		return rc;
 	}
 
-	/* publish /dev/mem initialized */
-	WRITE_ONCE(devmem_inode, inode);
+	/*
+	 * Publish /dev/mem initialized.
+	 * Pairs with smp_load_acquire() in revoke_devmem().
+	 */
+	smp_store_release(&devmem_inode, inode);
 
 	return 0;
 }

base-commit: f8456690ba8eb18ea4714e68554e242a04f65cff
-- 
2.27.0

