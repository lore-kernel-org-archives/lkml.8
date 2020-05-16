Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B7120671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEPM3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726219AbgEPM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:29:04 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FFC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:29:03 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 67A731B6324;
        Sat, 16 May 2020 12:28:57 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: documentation
Date:   Sat, 16 May 2020 14:27:40 +0200
Message-Id: <20200516122740.30665-1-grandmaster@al2klimov.de>
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

... for security reasons.

No breaking changes as either the HTTP vhost redirects to HTTPS
or both vhosts redirect to the same location
or both serve the same content.
---
 Documentation/COPYING-logo                    |   2 +-
 Documentation/accounting/cgroupstats.rst      |   4 +-
 Documentation/admin-guide/LSM/tomoyo.rst      |  14 +-
 Documentation/admin-guide/README.rst          |   2 +-
 Documentation/admin-guide/acpi/cppc_sysfs.rst |   2 +-
 .../acpi/fan_performance_states.rst           |   2 +-
 .../acpi/initrd_table_override.rst            |   2 +-
 .../admin-guide/auxdisplay/cfag12864b.rst     |   4 +-
 Documentation/admin-guide/bcache.rst          |   6 +-
 Documentation/admin-guide/cpu-load.rst        |   2 +-
 Documentation/admin-guide/dell_rbu.rst        |   4 +-
 Documentation/admin-guide/devices.txt         |  10 +-
 Documentation/admin-guide/ext4.rst            |  16 +-
 Documentation/admin-guide/initrd.rst          |   2 +-
 .../admin-guide/kernel-parameters.txt         |   4 +-
 .../admin-guide/laptops/asus-laptop.rst       |   2 +-
 .../laptops/disk-shock-protection.rst         |   2 +-
 Documentation/admin-guide/laptops/sonypi.rst  |   2 +-
 .../admin-guide/laptops/thinkpad-acpi.rst     |   8 +-
 Documentation/admin-guide/md.rst              |   2 +-
 Documentation/admin-guide/mm/ksm.rst          |   2 +-
 Documentation/admin-guide/mm/soft-dirty.rst   |   2 +-
 Documentation/admin-guide/mono.rst            |   4 +-
 Documentation/admin-guide/nfs/nfs-client.rst  |   4 +-
 Documentation/admin-guide/nfs/nfs-rdma.rst    |   2 +-
 Documentation/admin-guide/nfs/nfsroot.rst     |   6 +-
 Documentation/admin-guide/reporting-bugs.rst  |   2 +-
 Documentation/admin-guide/security-bugs.rst   |   2 +-
 Documentation/admin-guide/sysctl/fs.rst       |   2 +-
 Documentation/admin-guide/unicode.rst         |   8 +-
 Documentation/arm/arm.rst                     |   8 +-
 Documentation/arm/ixp4xx.rst                  |   4 +-
 Documentation/arm/keystone/overview.rst       |  10 +-
 Documentation/arm/marvel.rst                  | 150 +++++++++---------
 Documentation/arm/microchip.rst               |   2 +-
 Documentation/arm/sa1100/assabet.rst          |   4 +-
 Documentation/arm/sa1100/cerf.rst             |   2 +-
 Documentation/arm/samsung-s3c24xx/h1940.rst   |   6 +-
 .../arm/samsung-s3c24xx/overview.rst          |   6 +-
 .../arm/samsung-s3c24xx/smdk2440.rst          |   2 +-
 Documentation/arm/spear/overview.rst          |   2 +-
 Documentation/arm/uefi.rst                    |   2 +-
 Documentation/conf.py                         |   2 +-
 .../dev-tools/gdb-kernel-debugging.rst        |   2 +-
 Documentation/doc-guide/kernel-doc.rst        |   2 +-
 Documentation/doc-guide/sphinx.rst            |  12 +-
 .../driver-api/acpi/linuxized-acpica.rst      |   6 +-
 .../early_userspace_support.rst               |   4 +-
 .../driver-api/memory-devices/ti-gpmc.rst     |   2 +-
 Documentation/driver-api/mmc/mmc-tools.rst    |   2 +-
 Documentation/driver-api/mtd/nand_ecc.rst     |   2 +-
 Documentation/driver-api/nfc/nfc-pn544.rst    |   2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst    |  12 +-
 Documentation/driver-api/nvdimm/security.rst  |   2 +-
 Documentation/driver-api/rapidio/rapidio.rst  |   4 +-
 Documentation/driver-api/scsi.rst             |   6 +-
 .../driver-api/thermal/nouveau_thermal.rst    |   2 +-
 Documentation/driver-api/usb/bulk-streams.rst |   4 +-
 .../driver-api/usb/power-management.rst       |   4 +-
 .../usb/writing_musb_glue_layer.rst           |   8 +-
 .../driver-api/usb/writing_usb_driver.rst     |   2 +-
 Documentation/filesystems/debugfs.rst         |   2 +-
 Documentation/filesystems/hpfs.rst            |   2 +-
 Documentation/filesystems/journalling.rst     |   2 +-
 .../filesystems/nfs/rpc-server-gss.rst        |   6 +-
 Documentation/filesystems/path-lookup.rst     |   6 +-
 Documentation/filesystems/path-lookup.txt     |   2 +-
 .../filesystems/ramfs-rootfs-initramfs.rst    |   6 +-
 Documentation/filesystems/seq_file.txt        |   4 +-
 .../filesystems/ubifs-authentication.rst      |   4 +-
 Documentation/filesystems/vfs.rst             |   6 +-
 Documentation/kernel-hacking/locking.rst      |   2 +-
 Documentation/leds/leds-lm3556.rst            |   2 +-
 Documentation/leds/leds-lp3944.rst            |   2 +-
 Documentation/leds/leds-lp5521.rst            |   2 +-
 Documentation/leds/leds-lp5523.rst            |   2 +-
 Documentation/maintainer/configure-git.rst    |   2 +-
 Documentation/maintainer/pull-requests.rst    |   2 +-
 Documentation/misc-devices/c2port.txt         |   6 +-
 Documentation/misc-devices/isl29003.rst       |   2 +-
 Documentation/nios2/nios2.rst                 |   4 +-
 Documentation/process/2.Process.rst           |  10 +-
 Documentation/process/3.Early-stage.rst       |   4 +-
 Documentation/process/4.Coding.rst            |   4 +-
 Documentation/process/7.AdvancedTopics.rst    |   8 +-
 Documentation/process/8.Conclusion.rst        |  14 +-
 Documentation/process/adding-syscalls.rst     |   4 +-
 Documentation/process/applying-patches.rst    |   4 +-
 Documentation/process/botching-up-ioctls.rst  |   2 +-
 Documentation/process/changes.rst             |  10 +-
 Documentation/process/clang-format.rst        |   2 +-
 Documentation/process/coding-style.rst        |   2 +-
 Documentation/process/howto.rst               |   2 +-
 Documentation/process/kernel-docs.rst         |  34 ++--
 .../process/maintainer-pgp-guide.rst          |   2 +-
 Documentation/process/submitting-drivers.rst  |  22 +--
 Documentation/process/submitting-patches.rst  |   4 +-
 .../process/volatile-considered-harmful.rst   |   4 +-
 Documentation/rbtree.txt                      |   4 +-
 Documentation/scheduler/sched-deadline.rst    |   2 +-
 Documentation/scsi/BusLogic.rst               |   2 +-
 Documentation/scsi/ChangeLog.megaraid         |   2 +-
 Documentation/scsi/FlashPoint.rst             |   4 +-
 Documentation/scsi/aic79xx.rst                |  20 +--
 Documentation/scsi/aic7xxx.rst                |  18 +--
 Documentation/scsi/bfa.rst                    |   8 +-
 Documentation/scsi/ppa.rst                    |   6 +-
 Documentation/scsi/scsi.rst                   |   2 +-
 Documentation/scsi/scsi_mid_low_api.rst       |   2 +-
 Documentation/scsi/sym53c8xx_2.rst            |   2 +-
 Documentation/security/SCTP.rst               |   2 +-
 Documentation/sphinx/kfigure.py               |   6 +-
 Documentation/static-keys.txt                 |   2 +-
 Documentation/trace/mmiotrace.rst             |   2 +-
 Documentation/trace/tracepoints.rst           |   4 +-
 .../translations/ja_JP/SubmittingPatches      |   6 +-
 Documentation/translations/ja_JP/howto.rst    |   6 +-
 Documentation/translations/ko_KR/howto.rst    |   2 +-
 .../userspace-api/ioctl/ioctl-number.rst      |   4 +-
 Documentation/vm/active_mm.rst                |   2 +-
 Documentation/vm/ksm.rst                      |   2 +-
 Documentation/xz.txt                          |   6 +-
 scripts/kernel-doc                            |   2 +-
 123 files changed, 360 insertions(+), 360 deletions(-)

diff --git a/Documentation/COPYING-logo b/Documentation/COPYING-logo
index 296f0f7f67eb..7f9ba9575d5b 100644
--- a/Documentation/COPYING-logo
+++ b/Documentation/COPYING-logo
@@ -9,5 +9,5 @@ scale down to smaller sizes and are better for letterheads or whatever
 you want to use it for: for the full range of logos take a look at
 Larry's web-page:
 
-	http://www.isc.tamu.edu/~lewing/linux/
+	https://isc.tamu.edu/~lewing/linux/
 
diff --git a/Documentation/accounting/cgroupstats.rst b/Documentation/accounting/cgroupstats.rst
index b9afc48f4ea2..478423fbdfb4 100644
--- a/Documentation/accounting/cgroupstats.rst
+++ b/Documentation/accounting/cgroupstats.rst
@@ -3,8 +3,8 @@ Control Groupstats
 ==================
 
 Control Groupstats is inspired by the discussion at
-http://lkml.org/lkml/2007/4/11/187 and implements per cgroup statistics as
-suggested by Andrew Morton in http://lkml.org/lkml/2007/4/11/263.
+https://lkml.org/lkml/2007/4/11/187 and implements per cgroup statistics as
+suggested by Andrew Morton in https://lkml.org/lkml/2007/4/11/263.
 
 Per cgroup statistics infrastructure re-uses code from the taskstats
 interface. A new set of cgroup operations are registered with commands
diff --git a/Documentation/admin-guide/LSM/tomoyo.rst b/Documentation/admin-guide/LSM/tomoyo.rst
index e2d6b6e15082..599325476663 100644
--- a/Documentation/admin-guide/LSM/tomoyo.rst
+++ b/Documentation/admin-guide/LSM/tomoyo.rst
@@ -30,26 +30,26 @@ User <-> Kernel interface documentation is available at
 http://tomoyo.osdn.jp/2.5/policy-specification/index.html .
 
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
diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index cc6151fc0845..6538faa7304f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,6 +1,6 @@
 .. _readme:
 
-Linux kernel release 5.x <http://kernel.org/>
+Linux kernel release 5.x <https://kernel.org/>
 =============================================
 
 These are the release notes for Linux version 5.  Read them carefully,
diff --git a/Documentation/admin-guide/acpi/cppc_sysfs.rst b/Documentation/admin-guide/acpi/cppc_sysfs.rst
index a4b99afbe331..bfa7aa071caf 100644
--- a/Documentation/admin-guide/acpi/cppc_sysfs.rst
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
@@ -14,7 +14,7 @@ to request performance levels and to measure per-cpu delivered performance.
 
 For more details on CPPC please refer to the ACPI specification at:
 
-http://uefi.org/specifications
+https://uefi.org/specifications
 
 Some of the CPPC registers are exposed via sysfs under::
 
diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
index 98fe5c333121..2943af2d12ff 100644
--- a/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -11,7 +11,7 @@ These attributes list properties of fan performance states.
 
 For more information on _FPS refer to the ACPI specification at:
 
-http://uefi.org/specifications
+https://uefi.org/specifications
 
 For instance, the contents of the INT3404 ACPI device sysfs directory
 may look as follows::
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
diff --git a/Documentation/admin-guide/auxdisplay/cfag12864b.rst b/Documentation/admin-guide/auxdisplay/cfag12864b.rst
index 18c2865bd322..14382311d860 100644
--- a/Documentation/admin-guide/auxdisplay/cfag12864b.rst
+++ b/Documentation/admin-guide/auxdisplay/cfag12864b.rst
@@ -27,8 +27,8 @@ This driver supports a cfag12864b LCD.
 :Manufacturer:	Crystalfontz
 :Device Name:	Crystalfontz 12864b LCD Series
 :Device Code:	cfag12864b
-:Webpage:	http://www.crystalfontz.com
-:Device Webpage: http://www.crystalfontz.com/products/12864b/
+:Webpage:	https://www.crystalfontz.com
+:Device Webpage: https://www.crystalfontz.com/products/12864b/
 :Type:		LCD (Liquid Crystal Display)
 :Width:		128
 :Height:	64
