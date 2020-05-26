Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF91C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE20820870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgEZGGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgEZGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:06:11 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B42C061A0E;
        Mon, 25 May 2020 23:06:11 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id CCD44455AE;
        Tue, 26 May 2020 06:06:07 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Replace HTTP links with HTTPS ones: documentation
Date:   Tue, 26 May 2020 08:05:44 +0200
Message-Id: <20200526060544.25127-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  For each line:
    If doesn't contain `\bxmlns\b`:
      For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
        If both the HTTP and HTTPS versions
        return 200 OK and serve the same content:
          Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Documentation/COPYING-logo                       |  2 +-
 Documentation/admin-guide/LSM/tomoyo.rst         | 16 ++++++++--------
 .../admin-guide/acpi/initrd_table_override.rst   |  2 +-
 Documentation/admin-guide/bcache.rst             |  4 ++--
 Documentation/admin-guide/devices.rst            |  2 +-
 Documentation/admin-guide/initrd.rst             |  2 +-
 Documentation/admin-guide/md.rst                 |  2 +-
 Documentation/admin-guide/mono.rst               |  4 ++--
 Documentation/admin-guide/reporting-bugs.rst     |  2 +-
 Documentation/admin-guide/unicode.rst            |  4 ++--
 Documentation/conf.py                            |  2 +-
 Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
 Documentation/doc-guide/parse-headers.rst        |  2 +-
 .../driver-api/acpi/linuxized-acpica.rst         |  6 +++---
 Documentation/driver-api/usb/bulk-streams.rst    |  4 ++--
 .../driver-api/usb/writing_musb_glue_layer.rst   |  6 +++---
 Documentation/filesystems/path-lookup.txt        |  2 +-
 Documentation/filesystems/seq_file.txt           |  4 ++--
 Documentation/misc-devices/c2port.txt            |  6 +++---
 Documentation/process/3.Early-stage.rst          |  2 +-
 Documentation/process/7.AdvancedTopics.rst       |  8 ++++----
 Documentation/process/8.Conclusion.rst           | 14 +++++++-------
 Documentation/process/adding-syscalls.rst        |  4 ++--
 Documentation/process/applying-patches.rst       |  4 ++--
 .../process/volatile-considered-harmful.rst      |  4 ++--
 Documentation/rbtree.txt                         |  4 ++--
 Documentation/security/SCTP.rst                  |  2 +-
 Documentation/sphinx/kfigure.py                  |  6 +++---
 Documentation/static-keys.txt                    |  2 +-
 Documentation/trace/events-msr.rst               |  2 +-
 Documentation/trace/mmiotrace.rst                |  2 +-
 Documentation/vm/ksm.rst                         |  2 +-
 Documentation/xz.txt                             |  6 +++---
 scripts/kernel-doc                               |  2 +-
 34 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/Documentation/COPYING-logo b/Documentation/COPYING-logo
index 296f0f7f67eb..b21c7cf7d9f6 100644
--- a/Documentation/COPYING-logo
+++ b/Documentation/COPYING-logo
@@ -9,5 +9,5 @@ scale down to smaller sizes and are better for letterheads or whatever
 you want to use it for: for the full range of logos take a look at
 Larry's web-page:
 
-	http://www.isc.tamu.edu/~lewing/linux/
+	https://www.isc.tamu.edu/~lewing/linux/
 
diff --git a/Documentation/admin-guide/LSM/tomoyo.rst b/Documentation/admin-guide/LSM/tomoyo.rst
index e2d6b6e15082..4bc9c2b4da6f 100644
--- a/Documentation/admin-guide/LSM/tomoyo.rst
+++ b/Documentation/admin-guide/LSM/tomoyo.rst
@@ -27,29 +27,29 @@ Where is documentation?
 =======================
 
 User <-> Kernel interface documentation is available at
-http://tomoyo.osdn.jp/2.5/policy-specification/index.html .
+https://tomoyo.osdn.jp/2.5/policy-specification/index.html .
 
 Materials we prepared for seminars and symposiums are available at
-http://osdn.jp/projects/tomoyo/docs/?category_id=532&language_id=1 .
+https://osdn.jp/projects/tomoyo/docs/?category_id=532&language_id=1 .
 Below lists are chosen from three aspects.
 
 What is TOMOYO?
   TOMOYO Linux Overview
