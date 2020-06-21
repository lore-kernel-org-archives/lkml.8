Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87432C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC4248C4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgFUNgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:36:52 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:42468 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbgFUNgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:36:50 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 58D6F467DA;
        Sun, 21 Jun 2020 13:36:41 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Joe Perches <joe@perches.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
Date:   Sun, 21 Jun 2020 15:36:30 +0200
Message-Id: <20200621133630.46435-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Documentation/process/2.Process.rst           | 12 ++++----
 Documentation/process/4.Coding.rst            |  4 +--
 Documentation/process/botching-up-ioctls.rst  |  2 +-
 Documentation/process/changes.rst             |  6 ++--
 Documentation/process/clang-format.rst        |  2 +-
 Documentation/process/coding-style.rst        |  2 +-
 Documentation/process/howto.rst               |  2 +-
 Documentation/process/kernel-docs.rst         | 28 +++++++++----------
 .../process/maintainer-pgp-guide.rst          |  2 +-
 Documentation/process/submitting-drivers.rst  | 22 +++++++--------
 Documentation/process/submitting-patches.rst  |  4 +--
 11 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index b21b5b245d13..3588f48841eb 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -295,7 +295,7 @@ mainline get there via -mm.
 The current -mm patch is available in the "mmotm" (-mm of the moment)
 directory at:
 
-	http://www.ozlabs.org/~akpm/mmotm/
+	https://www.ozlabs.org/~akpm/mmotm/
 
 Use of the MMOTM tree is likely to be a frustrating experience, though;
 there is a definite chance that it will not even compile.
@@ -306,7 +306,7 @@ the mainline is expected to look like after the next merge window closes.
 Linux-next trees are announced on the linux-kernel and linux-next mailing
 lists when they are assembled; they can be downloaded from:
 
-	http://www.kernel.org/pub/linux/kernel/next/
+	https://www.kernel.org/pub/linux/kernel/next/
 
 Linux-next has become an integral part of the kernel development process;
 all patches merged during a given merge window should really have found
@@ -365,21 +365,21 @@ to keep up with what other developers (and the mainline) are doing.
 Git is now packaged by almost all Linux distributions.  There is a home
 page at:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
 That page has pointers to documentation and tutorials.
 
 Among the kernel developers who do not use git, the most popular choice is
 almost certainly Mercurial:
 
-	http://www.selenic.com/mercurial/
+	https://www.selenic.com/mercurial/
 
 Mercurial shares many features with git, but it provides an interface which
 many find easier to use.
 
 The other tool worth knowing about is Quilt:
 
-	http://savannah.nongnu.org/projects/quilt/
+	https://savannah.nongnu.org/projects/quilt/
 
 Quilt is a patch management system, rather than a source code management
 system.  It does not track history over time; it is, instead, oriented
@@ -494,7 +494,7 @@ Andrew Morton gives this advice for aspiring kernel developers
 	with others on getting things fixed up (this can require
 	persistence!) but that's fine - it's a part of kernel development.
 