diff --git a/Documentation/admin-guide/bcache.rst b/Documentation/admin-guide/bcache.rst
index c0ce64d75bbf..4f017a455829 100644
--- a/Documentation/admin-guide/bcache.rst
+++ b/Documentation/admin-guide/bcache.rst
@@ -7,9 +7,9 @@ nice if you could use them as cache... Hence bcache.
 
 Wiki and git repositories are at:
 
-  - http://bcache.evilpiepirate.org
-  - http://evilpiepirate.org/git/linux-bcache.git
-  - http://evilpiepirate.org/git/bcache-tools.git
+  - https://bcache.evilpiepirate.org
+  - https://evilpiepirate.org/git/linux-bcache.git
+  - https://evilpiepirate.org/git/bcache-tools.git
 
 It's designed around the performance characteristics of SSDs - it only allocates
 in erase block sized buckets, and it uses a hybrid btree/log to track cached
diff --git a/Documentation/admin-guide/cpu-load.rst b/Documentation/admin-guide/cpu-load.rst
index 2d01ce43d2a2..eb90f379b267 100644
--- a/Documentation/admin-guide/cpu-load.rst
+++ b/Documentation/admin-guide/cpu-load.rst
@@ -104,7 +104,7 @@ will lead to quite erratic information inside ``/proc/stat``::
 References
 ----------
 
-- http://lkml.org/lkml/2007/2/12/6
+- https://lkml.org/lkml/2007/2/12/6
 - Documentation/filesystems/proc.txt (1.8)
 
 
diff --git a/Documentation/admin-guide/dell_rbu.rst b/Documentation/admin-guide/dell_rbu.rst
index 8d70e1fc9f9d..15961539d9e4 100644
--- a/Documentation/admin-guide/dell_rbu.rst
+++ b/Documentation/admin-guide/dell_rbu.rst
@@ -22,11 +22,11 @@ This driver works with Dell OpenManage or Dell Update Packages for updating
 the BIOS on Dell servers (starting from servers sold since 1999), desktops
 and notebooks (starting from those sold in 2005).
 
-Please go to  http://support.dell.com register and you can find info on
+Please go to  https://support.dell.com register and you can find info on
 OpenManage and Dell Update packages (DUP).
 
 Libsmbios can also be used to update BIOS on Dell systems go to
-http://linux.dell.com/libsmbios/ for details.
+https://linux.dell.com/libsmbios/ for details.
 
 Dell_RBU driver supports BIOS update using the monolithic image and packetized
 image methods. In case of monolithic the driver allocates a contiguous chunk
diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 2a97aaec8b12..abb40eab4111 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -1442,7 +1442,7 @@
 		    ...
 
 		The driver and documentation may be obtained from
-		http://www.winradio.com/
+		https://www.winradio.com/
 
   82 block	I2O hard disk
 		  0 = /dev/i2o/hdag	33rd I2O hard disk, whole disk
@@ -1656,7 +1656,7 @@
 		dynamically, so there is no fixed mapping from subdevice
 		pathnames to minor numbers.
 
-		See http://www.comedi.org/ for information about the Comedi
+		See https://www.comedi.org/ for information about the Comedi
 		project.
 
   98 block	User-mode virtual block device
@@ -1723,7 +1723,7 @@
 		implementations a kernel presence for caching and easy
 		mounting.  For more information about the project,
 		write to <arla-drinkers@stacken.kth.se> or see
-		http://www.stacken.kth.se/project/arla/
+		https://www.stacken.kth.se/project/arla/
 
  103 block	Audit device
 		  0 = /dev/audit	Audit device
@@ -1961,7 +1961,7 @@
 		Note: EVMS populates and manages all the devnodes in
 		/dev/evms.
 
-		http://sf.net/projects/evms
+		https://sf.net/projects/evms
 
 		   0 = /dev/evms/block_device   EVMS block device
 		   1 = /dev/evms/legacyname1    First EVMS legacy device
@@ -2534,7 +2534,7 @@
 		    ...
 
 		See http://web.archive.org/web/20080115195241/
-		http://inter-mezzo.org/index.html
+		https://inter-mezzo.org/index.html
 
  186 char	Object-based storage control device
 		  0 = /dev/obd0		First obd control device
diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fcef1876..27a9c0ccdfd0 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -10,7 +10,7 @@ scalability and reliability enhancements for supporting large filesystems
 feature requirements.
 
 Mailing list:	linux-ext4@vger.kernel.org
-Web site:	http://ext4.wiki.kernel.org
+Web site:	https://ext4.wiki.kernel.org
 
 
 Quick usage instructions
@@ -18,7 +18,7 @@ Quick usage instructions
 
 Note: More extensive information for getting started with ext4 can be
 found at the ext4 wiki site at the URL:
-http://ext4.wiki.kernel.org/index.php/Ext4_Howto
+https://ext4.wiki.kernel.org/index.php/Ext4_Howto
 
   - The latest version of e2fsprogs can be found at:
 
@@ -26,7 +26,7 @@ http://ext4.wiki.kernel.org/index.php/Ext4_Howto
 
 	or
 
-    http://sourceforge.net/project/showfiles.php?group_id=2406
+    https://sourceforge.net/project/showfiles.php?group_id=2406
 
 	or grab the latest git repository from:
 
@@ -273,13 +273,13 @@ When mounting an ext4 filesystem, the following option are accepted:
         These options are ignored by the filesystem. They are used only by
         quota tools to recognize volumes where quota should be turned on. See
         documentation in the quota-tools package for more details