-    http://osdn.jp/projects/tomoyo/docs/lca2009-takeda.pdf
+    https://osdn.jp/projects/tomoyo/docs/lca2009-takeda.pdf
   TOMOYO Linux: pragmatic and manageable security for Linux
-    http://osdn.jp/projects/tomoyo/docs/freedomhectaipei-tomoyo.pdf
+    https://osdn.jp/projects/tomoyo/docs/freedomhectaipei-tomoyo.pdf
   TOMOYO Linux: A Practical Method to Understand and Protect Your Own Linux Box
-    http://osdn.jp/projects/tomoyo/docs/PacSec2007-en-no-demo.pdf
+    https://osdn.jp/projects/tomoyo/docs/PacSec2007-en-no-demo.pdf
 
 What can TOMOYO do?
   Deep inside TOMOYO Linux
-    http://osdn.jp/projects/tomoyo/docs/lca2009-kumaneko.pdf
+    https://osdn.jp/projects/tomoyo/docs/lca2009-kumaneko.pdf
   The role of "pathname based access control" in security.
-    http://osdn.jp/projects/tomoyo/docs/lfj2008-bof.pdf
+    https://osdn.jp/projects/tomoyo/docs/lfj2008-bof.pdf
 
 History of TOMOYO?
   Realities of Mainlining
-    http://osdn.jp/projects/tomoyo/docs/lfj2008.pdf
+    https://osdn.jp/projects/tomoyo/docs/lfj2008.pdf
 
 What is future plan?
 ====================
diff --git a/Documentation/admin-guide/acpi/initrd_table_override.rst b/Documentation/admin-guide/acpi/initrd_table_override.rst
index cbd768207631..bb24fa6b5fbe 100644
--- a/Documentation/admin-guide/acpi/initrd_table_override.rst
+++ b/Documentation/admin-guide/acpi/initrd_table_override.rst
@@ -102,7 +102,7 @@ Where to retrieve userspace tools
 =================================
 
 iasl and acpixtract are part of Intel's ACPICA project:
-http://acpica.org/
+https://acpica.org/
 
 and should be packaged by distributions (for example in the acpica package
 on SUSE).
diff --git a/Documentation/admin-guide/bcache.rst b/Documentation/admin-guide/bcache.rst
index c0ce64d75bbf..1eccf952876d 100644
--- a/Documentation/admin-guide/bcache.rst
+++ b/Documentation/admin-guide/bcache.rst
@@ -7,9 +7,9 @@ nice if you could use them as cache... Hence bcache.
 
 Wiki and git repositories are at:
 
-  - http://bcache.evilpiepirate.org
+  - https://bcache.evilpiepirate.org
   - http://evilpiepirate.org/git/linux-bcache.git
-  - http://evilpiepirate.org/git/bcache-tools.git
+  - https://evilpiepirate.org/git/bcache-tools.git
 
 It's designed around the performance characteristics of SSDs - it only allocates
 in erase block sized buckets, and it uses a hybrid btree/log to track cached
diff --git a/Documentation/admin-guide/devices.rst b/Documentation/admin-guide/devices.rst
index d41671aeaef0..035275fedbdd 100644
--- a/Documentation/admin-guide/devices.rst
+++ b/Documentation/admin-guide/devices.rst
@@ -17,7 +17,7 @@ Specifically explore the sections titled "CHAR and MISC DRIVERS", and
 to involve for character and block devices.
 
 This document is included by reference into the Filesystem Hierarchy
-Standard (FHS).	 The FHS is available from http://www.pathname.com/fhs/.
+Standard (FHS).	 The FHS is available from https://www.pathname.com/fhs/.
 
 Allocations marked (68k/Amiga) apply to Linux/68k on the Amiga
 platform only.	Allocations marked (68k/Atari) apply to Linux/68k on
