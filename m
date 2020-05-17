Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 03:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E6206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 03:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrJGD+zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgEQDn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 23:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEQDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 23:43:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BCDC061A0C;
        Sat, 16 May 2020 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Zsnnjh4Q+YwQiZZqIUAw5CELsY96VaLjYGkB34TQjs4=; b=XrJGD+zxIJJo6FEUFinQE1t/wy
        JUpYxv+2J/Q+dBZHv0FVR8uoOJvZvvbjMlEl6v1V+9bx2tj+nvIEZ486c2ar0vdjh5FZxbUS3cPcz
        bv5pgW9CW321rD011GZXayZy+pMBXeo0wei3lIJ8C9WLLm7CR7+XIVdiOF550GPG4FN2KEfD2qqk/
        wCfWBkM6TX7MHWHwAsc4i1Dnb8ZmPrUIx+XsBT0ohF1igdj1GZ1LwwQ0Cx2Xm9bNJ/7zPYqYkEBNq
        oC0bjQVDYz+7SBeUBYoZsOCMZNyKeyH2gIZlIB4uZr6V01DOI97HmiLHBj0NhPGQezhpM4k/eEVSH
        C1y/0myA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaADE-0006A4-1I; Sun, 17 May 2020 03:43:40 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, greg@wind.rmcc.com,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: admin-guide: update bug-hunting.rst
Message-ID: <c629a9ef-3867-c3d1-f6c9-2c3b0e4ac68a@infradead.org>
Date:   Sat, 16 May 2020 20:43:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update Documentation/admin-guide/bug-hunting.rst:

- add a small section on "Modules linked in" and their possible flags;
- delete all references to ksymoops since it is no longer applicable;
- fix spello, grammar, and punctuation;
- note that get_maintainers.pl only provides recent patchers if it is
  run inside a git tree;
- add mention of scripts/decode_stacktrace.sh;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: greg@wind.rmcc.com
---
 Documentation/admin-guide/bug-hunting.rst |   53 +++++++++++---------
 1 file changed, 31 insertions(+), 22 deletions(-)

--- linux-next-20200515.orig/Documentation/admin-guide/bug-hunting.rst
+++ linux-next-20200515/Documentation/admin-guide/bug-hunting.rst
@@ -49,15 +49,19 @@ the issue, it may also contain the word
 
 Despite being an **Oops** or some other sort of stack trace, the offended
 line is usually required to identify and handle the bug. Along this chapter,
-we'll refer to "Oops" for all kinds of stack traces that need to be analized.
+we'll refer to "Oops" for all kinds of stack traces that need to be analyzed.
 
-.. note::
+If the kernel is compiled with ``CONFIG_DEBUG_INFO``, you can enhance the
+quality of the stack trace by using file:`scripts/decode_stacktrace.sh`.
+
+Modules linked in
+-----------------
+
+Modules that are tainted or are being loaded or unloaded are marked with
+"(...)", where the taint flags are described in
+file:`Documentation/admin-guide/tainted-kernels.rst`, "being loaded" is
+annotated with "+", and "being unloaded" is annotated with "-".
 
-  ``ksymoops`` is useless on 2.6 or upper.  Please use the Oops in its original
-  format (from ``dmesg``, etc).  Ignore any references in this or other docs to
-  "decoding the Oops" or "running it through ksymoops".
-  If you post an Oops from 2.6+ that has been run through ``ksymoops``,
-  people will just tell you to repost it.
 
 Where is the Oops message is located?
 -------------------------------------
@@ -71,7 +75,7 @@ by running ``journalctl`` command.
 Sometimes ``klogd`` dies, in which case you can run ``dmesg > file`` to
 read the data from the kernel buffers and save it.  Or you can
 ``cat /proc/kmsg > file``, however you have to break in to stop the transfer,
-``kmsg`` is a "never ending file".
+since ``kmsg`` is a "never ending file".
 
 If the machine has crashed so badly that you cannot enter commands or
 the disk is not available then you have three options:
@@ -81,9 +85,9 @@ the disk is not available then you have
     planned for a crash. Alternatively, you can take a picture of
     the screen with a digital camera - not nice, but better than
     nothing.  If the messages scroll off the top of the console, you