-        (http://sourceforge.net/projects/linuxquota).
+        (https://sourceforge.net/projects/linuxquota).
 
   jqfmt=<quota type>, usrjquota=<file>, grpjquota=<file>
         These options tell filesystem details about quota so that quota
         information can be properly updated during journal replay. They replace
         the above quota options. See documentation in the quota-tools package
-        for more details (http://sourceforge.net/projects/linuxquota).
+        for more details (https://sourceforge.net/projects/linuxquota).
 
   stripe=n
         Number of filesystem blocks that mballoc will try to use for allocation
@@ -611,7 +611,7 @@ kernel source:	<file:fs/ext4/>
 
 programs:	http://e2fsprogs.sourceforge.net/
 
-useful links:	http://fedoraproject.org/wiki/ext3-devel
+useful links:	https://fedoraproject.org/wiki/ext3-devel
 		http://www.bullopensource.org/ext4/
-		http://ext4.wiki.kernel.org/index.php/Main_Page
-		http://fedoraproject.org/wiki/Features/Ext4
+		https://ext4.wiki.kernel.org/index.php/Main_Page
+		https://fedoraproject.org/wiki/Features/Ext4
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
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..3b4cc9d60b2e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2740,7 +2740,7 @@
 			touchscreen support is not enabled in the mainstream
 			kernel as of 2.6.30, a preliminary port can be found
 			in the "bleeding edge" mini2440 support kernel at
-			http://repo.or.cz/w/linux-2.6/mini2440.git
+			https://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
 			[X86,PPC,S390,ARM64] Control optional mitigations for
@@ -3494,7 +3494,7 @@
 				the function, IO port 0xCFA, also 8-bit, sets
 				bus number. The config space is then accessed
 				through ports 0xC000-0xCFFF).
-				See http://wiki.osdev.org/PCI for more info
+				See https://wiki.osdev.org/PCI for more info
 				on the configuration access mechanisms.
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
diff --git a/Documentation/admin-guide/laptops/asus-laptop.rst b/Documentation/admin-guide/laptops/asus-laptop.rst
index 95176321a25a..15a5bad0e670 100644
--- a/Documentation/admin-guide/laptops/asus-laptop.rst
+++ b/Documentation/admin-guide/laptops/asus-laptop.rst
@@ -268,4 +268,4 @@ Patches, Errors, Questions
 
  acpi4asus-user@lists.sourceforge.net
 
- http://sourceforge.net/projects/acpi4asus
+ https://sourceforge.net/projects/acpi4asus
diff --git a/Documentation/admin-guide/laptops/disk-shock-protection.rst b/Documentation/admin-guide/laptops/disk-shock-protection.rst
index e97c5f78d8c3..22c7ec3e84cf 100644
--- a/Documentation/admin-guide/laptops/disk-shock-protection.rst
+++ b/Documentation/admin-guide/laptops/disk-shock-protection.rst
@@ -135,7 +135,7 @@ single project which, although still considered experimental, is fit
 for use. Please feel free to add projects that have been the victims
 of my ignorance.
 
-- http://www.thinkwiki.org/wiki/HDAPS
+- https://www.thinkwiki.org/wiki/HDAPS
 
   See this page for information about Linux support of the hard disk
   active protection system as implemented in IBM/Lenovo Thinkpads.
diff --git a/Documentation/admin-guide/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
index c6eaaf48f7c1..190da1234314 100644
--- a/Documentation/admin-guide/laptops/sonypi.rst
+++ b/Documentation/admin-guide/laptops/sonypi.rst
@@ -151,7 +151,7 @@ Bugs:
 	  different way to adjust the backlighting of the screen. There
 	  is a userspace utility to adjust the brightness on those models,
 	  which can be downloaded from
-	  http://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
+	  https://www.acc.umu.se/~erikw/program/smartdimmer-0.1.tar.bz2
 
 	- since all development was done by reverse engineering, there is
 	  *absolutely no guarantee* that this driver will not crash your
diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 822907dcc845..fb7af9c7e861 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -904,7 +904,7 @@ temperatures:
 The mapping of thermal sensors to physical locations varies depending on
 system-board model (and thus, on ThinkPad model).
 
-http://thinkwiki.org/wiki/Thermal_Sensors is a public wiki page that
+https://thinkwiki.org/wiki/Thermal_Sensors is a public wiki page that
 tries to track down these locations for various models.
 
 Most (newer?) models seem to follow this pattern:
@@ -925,7 +925,7 @@ For the R51 (source: Thomas Gruber):
 - 3:  Internal HDD
 
 For the T43, T43/p (source: Shmidoax/Thinkwiki.org)
-http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
+https://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
 
 - 2:  System board, left side (near PCMCIA slot), reported as HDAPS temp
 - 3:  PCMCIA slot
@@ -935,7 +935,7 @@ http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_T43.2C_T43p
 - 11: Power regulator, underside of system board, below F2 key
 
 The A31 has a very atypical layout for the thermal sensors
-(source: Milos Popovic, http://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_A31)
+(source: Milos Popovic, https://thinkwiki.org/wiki/Thermal_Sensors#ThinkPad_A31)
 
 - 1:  CPU
 - 2:  Main Battery: main sensor
@@ -1468,7 +1468,7 @@ and set.
 
 For more details about which buttons will appear depending on the mode, please
 review the laptop's user guide:
-http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
+https://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
 
 Multiple Commands, Module Parameters
 ------------------------------------
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
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 874eb0c77d34..be4425245c2d 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -9,7 +9,7 @@ Overview
 
 KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
 added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
-and http://lwn.net/Articles/306704/ and http://lwn.net/Articles/330589/
+and https://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/
 
 KSM was originally developed for use with KVM (where it was known as
 Kernel Shared Memory), to fit more virtual machines into physical memory,
diff --git a/Documentation/admin-guide/mm/soft-dirty.rst b/Documentation/admin-guide/mm/soft-dirty.rst
index cb0cfd6672fa..b7a7404f8897 100644
--- a/Documentation/admin-guide/mm/soft-dirty.rst
+++ b/Documentation/admin-guide/mm/soft-dirty.rst
@@ -41,7 +41,7 @@ memory region renewal the kernel always marks new memory regions (and
 expanded regions) as soft dirty.
 
 This feature is actively used by the checkpoint-restore project. You
-can find more details about it on http://criu.org
+can find more details about it on https://criu.org
 
 
 -- Pavel Emelyanov, Apr 9, 2013
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
diff --git a/Documentation/admin-guide/nfs/nfs-client.rst b/Documentation/admin-guide/nfs/nfs-client.rst
index c4b777c7584b..6adb6457bc69 100644
--- a/Documentation/admin-guide/nfs/nfs-client.rst
+++ b/Documentation/admin-guide/nfs/nfs-client.rst
@@ -65,8 +65,8 @@ migrated onto another server by means of the special "fs_locations"
 attribute. See `RFC3530 Section 6: Filesystem Migration and Replication`_ and
 `Implementation Guide for Referrals in NFSv4`_.
 
-.. _RFC3530 Section 6\: Filesystem Migration and Replication: http://tools.ietf.org/html/rfc3530#section-6
-.. _Implementation Guide for Referrals in NFSv4: http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
+.. _RFC3530 Section 6\: Filesystem Migration and Replication: https://tools.ietf.org/html/rfc3530#section-6
+.. _Implementation Guide for Referrals in NFSv4: https://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
 
 The fs_locations information can take the form of either an ip address and
 a path, or a DNS hostname and a path. The latter requires the NFS client to
diff --git a/Documentation/admin-guide/nfs/nfs-rdma.rst b/Documentation/admin-guide/nfs/nfs-rdma.rst
index ef0f3678b1fb..f137485f8bde 100644
--- a/Documentation/admin-guide/nfs/nfs-rdma.rst
+++ b/Documentation/admin-guide/nfs/nfs-rdma.rst
@@ -65,7 +65,7 @@ use with NFS/RDMA.
   If the version is less than 1.1.2 or the command does not exist,
   you should install the latest version of nfs-utils.
 
-  Download the latest package from: http://www.kernel.org/pub/linux/utils/nfs
+  Download the latest package from: https://www.kernel.org/pub/linux/utils/nfs
 
   Uncompress the package and follow the installation instructions.
 
diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 82a4fda057f9..c3c293322337 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -264,7 +264,7 @@ They depend on various facilities being available:
      	access to the floppy drive device, /dev/fd0
 
      	For more information on syslinux, including how to create bootdisks
-     	for prebuilt kernels, see http://syslinux.zytor.com/
+     	for prebuilt kernels, see https://syslinux.zytor.com/
 
 	.. note::
 		Previously it was possible to write a kernel directly to
@@ -292,7 +292,7 @@ They depend on various facilities being available:
 	  cdrecord dev=ATAPI:1,0,0 arch/x86/boot/image.iso
 
      	For more information on isolinux, including how to create bootdisks
-     	for prebuilt kernels, see http://syslinux.zytor.com/
+     	for prebuilt kernels, see https://syslinux.zytor.com/
 
 - Using LILO
 
@@ -346,7 +346,7 @@ They depend on various facilities being available:
 	see Documentation/admin-guide/serial-console.rst for more information.
 
 	For more information on isolinux, including how to create bootdisks
-	for prebuilt kernels, see http://syslinux.zytor.com/
+	for prebuilt kernels, see https://syslinux.zytor.com/
 
 
 
diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
index 49ac8dc3594d..42481ea7b41d 100644
--- a/Documentation/admin-guide/reporting-bugs.rst
+++ b/Documentation/admin-guide/reporting-bugs.rst
@@ -75,7 +75,7 @@ Tips for reporting bugs
 
 If you haven't reported a bug before, please read:
 
-	http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
+	https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
 
 	http://www.catb.org/esr/faqs/smart-questions.html
 
diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index dcd6c93c7aac..8cd50c1f95d1 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -69,7 +69,7 @@ publication prefers to happen Tuesday through Thursday. When appropriate,
 the security team can assist with this coordination, or the reporter can
 include linux-distros from the start. In this case, remember to prefix
 the email Subject line with "[vs]" as described in the linux-distros wiki:
-<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
+<https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
 
 CVE assignment
 --------------
diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..f48277a0a850 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -261,7 +261,7 @@ directories like /tmp. The common method of exploitation of this flaw
 is to cross privilege boundaries when following a given symlink (i.e. a
 root process follows a symlink belonging to another user). For a likely
 incomplete list of hundreds of examples across the years, please see:
-http://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
+https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=/tmp
 
 When set to "0", symlink following behavior is unrestricted.
 
diff --git a/Documentation/admin-guide/unicode.rst b/Documentation/admin-guide/unicode.rst
index 7425a3351321..12edb55cc6a2 100644
--- a/Documentation/admin-guide/unicode.rst
+++ b/Documentation/admin-guide/unicode.rst
@@ -7,7 +7,7 @@ This file is maintained by H. Peter Anvin <unicode@lanana.org> as part
 of the Linux Assigned Names And Numbers Authority (LANANA) project.
 The current version can be found at:
 
-	    http://www.lanana.org/docs/unicode/admin-guide/unicode.rst
+	    https://www.lanana.org/docs/unicode/admin-guide/unicode.rst
 
 Introduction
 ------------
@@ -102,7 +102,7 @@ Linux/CSUR private assignment in the Linux Zone.
 This encoding has been endorsed by the Klingon Language Institute.
 For more information, contact them at:
 
-	http://www.kli.org/
+	https://www.kli.org/
 
 Since the characters in the beginning of the Linux CZ have been more
 of the dingbats/symbols/forms type and this is a language, I have
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
diff --git a/Documentation/arm/arm.rst b/Documentation/arm/arm.rst
index 2edc509df92a..4f8c4985191f 100644
--- a/Documentation/arm/arm.rst
+++ b/Documentation/arm/arm.rst
@@ -48,12 +48,12 @@ Bug reports etc
 ---------------
 
   Please send patches to the patch system.  For more information, see
-  http://www.arm.linux.org.uk/developer/patches/info.php Always include some
+  https://www.arm.linux.org.uk/developer/patches/info.php Always include some
   explanation as to what the patch does and why it is needed.
 
   Bug reports should be sent to linux-arm-kernel@lists.arm.linux.org.uk,
   or submitted through the web form at
-  http://www.arm.linux.org.uk/developer/
+  https://www.arm.linux.org.uk/developer/
 
   When sending bug reports, please ensure that they contain all relevant
   information, eg. the kernel messages that were printed before/during
@@ -169,7 +169,7 @@ ST506 hard drives
 
   Previous registrations may be found online.
 
-    <http://www.arm.linux.org.uk/developer/machines/>
+    <https://www.arm.linux.org.uk/developer/machines/>
 
 Kernel entry (head.S)
 ---------------------
@@ -204,7 +204,7 @@ Kernel entry (head.S)
   compile-time code selection method.  You can register a new machine via the
   web site at:
 
-    <http://www.arm.linux.org.uk/developer/machines/>
+    <https://www.arm.linux.org.uk/developer/machines/>
 
   Note: Please do not register a machine type for DT-only platforms.  If your
   platform is DT-only, you do not need a registered machine type.
diff --git a/Documentation/arm/ixp4xx.rst b/Documentation/arm/ixp4xx.rst
index a57235616294..3b4b717da182 100644
--- a/Documentation/arm/ixp4xx.rst
+++ b/Documentation/arm/ixp4xx.rst
@@ -53,7 +53,7 @@ SOFTWARE.
 There are several websites that provide directions/pointers on using
 Intel's software:
 
-   - http://sourceforge.net/projects/ixp4xx-osdg/
+   - https://sourceforge.net/projects/ixp4xx-osdg/
      Open Source Developer's Guide for using uClinux and the Intel libraries
 
    - http://gatewaymaker.sourceforge.net/
@@ -112,7 +112,7 @@ http://www.adiengineering.com/productsCoyote.html
    Finally, there is an IDE port hanging off the expansion bus.
 
 Gateworks Avila Network Platform
-http://www.gateworks.com/support/overview.php
+https://www.gateworks.com/support/overview.php
 
    The Avila platform is basically and IXDP425 with the 4 PCI slots
    replaced with mini-PCI slots and a CF IDE interface hanging off
diff --git a/Documentation/arm/keystone/overview.rst b/Documentation/arm/keystone/overview.rst
index cd90298c493c..381791c6a1c1 100644
--- a/Documentation/arm/keystone/overview.rst
+++ b/Documentation/arm/keystone/overview.rst
@@ -16,11 +16,11 @@ K2HK SoC and EVM
 a.k.a Keystone 2 Hawking/Kepler SoC
 TCI6636K2H & TCI6636K2K: See documentation at
 
-	http://www.ti.com/product/tci6638k2k
-	http://www.ti.com/product/tci6638k2h
+	https://www.ti.com/product/tci6638k2k
+	https://www.ti.com/product/tci6638k2h
 
 EVM:
-  http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
+  https://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
 
 K2E SoC and EVM
 ===============
@@ -31,7 +31,7 @@ K2E  -  66AK2E05:
 
 See documentation at
 
-	http://www.ti.com/product/66AK2E05/technicaldocuments
+	https://www.ti.com/product/66AK2E05/technicaldocuments
 
 EVM:
    https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
@@ -44,7 +44,7 @@ a.k.a Keystone 2 Lamarr SoC
 K2L  -  TCI6630K2L:
 
 See documentation at
-	http://www.ti.com/product/TCI6630K2L/technicaldocuments
+	https://www.ti.com/product/TCI6630K2L/technicaldocuments
 
 EVM:
   https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
index 16ab2eb085b8..feae25484186 100644
--- a/Documentation/arm/marvel.rst
+++ b/Documentation/arm/marvel.rst
@@ -18,9 +18,9 @@ Orion family
         - 88F5181L
         - 88F5182
 
-               - Datasheet: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
-               - Programmer's User Guide: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
-               - User Manual: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
+               - Datasheet: https://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
+               - Programmer's User Guide: https://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
+               - User Manual: https://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
         - 88F5281
 
                - Datasheet: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
@@ -38,33 +38,33 @@ Kirkwood family
   Flavors:
         - 88F6282 a.k.a Armada 300
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
         - 88F6283 a.k.a Armada 310
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/armada-300/assets/armada_310.pdf
         - 88F6190
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/kirkwood/assets/88F6190-003_WEB.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
         - 88F6192
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/kirkwood/assets/88F6192-003_ver1.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F619x_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
         - 88F6182
         - 88F6180
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
         - 88F6281
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
   Homepage:
-	http://www.marvell.com/embedded-processors/kirkwood/
+	https://www.marvell.com/embedded-processors/kirkwood/
   Core:
 	Feroceon 88fr131 ARMv5 compatible
   Linux kernel mach directory:
@@ -78,14 +78,14 @@ Discovery family
   Flavors:
         - MV78100
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100-003_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78100-003_WEB.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78100_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
         - MV78200
 
-                - Product Brief  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200-002_WEB.pdf
-                - Hardware Spec  : http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
-                - Functional Spec: http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+                - Product Brief  : https://www.marvell.com/embedded-processors/discovery-innovation/assets/MV78200-002_WEB.pdf
+                - Hardware Spec  : https://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV78200_OpenSource.pdf
+                - Functional Spec: https://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
         - MV76100
 
                 Not supported by the Linux kernel.
@@ -106,9 +106,9 @@ EBU Armada family
         - 88F6707
         - 88F6W11
 
-    - Product Brief:   http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
-    - Hardware Spec:   http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
-    - Functional Spec: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
+    - Product Brief:   https://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
+    - Hardware Spec:   https://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
+    - Functional Spec: https://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
 
   Core:
 	Sheeva ARMv7 compatible PJ4B
@@ -116,7 +116,7 @@ EBU Armada family
   Armada 375 Flavors:
 	- 88F6720
 
-    - Product Brief: http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
+    - Product Brief: https://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
 
   Core:
 	ARM Cortex-A9
@@ -126,7 +126,7 @@ EBU Armada family
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
 
-    - Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
+    - Product infos:   https://www.marvell.com/embedded-processors/armada-38x/
     - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
 
   Core:
@@ -136,7 +136,7 @@ EBU Armada family
 	- 88F6920 Armada 390
 	- 88F6928 Armada 398
 
-    - Product infos: http://www.marvell.com/embedded-processors/armada-39x/
+    - Product infos: https://www.marvell.com/embedded-processors/armada-39x/
 
   Core:
 	ARM Cortex-A9
@@ -150,16 +150,16 @@ EBU Armada family
 	not to be confused with the non-SMP 78xx0 SoCs
 
     Product Brief:
-	http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
+	https://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
 
     Functional Spec:
-	http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
+	https://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
 
     - Hardware Specs:
 
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
-        - http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
+        - https://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
+        - https://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
+        - https://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
 
   Core:
 	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
@@ -180,10 +180,10 @@ EBU Armada family ARMv8
 	ARM Cortex A53 (ARMv8)
 
   Homepage:
-	http://www.marvell.com/embedded-processors/armada-3700/
+	https://www.marvell.com/embedded-processors/armada-3700/
 
   Product Brief:
-	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
+	https://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
 
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-37*
@@ -195,11 +195,11 @@ EBU Armada family ARMv8
   Core: ARM Cortex A72
 
   Homepage:
-	http://www.marvell.com/embedded-processors/armada-70xx/
+	https://www.marvell.com/embedded-processors/armada-70xx/
 
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pdf
+	  - https://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pdf
+	  - https://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pdf
 
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-70*
@@ -211,11 +211,11 @@ EBU Armada family ARMv8
 	ARM Cortex A72
 
   Homepage:
-	http://www.marvell.com/embedded-processors/armada-80xx/
+	https://www.marvell.com/embedded-processors/armada-80xx/
 
   Product Brief:
-	  - http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2016.pdf
-	  - http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2016.pdf
+	  - https://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2016.pdf
+	  - https://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2016.pdf
 
   Device tree files:
 	arch/arm64/boot/dts/marvell/armada-80*
@@ -230,10 +230,10 @@ Avanta family
        - 88F6560
 
   Homepage:
-	http://www.marvell.com/broadband/
+	https://www.marvell.com/broadband/
 
   Product Brief:
-	http://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
+	https://www.marvell.com/broadband/assets/Marvell_Avanta_88F6510_305_060-001_product_brief.pdf
 
   No public datasheet available.
 
@@ -252,7 +252,7 @@ Storage family
 	- 88RC1580
 
   Product infos:
-	http://www.marvell.com/storage/armada-sp/
+	https://www.marvell.com/storage/armada-sp/
 
   Core:
 	Sheeva ARMv7 comatible Quad-core PJ4C
@@ -266,16 +266,16 @@ Dove family (application processor)
         - 88AP510 a.k.a Armada 510
 
    Product Brief:
-	http://www.marvell.com/application-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
+	https://www.marvell.com/application-processors/armada-500/assets/Marvell_Armada510_SoC.pdf
 
    Hardware Spec:
-	http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Hardware-Spec.pdf
+	https://www.marvell.com/application-processors/armada-500/assets/Armada-510-Hardware-Spec.pdf
 
   Functional Spec:
-	http://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
+	https://www.marvell.com/application-processors/armada-500/assets/Armada-510-Functional-Spec.pdf
 
   Homepage:
-	http://www.marvell.com/application-processors/armada-500/
+	https://www.marvell.com/application-processors/armada-500/
 
   Core:
 	ARMv7 compatible
@@ -292,22 +292,22 @@ PXA 2xx/3xx/93x/95x family
              - Application processor only
              - Core: ARMv5 XScale1 core
         - PXA270, PXA271, PXA272
-             - Product Brief         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
-             - Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
-             - Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
-             - Specification         : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
-             - Specification update  : http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
+             - Product Brief         : https://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_pb.pdf
+             - Design guide          : https://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_design_guide.pdf
+             - Developers manual     : https://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_dev_man.pdf
+             - Specification         : https://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_emts.pdf
+             - Specification update  : https://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf
              - Application processor only
              - Core: ARMv5 XScale2 core
         - PXA300, PXA310, PXA320
-             - PXA 300 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
-             - PXA 310 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
-             - PXA 320 Product Brief : http://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
-             - Design guide          : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
-             - Developers manual     : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
-             - Specifications        : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
-             - Specification Update  : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
-             - Reference Manual      : http://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
+             - PXA 300 Product Brief : https://www.marvell.com/application-processors/pxa-family/assets/PXA300_PB_R4.pdf
+             - PXA 310 Product Brief : https://www.marvell.com/application-processors/pxa-family/assets/PXA310_PB_R4.pdf
+             - PXA 320 Product Brief : https://www.marvell.com/application-processors/pxa-family/assets/PXA320_PB_R4.pdf
+             - Design guide          : https://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Design_Guide.pdf
+             - Developers manual     : https://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Developers_Manual.zip
+             - Specifications        : https://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_EMTS.pdf
+             - Specification Update  : https://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_Spec_Update.zip
+             - Reference Manual      : https://www.marvell.com/application-processors/pxa-family/assets/PXA3xx_TavorP_BootROM_Ref_Manual.pdf
              - Application processor only
              - Core: ARMv5 XScale3 core
         - PXA930, PXA935
@@ -338,26 +338,26 @@ MMP/MMP2/MMP3 family (communication processor)
 
    Flavors:
         - PXA168, a.k.a Armada 168
-             - Homepage             : http://www.marvell.com/application-processors/armada-100/armada-168.jsp
-             - Product brief        : http://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
-             - Hardware manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
-             - Software manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
-             - Specification update : http://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
-             - Boot ROM manual      : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
-             - App node package     : http://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
+             - Homepage             : https://www.marvell.com/application-processors/armada-100/armada-168.jsp
+             - Product brief        : https://www.marvell.com/application-processors/armada-100/assets/pxa_168_pb.pdf
+             - Hardware manual      : https://www.marvell.com/application-processors/armada-100/assets/armada_16x_datasheet.pdf
+             - Software manual      : https://www.marvell.com/application-processors/armada-100/assets/armada_16x_software_manual.pdf
+             - Specification update : https://www.marvell.com/application-processors/armada-100/assets/ARMADA16x_Spec_update.pdf
+             - Boot ROM manual      : https://www.marvell.com/application-processors/armada-100/assets/armada_16x_ref_manual.pdf
+             - App node package     : https://www.marvell.com/application-processors/armada-100/assets/armada_16x_app_note_package.pdf
              - Application processor only
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA910/PXA920
-             - Homepage             : http://www.marvell.com/communication-processors/pxa910/
-             - Product Brief        : http://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
+             - Homepage             : https://www.marvell.com/communication-processors/pxa910/
+             - Product Brief        : https://www.marvell.com/communication-processors/pxa910/assets/Marvell_PXA910_Platform-001_PB_final.pdf
              - Application processor with Communication processor
              - Core: ARMv5 compatible Marvell PJ1 88sv331 (Mohawk)
         - PXA688, a.k.a. MMP2, a.k.a Armada 610
-             - Product Brief        : http://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
+             - Product Brief        : https://www.marvell.com/application-processors/armada-600/assets/armada610_pb.pdf
              - Application processor only
              - Core: ARMv7 compatible Sheeva PJ4 88sv581x core
 	- PXA2128, a.k.a. MMP3 (OLPC XO4, Linux support not upstream)
-	     - Product Brief	  : http://www.marvell.com/application-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
+	     - Product Brief	  : https://www.marvell.com/application-processors/armada/pxa2128/assets/Marvell-ARMADA-PXA2128-SoC-PB.pdf
 	     - Application processor only
 	     - Core: Dual-core ARMv7 compatible Sheeva PJ4C core
 	- PXA960/PXA968/PXA978 (Linux support not upstream)
@@ -394,7 +394,7 @@ Berlin family (Multimedia Solutions)
   - Flavors:
 	- 88DE3010, Armada 1000 (no Linux support)
 		- Core:		Marvell PJ1 (ARMv5TE), Dual-core
-		- Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
+		- Product Brief:	https://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
 	- 88DE3005, Armada 1500 Mini
 		- Design name:	BG2CD
 		- Core:		ARM Cortex-A9, PL310 L2CC
diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 05e5f2dfb814..4c97203a5e1d 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -18,7 +18,7 @@ git branches/tags and email subject always contain this "at91" sub-string.
 AT91 SoCs
 ---------
 Documentation and detailed datasheet for each product are available on
-the Microchip website: http://www.microchip.com.
+the Microchip website: https://www.microchip.com.
 
   Flavors:
     * ARM 920 based SoC
diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arm/sa1100/assabet.rst
index a761e128fb08..0bc5a1b4a754 100644
--- a/Documentation/arm/sa1100/assabet.rst
+++ b/Documentation/arm/sa1100/assabet.rst
@@ -6,7 +6,7 @@ Please see:
 http://developer.intel.com
 
 Also some notes from John G Dorsey <jd5q@andrew.cmu.edu>:
-http://www.cs.cmu.edu/~wearable/software/assabet.html
+https://www.cs.cmu.edu/~wearable/software/assabet.html
 
 
 Building the kernel
@@ -32,7 +32,7 @@ BLOB (http://www.lartmaker.nl/lartware/blob/)
    patches were merged into BLOB to add support for Assabet.
 
 Compaq's Bootldr + John Dorsey's patch for Assabet support
-(http://www.handhelds.org/Compaq/bootldr.html)
+(https://www.handhelds.org/Compaq/bootldr.html)
 (http://www.wearablegroup.org/software/bootldr/)
 
    Bootldr is the bootloader developed by Compaq for the iPAQ Pocket PC.
diff --git a/Documentation/arm/sa1100/cerf.rst b/Documentation/arm/sa1100/cerf.rst
index 7fa71b609bf9..c964c2972a0c 100644
--- a/Documentation/arm/sa1100/cerf.rst
+++ b/Documentation/arm/sa1100/cerf.rst
@@ -8,7 +8,7 @@ The Intrinsyc CerfBoard is a StrongARM 1110-based computer on a board
 that measures approximately 2" square. It includes an Ethernet
 controller, an RS232-compatible serial port, a USB function port, and
 one CompactFlash+ slot on the back. Pictures can be found at the
-Intrinsyc website, http://www.intrinsyc.com.
+Intrinsyc website, https://www.intrinsyc.com.
 
 This document describes the support in the Linux kernel for the
 Intrinsyc CerfBoard.
diff --git a/Documentation/arm/samsung-s3c24xx/h1940.rst b/Documentation/arm/samsung-s3c24xx/h1940.rst
index 62a562c178e3..94fa58bda793 100644
--- a/Documentation/arm/samsung-s3c24xx/h1940.rst
+++ b/Documentation/arm/samsung-s3c24xx/h1940.rst
@@ -2,7 +2,7 @@
 HP IPAQ H1940
 =============
 
-http://www.handhelds.org/projects/h1940.html
+https://www.handhelds.org/projects/h1940.html
 
 Introduction
 ------------
@@ -18,11 +18,11 @@ Support
 
   handhelds.org project page:
 
-    http://www.handhelds.org/projects/h1940.html
+    https://www.handhelds.org/projects/h1940.html
 
   handhelds.org wiki page:
 
-    http://handhelds.org/moin/moin.cgi/HpIpaqH1940
+    https://handhelds.org/moin/moin.cgi/HpIpaqH1940
 
   Herbert Pötzl pages:
 
diff --git a/Documentation/arm/samsung-s3c24xx/overview.rst b/Documentation/arm/samsung-s3c24xx/overview.rst
index e9a1dc7276b5..b4a7db77f33b 100644
--- a/Documentation/arm/samsung-s3c24xx/overview.rst
+++ b/Documentation/arm/samsung-s3c24xx/overview.rst
@@ -114,7 +114,7 @@ Machines
   Acer N30
 
     A S3C2410 based PDA from Acer.  There is a Wiki page at
-    http://handhelds.org/moin/moin.cgi/AcerN30Documentation .
+    https://handhelds.org/moin/moin.cgi/AcerN30Documentation .
 
   AML M5900
 
@@ -140,7 +140,7 @@ Adding New Machines
   Read the kernel patch submission policies as well as the
   Documentation/arm directory before submitting patches. The
   ARM kernel series is managed by Russell King, and has a patch system
-  located at http://www.arm.linux.org.uk/developer/patches/
+  located at https://www.arm.linux.org.uk/developer/patches/
   as well as mailing lists that can be found from the same site.
 
   As a courtesy, please notify <ben-linux@fluff.org> of any new
@@ -148,7 +148,7 @@ Adding New Machines
 
   Any large scale modifications, or new drivers should be discussed
   on the ARM kernel mailing list (linux-arm-kernel) before being
-  attempted. See http://www.arm.linux.org.uk/mailinglists/ for the
+  attempted. See https://www.arm.linux.org.uk/mailinglists/ for the
   mailing list information.
 
 
diff --git a/Documentation/arm/samsung-s3c24xx/smdk2440.rst b/Documentation/arm/samsung-s3c24xx/smdk2440.rst
index 524fd0b4afaf..76996b803f7c 100644
--- a/Documentation/arm/samsung-s3c24xx/smdk2440.rst
+++ b/Documentation/arm/samsung-s3c24xx/smdk2440.rst
@@ -26,7 +26,7 @@ Support
   includes linux based USB download tools.
 
   Some of the h1940 patches that can be found from the H1940 project
-  site at http://www.handhelds.org/projects/h1940.html can also be
+  site at https://www.handhelds.org/projects/h1940.html can also be
   applied to this board.
 
 
diff --git a/Documentation/arm/spear/overview.rst b/Documentation/arm/spear/overview.rst
index 1a77f6b213b6..a8ae90a4f1bd 100644
--- a/Documentation/arm/spear/overview.rst
+++ b/Documentation/arm/spear/overview.rst
@@ -6,7 +6,7 @@ Introduction
 ------------
 
   SPEAr (Structured Processor Enhanced Architecture).
-  weblink : http://www.st.com/spear
+  weblink : https://www.st.com/spear
 
   The ST Microelectronics SPEAr range of ARM9/CortexA9 System-on-Chip CPUs are
   supported by the 'spear' platform of ARM Linux. Currently SPEAr1310,
diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index f868330df6be..120387c5efda 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -4,7 +4,7 @@ The Unified Extensible Firmware Interface (UEFI)
 
 UEFI, the Unified Extensible Firmware Interface, is a specification
 governing the behaviours of compatible firmware interfaces. It is
-maintained by the UEFI Forum - http://www.uefi.org/.
+maintained by the UEFI Forum - https://uefi.org/.
 
 UEFI is an evolution of its predecessor 'EFI', so the terms EFI and
 UEFI are used somewhat interchangeably in this document and associated
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
diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index fff6604631ea..fe4da8f1edec 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -16,7 +16,7 @@ The kernel-doc structure is extracted from the comments, and proper
 generated from them. The descriptions are filtered for special kernel-doc
 highlights and cross-references. See below for details.
 
-.. _Sphinx C Domain: http://www.sphinx-doc.org/en/stable/domains.html
+.. _Sphinx C Domain: https://www.sphinx-doc.org/en/stable/domains.html
 
 Every function that is exported to loadable modules using
 ``EXPORT_SYMBOL`` or ``EXPORT_SYMBOL_GPL`` should have a kernel-doc
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index f71ddd592aaa..224e0d3605e9 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -8,7 +8,7 @@ The Linux kernel uses `Sphinx`_ to generate pretty documentation from
 HTML or PDF formats, use ``make htmldocs`` or ``make pdfdocs``. The generated
 documentation is placed in ``Documentation/output``.
 
-.. _Sphinx: http://www.sphinx-doc.org/
+.. _Sphinx: https://www.sphinx-doc.org/
 .. _reStructuredText: http://docutils.sourceforge.net/rst.html
 
 The reStructuredText files may contain directives to include structured
@@ -152,7 +152,7 @@ Adding new documentation can be as simple as:
 1. Add a new ``.rst`` file somewhere under ``Documentation``.
 2. Refer to it from the Sphinx main `TOC tree`_ in ``Documentation/index.rst``.
 
-.. _TOC tree: http://www.sphinx-doc.org/en/stable/markup/toctree.html
+.. _TOC tree: https://www.sphinx-doc.org/en/stable/markup/toctree.html
 
 This is usually good enough for simple documentation (like the one you're
 reading right now), but for larger documents it may be advisable to create a
@@ -166,8 +166,8 @@ with them. In particular, the Sphinx `reStructuredText Primer`_ is a good place
 to get started with reStructuredText. There are also some `Sphinx specific
 markup constructs`_.
 
-.. _reStructuredText Primer: http://www.sphinx-doc.org/en/stable/rest.html
-.. _Sphinx specific markup constructs: http://www.sphinx-doc.org/en/stable/markup/index.html
+.. _reStructuredText Primer: https://www.sphinx-doc.org/en/stable/rest.html
+.. _Sphinx specific markup constructs: https://www.sphinx-doc.org/en/stable/markup/index.html
 
 Specific guidelines for the kernel documentation
 ------------------------------------------------
@@ -360,8 +360,8 @@ image format use SVG (:ref:`svg_image_example`)::
 
 The kernel figure (and image) directive support **DOT** formated files, see
 
-* DOT: http://graphviz.org/pdf/dotguide.pdf
-* Graphviz: http://www.graphviz.org/content/dot-language
+* DOT: https://graphviz.org/pdf/dotguide.pdf
+* Graphviz: https://www.graphviz.org/content/dot-language
 
 A simple example (:ref:`hello_dot_file`)::
 
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
diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
index 3deefb34046b..8a58c61932ff 100644
--- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
+++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
@@ -92,7 +92,7 @@ You can obtain somewhat infrequent snapshots of klibc from
 https://www.kernel.org/pub/linux/libs/klibc/
 
 For active users, you are better off using the klibc git
-repository, at http://git.kernel.org/?p=libs/klibc/klibc.git
+repository, at https://git.kernel.org/?p=libs/klibc/klibc.git
 
 The standalone klibc distribution currently provides three components,
 in addition to the klibc library:
@@ -122,7 +122,7 @@ and a number of other utilities, so you can replace kinit and build
 custom initramfs images that meet your needs exactly.
 
 For questions and help, you can sign up for the early userspace
-mailing list at http://www.zytor.com/mailman/listinfo/klibc
+mailing list at https://www.zytor.com/mailman/listinfo/klibc
 
 How does it work?
 =================
diff --git a/Documentation/driver-api/memory-devices/ti-gpmc.rst b/Documentation/driver-api/memory-devices/ti-gpmc.rst
index 33efcb81f080..b1bb86871ad7 100644
--- a/Documentation/driver-api/memory-devices/ti-gpmc.rst
+++ b/Documentation/driver-api/memory-devices/ti-gpmc.rst
@@ -14,7 +14,7 @@ memory devices like
  * Pseudo-SRAM devices
 
 GPMC is found on Texas Instruments SoC's (OMAP based)
-IP details: http://www.ti.com/lit/pdf/spruh73 section 7.1
+IP details: https://www.ti.com/lit/pdf/spruh73 section 7.1
 
 
 GPMC generic timing calculation:
diff --git a/Documentation/driver-api/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
index 54406093768b..a231e9644351 100644
--- a/Documentation/driver-api/mmc/mmc-tools.rst
+++ b/Documentation/driver-api/mmc/mmc-tools.rst
@@ -5,7 +5,7 @@ MMC tools introduction
 There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
 you can find it at the below public git repository:
 
-	http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+	https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
 
 Functions
 =========
diff --git a/Documentation/driver-api/mtd/nand_ecc.rst b/Documentation/driver-api/mtd/nand_ecc.rst
index e8d3c53a5056..0abcb54b4ad3 100644
--- a/Documentation/driver-api/mtd/nand_ecc.rst
+++ b/Documentation/driver-api/mtd/nand_ecc.rst
@@ -110,7 +110,7 @@ ECC 2   cp5   cp4   cp3   cp2   cp1   cp0      1     1
 =====  ===== ===== ===== ===== ===== ===== ===== =====
 
 I detected after writing this that ST application note AN1823
-(http://www.st.com/stonline/) gives a much
+(https://www.st.com/stonline/) gives a much
 nicer picture.(but they use line parity as term where I use row parity)
 Oh well, I'm graphically challenged, so suffer with me for a moment :-)
 
diff --git a/Documentation/driver-api/nfc/nfc-pn544.rst b/Documentation/driver-api/nfc/nfc-pn544.rst
index 6b2d8aae0c4e..3b56bd8db959 100644
--- a/Documentation/driver-api/nfc/nfc-pn544.rst
+++ b/Documentation/driver-api/nfc/nfc-pn544.rst
@@ -31,4 +31,4 @@ and third (LSB) bytes of the message. The maximum FW message length is
 1024 bytes.
 
 For the ETSI HCI specification see
-http://www.etsi.org/WebSite/Technologies/ProtocolSpecification.aspx
+https://www.etsi.org/WebSite/Technologies/ProtocolSpecification.aspx
diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 08f855cbb4e6..afe4184cacaa 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -113,13 +113,13 @@ Supporting Documents
 --------------------
 
 ACPI 6:
-	http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
+	https://uefi.org/sites/default/files/resources/ACPI_6.0.pdf
 NVDIMM Namespace:
-	http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
+	https://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
 DSM Interface Example:
-	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
+	https://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
 Driver Writer's Guide:
-	http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
+	https://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
 
 Git Trees
 ---------
@@ -778,7 +778,7 @@ Why the Term "namespace"?
 
     2. The term originated to describe the sub-devices that can be created
        within a NVME controller (see the nvme specification:
-       http://www.nvmexpress.org/specifications/), and NFIT namespaces are
+       https://www.nvmexpress.org/specifications/), and NFIT namespaces are
        meant to parallel the capabilities and configurability of
        NVME-namespaces.
 
@@ -786,7 +786,7 @@ Why the Term "namespace"?
 LIBNVDIMM/LIBNDCTL: Block Translation Table "btt"
 -------------------------------------------------
 
-A BTT (design document: http://pmem.io/2014/09/23/btt.html) is a stacked
+A BTT (design document: https://pmem.io/2014/09/23/btt.html) is a stacked
 block device driver that fronts either the whole block device or a
 partition of a block device emitted by either a PMEM or BLK NAMESPACE.
 
diff --git a/Documentation/driver-api/nvdimm/security.rst b/Documentation/driver-api/nvdimm/security.rst
index ad9dea099b34..7aab71524116 100644
--- a/Documentation/driver-api/nvdimm/security.rst
+++ b/Documentation/driver-api/nvdimm/security.rst
@@ -138,6 +138,6 @@ another encrypted-key.
 This command is only available when the master security is enabled, indicated
 by the extended security status.
 
-[1]: http://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
+[1]: https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
 
 [2]: http://www.t13.org/documents/UploadedDocuments/docs2006/e05179r4-ACS-SecurityClarifications.pdf
diff --git a/Documentation/driver-api/rapidio/rapidio.rst b/Documentation/driver-api/rapidio/rapidio.rst
index fb8942d3ba85..74c552ad3eb8 100644
--- a/Documentation/driver-api/rapidio/rapidio.rst
+++ b/Documentation/driver-api/rapidio/rapidio.rst
@@ -356,7 +356,7 @@ NOTE:
     http://www.rapidio.org/education/technology_comparisons/
 
 [3] RapidIO support for Linux.
-    http://lwn.net/Articles/139118/
+    https://lwn.net/Articles/139118/
 
 [4] Matt Porter. RapidIO for Linux. Ottawa Linux Symposium, 2005
-    http://www.kernel.org/doc/ols/2005/ols2005v2-pages-43-56.pdf
+    https://www.kernel.org/doc/ols/2005/ols2005v2-pages-43-56.pdf
diff --git a/Documentation/driver-api/scsi.rst b/Documentation/driver-api/scsi.rst
index 64b231d125e0..ea424475d321 100644
--- a/Documentation/driver-api/scsi.rst
+++ b/Documentation/driver-api/scsi.rst
@@ -20,7 +20,7 @@ Although the old parallel (fast/wide/ultra) SCSI bus has largely fallen
 out of use, the SCSI command set is more widely used than ever to
 communicate with devices over a number of different busses.
 
-The `SCSI protocol <http://www.t10.org/scsi-3.htm>`__ is a big-endian
+The `SCSI protocol <https://www.t10.org/scsi-3.htm>`__ is a big-endian
 peer-to-peer packet based protocol. SCSI commands are 6, 10, 12, or 16
 bytes long, often followed by an associated data payload.
 
@@ -106,7 +106,7 @@ drivers/scsi/scsicam.c
 ~~~~~~~~~~~~~~~~~~~~~~
 
 `SCSI Common Access
-Method <http://www.t10.org/ftp/t10/drafts/cam/cam-r12b.pdf>`__ support
+Method <https://www.t10.org/ftp/t10/drafts/cam/cam-r12b.pdf>`__ support
 functions, for use with HDIO_GETGEO, etc.
 
 .. kernel-doc:: drivers/scsi/scsicam.c
@@ -171,7 +171,7 @@ drivers/scsi/scsi_netlink.c
 Infrastructure to provide async events from transports to userspace via
 netlink, using a single NETLINK_SCSITRANSPORT protocol for all
 transports. See `the original patch
-submission <http://marc.info/?l=linux-scsi&m=115507374832500&w=2>`__ for
+submission <https://marc.info/?l=linux-scsi&m=115507374832500&w=2>`__ for
 more details.
 
 .. kernel-doc:: drivers/scsi/scsi_netlink.c
diff --git a/Documentation/driver-api/thermal/nouveau_thermal.rst b/Documentation/driver-api/thermal/nouveau_thermal.rst
index 37255fd6735d..79ece266cf6d 100644
--- a/Documentation/driver-api/thermal/nouveau_thermal.rst
+++ b/Documentation/driver-api/thermal/nouveau_thermal.rst
@@ -93,4 +93,4 @@ Thermal management on Nouveau is new and may not work on all cards. If you have
 inquiries, please ping mupuf on IRC (#nouveau, freenode).
 
 Bug reports should be filled on Freedesktop's bug tracker. Please follow
-http://nouveau.freedesktop.org/wiki/Bugs
+https://nouveau.freedesktop.org/wiki/Bugs
diff --git a/Documentation/driver-api/usb/bulk-streams.rst b/Documentation/driver-api/usb/bulk-streams.rst
index 99b515babdeb..69daca50a709 100644
--- a/Documentation/driver-api/usb/bulk-streams.rst
+++ b/Documentation/driver-api/usb/bulk-streams.rst
@@ -9,9 +9,9 @@ device driver to overload a bulk endpoint so that multiple transfers can be
 queued at once.
 
 Streams are defined in sections 4.4.6.4 and 8.12.1.4 of the Universal Serial Bus
-3.0 specification at http://www.usb.org/developers/docs/  The USB Attached SCSI
+3.0 specification at https://www.usb.org/developers/docs/  The USB Attached SCSI
 Protocol, which uses streams to queue multiple SCSI commands, can be found on
-the T10 website (http://t10.org/).
+the T10 website (https://www.t10.org/).
 
 
 Device-side implications
diff --git a/Documentation/driver-api/usb/power-management.rst b/Documentation/driver-api/usb/power-management.rst
index 2525c3622cae..bb634d22b597 100644
--- a/Documentation/driver-api/usb/power-management.rst
+++ b/Documentation/driver-api/usb/power-management.rst
@@ -594,11 +594,11 @@ quirks) as the system resume path for the hub.
 
 .. [#f1]
 
-  http://dl.dropbox.com/u/96820575/sarah-sharp-lpt-port-power-off2-mini.pdf
+  https://dl.dropbox.com/u/96820575/sarah-sharp-lpt-port-power-off2-mini.pdf
 
 .. [#f2]
 
-  http://linuxplumbers.ubicast.tv/videos/usb-port-power-off-kerneluserspace-api/
+  https://linuxplumbers.ubicast.tv/videos/usb-port-power-off-kerneluserspace-api/
 
 .. [#f3]
 
diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index 5bf7152fd76f..d7ee0e7ebcbe 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -707,14 +707,14 @@ cheerful guidance and support.
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
 
 Texas Instruments USB Configuration Wiki Page:
-http://processors.wiki.ti.com/index.php/Usbgeneralpage
+https://processors.wiki.ti.com/index.php/Usbgeneralpage
diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 0b3d9ff221bb..9a10ca74c992 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -320,4 +320,4 @@ https://lore.kernel.org/linux-usb/
 Programming Guide for Linux USB Device Drivers:
 http://lmu.web.psi.ch/docu/manuals/software_manuals/linux_sl/usb_linux_programming_guide.pdf
 
-USB Home Page: http://www.usb.org
+USB Home Page: https://www.usb.org
diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 6c032db235a5..6dcc0f5146ef 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -244,4 +244,4 @@ If this function is passed a pointer for the dentry corresponding to the
 top-level directory, the entire hierarchy below that directory will be
 removed.
 
-.. [1] http://lwn.net/Articles/309298/
+.. [1] https://lwn.net/Articles/309298/
diff --git a/Documentation/filesystems/hpfs.rst b/Documentation/filesystems/hpfs.rst
index 0db152278572..7e0dd2f4373e 100644
--- a/Documentation/filesystems/hpfs.rst
+++ b/Documentation/filesystems/hpfs.rst
@@ -7,7 +7,7 @@ Read/Write HPFS 2.09
 1998-2004, Mikulas Patocka
 
 :email: mikulas@artax.karlin.mff.cuni.cz
-:homepage: http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
+:homepage: https://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 
 Credits
 =======
diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 58ce6b395206..da1b2d0f4ef7 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -177,7 +177,7 @@ See also
 --------
 
 `Journaling the Linux ext2fs Filesystem, LinuxExpo 98, Stephen
-Tweedie <http://kernel.org/pub/linux/kernel/people/sct/ext3/journal-design.ps.gz>`__
+Tweedie <https://kernel.org/pub/linux/kernel/people/sct/ext3/journal-design.ps.gz>`__
 
 `Ext3 Journalling FileSystem, OLS 2000, Dr. Stephen
 Tweedie <http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html>`__
diff --git a/Documentation/filesystems/nfs/rpc-server-gss.rst b/Documentation/filesystems/nfs/rpc-server-gss.rst
index 812754576845..abed4a2b1b82 100644
--- a/Documentation/filesystems/nfs/rpc-server-gss.rst
+++ b/Documentation/filesystems/nfs/rpc-server-gss.rst
@@ -10,12 +10,12 @@ purposes of authentication.)
 
 RPCGSS is specified in a few IETF documents:
 
- - RFC2203 v1: http://tools.ietf.org/rfc/rfc2203.txt
- - RFC5403 v2: http://tools.ietf.org/rfc/rfc5403.txt
+ - RFC2203 v1: https://tools.ietf.org/rfc/rfc2203.txt
+ - RFC5403 v2: https://tools.ietf.org/rfc/rfc5403.txt
 
 and there is a 3rd version  being proposed:
 
- - http://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
+ - https://tools.ietf.org/id/draft-williams-rpcsecgssv3.txt
    (At draft n. 02 at the time of writing)
 
 Background
diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index f46b05e9b96c..1c552b97eb35 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -69,7 +69,7 @@ pathname that is just slashes have a final component.  If it does
 exist, it could be "``.``" or "``..``" which are handled quite differently
 from other components.
 
-.. _POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_12
+.. _POSIX: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_12
 
 If a pathname ends with a slash, such as "``/tmp/foo/``" it might be
 tempting to consider that to have an empty final component.  In many
@@ -376,7 +376,7 @@ table, and the mount point hash table.
 Bringing it together with ``struct nameidata``
 ----------------------------------------------
 
-.. _First edition Unix: http://minnie.tuhs.org/cgi-bin/utree.pl?file=V1/u2.s
+.. _First edition Unix: https://minnie.tuhs.org/cgi-bin/utree.pl?file=V1/u2.s
 
 Throughout the process of walking a path, the current status is stored
 in a ``struct nameidata``, "namei" being the traditional name - dating
@@ -1265,7 +1265,7 @@ Symlinks are different it seems.  Both reading a symlink (with ``readlink()``)
 and looking up a symlink on the way to some other destination can
 update the atime on that symlink.
 
-.. _clearest statement: http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_08
+.. _clearest statement: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_08
 
 It is not clear why this is the case; POSIX has little to say on the
 subject.  The `clearest statement`_ is that, if a particular implementation
diff --git a/Documentation/filesystems/path-lookup.txt b/Documentation/filesystems/path-lookup.txt
index 9b8930f589d9..2ca1590f27bd 100644
--- a/Documentation/filesystems/path-lookup.txt
+++ b/Documentation/filesystems/path-lookup.txt
@@ -375,7 +375,7 @@ common path elements, the more likely they will exist in dentry cache.
 Papers and other documentation on dcache locking
 ================================================
 
-1. Scaling dcache with RCU (http://linuxjournal.com/article.php?sid=7124).
+1. Scaling dcache with RCU (https://www.linuxjournal.com/article.php?sid=7124).
 
 2. http://lse.sourceforge.net/locking/dcache/dcache.html
 
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 6c576e241d86..9b1d0f814b30 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -250,11 +250,11 @@ references:
 - http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
 - http://www.linuxfromscratch.org/lfs/view/stable/
 
-The "klibc" package (http://www.kernel.org/pub/linux/libs/klibc) is
+The "klibc" package (https://www.kernel.org/pub/linux/libs/klibc) is
 designed to be a tiny C library to statically link early userspace
 code against, along with some related utilities.  It is BSD licensed.
 
-I use uClibc (http://www.uclibc.org) and busybox (http://www.busybox.net)
+I use uClibc (https://uclibc.org) and busybox (http://www.busybox.net)
 myself.  These are LGPL and GPL, respectively.  (A self-contained initramfs
 package is planned for the busybox 1.3 release.)
 
@@ -304,7 +304,7 @@ the above threads) is:
    widely used on Linux (inside RPM, Red Hat's device driver disks).  Here's
    a Linux Journal article about it from 1996:
 
-      http://www.linuxjournal.com/article/1213
+      https://www.linuxjournal.com/article/1213
 
    It's not as popular as tar because the traditional cpio command line tools
    require _truly_hideous_ command line arguments.  But that says nothing
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
 
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 16efd729bf7c..1f39c8cea702 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -433,9 +433,9 @@ will then have to be provided beforehand in the normal way.
 References
 ==========
 
-[CRYPTSETUP2]        http://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
+[CRYPTSETUP2]        https://www.saout.de/pipermail/dm-crypt/2017-November/005745.html
 
-[DMC-CBC-ATTACK]     http://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
+[DMC-CBC-ATTACK]     https://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
 
 [DM-INTEGRITY]       https://www.kernel.org/doc/Documentation/device-mapper/dm-integrity.rst
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..64086b7fa4f4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1416,13 +1416,13 @@ Resources
  version.)
 
 Creating Linux virtual filesystems. 2002
-    <http://lwn.net/Articles/13325/>
+    <https://lwn.net/Articles/13325/>
 
 The Linux Virtual File-system Layer by Neil Brown. 1999
-    <http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>
+    <https://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html>
 
 A tour of the Linux VFS by Michael K. Johnson. 1996
     <http://www.tldp.org/LDP/khg/HyperNews/get/fs/vfstour.html>
 
 A small trail through the Linux kernel by Andries Brouwer. 2001
-    <http://www.win.tue.nl/~aeb/linux/vfs/trail.html>
+    <https://www.win.tue.nl/~aeb/linux/vfs/trail.html>
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6ed806e6061b..6a5bf1fadde6 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1041,7 +1041,7 @@ on a machine with more CPUs, this likelihood drops fast. Consider a
 increment takes about 58ns, a lock which is cache-hot on this CPU takes
 160ns, and a cacheline transfer from another CPU takes an additional 170
 to 360ns. (These figures from Paul McKenney's `Linux Journal RCU
-article <http://www.linuxjournal.com/article.php?sid=6993>`__).
+article <https://www.linuxjournal.com/article.php?sid=6993>`__).
 
 These two aims conflict: holding a lock for a short time might be done
 by splitting locks into parts (such as in our final per-object-lock
diff --git a/Documentation/leds/leds-lm3556.rst b/Documentation/leds/leds-lm3556.rst
index 1ef17d7d800e..9e2eef228ace 100644
--- a/Documentation/leds/leds-lm3556.rst
+++ b/Documentation/leds/leds-lm3556.rst
@@ -4,7 +4,7 @@ Kernel driver for lm3556
 
 * Texas Instrument:
   1.5 A Synchronous Boost LED Flash Driver w/ High-Side Current Source
-* Datasheet: http://www.national.com/ds/LM/LM3556.pdf
+* Datasheet: https://www.national.com/ds/LM/LM3556.pdf
 
 Authors:
       - Daniel Jeong
diff --git a/Documentation/leds/leds-lp3944.rst b/Documentation/leds/leds-lp3944.rst
index c2f87dc1a3a9..6d2b1530d44d 100644
--- a/Documentation/leds/leds-lp3944.rst
+++ b/Documentation/leds/leds-lp3944.rst
@@ -11,7 +11,7 @@ Kernel driver lp3944
     Datasheet:
 
 	Publicly available at the National Semiconductor website
-	http://www.national.com/pf/LP/LP3944.html
+	https://www.national.com/pf/LP/LP3944.html
 
 Authors:
 	Antonio Ospite <ospite@studenti.unina.it>
diff --git a/Documentation/leds/leds-lp5521.rst b/Documentation/leds/leds-lp5521.rst
index 0432615b083d..30a65894049a 100644
--- a/Documentation/leds/leds-lp5521.rst
+++ b/Documentation/leds/leds-lp5521.rst
@@ -3,7 +3,7 @@ Kernel driver for lp5521
 ========================
 
 * National Semiconductor LP5521 led driver chip
-* Datasheet: http://www.national.com/pf/LP/LP5521.html
+* Datasheet: https://www.national.com/pf/LP/LP5521.html
 
 Authors: Mathias Nyman, Yuri Zaporozhets, Samu Onkalo
 
diff --git a/Documentation/leds/leds-lp5523.rst b/Documentation/leds/leds-lp5523.rst
index 7d7362a1dd57..3c69977b5690 100644
--- a/Documentation/leds/leds-lp5523.rst
+++ b/Documentation/leds/leds-lp5523.rst
@@ -3,7 +3,7 @@ Kernel driver for lp5523
 ========================
 
 * National Semiconductor LP5523 led driver chip
-* Datasheet: http://www.national.com/pf/LP/LP5523.html
+* Datasheet: https://www.national.com/pf/LP/LP5523.html
 
 Authors: Mathias Nyman, Yuri Zaporozhets, Samu Onkalo
 Contact: Samu Onkalo (samu.p.onkalo-at-nokia.com)
diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index 80ae5030a590..18758589dcfa 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -37,7 +37,7 @@ You may also like to tell ``gpg`` which ``tty`` to use (add to your shell rc fil
 Creating commit links to lore.kernel.org
 ----------------------------------------
 
-The web site http://lore.kernel.org is meant as a grand archive of all mail
+The web site https://lore.kernel.org is meant as a grand archive of all mail
 list traffic concerning or influencing the kernel development. Storing archives
 of patches here is a recommended practice, and when a maintainer applies a
 patch to a subsystem tree, it is a good idea to provide a Link: tag with a
diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
index 1a2f99b67d25..713d27efccd3 100644
--- a/Documentation/maintainer/pull-requests.rst
+++ b/Documentation/maintainer/pull-requests.rst
@@ -15,7 +15,7 @@ please direct abuse to Tobin C. Harding <me@tobin.cc>.
 
 Original email thread::
 
-	http://lkml.kernel.org/r/20171114110500.GA21175@kroah.com
+	https://lkml.kernel.org/r/20171114110500.GA21175@kroah.com
 
 
 Create Branch
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
diff --git a/Documentation/misc-devices/isl29003.rst b/Documentation/misc-devices/isl29003.rst
index 0cc38aed6c00..b2ecd41a6190 100644
--- a/Documentation/misc-devices/isl29003.rst
+++ b/Documentation/misc-devices/isl29003.rst
@@ -11,7 +11,7 @@ Prefix: 'isl29003'
 Addresses scanned: none
 
 Datasheet:
-http://www.intersil.com/data/fn/fn7464.pdf
+https://www.intersil.com/data/fn/fn7464.pdf
 
 Author: Daniel Mack <daniel@caiaq.de>
 
diff --git a/Documentation/nios2/nios2.rst b/Documentation/nios2/nios2.rst
index 43da3f7cee76..444989c5578c 100644
--- a/Documentation/nios2/nios2.rst
+++ b/Documentation/nios2/nios2.rst
@@ -7,10 +7,10 @@ This is a port of Linux to Nios II (nios2) processor.
 In order to compile for Nios II, you need a version of GCC with support for the generic
 system call ABI. Please see this link for more information on how compiling and booting
 software for the Nios II platform:
-http://www.rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
+https://rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
 
 For reference, please see the following link:
-http://www.altera.com/literature/lit-nio2.jsp
+https://www.altera.com/literature/lit-nio2.jsp
 
 What is Nios II?
 ================
diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index b21b5b245d13..60015961f86b 100644
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
@@ -365,14 +365,14 @@ to keep up with what other developers (and the mainline) are doing.
 Git is now packaged by almost all Linux distributions.  There is a home
 page at:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
 That page has pointers to documentation and tutorials.
 
 Among the kernel developers who do not use git, the most popular choice is
 almost certainly Mercurial:
 
-	http://www.selenic.com/mercurial/
+	https://selenic.com/mercurial/
 
 Mercurial shares many features with git, but it provides an interface which
 many find easier to use.
@@ -494,7 +494,7 @@ Andrew Morton gives this advice for aspiring kernel developers
 	with others on getting things fixed up (this can require
 	persistence!) but that's fine - it's a part of kernel development.
 
-(http://lwn.net/Articles/283982/).
+(https://lwn.net/Articles/283982/).
 
 In the absence of obvious problems to fix, developers are advised to look
 at the current lists of regressions and open bugs in general.  There is
diff --git a/Documentation/process/3.Early-stage.rst b/Documentation/process/3.Early-stage.rst
index be00716071d4..098a843988d6 100644
--- a/Documentation/process/3.Early-stage.rst
+++ b/Documentation/process/3.Early-stage.rst
@@ -46,7 +46,7 @@ and posted this:
 	to communicate user requirements to these people is a waste of
 	time. They are much too "intelligent" to listen to lesser mortals.
 
-(http://lwn.net/Articles/131776/).
+(https://lwn.net/Articles/131776/).
 
 The reality of the situation was different; the kernel developers were far
 more concerned about system stability, long-term maintenance, and finding
@@ -216,7 +216,7 @@ a non-disclosure agreement.  The Linux Foundation operates an NDA program
 designed to help with this sort of situation; more information can be found
 at:
 
-    http://www.linuxfoundation.org/en/NDA_program
+    https://www.linuxfoundation.org/en/NDA_program
 
 This kind of review is often enough to avoid serious problems later on
 without requiring public disclosure of the project.
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
index 1c3a840d06b9..4b882ebf9057 100644
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
+   https://ukuug.org/events/linux2007/2007/papers/Bergmann.pdf
  - LWN article from Michael Kerrisk on avoiding new uses of CAP_SYS_ADMIN:
    https://lwn.net/Articles/486306/
  - Recommendation from Andrew Morton that all related information for a new
diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index fbb9297e6360..e45d97ab9927 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -229,7 +229,7 @@ Although interdiff may save you a step or two you are generally advised to
 do the additional steps since interdiff can get things wrong in some cases.
 
 Another alternative is ``ketchup``, which is a python script for automatic
-downloading and applying of patches (http://www.selenic.com/ketchup/).
+downloading and applying of patches (https://selenic.com/ketchup/).
 
 Other nice tools are diffstat, which shows a summary of changes made by a
 patch; lsdiff, which displays a short listing of affected files in a patch
@@ -241,7 +241,7 @@ the patch contains a given regular expression.
 Where can I download the patches?
 =================================
 
-The patches are available at http://kernel.org/
+The patches are available at https://kernel.org/
 Most recent patches are linked from the front page, but they also have
 specific homes.
 
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
index 91c5ff8e161e..c6b48cfb994e 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -129,7 +129,7 @@ Architectural changes
 ---------------------
 
 DevFS has been obsoleted in favour of udev
-(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
 
 32-bit UID support is now in place.  Have fun!
 
@@ -410,7 +410,7 @@ Pcmciautils
 Quota-tools
 -----------
 
-- <http://sourceforge.net/projects/linuxquota/>
+- <https://sourceforge.net/projects/linuxquota/>
 
 
 Intel P6 microcode
@@ -421,7 +421,7 @@ Intel P6 microcode
 udev
 ----
 
-- <http://www.freedesktop.org/software/systemd/man/udev.html>
+- <https://www.freedesktop.org/software/systemd/man/udev.html>
 
 FUSE
 ----
@@ -446,7 +446,7 @@ PPP
 NFS-utils
 ---------
 
-- <http://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
 
 Iptables
 --------
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
index acb2f1b36350..c2efcea25823 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1124,7 +1124,7 @@ Addison-Wesley, Inc., 1999.
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
index 9d6d0ac4fca9..4075bf76c040 100644
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
@@ -108,7 +108,7 @@ On-line docs
     * Title: **Writing an ALSA Driver**
 
       :Author: Takashi Iwai <tiwai@suse.de>
-      :URL: http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
+      :URL: https://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
       :Date: 2005
       :Keywords: ALSA, sound, soundcard, driver, lowlevel, hardware.
       :Description: Advanced Linux Sound Architecture for developers,
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
@@ -310,7 +310,7 @@ On-line docs
     * Title: **The Linux RAID-1, 4, 5 Code**
 
       :Author: Ingo Molnar, Gadi Oxman and Miguel de Icaza.
-      :URL: http://www.linuxjournal.com/article.php?sid=2391
+      :URL: https://www.linuxjournal.com/article.php?sid=2391
       :Date: 1997
       :Keywords: RAID, MD driver.
       :Description: Linux Journal Kernel Korner article.
@@ -334,7 +334,7 @@ On-line docs
     * Title: **Dynamic Kernels: Modularized Device Drivers**
 
       :Author: Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1219
+      :URL: https://www.linuxjournal.com/article.php?sid=1219
       :Date: 1996
       :Keywords: device driver, module, loading/unloading modules,
         allocating resources.
@@ -349,7 +349,7 @@ On-line docs
     * Title: **Dynamic Kernels: Discovery**
 
       :Author: Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1220
+      :URL: https://www.linuxjournal.com/article.php?sid=1220
       :Date: 1996
       :Keywords: character driver, init_module, clean_up module,
         autodetection, mayor number, minor number, file operations,
@@ -363,7 +363,7 @@ On-line docs
     * Title: **The Devil's in the Details**
 
       :Author: Georg v. Zezschwitz and Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1221
+      :URL: https://www.linuxjournal.com/article.php?sid=1221
       :Date: 1996
       :Keywords: read(), write(), select(), ioctl(), blocking/non
         blocking mode, interrupt handler.
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
@@ -479,8 +479,8 @@ Published books
       :Pages: 636
       :ISBN: 0-596-00590-3
       :Notes: Further information in
-        http://www.oreilly.com/catalog/linuxdrive3/
-        PDF format, URL: http://lwn.net/Kernel/LDD3/
+        https://www.oreilly.com/catalog/linuxdrive3/
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
index 1acaa14903d6..253afc060ea9 100644
--- a/Documentation/process/submitting-drivers.rst
+++ b/Documentation/process/submitting-drivers.rst
@@ -5,8 +5,8 @@ Submitting Drivers For The Linux Kernel
 
 This document is intended to explain how to submit device drivers to the
 various kernel trees. Note that if you are interested in video card drivers
-you should probably talk to XFree86 (http://www.xfree86.org/) and/or X.Org
-(http://x.org/) instead.
+you should probably talk to XFree86 (https://www.xfree86.org/) and/or X.Org
+(https://www.x.org/) instead.
 
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
index ba5e944c7a63..d925d5d83d08 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -892,7 +892,7 @@ References
 ----------
 
 Andrew Morton, "The perfect patch" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
@@ -917,7 +917,7 @@ Kernel Documentation/process/coding-style.rst:
   :ref:`Documentation/process/coding-style.rst <codingstyle>`
 
 Linus Torvalds's mail on the canonical patch format:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lkml.org/lkml/2005/4/7/183>
 
 Andi Kleen, "On submitting kernel patches"
   Some strategies to get difficult or controversial changes in.
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
diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 14a2f7bf63fe..132149df672c 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -518,7 +518,7 @@ Deadline Task Scheduling
        vol. 25, no. 2–3, pp. 187–205, 2003.
   11 - R. Davis and A. Burns. A Survey of Hard Real-Time Scheduling for
        Multiprocessor Systems. ACM Computing Surveys, vol. 43, no. 4, 2011.
-       http://www-users.cs.york.ac.uk/~robdavis/papers/MPSurveyv5.0.pdf
+       https://www-users.cs.york.ac.uk/~robdavis/papers/MPSurveyv5.0.pdf
   12 - U. C. Devi and J. H. Anderson. Tardiness Bounds under Global EDF
        Scheduling on a Multiprocessor. Real-Time Systems Journal, vol. 32,
        no. 2, pp 133-189, 2008.
diff --git a/Documentation/scsi/BusLogic.rst b/Documentation/scsi/BusLogic.rst
index b60169812358..36726004bcef 100644
--- a/Documentation/scsi/BusLogic.rst
+++ b/Documentation/scsi/BusLogic.rst
@@ -55,7 +55,7 @@ tune driver performance and error recovery to their particular needs.
 The latest information on Linux support for BusLogic SCSI Host Adapters, as
 well as the most recent release of this driver and the latest firmware for the
 BT-948/958/958D, will always be available from my Linux Home Page at URL
-"http://sourceforge.net/projects/dandelion/".
+"https://sourceforge.net/projects/dandelion/".
 
 Bug reports should be sent via electronic mail to "lnz@dandelion.com".  Please
 include with the bug report the complete configuration messages reported by the
diff --git a/Documentation/scsi/ChangeLog.megaraid b/Documentation/scsi/ChangeLog.megaraid
index d2052fdbedd2..03a58bdc235e 100644
--- a/Documentation/scsi/ChangeLog.megaraid
+++ b/Documentation/scsi/ChangeLog.megaraid
@@ -215,7 +215,7 @@ Older Version	: 2.20.4.5 (scsi module), 2.20.2.5 (cmm module)
 
 3.	Convert pci_module_init to pci_register_driver
 	Convert from pci_module_init to pci_register_driver
-	(from:http://kernelnewbies.org/KernelJanitors/TODO)
+	(from:https://kernelnewbies.org/KernelJanitors/TODO)
 		- Signed-off-by: Domen Puncer <domen@coderock.org>
 
 4.	Use the pre defined DMA mask constants from dma-mapping.h
diff --git a/Documentation/scsi/FlashPoint.rst b/Documentation/scsi/FlashPoint.rst
index ef3c07e94ad6..3d465957e4c3 100644
--- a/Documentation/scsi/FlashPoint.rst
+++ b/Documentation/scsi/FlashPoint.rst
@@ -19,7 +19,7 @@ The upgrade program described below has been officially terminated effective
   host adapters.  All of BusLogic's other SCSI host adapters, including the
   MultiMaster line, currently support the Linux operating system.  Linux
   drivers and information will be available on October 15th at
-  http://sourceforge.net/projects/dandelion/.
+  https://sourceforge.net/projects/dandelion/.
 
   "Mylex is committed to supporting the Linux community," says Peter Shambora,
   vice president of marketing for Mylex.  "We have supported Linux driver
@@ -34,7 +34,7 @@ Linux is a freely-distributed implementation of UNIX for Intel x86, Sun
 SPARC, SGI MIPS, Motorola 68k, Digital Alpha AXP and Motorola PowerPC
 machines.  It supports a wide range of software, including the X Window
 System, Emacs, and TCP/IP networking.  Further information is available at
-http://www.linux.org and http://www.ssc.com/.
+https://www.linux.org and http://www.ssc.com/.
 
 FlashPoint Host Adapters
 ========================
diff --git a/Documentation/scsi/aic79xx.rst b/Documentation/scsi/aic79xx.rst
index 071ff5111a4f..e9585b41ba1f 100644
--- a/Documentation/scsi/aic79xx.rst
+++ b/Documentation/scsi/aic79xx.rst
@@ -505,7 +505,7 @@ for targets 0 and 6 of Controller 0.
           other RPM packages that try to install system modules.  The best
           way to correct this once the system is running is to install
           the latest RPM package version of this driver, available from
-          http://www.adaptec.com.
+          https://www.adaptec.com.
 
 
 5. Adaptec Customer Support
@@ -521,13 +521,13 @@ for targets 0 and 6 of Controller 0.
 
    Support Options
     - Search the Adaptec Support Knowledgebase (ASK) at
-      http://ask.adaptec.com for articles, troubleshooting tips, and
+      https://ask.adaptec.com for articles, troubleshooting tips, and
       frequently asked questions about your product.
     - For support via Email, submit your question to Adaptec's
-      Technical Support Specialists at http://ask.adaptec.com/.
+      Technical Support Specialists at https://ask.adaptec.com/.
 
    North America
-    - Visit our Web site at http://www.adaptec.com/.
+    - Visit our Web site at https://www.adaptec.com/.
     - For information about Adaptec's support options, call
       408-957-2550, 24 hours a day, 7 days a week.
     - To speak with a Technical Support Specialist,
@@ -540,21 +540,21 @@ for targets 0 and 6 of Controller 0.
       To expedite your service, have your computer with you.
     - To order Adaptec products, including accessories and cables,
       call 408-957-7274.  To order cables online go to
-      http://www.adaptec.com/buy-cables/.
+      https://www.adaptec.com/buy-cables/.
 
    Europe
-    - Visit our Web site at http://www.adaptec.com/en-US/_common/world_index.
+    - Visit our Web site at https://www.adaptec.com/en-US/_common/world_index.
     - To speak with a Technical Support Specialist, call, or email,
 
       * German:  +49 89 4366 5522, Monday-Friday, 9:00-17:00 CET,
-        http://ask-de.adaptec.com/.
+        https://ask-de.adaptec.com/.
       * French:  +49 89 4366 5533, Monday-Friday, 9:00-17:00 CET,
-	http://ask-fr.adaptec.com/.
+	https://ask-fr.adaptec.com/.
       * English: +49 89 4366 5544, Monday-Friday, 9:00-17:00 GMT,
-	http://ask.adaptec.com/.
+	https://ask.adaptec.com/.
 
     - You can order Adaptec cables online at
-      http://www.adaptec.com/buy-cables/.
+      https://www.adaptec.com/buy-cables/.
 
    Japan
     - Visit our web site at http://www.adaptec.co.jp/.
diff --git a/Documentation/scsi/aic7xxx.rst b/Documentation/scsi/aic7xxx.rst
index bad0e5567b21..2c15f6cfcbb9 100644
--- a/Documentation/scsi/aic7xxx.rst
+++ b/Documentation/scsi/aic7xxx.rst
@@ -385,13 +385,13 @@ and set tag depth on Controller 1/Target 2 to 10 tags.
 
    Support Options
     - Search the Adaptec Support Knowledgebase (ASK) at
-      http://ask.adaptec.com for articles, troubleshooting tips, and
+      https://ask.adaptec.com for articles, troubleshooting tips, and
       frequently asked questions about your product.
     - For support via Email, submit your question to Adaptec's
-      Technical Support Specialists at http://ask.adaptec.com/.
+      Technical Support Specialists at https://ask.adaptec.com/.
 
    North America
-    - Visit our Web site at http://www.adaptec.com/.
+    - Visit our Web site at https://www.adaptec.com/.
     - For information about Adaptec's support options, call
       408-957-2550, 24 hours a day, 7 days a week.
     - To speak with a Technical Support Specialist,
@@ -404,21 +404,21 @@ and set tag depth on Controller 1/Target 2 to 10 tags.
       To expedite your service, have your computer with you.
     - To order Adaptec products, including accessories and cables,
       call 408-957-7274.  To order cables online go to
-      http://www.adaptec.com/buy-cables/.
+      https://www.adaptec.com/buy-cables/.
 
    Europe
-    - Visit our Web site at http://www.adaptec.com/en-US/_common/world_index.
+    - Visit our Web site at https://www.adaptec.com/en-US/_common/world_index.
     - To speak with a Technical Support Specialist, call, or email,
 
       * German:  +49 89 4366 5522, Monday-Friday, 9:00-17:00 CET,
-        http://ask-de.adaptec.com/.
+        https://ask-de.adaptec.com/.
       * French:  +49 89 4366 5533, Monday-Friday, 9:00-17:00 CET,
-	http://ask-fr.adaptec.com/.
+	https://ask-fr.adaptec.com/.
       * English: +49 89 4366 5544, Monday-Friday, 9:00-17:00 GMT,
-	http://ask.adaptec.com/.
+	https://ask.adaptec.com/.
 
     - You can order Adaptec cables online at
-      http://www.adaptec.com/buy-cables/.
+      https://www.adaptec.com/buy-cables/.
 
    Japan
     - Visit our web site at http://www.adaptec.co.jp/.
diff --git a/Documentation/scsi/bfa.rst b/Documentation/scsi/bfa.rst
index 3abc0411857d..3214a58a5374 100644
--- a/Documentation/scsi/bfa.rst
+++ b/Documentation/scsi/bfa.rst
@@ -38,7 +38,7 @@ Firmware download
 
 The latest Firmware package for 3.0.2.2 bfa driver can be found at:
 
-http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
+https://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 
 and then click following respective util package link:
 
@@ -55,7 +55,7 @@ Configuration & Management utility download
 The latest driver configuration & management utility for 3.0.2.2 bfa driver can
 be found at:
 
-http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
+https://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 
 and then click following respective util package link
 
@@ -73,7 +73,7 @@ The latest Administration's Guide, Installation and Reference Manual,
 Troubleshooting Guide, and Release Notes for the corresponding out-of-box
 driver can be found at:
 
-http://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
+https://www.brocade.com/services-support/drivers-downloads/adapters/Linux.page
 
 and use the following inbox and out-of-box driver version mapping to find
 the corresponding documentation:
@@ -89,4 +89,4 @@ Support
 
 For general product and support info, go to the Brocade website at:
 
-http://www.brocade.com/services-support/index.page
+https://www.brocade.com/services-support/index.page
diff --git a/Documentation/scsi/ppa.rst b/Documentation/scsi/ppa.rst
index 5fe3859a6892..3faa185bfff5 100644
--- a/Documentation/scsi/ppa.rst
+++ b/Documentation/scsi/ppa.rst
@@ -5,13 +5,13 @@ Terse where to get ZIP Drive help info
 ======================================
 
 General Iomega ZIP drive page for Linux:
-http://web.archive.org/web/%2E/http://www.torque.net/~campbell/
+http://web.archive.org/web/%2E/https://www.torque.net/~campbell/
 
 Driver archive for old drivers:
-http://web.archive.org/web/%2E/http://www.torque.net/~campbell/ppa
+http://web.archive.org/web/%2E/https://www.torque.net/~campbell/ppa
 
 Linux Parport page (parallel port)
-http://web.archive.org/web/%2E/http://www.torque.net/parport/
+http://web.archive.org/web/%2E/https://www.torque.net/parport/
 
 Email list for Linux Parport
 linux-parport@torque.net
diff --git a/Documentation/scsi/scsi.rst b/Documentation/scsi/scsi.rst
index 276918eb4d74..7442424a0af8 100644
--- a/Documentation/scsi/scsi.rst
+++ b/Documentation/scsi/scsi.rst
@@ -9,7 +9,7 @@ the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
 http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
 and multiple page HTML renderings as well as postscript and pdf.
 It can also be found at:
-http://web.archive.org/web/%2E/http://www.torque.net/scsi/SCSI-2.4-HOWTO
+http://web.archive.org/web/%2E/https://www.torque.net/scsi/SCSI-2.4-HOWTO
 
 Notes on using modules in the SCSI subsystem
 ============================================
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 5358bc10689e..a2f35b2638d1 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -11,7 +11,7 @@ SCSI lower level drivers. Lower level drivers (LLDs) are variously called
 host bus adapter (HBA) drivers and host drivers (HD). A "host" in this
 context is a bridge between a computer IO bus (e.g. PCI or ISA) and a
 single SCSI initiator port on a SCSI transport. An "initiator" port
-(SCSI terminology, see SAM-3 at http://www.t10.org) sends SCSI commands
+(SCSI terminology, see SAM-3 at https://www.t10.org) sends SCSI commands
 to "target" SCSI ports (e.g. disks). There can be many LLDs in a running
 system, but only one per hardware type. Most LLDs can control one or more
 SCSI HBAs. Some HBAs contain multiple hosts.
diff --git a/Documentation/scsi/sym53c8xx_2.rst b/Documentation/scsi/sym53c8xx_2.rst
index 8de44a7baa9b..5020a395d8aa 100644
--- a/Documentation/scsi/sym53c8xx_2.rst
+++ b/Documentation/scsi/sym53c8xx_2.rst
@@ -114,7 +114,7 @@ Information about new chips is available at LSILOGIC web server:
 
 SCSI standard documentations are available at T10 site:
 
-          http://www.t10.org/
+          https://www.t10.org/
 
 Useful SCSI tools written by Eric Youngdale are part of most Linux
 distributions:
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
diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
index 6e3ce3bf3593..95728a9212e8 100644
--- a/Documentation/trace/tracepoints.rst
+++ b/Documentation/trace/tracepoints.rst
@@ -143,6 +143,6 @@ the static_key of the tracepoint to allow the if statement to be implemented
 with jump labels and avoid conditional branches.
 
 .. note:: The convenience macro TRACE_EVENT provides an alternative way to
-      define tracepoints. Check http://lwn.net/Articles/379903,
-      http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
+      define tracepoints. Check https://lwn.net/Articles/379903,
+      https://lwn.net/Articles/381064 and https://lwn.net/Articles/383362
       for a series of articles with more details.
diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index dd0c3280ba5a..f27508b2bb47 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -690,7 +690,7 @@ gcc においては、マクロと同じくらい軽いです。
 ----------------------
 
 Andrew Morton, "The perfect patch" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Linux kernel patch submission format".
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
@@ -705,10 +705,10 @@ NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lkml.org/lkml/2005/7/11/336>
 
 Kernel Documentation/process/coding-style.rst:
-  <http://users.sosdg.org/~qiyong/lxr/source/Documentation/process/coding-style.rst>
+  <https://users.sosdg.org/~qiyong/lxr/source/Documentation/process/coding-style.rst>
 
 Linus Torvalds's mail on the canonical patch format:
-  <http://lkml.org/lkml/2005/4/7/183>
+  <https://lkml.org/lkml/2005/4/7/183>
 
 Andi Kleen, "On submitting kernel patches"
   Some strategies to get difficult or controversial changes in.
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 73ebdab4ced7..87c503206892 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -137,7 +137,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
     この他にパッチを作る方法についてのよくできた記述は-
 
        "The Perfect Patch"
-		http://www.ozlabs.org/~akpm/stuff/tpp.txt
+		https://www.ozlabs.org/~akpm/stuff/tpp.txt
        "Linux kernel patch submission format"
 		https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html
 
@@ -270,7 +270,7 @@ https://kernel.org の pub/linux/kernel/v4.x/ ディレクトリに存在しま
     この期間中に、メンテナ達は Linus に大きな差分を送ることができます。
     このような差分は通常 -next カーネルに数週間含まれてきたパッチです。
     大きな変更は git(カーネルのソース管理ツール、詳細は
-    http://git-scm.com/ 参照) を使って送るのが好ましいやり方ですが、パッ
+    https://git-scm.com/ 参照) を使って送るのが好ましいやり方ですが、パッ
     チファイルの形式のまま送るのでも十分です。
   - 2週間後、-rc1 カーネルがリリースされ、この後にはカーネル全体の安定
     性に影響をあたえるような新機能は含まない類のパッチしか取り込むこと
@@ -615,7 +615,7 @@ Linux カーネルコミュニティは、一度に大量のコードの塊を
 ントの ChangeLog セクションを見てください -
 
   "The Perfect Patch"
-      http://www.ozlabs.org/~akpm/stuff/tpp.txt
+      https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 これらはどれも、実行することが時にはとても困難です。これらの例を完璧に
 実施するには数年かかるかもしれません。これは継続的な改善のプロセスであ
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 71d4823e41e1..1cac6f4e4a95 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -582,7 +582,7 @@ Pat이라는 이름을 가진 여자가 있을 수도 있는 것이다. 리눅
 
    "The Perfect Patch"
 
-    http://www.ozlabs.org/~akpm/stuff/tpp.txt
+    https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 
 이 모든 것을 하는 것은 매우 어려운 일이다. 완벽히 소화하는 데는 적어도 몇년이
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index f759edafd938..2c1138660abe 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -250,7 +250,7 @@ Code  Seq#    Include File                                           Comments
 'l'   00-3F  linux/tcfs_fs.h                                         transparent cryptographic file system
                                                                      <http://web.archive.org/web/%2A/http://mikonos.dia.unisa.it/tcfs>
 'l'   40-7F  linux/udf_fs_i.h                                        in development:
-                                                                     <http://sourceforge.net/projects/linux-udf/>
+                                                                     <https://sourceforge.net/projects/linux-udf/>
 'm'   00-09  linux/mmtimer.h                                         conflict!
 'm'   all    linux/mtio.h                                            conflict!
 'm'   all    linux/soundcard.h                                       conflict!
@@ -304,7 +304,7 @@ Code  Seq#    Include File                                           Comments
 0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
 0x8B  all    linux/wireless.h
 0x8C  00-3F                                                          WiNRADiO driver
-                                                                     <http://www.winradio.com.au/>
+                                                                     <https://www.winradio.com.au/>
 0x90  00     drivers/cdrom/sbpcd.h
 0x92  00-0F  drivers/usb/mon/mon_bin.c
 0x93  60-7F  linux/auto_fs.h
diff --git a/Documentation/vm/active_mm.rst b/Documentation/vm/active_mm.rst
index c84471b180f8..6d4df6818c6f 100644
--- a/Documentation/vm/active_mm.rst
+++ b/Documentation/vm/active_mm.rst
@@ -88,4 +88,4 @@ Active MM
  and register state is separate, the alpha PALcode joins the two, and you
  need to switch both together).
 
- (From http://marc.info/?l=linux-kernel&m=93337278602211&w=2)
+ (From https://marc.info/?l=linux-kernel&m=93337278602211&w=2)
diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index d32016d9be2c..d34fe1a71c96 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -6,7 +6,7 @@ Kernel Samepage Merging
 
 KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
 added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
-and http://lwn.net/Articles/306704/ and http://lwn.net/Articles/330589/
+and https://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/
 
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
2.24.1