diff --git a/Documentation/admin-guide/initrd.rst b/Documentation/admin-guide/initrd.rst
index a03dabaaf3a3..67bbad8806e8 100644
--- a/Documentation/admin-guide/initrd.rst
+++ b/Documentation/admin-guide/initrd.rst
@@ -376,7 +376,7 @@ Resources
 ---------
 
 .. [#f1] Almesberger, Werner; "Booting Linux: The History and the Future"
-    http://www.almesberger.net/cv/papers/ols2k-9.ps.gz
+    https://www.almesberger.net/cv/papers/ols2k-9.ps.gz
 .. [#f2] newlib package (experimental), with initrd example
     https://www.sourceware.org/newlib/
 .. [#f3] util-linux: Miscellaneous utilities for Linux
diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index 3c51084ffd37..d973d469ffc4 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -5,7 +5,7 @@ Boot time assembly of RAID arrays
 ---------------------------------
 
 Tools that manage md devices can be found at
-   http://www.kernel.org/pub/linux/utils/raid/
+   https://www.kernel.org/pub/linux/utils/raid/
 
 
 You can boot with your md device with the following kernel command
diff --git a/Documentation/admin-guide/mono.rst b/Documentation/admin-guide/mono.rst
index 59e6d59f0ed9..c6dab5680065 100644
--- a/Documentation/admin-guide/mono.rst
+++ b/Documentation/admin-guide/mono.rst
@@ -12,11 +12,11 @@ other program after you have done the following:
    a binary package, a source tarball or by installing from Git. Binary
    packages for several distributions can be found at:
 
-	http://www.mono-project.com/download/
+	https://www.mono-project.com/download/
 
    Instructions for compiling Mono can be found at:
 
-	http://www.mono-project.com/docs/compiling-mono/linux/
+	https://www.mono-project.com/docs/compiling-mono/linux/
 
    Once the Mono CLR support has been installed, just check that
    ``/usr/bin/mono`` (which could be located elsewhere, for example
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 49ac8dc3594d..42481ea7b41d 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -75,7 +75,7 @@ Tips for reporting bugs
 
 If you haven't reported a bug before, please read:
 
-	http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
+	https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
 
 	http://www.catb.org/esr/faqs/smart-questions.html
 
diff --git a/Documentation/admin-guide/unicode.rst b/Documentation/admin-guide/unicode.rst
index 7425a3351321..290fe83ebe82 100644
--- a/Documentation/admin-guide/unicode.rst
+++ b/Documentation/admin-guide/unicode.rst
@@ -114,7 +114,7 @@ Unicode practice.
   This range is now officially managed by the ConScript Unicode
   Registry.  The normative reference is at:
 
-	http://www.evertype.com/standards/csur/klingon.html
+	https://www.evertype.com/standards/csur/klingon.html
 
 Klingon has an alphabet of 26 characters, a positional numeric writing
 system with 10 digits, and is written left-to-right, top-to-bottom.
@@ -178,7 +178,7 @@ fictional and artificial scripts has been established by John Cowan
 <jcowan@reutershealth.com> and Michael Everson <everson@evertype.com>.
 The ConScript Unicode Registry is accessible at:
 
-	  http://www.evertype.com/standards/csur/
+	  https://www.evertype.com/standards/csur/
 
 The ranges used fall at the low end of the End User Zone and can hence
 not be normatively assigned, but it is recommended that people who
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 9ae8e9abf846..361e038c5474 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -576,7 +576,7 @@ epub_exclude_files = ['search.html']
 # Grouping the document tree into PDF files. List of tuples
 # (source start file, target name, title, author, options).
 #
-# See the Sphinx chapter of http://ralsina.me/static/manual.pdf
+# See the Sphinx chapter of https://ralsina.me/static/manual.pdf
 #
 # FIXME: Do not add the index file here; the result will be too big. Adding
 # multiple PDF files here actually tries to get the cross-referencing right
diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
index 19df79286f00..4756f6b3a04e 100644
--- a/Documentation/dev-tools/gdb-kernel-debugging.rst
+++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
@@ -24,7 +24,7 @@ Setup
 
 - Create a virtual Linux machine for QEMU/KVM (see www.linux-kvm.org and
   www.qemu.org for more details). For cross-development,
-  http://landley.net/aboriginal/bin keeps a pool of machine images and
+  https://landley.net/aboriginal/bin keeps a pool of machine images and
   toolchains that can be helpful to start from.
 
 - Build the kernel with CONFIG_GDB_SCRIPTS enabled, but leave
diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 24cfaa15dd81..ac5d9304a918 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -186,7 +186,7 @@ COPYRIGHT
 
 Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
 
-License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+License GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
 
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.
diff --git a/Documentation/driver-api/acpi/linuxized-acpica.rst b/Documentation/driver-api/acpi/linuxized-acpica.rst
index 0ca8f1538519..6bee03383225 100644
--- a/Documentation/driver-api/acpi/linuxized-acpica.rst
+++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
@@ -175,9 +175,9 @@ illustrated in the following figure::
     B. acpica / master - "master" branch of the git repository at
        <https://github.com/acpica/acpica.git>.
     C. linux-pm / linux-next - "linux-next" branch of the git repository at
-       <http://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git>.
+       <https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git>.
     D. linux / master - "master" branch of the git repository at
-       <http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>.
+       <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>.
 
    Before the linuxized ACPICA patches are sent to the Linux ACPI community
    for review, there is a quality assurance build test process to reduce
@@ -274,6 +274,6 @@ before they become available from the ACPICA release process.
    a diff file indicating the state of the current divergences::
 
    # git clone https://github.com/acpica/acpica
-   # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+   # git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    # cd acpica
    # generate/linux/divergences.sh -s ../linux
diff --git a/Documentation/driver-api/usb/bulk-streams.rst b/Documentation/driver-api/usb/bulk-streams.rst
index 99b515babdeb..eeefe582f8ff 100644
--- a/Documentation/driver-api/usb/bulk-streams.rst
+++ b/Documentation/driver-api/usb/bulk-streams.rst
@@ -9,9 +9,9 @@ device driver to overload a bulk endpoint so that multiple transfers can be
 queued at once.
 
 Streams are defined in sections 4.4.6.4 and 8.12.1.4 of the Universal Serial Bus
-3.0 specification at http://www.usb.org/developers/docs/  The USB Attached SCSI
+3.0 specification at https://www.usb.org/developers/docs/  The USB Attached SCSI
 Protocol, which uses streams to queue multiple SCSI commands, can be found on
-the T10 website (http://t10.org/).
+the T10 website (https://t10.org/).
 
 
 Device-side implications
diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index 5bf7152fd76f..10416cc11cd5 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -707,12 +707,12 @@ cheerful guidance and support.
 Resources
 =========
 
-USB Home Page: http://www.usb.org
+USB Home Page: https://www.usb.org
 
-linux-usb Mailing List Archives: http://marc.info/?l=linux-usb
+linux-usb Mailing List Archives: https://marc.info/?l=linux-usb
 
 USB On-the-Go Basics:
-http://www.maximintegrated.com/app-notes/index.mvp/id/1822
+https://www.maximintegrated.com/app-notes/index.mvp/id/1822
 
 :ref:`Writing USB Device Drivers <writing-usb-driver>`
 
diff --git a/Documentation/filesystems/path-lookup.txt b/Documentation/filesystems/path-lookup.txt
index 9b8930f589d9..1aa7ce099f6f 100644
--- a/Documentation/filesystems/path-lookup.txt
+++ b/Documentation/filesystems/path-lookup.txt
@@ -375,7 +375,7 @@ common path elements, the more likely they will exist in dentry cache.
 Papers and other documentation on dcache locking
 ================================================
 
-1. Scaling dcache with RCU (http://linuxjournal.com/article.php?sid=7124).
+1. Scaling dcache with RCU (https://linuxjournal.com/article.php?sid=7124).
 
 2. http://lse.sourceforge.net/locking/dcache/dcache.html
 
diff --git a/Documentation/filesystems/seq_file.txt b/Documentation/filesystems/seq_file.txt
index d412b236a9d6..361ff0ebf17a 100644
--- a/Documentation/filesystems/seq_file.txt
+++ b/Documentation/filesystems/seq_file.txt
@@ -2,7 +2,7 @@ The seq_file interface
 
 	Copyright 2003 Jonathan Corbet <corbet@lwn.net>
 	This file is originally from the LWN.net Driver Porting series at
-	http://lwn.net/Articles/driver-porting/
+	https://lwn.net/Articles/driver-porting/
 
 
 There are numerous ways for a device driver (or other kernel component) to
@@ -52,7 +52,7 @@ Then concatenate the output files out1 and out2 and get the right
 result. Yes, it is a thoroughly useless module, but the point is to show
 how the mechanism works without getting lost in other details.  (Those
 wanting to see the full source for this module can find it at
-http://lwn.net/Articles/22359/).
+https://lwn.net/Articles/22359/).
 
 Deprecated create_proc_entry
 
diff --git a/Documentation/misc-devices/c2port.txt b/Documentation/misc-devices/c2port.txt
index ea7344465610..31351b1a5a1f 100644
--- a/Documentation/misc-devices/c2port.txt
+++ b/Documentation/misc-devices/c2port.txt
@@ -28,14 +28,14 @@ where the micro controller is connected via special GPIOs pins.
 References
 ----------
 
-The C2 Interface main references are at (http://www.silabs.com)
+The C2 Interface main references are at (https://www.silabs.com)
 Silicon Laboratories site], see:
 
 - AN127: FLASH Programming via the C2 Interface at
-http://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf 
+https://www.silabs.com/Support Documents/TechnicalDocs/an127.pdf 
 
 - C2 Specification at
-http://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
+https://www.silabs.com/pages/DownloadDoc.aspx?FILEURL=Support%20Documents/TechnicalDocs/an127.pdf&src=SearchResults
 
 however it implements a two wire serial communication protocol (bit
 banging) designed to enable in-system programming, debugging, and
diff --git a/Documentation/process/3.Early-stage.rst b/Documentation/process/3.Early-stage.rst
index be00716071d4..eaafb4b22f33 100644
--- a/Documentation/process/3.Early-stage.rst
+++ b/Documentation/process/3.Early-stage.rst
@@ -46,7 +46,7 @@ and posted this:
 	to communicate user requirements to these people is a waste of
 	time. They are much too "intelligent" to listen to lesser mortals.
 
-(http://lwn.net/Articles/131776/).
+(https://lwn.net/Articles/131776/).
 
 The reality of the situation was different; the kernel developers were far
 more concerned about system stability, long-term maintenance, and finding
diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation/process/7.AdvancedTopics.rst
index 172733cff097..bf7cbfb4caa5 100644
--- a/Documentation/process/7.AdvancedTopics.rst
+++ b/Documentation/process/7.AdvancedTopics.rst
@@ -29,9 +29,9 @@ long document in its own right.  Instead, the focus here will be on how git
 fits into the kernel development process in particular.  Developers who
 wish to come up to speed with git will find more information at:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 and on various tutorials found on the web.
 
@@ -55,7 +55,7 @@ server with git-daemon is relatively straightforward if you have a system
 which is accessible to the Internet.  Otherwise, free, public hosting sites
 (Github, for example) are starting to appear on the net.  Established
 developers can get an account on kernel.org, but those are not easy to come
-by; see http://kernel.org/faq/ for more information.
+by; see https://kernel.org/faq/ for more information.
 
 The normal git workflow involves the use of a lot of branches.  Each line
 of development can be separated into a separate "topic branch" and
@@ -125,7 +125,7 @@ can affect your ability to get trees pulled in the future.  Quoting Linus:
 	to trust things *without* then having to go and check every
 	individual change by hand.
 
-(http://lwn.net/Articles/224135/).
+(https://lwn.net/Articles/224135/).
 
 To avoid this kind of situation, ensure that all patches within a given
 branch stick closely to the associated topic; a "driver fixes" branch
diff --git a/Documentation/process/8.Conclusion.rst b/Documentation/process/8.Conclusion.rst
index 8395aa2c1f3a..b32a40215858 100644
--- a/Documentation/process/8.Conclusion.rst
+++ b/Documentation/process/8.Conclusion.rst
@@ -16,24 +16,24 @@ distributions runs into internal limits and fails to process the documents
 properly).
 
 Various web sites discuss kernel development at all levels of detail.  Your
-author would like to humbly suggest http://lwn.net/ as a source;
+author would like to humbly suggest https://lwn.net/ as a source;
 information on many specific kernel topics can be found via the LWN kernel
 index at:
 
-	http://lwn.net/Kernel/Index/
+	https://lwn.net/Kernel/Index/
 
 Beyond that, a valuable resource for kernel developers is:
 
-	http://kernelnewbies.org/
+	https://kernelnewbies.org/
 
-And, of course, one should not forget http://kernel.org/, the definitive
+And, of course, one should not forget https://kernel.org/, the definitive
 location for kernel release information.
 
 There are a number of books on kernel development:
 
 	Linux Device Drivers, 3rd Edition (Jonathan Corbet, Alessandro
 	Rubini, and Greg Kroah-Hartman).  Online at
-	http://lwn.net/Kernel/LDD3/.
+	https://lwn.net/Kernel/LDD3/.
 
 	Linux Kernel Development (Robert Love).
 
@@ -46,9 +46,9 @@ information to be found there.
 
 Documentation for git can be found at:
 
-	http://www.kernel.org/pub/software/scm/git/docs/
+	https://www.kernel.org/pub/software/scm/git/docs/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 
 Conclusion
diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 1c3a840d06b9..d25a1d34dd1d 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -541,9 +541,9 @@ References and Sources
    :manpage:`syscall(2)` man-page:
    http://man7.org/linux/man-pages/man2/syscall.2.html#NOTES
  - Collated emails from Linus Torvalds discussing the problems with ``ioctl()``:
-   http://yarchive.net/comp/linux/ioctl.html
+   https://yarchive.net/comp/linux/ioctl.html
  - "How to not invent kernel interfaces", Arnd Bergmann,
-   http://www.ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
+   https://www.ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
  - LWN article from Michael Kerrisk on avoiding new uses of CAP_SYS_ADMIN:
    https://lwn.net/Articles/486306/
  - Recommendation from Andrew Morton that all related information for a new
diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index fbb9297e6360..2e7017bef4b8 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -229,7 +229,7 @@ Although interdiff may save you a step or two you are generally advised to
 do the additional steps since interdiff can get things wrong in some cases.
 
 Another alternative is ``ketchup``, which is a python script for automatic
-downloading and applying of patches (http://www.selenic.com/ketchup/).
+downloading and applying of patches (https://www.selenic.com/ketchup/).
 
 Other nice tools are diffstat, which shows a summary of changes made by a
 patch; lsdiff, which displays a short listing of affected files in a patch
@@ -241,7 +241,7 @@ the patch contains a given regular expression.
 Where can I download the patches?
 =================================
 
-The patches are available at http://kernel.org/
+The patches are available at https://kernel.org/
 Most recent patches are linked from the front page, but they also have
 specific homes.
 
diff --git a/Documentation/process/volatile-considered-harmful.rst b/Documentation/process/volatile-considered-harmful.rst
index 4934e656a6f3..7eb6bd7c9214 100644
--- a/Documentation/process/volatile-considered-harmful.rst
+++ b/Documentation/process/volatile-considered-harmful.rst
@@ -109,9 +109,9 @@ been properly thought through.
 References
 ==========
 
-[1] http://lwn.net/Articles/233481/
+[1] https://lwn.net/Articles/233481/
 
-[2] http://lwn.net/Articles/233482/
+[2] https://lwn.net/Articles/233482/
 
 Credits
 =======
diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index 523d54b60087..6b88837fbf82 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -36,10 +36,10 @@ This document covers use of the Linux rbtree implementation.  For more
 information on the nature and implementation of Red Black Trees,  see:
 
   Linux Weekly News article on red-black trees
-    http://lwn.net/Articles/184495/
+    https://lwn.net/Articles/184495/
 
   Wikipedia entry on red-black trees
-    http://en.wikipedia.org/wiki/Red-black_tree
+    https://en.wikipedia.org/wiki/Red-black_tree
 
 Linux implementation of red-black trees
 ---------------------------------------
diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
index d903eb97fcf3..0bcf6c1245ee 100644
--- a/Documentation/security/SCTP.rst
+++ b/Documentation/security/SCTP.rst
@@ -328,7 +328,7 @@ NOTES:
       label (see **netlabel-config**\(8) helper script for details).
 
    5) The NetLabel SCTP peer labeling rules apply as discussed in the following
-      set of posts tagged "netlabel" at: http://www.paul-moore.com/blog/t.
+      set of posts tagged "netlabel" at: https://www.paul-moore.com/blog/t.
 
    6) CIPSO is only supported for IPv4 addressing: ``socket(AF_INET, ...)``
       CALIPSO is only supported for IPv6 addressing: ``socket(AF_INET6, ...)``
diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index fbfe6693bb60..788704886eec 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -29,7 +29,7 @@ u"""
 
     Used tools:
 
-    * ``dot(1)``: Graphviz (http://www.graphviz.org). If Graphviz is not
+    * ``dot(1)``: Graphviz (https://www.graphviz.org). If Graphviz is not
       available, the DOT language is inserted as literal-block.
 
     * SVG to PDF: To generate PDF, you need at least one of this tools:
@@ -41,7 +41,7 @@ u"""
     * generate PDF from SVG / used by PDF (LaTeX) builder
 
     * generate SVG (html-builder) and PDF (latex-builder) from DOT files.
-      DOT: see http://www.graphviz.org/content/dot-language
+      DOT: see https://www.graphviz.org/content/dot-language
 
     """
 
@@ -182,7 +182,7 @@ def setupTools(app):
         kernellog.verbose(app, "use dot(1) from: " + dot_cmd)
     else:
         kernellog.warn(app, "dot(1) not found, for better output quality install "
-                       "graphviz from http://www.graphviz.org")
+                       "graphviz from https://www.graphviz.org")
     if convert_cmd:
         kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
     else:
diff --git a/Documentation/static-keys.txt b/Documentation/static-keys.txt
index 9803e14639bf..38290b9f25eb 100644
--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -71,7 +71,7 @@ Solution
 
 gcc (v4.5) adds a new 'asm goto' statement that allows branching to a label:
 
-http://gcc.gnu.org/ml/gcc-patches/2009-07/msg01556.html
+https://gcc.gnu.org/ml/gcc-patches/2009-07/msg01556.html
 
 Using the 'asm goto', we can create branches that are either taken or not taken
 by default, without the need to check memory. Then, at run-time, we can patch
diff --git a/Documentation/trace/events-msr.rst b/Documentation/trace/events-msr.rst
index e938aa0b6f4f..810481e530b6 100644
--- a/Documentation/trace/events-msr.rst
+++ b/Documentation/trace/events-msr.rst
@@ -4,7 +4,7 @@ MSR Trace Events
 
 The x86 kernel supports tracing most MSR (Model Specific Register) accesses.
 To see the definition of the MSRs on Intel systems please see the SDM
-at http://www.intel.com/sdm (Volume 3)
+at https://www.intel.com/sdm (Volume 3)
 
 Available trace points:
 
diff --git a/Documentation/trace/mmiotrace.rst b/Documentation/trace/mmiotrace.rst
index 5116e8ca27b4..fed13eaead89 100644
--- a/Documentation/trace/mmiotrace.rst
+++ b/Documentation/trace/mmiotrace.rst
@@ -5,7 +5,7 @@ In-kernel memory-mapped I/O tracing
 
 Home page and links to optional user space tools:
 
-	http://nouveau.freedesktop.org/wiki/MmioTrace
+	https://nouveau.freedesktop.org/wiki/MmioTrace
 
 MMIO tracing was originally developed by Intel around 2003 for their Fault
 Injection Test Harness. In Dec 2006 - Jan 2007, using the code from Intel,
diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index d32016d9be2c..d1b7270ad55c 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -6,7 +6,7 @@ Kernel Samepage Merging
 
 KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
 added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
-and http://lwn.net/Articles/306704/ and http://lwn.net/Articles/330589/
+and http://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/
 
 The userspace interface of KSM is described in :ref:`Documentation/admin-guide/mm/ksm.rst <admin_guide_ksm>`
 
diff --git a/Documentation/xz.txt b/Documentation/xz.txt
index b2220d03aa50..b2f5ff12a161 100644
--- a/Documentation/xz.txt
+++ b/Documentation/xz.txt
@@ -14,13 +14,13 @@ improve compression ratio of executable data.
 The XZ decompressor in Linux is called XZ Embedded. It supports
 the LZMA2 filter and optionally also BCJ filters. CRC32 is supported
 for integrity checking. The home page of XZ Embedded is at
-<http://tukaani.org/xz/embedded.html>, where you can find the
+<https://tukaani.org/xz/embedded.html>, where you can find the
 latest version and also information about using the code outside
 the Linux kernel.
 
 For userspace, XZ Utils provide a zlib-like compression library
 and a gzip-like command line tool. XZ Utils can be downloaded from
-<http://tukaani.org/xz/>.
+<https://tukaani.org/xz/>.
 
 XZ related components in the kernel
 ===================================
@@ -113,7 +113,7 @@ Reporting bugs
 ==============
 
 Before reporting a bug, please check that it's not fixed already
-at upstream. See <http://tukaani.org/xz/embedded.html> to get the
+at upstream. See <https://tukaani.org/xz/embedded.html> to get the
 latest code.
 
 Report bugs to <lasse.collin@tukaani.org> or visit #tukaani on
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f746ca8fa403..b04d395ca894 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -317,7 +317,7 @@ if (defined($ENV{'KBUILD_VERBOSE'})) {
 
 # Generated docbook code is inserted in a template at a point where
 # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
-# http://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
+# https://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
 # We keep track of number of generated entries and generate a dummy
 # if needs be to ensure the expanded template can be postprocessed
 # into html.
-- 
2.26.2