-    may find that booting with a higher resolution (eg, ``vga=791``)
+    may find that booting with a higher resolution (e.g., ``vga=791``)
     will allow you to read more of the text. (Caveat: This needs ``vesafb``,
-    so won't help for 'early' oopses)
+    so won't help for 'early' oopses.)
 
 (2) Boot with a serial console (see
     :ref:`Documentation/admin-guide/serial-console.rst <serial_console>`),
@@ -104,7 +108,7 @@ Kernel source file. There are two method
 gdb
 ^^^
 
-The GNU debug (``gdb``) is the best way to figure out the exact file and line
+The GNU debugger (``gdb``) is the best way to figure out the exact file and line
 number of the OOPS from the ``vmlinux`` file.
 
 The usage of gdb works best on a kernel compiled with ``CONFIG_DEBUG_INFO``.
@@ -165,7 +169,7 @@ If you have a call trace, such as::
       [<ffffffff8802770b>] :jbd:journal_stop+0x1be/0x1ee
       ...
 
-this shows the problem likely in the :jbd: module. You can load that module
+this shows the problem likely is in the :jbd: module. You can load that module
 in gdb and list the relevant code::
 
   $ gdb fs/jbd/jbd.ko
@@ -199,8 +203,9 @@ in the kernel hacking menu of the menu c
    You need to be at the top level of the kernel tree for this to pick up
    your C files.
 
-If you don't have access to the code you can also debug on some crash dumps
-e.g. crash dump output as shown by Dave Miller::
+If you don't have access to the source code you can still debug some crash
+dumps using the following method (example crash dump output as shown by
+Dave Miller)::
 
      EIP is at 	+0x14/0x4c0
       ...
@@ -230,6 +235,9 @@ e.g. crash dump output as shown by Dave
          mov        0x8(%ebp), %ebx         ! %ebx = skb->sk
          mov        0x13c(%ebx), %eax       ! %eax = inet_sk(sk)->opt
 
+file:`scripts/decodecode` can be used to automate most of this, depending
+on what CPU architecture is being debugged.
+
 Reporting the bug
 -----------------
 
@@ -241,7 +249,7 @@ used for the development of the affected
 the ``get_maintainer.pl`` script.
 
 For example, if you find a bug at the gspca's sonixj.c file, you can get
-their maintainers with::
+its maintainers with::
 
 	$ ./scripts/get_maintainer.pl -f drivers/media/usb/gspca/sonixj.c
 	Hans Verkuil <hverkuil@xs4all.nl> (odd fixer:GSPCA USB WEBCAM DRIVER,commit_signer:1/1=100%)
@@ -253,16 +261,17 @@ their maintainers with::
 
 Please notice that it will point to:
 
-- The last developers that touched on the source code. On the above example,
-  Tejun and Bhaktipriya (in this specific case, none really envolved on the
-  development of this file);
+- The last developers that touched the source code (if this is done inside
+  a git tree). On the above example, Tejun and Bhaktipriya (in this
+  specific case, none really envolved on the development of this file);
 - The driver maintainer (Hans Verkuil);
 - The subsystem maintainer (Mauro Carvalho Chehab);
 - The driver and/or subsystem mailing list (linux-media@vger.kernel.org);
 - the Linux Kernel mailing list (linux-kernel@vger.kernel.org).
 
 Usually, the fastest way to have your bug fixed is to report it to mailing
-list used for the development of the code (linux-media ML) copying the driver maintainer (Hans).
+list used for the development of the code (linux-media ML) copying the
+driver maintainer (Hans).
 
 If you are totally stumped as to whom to send the report, and
 ``get_maintainer.pl`` didn't provide you anything useful, send it to
@@ -303,9 +312,9 @@ protection fault message can be simply c
 and forwarded to the kernel developers.
 
 Two types of address resolution are performed by ``klogd``.  The first is
-static translation and the second is dynamic translation.  Static
-translation uses the System.map file in much the same manner that
-ksymoops does.  In order to do static translation the ``klogd`` daemon
+static translation and the second is dynamic translation.
+Static translation uses the System.map file.
+In order to do static translation the ``klogd`` daemon
 must be able to find a system map file at daemon initialization time.
 See the klogd man page for information on how ``klogd`` searches for map
 files.

