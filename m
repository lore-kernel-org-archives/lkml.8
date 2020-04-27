Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F5C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1912078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022251;
	bh=Js898cFBeqq0xTdeHpDvGillcAR42l1XpEI+yj+aM0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1SjOCLUUVjeRtP0VA48bgl82BrrJNKHM8emRAI+SfhXf34LopbD0KtWx2ij8oOPn7
	 eBxS7ZQNcI8LSrptxm5KfM9SUXV7gE1COU2SmUyVeQHu4FvWfCCTlynGbiHP+12JiW
	 1rS0qLu76TXyPO5YAArGfOncWbgW4n+bQiZUjn4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgD0VR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgD0VR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:26 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DED921D7F;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=Js898cFBeqq0xTdeHpDvGillcAR42l1XpEI+yj+aM0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJXjfvGJ6cuT/jnh2MWRtq0Fdd7pC8IInRX7XiSPEBhdVCBe9sGiniGuyfQoutHXC
         dB+BwEt/mBbREc5i8NPC1kl/rQBUYFPKb0/6GUjBQIUHyxE85PowWdx1UUk+dH9cnY
         1Mfep++dbC6eY0JxebeuRrYqJH/mCQBw8ou3cXHY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hkd-Nw; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 13/29] docs: filesystems: convert files.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:05 +0200
Message-Id: <e31b0f6a7ee466a233dc7f9c73f53f07ebb07f0b.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{files.txt => files.rst}          | 15 ++++++++++-----
 Documentation/filesystems/index.rst               |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/filesystems/{files.txt => files.rst} (95%)

diff --git a/Documentation/filesystems/files.txt b/Documentation/filesystems/files.rst
similarity index 95%
rename from Documentation/filesystems/files.txt
rename to Documentation/filesystems/files.rst
index 46dfc6b038c3..cbf8e57376bf 100644
--- a/Documentation/filesystems/files.txt
+++ b/Documentation/filesystems/files.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
 File management in the Linux kernel
------------------------------------
+===================================
 
 This document describes how locking for files (struct file)
 and file descriptor table (struct files) works.
@@ -34,7 +37,7 @@ appear atomic. Here are the locking rules for
 the fdtable structure -
 
 1. All references to the fdtable must be done through
-   the files_fdtable() macro :
+   the files_fdtable() macro::
 
 	struct fdtable *fdt;
 
@@ -61,7 +64,8 @@ the fdtable structure -
 4. To look up the file structure given an fd, a reader
    must use either fcheck() or fcheck_files() APIs. These
    take care of barrier requirements due to lock-free lookup.
-   An example :
+
+   An example::
 
 	struct file *file;
 
@@ -77,7 +81,7 @@ the fdtable structure -
    of the fd (fget()/fget_light()) are lock-free, it is possible
    that look-up may race with the last put() operation on the
    file structure. This is avoided using atomic_long_inc_not_zero()
-   on ->f_count :
+   on ->f_count::
 
 	rcu_read_lock();
 	file = fcheck_files(files, fd);
@@ -106,7 +110,8 @@ the fdtable structure -
    holding files->file_lock. If ->file_lock is dropped, then
    another thread expand the files thereby creating a new
    fdtable and making the earlier fdtable pointer stale.
-   For example :
+
+   For example::
 
 	spin_lock(&files->file_lock);
 	fd = locate_fd(files, file, start);
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c571112746f3..42f3309b994e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -27,6 +27,7 @@ algorithms work.
    devpts
    dnotify
    fiemap
+   files
 
    automount-support
 
-- 
2.25.4

