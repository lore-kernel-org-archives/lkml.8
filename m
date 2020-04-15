Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AD8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961294;
	bh=wgc5ZRDNb/Os5mnZGCAK3Ryr5aIheM5QZV5lEE7sBMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UK1hqwZo6u36eW2QiH7ClXQettVb8wOqvMsyzVWfrGqq6f1jPDHJ78koyqmRf8yyg
	 KFvrjE7QyXKWd4NngBKclz2vG5ORG6u1gzgPGnmJOf1xeMYaKZNJ7vz6RQwN11zYg7
	 ZD/wKVMz+DwXeht/j6NiVMFoBBJi8WnhbxRbyNxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394162AbgDOOer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394101AbgDOOdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:19 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75642076D;
        Wed, 15 Apr 2020 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961178;
        bh=wgc5ZRDNb/Os5mnZGCAK3Ryr5aIheM5QZV5lEE7sBMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05a2XxlqWagShzDpfT4FBP6Lw/+9REzu9U9BcGscNUMU97S9feNRDD84/ce9C85rm
         75P3qGl8mkXNxTTDpgwSjjIMSygW7BUmp6SIdBrQkRHeGKe/QIz78ZnFcF2IgN8/ex
         bAhzcrU3jkNltDwnSjVJyqNtYYRk9wMHHUrhZNXM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kOy-Hw; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 16/34] docs: filesystems: convert files.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:29 +0200
Message-Id: <26a803d5200555d5104df155d9e59221c9528be8.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
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
index 5514fd122619..c947df7b2a47 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -28,6 +28,7 @@ algorithms work.
    devpts
    dnotify
    fiemap
+   files
 
    automount-support
 
-- 
2.25.2