-(http://lwn.net/Articles/283982/).
+(https://lwn.net/Articles/283982/).
 
 In the absence of obvious problems to fix, developers are advised to look
 at the current lists of regressions and open bugs in general.  There is
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 13dd893c9f88..c27e59d2f702 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -210,7 +210,7 @@ breaks?  The best answer to this question was expressed by Linus in July,
 	progress at all. Is it two steps forwards, one step back, or one
 	step forward and two steps back?
 
-(http://lwn.net/Articles/243460/).
+(https://lwn.net/Articles/243460/).
 
 An especially unwelcome type of regression is any sort of change to the
 user-space ABI.  Once an interface has been exported to user space, it must
@@ -323,7 +323,7 @@ other architectures.  If you do not happen to have an S/390 system or a
 Blackfin development board handy, you can still perform the compilation
 step.  A large set of cross compilers for x86 systems can be found at
 
-	http://www.kernel.org/pub/tools/crosstool/
+	https://www.kernel.org/pub/tools/crosstool/
 
 Some time spent installing and using these compilers will help avoid
 embarrassment later.
diff --git a/Documentation/process/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
index 2d4829b2fb09..ba4667ab396b 100644
--- a/Documentation/process/botching-up-ioctls.rst
+++ b/Documentation/process/botching-up-ioctls.rst
@@ -2,7 +2,7 @@
 (How to avoid) Botching up ioctls
 =================================
 
-From: http://blog.ffwll.ch/2013/11/botching-up-ioctls.html
+From: https://blog.ffwll.ch/2013/11/botching-up-ioctls.html
 
 By: Daniel Vetter, Copyright © 2013 Intel Corporation
 
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 5cfb54c2aaa6..4f376db3b978 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -129,7 +129,7 @@ Architectural changes
 ---------------------
 
 DevFS has been obsoleted in favour of udev
-(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
 
 32-bit UID support is now in place.  Have fun!
 
@@ -421,7 +421,7 @@ Intel P6 microcode
 udev
 ----
 
-- <http://www.freedesktop.org/software/systemd/man/udev.html>
+- <https://www.freedesktop.org/software/systemd/man/udev.html>
 
 FUSE
 ----
@@ -474,4 +474,4 @@ Kernel documentation
 Sphinx
 ------
 
-- <http://www.sphinx-doc.org/>
+- <https://www.sphinx-doc.org/>
diff --git a/Documentation/process/clang-format.rst b/Documentation/process/clang-format.rst
index 6710c0707721..82676e5a7c6e 100644
--- a/Documentation/process/clang-format.rst
+++ b/Documentation/process/clang-format.rst
@@ -32,7 +32,7 @@ Linux distributions for a long time. Search for ``clang-format`` in
 your repositories. Otherwise, you can either download pre-built
 LLVM/clang binaries or build the source code from:
 
-    http://releases.llvm.org/download.html
+    https://releases.llvm.org/download.html
 
 See more information about the tool at:
 
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 2657a55c6f12..14f06ec22727 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1129,7 +1129,7 @@ Addison-Wesley, Inc., 1999.
 ISBN 0-201-61586-X.
 
 GNU manuals - where in compliance with K&R and this text - for cpp, gcc,
-gcc internals and indent, all available from http://www.gnu.org/manual/
+gcc internals and indent, all available from https://www.gnu.org/manual/
 
 WG14 is the international standardization working group for the programming
 language C, URL: http://www.open-std.org/JTC1/SC22/WG14/
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 70791e153de1..20c9e07e09a4 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -597,7 +597,7 @@ For more details on what this should all look like, please see the
 ChangeLog section of the document:
 
   "The Perfect Patch"
-      http://www.ozlabs.org/~akpm/stuff/tpp.txt
+      https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 
 All of these things are sometimes very hard to do. It can take years to
diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 9d6d0ac4fca9..64786e50026c 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -98,7 +98,7 @@ On-line docs
     * Title: **Linux Device Drivers, Third Edition**
 
       :Author: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
-      :URL: http://lwn.net/Kernel/LDD3/
+      :URL: https://lwn.net/Kernel/LDD3/
       :Date: 2005
       :Description: A 600-page book covering the (2.6.10) driver
         programming API and kernel hacking in general.  Available under the
@@ -129,7 +129,7 @@ On-line docs
     * Title: **Linux Kernel Module Programming Guide**
 
       :Author: Ori Pomerantz.
-      :URL: http://tldp.org/LDP/lkmpg/2.6/html/index.html
+      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
       :Date: 2001
       :Keywords: modules, GPL book, /proc, ioctls, system calls,
         interrupt handlers .
@@ -244,7 +244,7 @@ On-line docs
     * Title: **I/O Event Handling Under Linux**
 
       :Author: Richard Gooch.
-      :URL: http://web.mit.edu/~yandros/doc/io-events.html
+      :URL: https://web.mit.edu/~yandros/doc/io-events.html
       :Date: 1999
       :Keywords: IO, I/O, select(2), poll(2), FDs, aio_read(2), readiness
         event queues.
@@ -295,7 +295,7 @@ On-line docs
     * Title: **Design and Implementation of the Second Extended Filesystem**
 
       :Author: Rémy Card, Theodore Ts'o, Stephen Tweedie.
-      :URL: http://web.mit.edu/tytso/www/linux/ext2intro.html
+      :URL: https://web.mit.edu/tytso/www/linux/ext2intro.html
       :Date: 1998
       :Keywords: ext2, linux fs history, inode, directory, link, devices,
         VFS, physical structure, performance, benchmarks, ext2fs library,
@@ -322,7 +322,7 @@ On-line docs
     * Title: **Linux Kernel Hackers' Guide**
 
       :Author: Michael K. Johnson.
-      :URL: http://www.tldp.org/LDP/khg/HyperNews/get/khg.html
+      :URL: https://www.tldp.org/LDP/khg/HyperNews/get/khg.html
       :Date: 1997
       :Keywords: device drivers, files, VFS, kernel interface, character vs
         block devices, hardware interrupts, scsi, DMA, access to user memory,
@@ -375,7 +375,7 @@ On-line docs
     * Title: **Dissecting Interrupts and Browsing DMA**
 
       :Author: Alessandro Rubini and Georg v. Zezschwitz.
-      :URL: http://www.linuxjournal.com/article.php?sid=1222
+      :URL: https://www.linuxjournal.com/article.php?sid=1222
       :Date: 1996
       :Keywords: interrupts, irqs, DMA, bottom halves, task queues.
       :Description: Linux Journal Kernel Korner article.
@@ -391,7 +391,7 @@ On-line docs
     * Title: **Device Drivers Concluded**
 
       :Author: Georg v. Zezschwitz.
-      :URL: http://www.linuxjournal.com/article.php?sid=1287
+      :URL: https://www.linuxjournal.com/article.php?sid=1287
       :Date: 1996
       :Keywords: address spaces, pages, pagination, page management,
         demand loading, swapping, memory protection, memory mapping, mmap,
@@ -405,7 +405,7 @@ On-line docs
     * Title: **Network Buffers And Memory Management**
 
       :Author: Alan Cox.
-      :URL: http://www.linuxjournal.com/article.php?sid=1312
+      :URL: https://www.linuxjournal.com/article.php?sid=1312
       :Date: 1996
       :Keywords: sk_buffs, network devices, protocol/link layer
         variables, network devices flags, transmit, receive,
@@ -418,7 +418,7 @@ On-line docs
     * Title: **Analysis of the Ext2fs structure**
 
       :Author: Louis-Dominique Dubeau.
-      :URL: http://teaching.csse.uwa.edu.au/units/CITS2002/fs-ext2/
+      :URL: https://teaching.csse.uwa.edu.au/units/CITS2002/fs-ext2/
       :Date: 1994
       :Keywords: ext2, filesystem, ext2fs.
       :Description: Description of ext2's blocks, directories, inodes,
@@ -480,7 +480,7 @@ Published books
       :ISBN: 0-596-00590-3
       :Notes: Further information in
         http://www.oreilly.com/catalog/linuxdrive3/
-        PDF format, URL: http://lwn.net/Kernel/LDD3/
+        PDF format, URL: https://lwn.net/Kernel/LDD3/
 
     * Title: **Linux Kernel Internals**
 
@@ -561,7 +561,7 @@ Miscellaneous
 
     * Name: **Linux Weekly News**
 
-      :URL: http://lwn.net
+      :URL: https://lwn.net
       :Keywords: latest kernel news.
       :Description: The title says it all. There's a fixed kernel section
         summarizing developers' work, bug fixes, new features and versions
@@ -570,7 +570,7 @@ Miscellaneous
     * Name: **The home page of Linux-MM**
 
       :Author: The Linux-MM team.
-      :URL: http://linux-mm.org/
+      :URL: https://linux-mm.org/
       :Keywords: memory management, Linux-MM, mm patches, TODO, docs,
         mailing list.
       :Description: Site devoted to Linux Memory Management development.
@@ -579,7 +579,7 @@ Miscellaneous
 
     * Name: **Kernel Newbies IRC Channel and Website**
 
-      :URL: http://www.kernelnewbies.org
+      :URL: https://www.kernelnewbies.org
       :Keywords: IRC, newbies, channel, asking doubts.
       :Description: #kernelnewbies on irc.oftc.net.
         #kernelnewbies is an IRC network dedicated to the 'newbie'
@@ -605,4 +605,4 @@ Miscellaneous
 Document last updated on Tue 2016-Sep-20
 
 This document is based on:
- http://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
+ https://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html
diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index 17db11b7ed48..8f8f1fee92b8 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -462,7 +462,7 @@ geographical region, and open/proprietary hardware considerations.
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
 .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
-.. _Gnuk: http://www.fsij.org/doc-gnuk/
+.. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`LWN has a good review`: https://lwn.net/Articles/736231/
 .. _`qualify for a free Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
 
diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
index 1acaa14903d6..74b35bfc6623 100644
--- a/Documentation/process/submitting-drivers.rst
+++ b/Documentation/process/submitting-drivers.rst
@@ -5,8 +5,8 @@ Submitting Drivers For The Linux Kernel
 
 This document is intended to explain how to submit device drivers to the
 various kernel trees. Note that if you are interested in video card drivers
-you should probably talk to XFree86 (http://www.xfree86.org/) and/or X.Org
-(http://x.org/) instead.
+you should probably talk to XFree86 (https://www.xfree86.org/) and/or X.Org
+(https://x.org/) instead.
 
 .. note::
 
@@ -25,7 +25,7 @@ Allocating Device Numbers
 
 Major and minor numbers for block and character devices are allocated
 by the Linux assigned name and number authority (currently this is
-Torben Mathiasen). The site is http://www.lanana.org/. This
+Torben Mathiasen). The site is https://www.lanana.org/. This
 also deals with allocating numbers for devices that are not going to
 be submitted to the mainstream kernel.
 See :ref:`Documentation/admin-guide/devices.rst <admin_devices>`
@@ -155,30 +155,30 @@ Linux kernel master tree:
 	where *country_code* == your country code, such as
 	**us**, **uk**, **fr**, etc.
 
-	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git
+	https://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git
 
 Linux kernel mailing list:
 	linux-kernel@vger.kernel.org
 	[mail majordomo@vger.kernel.org to subscribe]
 
 Linux Device Drivers, Third Edition (covers 2.6.10):
-	http://lwn.net/Kernel/LDD3/  (free version)
+	https://lwn.net/Kernel/LDD3/  (free version)
 
 LWN.net:
-	Weekly summary of kernel development activity - http://lwn.net/
+	Weekly summary of kernel development activity - https://lwn.net/
 
 	2.6 API changes:
 
-		http://lwn.net/Articles/2.6-kernel-api/
+		https://lwn.net/Articles/2.6-kernel-api/
 
 	Porting drivers from prior kernels to 2.6:
 
-		http://lwn.net/Articles/driver-porting/
+		https://lwn.net/Articles/driver-porting/
 
 KernelNewbies:
 	Documentation and assistance for new kernel programmers
 
-		http://kernelnewbies.org/
+		https://kernelnewbies.org/
 
 Linux USB project:
 	http://www.linux-usb.org/
@@ -187,7 +187,7 @@ How to NOT write kernel driver by Arjan van de Ven:
 	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
 
 Kernel Janitor:
-	http://kernelnewbies.org/KernelJanitors
+	https://kernelnewbies.org/KernelJanitors
 
 GIT, Fast Version Control System:
-	http://git-scm.com/
+	https://git-scm.com/
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1699b7f8e63a..e58b2c541d25 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -94,7 +94,7 @@ individual patches which modify things in logical stages; see
 very important if you want your patch accepted.
 
 If you're using ``git``, ``git rebase -i`` can help you with this process.  If
-you're not using ``git``, ``quilt`` <http://savannah.nongnu.org/projects/quilt>
+you're not using ``git``, ``quilt`` <https://savannah.nongnu.org/projects/quilt>
 is another popular alternative.
 
 .. _describe_changes:
@@ -892,7 +892,7 @@ References
 ----------
 
 Andrew Morton, "The perfect patch" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
-- 
2.27.0

