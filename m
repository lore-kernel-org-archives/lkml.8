Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65AC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E945A206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1umw+df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBVRUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:20:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:20:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so3001221pfc.1;
        Sat, 22 Feb 2020 09:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pBlnEnGsMstGVyIAKqUSLHLBYoQgpr7wBNrwAms26Yo=;
        b=N1umw+dflj+4ygktxCh4x4Xar6LUvIUmf87d4s89h/nqrxANA7zQDFBY8qnXkOrEyx
         CQXxj4ALPcj9n2jU4lqCLhSdIaabPtBMeOrc4ROQKyQz45q+eoMd6ZGd86Jc1Y3bKEbM
         ofQ6l0SsWVo8pvRkgKXPKjEA2O5VFuCojotM/dlJkIoLJtkN2EEyR/qFVoizEXpolbpP
         crUwRoOWuqASC2bDRyLUELkObvduTrGL36P8kvwhyVR17d9N2fW+hTJRk/g4SX1xGN0/
         oVz2HIGXviL3O0M1Bvn3V8j4wkaftP7mhIXa1xUKMKqlA9gJ2S9gpIbQBpNGAac/I6k7
         3bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pBlnEnGsMstGVyIAKqUSLHLBYoQgpr7wBNrwAms26Yo=;
        b=mdc2stm4Od63J3/euoZ3FX7bFuAb3lNAUnxgcp5R7nTczzIBO9vEyJ5dVA5Oh1nZgT
         bUqZese5simL+5qSz5vJA2I/mP8/d/dkAVi30yBQgzpIP76g2Bj3KqKE3NblVkyTbfPW
         BANiie+FKdFSX8xlnxV2JgGsTTJY/uHaKGjqLN0jIK22+lta3u1I/5cxZKBzB05c4lJy
         WuqpdPpvllsKwAOKBcFi8462GfChRz8DjcaQWuIoQZdRbq6X+FMWJojw6vHQ+hB+C+pW
         e8eh+/0QuKK5PkHtq/qgs87NoApxphAYEbIBqDjICvyTeE7d1BPY1x0ASBOaTpaqqm21
         VAWQ==
X-Gm-Message-State: APjAAAVU23T17HkWk5BbAEY5kUQMvYX/TqxguLkRMgt4HfA6LlBCN0A+
        P3bAgxnme9KEYxEIZRMacR4=
X-Google-Smtp-Source: APXvYqyMMrZF1/Re4YpunwWENhyrHlPdkj4bvOMtyz7rrMFPvXnZsgu1uZHAceyS/8F+rJM/rTosGw==
X-Received: by 2002:a63:da49:: with SMTP id l9mr44453319pgj.125.1582392000256;
        Sat, 22 Feb 2020 09:20:00 -0800 (PST)
Received: from localhost.localdomain (180-177-0-29.dynamic.kbronet.com.tw. [180.177.0.29])
        by smtp.googlemail.com with ESMTPSA id i27sm6501077pgn.76.2020.02.22.09.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Feb 2020 09:19:59 -0800 (PST)
From:   Manbing <manbing3@gmail.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Manbing <manbing3@gmail.com>, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: update UserModeLinux-HOWTO.txt
Date:   Sun, 23 Feb 2020 01:19:27 +0800
Message-Id: <1582391968-3960-1-git-send-email-manbing3@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original content is obsolete. Which is based on kernel 2.4.0-prerelease.
Updating content according to kernel 5.5.1.

Signed-off-by: Manbing <manbing3@gmail.com>
---
 Documentation/virt/uml/UserModeLinux-HOWTO.txt | 42 +++++---------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/uml/UserModeLinux-HOWTO.txt b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
index 87b80f5..08ee28d 100644
--- a/Documentation/virt/uml/UserModeLinux-HOWTO.txt
+++ b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
@@ -1,6 +1,6 @@
   User Mode Linux HOWTO
   User Mode Linux Core Team
-  Mon Nov 18 14:16:16 EST 2002
+  Mon Feb 10 08:27:24 EST 2020
 
   This document describes the use and abuse of Jeff Dike's User Mode
   Linux: a port of the Linux kernel as a normal Intel Linux process.
@@ -215,26 +215,17 @@
 
 
   Compiling the user mode kernel is just like compiling any other
-  kernel.  Let's go through the steps, using 2.4.0-prerelease (current
+  kernel.  Let's go through the steps, using 5.5.1 (current
   as of this writing) as an example:
 
 
-  1. Download the latest UML patch from
-
-     the download page <http://user-mode-linux.sourceforge.net/
-
-     In this example, the file is uml-patch-2.4.0-prerelease.bz2.
-
-
-  2. Download the matching kernel from your favourite kernel mirror,
+  1. Download the matching kernel from your favourite kernel mirror,
      such as:
 
-     ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2
-     <ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2>
-     .
+     wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
 
 
-  3. Make a directory and unpack the kernel into it.
+  2. Make a directory and unpack the kernel into it.
 
 
 
@@ -255,31 +246,14 @@
 
 
        host%
-       tar -xzvf linux-2.4.0-prerelease.tar.bz2
-
-
-
-
-
-
-  4. Apply the patch using
-
-
-
-       host%
-       cd ~/uml/linux
-
-
-
-       host%
-       bzcat uml-patch-2.4.0-prerelease.bz2 | patch -p1
+       tar xvf linux-5.5.1.tar.xz
 
 
 
 
 
 
-  5. Run your favorite config; `make xconfig ARCH=um' is the most
+  3. Run your favorite config; `make xconfig ARCH=um' is the most
      convenient.  `make config ARCH=um' and 'make menuconfig ARCH=um'
      will work as well.  The defaults will give you a useful kernel.  If
      you want to change something, go ahead, it probably won't hurt
@@ -293,7 +267,7 @@
 
 
 
-  6. Finish with `make linux ARCH=um': the result is a file called
+  4. Finish with `make linux ARCH=um': the result is a file called
      `linux' in the top directory of your source tree.
 
   Make sure that you don't build this kernel in /usr/src/linux.  On some
-- 
2.7.4

