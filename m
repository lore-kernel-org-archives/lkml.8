Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E8A206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgFJXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:07:41 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:59372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726471AbgFJXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:07:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5DC19180A8130;
        Wed, 10 Jun 2020 23:07:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cough17_5e02cf726dcf
X-Filterd-Recvd-Size: 77871
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 23:07:33 +0000 (UTC)
Message-ID: <9587fe318ac88299131e751a07bdd1f4b69ae0de.camel@perches.com>
Subject: [PATCH] Documentation: Fix most typos
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jun 2020 16:07:32 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are the typos found in scripts/spelling.txt for
most of the Documentation/ tree.

Scripted with:

$ cat scripts/spelling.txt | \
  grep -v -P "^\s*\#" | \
  while read line ; do \
    from=$(echo $line | cut -f1 -d'|'); \
    to=$(echo $line | cut -f3 -d'|'); \
    echo "from: $from to: $to" ; \
    git grep -w --name-only $from | \
    xargs sed -i "s/\b$from\b/$to/" ; \
    git checkout scripts/spelling.txt ; \
  done

And some removal of inappropriate conversions
in Documentation/translations and a few files
where the conversions were incorrect.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/ABI/testing/debugfs-driver-genwqe        |  2 +-
 Documentation/ABI/testing/procfs-diskstats             |  2 +-
 .../ABI/testing/sysfs-bus-event_source-devices-events  |  4 ++--
 Documentation/ABI/testing/sysfs-bus-umc                |  2 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu     |  2 +-
 Documentation/ABI/testing/sysfs-driver-tegra-fuse      |  2 +-
 Documentation/ABI/testing/sysfs-fs-xfs                 |  2 +-
 Documentation/RCU/RTFP.txt                             |  8 ++++----
 Documentation/RCU/UP.rst                               |  4 ++--
 Documentation/admin-guide/bcache.rst                   |  2 +-
 Documentation/admin-guide/device-mapper/dm-crypt.rst   |  4 ++--
 .../admin-guide/device-mapper/dm-integrity.rst         |  2 +-
 Documentation/admin-guide/device-mapper/dm-raid.rst    |  2 +-
 Documentation/admin-guide/device-mapper/verity.rst     |  2 +-
 Documentation/admin-guide/device-mapper/writecache.rst |  4 ++--
 Documentation/admin-guide/mm/index.rst                 |  2 +-
 Documentation/admin-guide/sysctl/vm.rst                |  4 ++--
 Documentation/admin-guide/tainted-kernels.rst          |  2 +-
 Documentation/arm/interrupts.rst                       |  2 +-
 Documentation/arm/sunxi/clocks.rst                     |  2 +-
 Documentation/arm64/booting.rst                        |  2 +-
 Documentation/arm64/elf_hwcaps.rst                     |  2 +-
 .../bindings/arm/marvell/cp110-system-controller.txt   |  6 +++---
 .../devicetree/bindings/clock/sprd,sc9863a-clk.yaml    |  2 +-
 Documentation/devicetree/bindings/clock/ti/mux.txt     |  2 +-
 Documentation/devicetree/bindings/display/msm/dpu.txt  |  2 +-
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml |  2 +-
 Documentation/devicetree/bindings/fpga/fpga-region.txt |  2 +-
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml     |  2 +-
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml     |  2 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml      |  2 +-
 .../interrupt-controller/socionext,synquacer-exiu.txt  |  2 +-
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt     |  2 +-
 Documentation/devicetree/bindings/misc/ge-achc.txt     |  2 +-
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt    |  2 +-
 .../devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt   |  2 +-
 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  2 +-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.txt           |  6 +++---
 .../bindings/pinctrl/renesas,rza1-pinctrl.txt          |  2 +-
 .../devicetree/bindings/reset/ti-syscon-reset.txt      |  2 +-
 Documentation/devicetree/bindings/sound/cs35l35.txt    |  4 ++--
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt       |  2 +-
 .../bindings/sound/qcom,msm8916-wcd-analog.txt         |  2 +-
 Documentation/devicetree/bindings/sound/sprd-pcm.txt   |  2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml       |  2 +-
 .../devicetree/bindings/timer/lsi,zevio-timer.txt      |  2 +-
 Documentation/driver-api/gpio/driver.rst               |  2 +-
 Documentation/driver-api/md/md-cluster.rst             |  2 +-
 Documentation/driver-api/md/raid5-cache.rst            |  2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst             |  6 +++---
 Documentation/driver-api/thermal/intel_powerclamp.rst  |  4 ++--
 Documentation/driver-api/usb/usb3-debug-port.rst       |  2 +-
 Documentation/fb/udlfb.rst                             |  2 +-
 Documentation/filesystems/ext4/super.rst               |  2 +-
 Documentation/filesystems/fsinfo.rst                   |  2 +-
 Documentation/filesystems/orangefs.rst                 |  2 +-
 Documentation/filesystems/proc.rst                     |  2 +-
 Documentation/filesystems/spufs/spu_create.rst         |  2 +-
 Documentation/filesystems/spufs/spu_run.rst            |  2 +-
 Documentation/filesystems/ubifs-authentication.rst     |  2 +-
 Documentation/firmware-guide/acpi/acpi-lid.rst         |  4 ++--
 Documentation/firmware-guide/acpi/gpio-properties.rst  |  2 +-
 Documentation/gpu/todo.rst                             |  2 +-
 Documentation/hid/hid-transport.rst                    |  8 ++++----
 Documentation/hwmon/abituguru-datasheet.rst            |  2 +-
 Documentation/input/devices/elantech.rst               |  2 +-
 Documentation/isdn/credits.rst                         |  2 +-
 Documentation/kernel-hacking/hacking.rst               |  2 +-
 Documentation/locking/lockdep-design.rst               |  2 +-
 Documentation/networking/ip-sysctl.rst                 |  2 +-
 Documentation/networking/snmp_counter.rst              |  4 ++--
 Documentation/openrisc/openrisc_port.rst               |  2 +-
 Documentation/powerpc/vas-api.rst                      |  2 +-
 Documentation/process/clang-format.rst                 |  2 +-
 Documentation/process/embargoed-hardware-issues.rst    |  6 +++---
 Documentation/process/submitting-patches.rst           |  4 ++--
 Documentation/security/keys/core.rst                   |  2 +-
 Documentation/sound/designs/seq-oss.rst                |  2 +-
 Documentation/sparc/oradax/dax-hv-api.txt              | 18 +++++++++---------
 Documentation/spi/spidev.rst                           |  2 +-
 Documentation/trace/hwlat_detector.rst                 |  2 +-
 Documentation/usb/usbip_protocol.rst                   |  2 +-
 Documentation/userspace-api/media/v4l/hist-v4l2.rst    |  2 +-
 Documentation/virt/kvm/api.rst                         |  2 +-
 Documentation/virt/kvm/halt-polling.rst                |  2 +-
 Documentation/virt/kvm/running-nested-guests.rst       |  2 +-
 86 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-genwqe b/Documentation/ABI/testing/debugfs-driver-genwqe
index 1c2f25674e8c..b45b016545d8 100644
--- a/Documentation/ABI/testing/debugfs-driver-genwqe
+++ b/Documentation/ABI/testing/debugfs-driver-genwqe
@@ -31,7 +31,7 @@ What:           /sys/kernel/debug/genwqe/genwqe<n>_card/prev_regs
 Date:           Oct 2013
 Contact:        haver@linux.vnet.ibm.com
 Description:    Dump of the error registers before the last reset of
-                the card occured.
+                the card occurred.
                 Only available for PF.
 
 What:           /sys/kernel/debug/genwqe/genwqe<n>_card/prev_dbg_uid0
diff --git a/Documentation/ABI/testing/procfs-diskstats b/Documentation/ABI/testing/procfs-diskstats
index 70dcaf2481f4..82180ca671fc 100644
--- a/Documentation/ABI/testing/procfs-diskstats
+++ b/Documentation/ABI/testing/procfs-diskstats
@@ -7,7 +7,7 @@ Description:
 		fields:
 
 		 1 - major number
-		 2 - minor mumber
+		 2 - minor number
 		 3 - device name
 		 4 - reads completed successfully
 		 5 - reads merged
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 505f080d20a1..77de58d03822 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -47,7 +47,7 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		If a <term> is specified alone (without an assigned value), it
 		is implied that 0x1 is assigned to that <term>.
 
-		Examples (each of these lines would be in a seperate file):
+		Examples (each of these lines would be in a separate file):
 
 			event=0x2abc
 			event=0x423,inv,cmask=0x3
@@ -83,7 +83,7 @@ Description:	Perf event scaling factors
 
 		A string representing a floating point value expressed in
 		scientific notation to be multiplied by the event count
-		recieved from the kernel to match the unit specified in the
+		received from the kernel to match the unit specified in the
 		<event>.unit file.
 
 		Example:
diff --git a/Documentation/ABI/testing/sysfs-bus-umc b/Documentation/ABI/testing/sysfs-bus-umc
index 948fec412446..80ef88bc5097 100644
--- a/Documentation/ABI/testing/sysfs-bus-umc
+++ b/Documentation/ABI/testing/sysfs-bus-umc
@@ -9,7 +9,7 @@ Description:
                 Controller (UMC).
 
                 The umc bus presents each of the individual
-                capabilties as a device.
+                capabilities as a device.
 
 What:           /sys/bus/umc/devices/.../capability_id
 Date:           July 2008
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b555df825447..863818f93d84 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -97,7 +97,7 @@ Description:	CPU topology files that describe a logical CPU's relationship
 		corresponds to a physical socket number, but the actual value
 		is architecture and platform dependent.
 
-		thread_siblings: internel kernel map of cpu#'s hardware
+		thread_siblings: internal kernel map of cpu#'s hardware
 		threads within the same core as cpu#
 
 		thread_siblings_list: human-readable list of cpu#'s hardware
diff --git a/Documentation/ABI/testing/sysfs-driver-tegra-fuse b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
index 69f5af632657..b8936fad2ccf 100644
--- a/Documentation/ABI/testing/sysfs-driver-tegra-fuse
+++ b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
@@ -3,7 +3,7 @@ Date:		February 2014
 Contact:	Peter De Schrijver <pdeschrijver@nvidia.com>
 Description:	read-only access to the efuses on Tegra20, Tegra30, Tegra114
 		and Tegra124 SoC's from NVIDIA. The efuses contain write once
-		data programmed at the factory. The data is layed out in 32bit
+		data programmed at the factory. The data is laid out in 32bit
 		words in LSB first format. Each bit represents a single value
 		as decoded from the fuse registers. Bits order/assignment
 		exactly matches the HW registers, including any unused bits.
diff --git a/Documentation/ABI/testing/sysfs-fs-xfs b/Documentation/ABI/testing/sysfs-fs-xfs
index ea0cc8c42093..f704925f6fe9 100644
--- a/Documentation/ABI/testing/sysfs-fs-xfs
+++ b/Documentation/ABI/testing/sysfs-fs-xfs
@@ -33,7 +33,7 @@ Contact:	xfs@oss.sgi.com
 Description:
 		The current state of the log write grant head. It
 		represents the total log reservation of all currently
-		oustanding transactions, including regrants due to
+		outstanding transactions, including regrants due to
 		rolling transactions. The grant head is exported in
 		"cycle:bytes" format.
 Users:		xfstests
diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 9bccf16736f7..85920ac2f20e 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -1245,7 +1245,7 @@ Oregon Health and Sciences University"
 [Viewed September 5, 2005]"
 ,annotation={
 	First posting showing how RCU can be safely adapted for
-	preemptable RCU read side critical sections.
+	preemptible RCU read side critical sections.
 }
 }
 
@@ -1888,7 +1888,7 @@ Revised:
 \url{http://lkml.org/lkml/2007/9/10/213}
 [Viewed October 25, 2007]"
 ,annotation={
-	Final patch for preemptable RCU to -rt.  (Later patches were
+	Final patch for preemptible RCU to -rt.  (Later patches were
 	to mainline, eventually incorporated.)
 }
 }
@@ -2267,7 +2267,7 @@ lot of {Linux} into your technology!!!"
 
 @unpublished{PaulEMcKenney2009fastRTRCU
 ,Author="Paul E. McKenney"
-,Title="[{PATCH} {RFC} -tip 0/4] {RCU} cleanups and simplified preemptable {RCU}"
+,Title="[{PATCH} {RFC} -tip 0/4] {RCU} cleanups and simplified preemptible {RCU}"
 ,month="July"
 ,day="23"
 ,year="2009"
@@ -2275,7 +2275,7 @@ lot of {Linux} into your technology!!!"
 \url{http://lkml.org/lkml/2009/7/23/294}
 [Viewed August 15, 2009]"
 ,annotation={
-	First posting of simple and fast preemptable RCU.
+	First posting of simple and fast preemptible RCU.
 }
 }
 
diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
index e26dda27430c..45895eca9b8a 100644
--- a/Documentation/RCU/UP.rst
+++ b/Documentation/RCU/UP.rst
@@ -98,7 +98,7 @@ UP systems, including PREEMPT SMP builds running on UP systems.
 
 Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems running
-	preemptable RCU?
+	preemptible RCU?
 
 .. _answer_quick_quiz_up:
 
@@ -134,7 +134,7 @@ Answer to Quick Quiz #2:
 
 Answer to Quick Quiz #3:
 	Why can't synchronize_rcu() return immediately on UP systems
-	running preemptable RCU?
+	running preemptible RCU?
 
 	Because some other task might have been preempted in the middle
 	of an RCU read-side critical section.  If synchronize_rcu()
diff --git a/Documentation/admin-guide/bcache.rst b/Documentation/admin-guide/bcache.rst
index 1eccf952876d..9701150e4e98 100644
--- a/Documentation/admin-guide/bcache.rst
+++ b/Documentation/admin-guide/bcache.rst
@@ -197,7 +197,7 @@ For example::
 This should present your unmodified backing device data in /dev/loop0
 
 If your cache is in writethrough mode, then you can safely discard the
-cache device without loosing data.
+cache device without losing data.
 
 
 E) Wiping a cache device
diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index 8f4a3f889d43..5b139257b76b 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -46,7 +46,7 @@ Parameters::
         capi:authenc(hmac(sha256),xts(aes))-random
         capi:rfc7539(chacha20,poly1305)-random
 
-    The /proc/crypto contains a list of curently loaded crypto modes.
+    The /proc/crypto contains a list of currently loaded crypto modes.
 
 <key>
     Key used for encryption. It is encoded either as a hexadecimal number
@@ -92,7 +92,7 @@ Parameters::
 
 <#opt_params>
     Number of optional parameters. If there are no optional parameters,
-    the optional paramaters section can be skipped or #opt_params can be zero.
+    the optional parameters section can be skipped or #opt_params can be zero.
     Otherwise #opt_params is the number of following arguments.
 
     Example of optional parameters section:
diff --git a/Documentation/admin-guide/device-mapper/dm-integrity.rst b/Documentation/admin-guide/device-mapper/dm-integrity.rst
index 9edd45593abd..752459b47889 100644
--- a/Documentation/admin-guide/device-mapper/dm-integrity.rst
+++ b/Documentation/admin-guide/device-mapper/dm-integrity.rst
@@ -117,7 +117,7 @@ journal_watermark:number
 
 commit_time:number
 	Commit time in milliseconds. When this time passes, the journal is
-	written. The journal is also written immediatelly if the FLUSH
+	written. The journal is also written immediately if the FLUSH
 	request is received.
 
 internal_hash:algorithm(:key)	(the key is optional)
diff --git a/Documentation/admin-guide/device-mapper/dm-raid.rst b/Documentation/admin-guide/device-mapper/dm-raid.rst
index 695a2ea1d1ae..345dfd6f989a 100644
--- a/Documentation/admin-guide/device-mapper/dm-raid.rst
+++ b/Documentation/admin-guide/device-mapper/dm-raid.rst
@@ -418,6 +418,6 @@ Version History
 	specific devices are requested via rebuild.  Fix RAID leg
 	rebuild errors.
  1.15.0 Fix size extensions not being synchronized in case of new MD bitmap
-        pages allocated;  also fix those not occuring after previous reductions
+        pages allocated;  also fix those not occurring after previous reductions
  1.15.1 Fix argument count and arguments for rebuild/write_mostly/journal_(dev|mode)
         on the status line.
diff --git a/Documentation/admin-guide/device-mapper/verity.rst b/Documentation/admin-guide/device-mapper/verity.rst
index bb02caa45289..34319a0818af 100644
--- a/Documentation/admin-guide/device-mapper/verity.rst
+++ b/Documentation/admin-guide/device-mapper/verity.rst
@@ -69,7 +69,7 @@ Construction Parameters
 
 <#opt_params>
     Number of optional parameters. If there are no optional parameters,
-    the optional paramaters section can be skipped or #opt_params can be zero.
+    the optional parameters section can be skipped or #opt_params can be zero.
     Otherwise #opt_params is the number of following arguments.
 
     Example of optional parameters section:
diff --git a/Documentation/admin-guide/device-mapper/writecache.rst b/Documentation/admin-guide/device-mapper/writecache.rst
index d3d7690f5e8d..dce0184e07ca 100644
--- a/Documentation/admin-guide/device-mapper/writecache.rst
+++ b/Documentation/admin-guide/device-mapper/writecache.rst
@@ -37,10 +37,10 @@ Constructor parameters:
 	autocommit_blocks n	(default: 64 for pmem, 65536 for ssd)
 		when the application writes this amount of blocks without
 		issuing the FLUSH request, the blocks are automatically
-		commited
+		committed
 	autocommit_time ms	(default: 1000)
 		autocommit time in milliseconds. The data is automatically
-		commited if this time passes and no FLUSH request is
+		committed if this time passes and no FLUSH request is
 		received
 	fua			(by default on)
 		applicable only to persistent memory - use the FUA flag
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 11db46448354..9bd591789b08 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -5,7 +5,7 @@ Memory Management
 Linux memory management subsystem is responsible, as the name implies,
 for managing the memory in the system. This includes implemnetation of
 virtual memory and demand paging, memory allocation both for kernel
-internal structures and user space programms, mapping of files into
+internal structures and user space programs, mapping of files into
 processes address space and many other cool things.
 
 Linux memory management is a complex system with many configurable
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index d46d5b7013c6..3438192ce368 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -129,7 +129,7 @@ This should be used on systems where stalls for minor page faults are an
 acceptable trade for large contiguous free memory.  Set to 0 to prevent
 compaction from moving pages that are unevictable.  Default value is 1.
 On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
-to compaction, which would block the task from becomming active until the fault
+to compaction, which would block the task from becoming active until the fault
 is resolved.
 
 
@@ -345,7 +345,7 @@ The lowmem_reserve_ratio is an array. You can see them by reading this file::
 
 But, these values are not used directly. The kernel calculates # of protection
 pages for each zones from them. These are shown as array of protection pages
-in /proc/zoneinfo like followings. (This is an example of x86-64 box).
+in /proc/zoneinfo like the following. (This is an example of x86-64 box).
 Each zone has an array of protection pages like this::
 
   Node 0, zone      DMA
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 71e9184a9079..8a70af938455 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -130,7 +130,7 @@ More detailed explanation for tainting
  5)  ``B`` If a page-release function has found a bad page reference or some
      unexpected page flags. This indicates a hardware problem or a kernel bug;
      there should be other information in the log indicating why this tainting
-     occured.
+     occurred.
 
  6)  ``U`` if a user or user application specifically requested that the
      Tainted flag be set, ``' '`` otherwise.
diff --git a/Documentation/arm/interrupts.rst b/Documentation/arm/interrupts.rst
index 2ae70e0e9732..56fd51bb5e95 100644
--- a/Documentation/arm/interrupts.rst
+++ b/Documentation/arm/interrupts.rst
@@ -148,7 +148,7 @@ So, what's changed?
 
 4. Direct access to SA1111 INTPOL is deprecated.  Use set_irq_type instead.
 
-5. A handler is expected to perform any necessary acknowledgement of the
+5. A handler is expected to perform any necessary acknowledgment of the
    parent IRQ via the correct chip specific function.  For instance, if
    the SA1111 is directly connected to a SA1110 GPIO, then you should
    acknowledge the SA1110 IRQ each time you re-read the SA1111 IRQ status.
diff --git a/Documentation/arm/sunxi/clocks.rst b/Documentation/arm/sunxi/clocks.rst
index 23bd03f3e21f..dfe6d4887210 100644
--- a/Documentation/arm/sunxi/clocks.rst
+++ b/Documentation/arm/sunxi/clocks.rst
@@ -5,7 +5,7 @@ Frequently asked questions about the sunxi clock system
 This document contains useful bits of information that people tend to ask
 about the sunxi clock system, as well as accompanying ASCII art when adequate.
 
-Q: Why is the main 24MHz oscillator gatable? Wouldn't that break the
+Q: Why is the main 24MHz oscillator gateable? Wouldn't that break the
    system?
 
 A: The 24MHz oscillator allows gating to save power. Indeed, if gated
diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 7552dbc1cc54..a8fafe81261c 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -287,7 +287,7 @@ following manner:
 
 - CPUs with a "spin-table" enable-method must have a 'cpu-release-addr'
   property in their cpu node.  This property identifies a
-  naturally-aligned 64-bit zero-initalised memory location.
+  naturally-aligned 64-bit zero-initialized memory location.
 
   These CPUs should spin outside of the kernel in a reserved area of
   memory (communicated to the kernel by a /memreserve/ region in the
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 84a9fd2d41b4..4bbeb59b701e 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -12,7 +12,7 @@ Some hardware or software features are only available on some CPU
 implementations, and/or with certain kernel configurations, but have no
 architected discovery mechanism available to userspace code at EL0. The
 kernel exposes the presence of these features to userspace through a set
-of flags called hwcaps, exposed in the auxilliary vector.
+of flags called hwcaps, exposed in the auxiliary vector.
 
 Userspace software can test for features by acquiring the AT_HWCAP or
 AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index f982a8ed9396..5b8a6be0d81f 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -21,13 +21,13 @@ The Device Tree node representing this System Controller 0 provides a
 number of clocks:
 
  - a set of core clocks
- - a set of gatable clocks
+ - a set of gateable clocks
 
 Those clocks can be referenced by other Device Tree nodes using two
 cells:
  - The first cell must be 0 or 1. 0 for the core clocks and 1 for the
-   gatable clocks.
- - The second cell identifies the particular core clock or gatable
+   gateable clocks.
+ - The second cell identifies the particular core clock or gateable
    clocks.
 
 The following clocks are available:
diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
index 29813873cfbc..af3b0163c1ec 100644
--- a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
@@ -67,7 +67,7 @@ then:
 else:
   description: |
     Other SC9863a clock nodes should be the child of a syscon node in
-    which compatible string shoule be:
+    which compatible string should be:
             "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
 
     The 'reg' property for the clock node is also required if there is a sub
diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
index eec8994b9be8..5e9ab325bddd 100644
--- a/Documentation/devicetree/bindings/clock/ti/mux.txt
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -8,7 +8,7 @@ parents, one of which can be selected as output.  This clock does not
 gate or adjust the parent rate via a divider or multiplier.
 
 By default the "clocks" property lists the parents in the same order
-as they are programmed into the regster.  E.g:
+as they are programmed into the register.  E.g:
 
 	clocks = <&foo_clock>, <&bar_clock>, <&baz_clock>;
 
diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
index 551ae26f60da..f83cd302f6a6 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
@@ -9,7 +9,7 @@ The DPU display controller is found in SDM845 SoC.
 MDSS:
 Required properties:
 - compatible:  "qcom,sdm845-mdss", "qcom,sc7180-mdss"
-- reg: physical base address and length of contoller's registers.
+- reg: physical base address and length of controller's registers.
 - reg-names: register region names. The following region is required:
   * "mdss"
 - power-domains: a power domain consumer specifier according to
diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index 92794c500589..5212fe40764e 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -51,7 +51,7 @@ properties:
     $ref: /schemas/types.yaml#definitions/uint32
     description: >
       Bitmask of channels to reserve for devices that need a specific
-      channel. These channels will only be assigned when explicitely
+      channel. These channels will only be assigned when explicitly
       requested by a client. The primary use for this is channels 0 and
       1, which can be configured to have special behaviour for NAND/BCH
       when using programmable firmware.
diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 8ab19d1d3f9a..501b73f8c72a 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -483,7 +483,7 @@ It is beyond the scope of this document to fully describe all the FPGA design
 constraints required to make partial reconfiguration work[1] [2] [3], but a few
 deserve quick mention.
 
-A persona must have boundary connections that line up with those of the partion
+A persona must have boundary connections that line up with those of the partition
 or region it is designed to go into.
 
 During programming, transactions through those connections must be stopped and
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
index a0ebb4680140..d11bf9f45a53 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jonathan Cameron <jic23@kernel.org>
 
 description: |
-   Family of simple ADCs with i2c inteface and internal references.
+   Family of simple ADCs with i2c interface and internal references.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
index 48377549c39a..77305b7fd9db 100644
--- a/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jonathan Cameron <jic23@kernel.org>
 
 description: |
-   Family of ADCs with i2c inteface, internal references and threshold
+   Family of ADCs with i2c interface, internal references and threshold
    monitoring.
 
 properties:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 1ecd1831cf02..cc7cd6054b49 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -104,7 +104,7 @@ properties:
 
   msi-controller:
     description:
-      Only present if the Message Based Interrupt functionnality is
+      Only present if the Message Based Interrupt functionality is
       being exposed by the HW, and the mbi-ranges property present.
 
   mbi-ranges:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
index dac0846fe789..2b0df24b5970 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
@@ -13,7 +13,7 @@ Required properties:
 - #interrupt-cells     : Specifies the number of cells needed to encode an
                          interrupt source. The value must be 3.
 - socionext,spi-base   : The SPI number of the first SPI of the 32 adjacent
-                         ones the EXIU forwards its interrups to.
+                         ones the EXIU forwards its interrupts to.
 
 Notes:
 
diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index b823b8625243..f79ff8941374 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -24,7 +24,7 @@ frequencies.
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: three entries specifying the RPM's:
-		    1. acknowledgement interrupt
+		    1. acknowledgment interrupt
 		    2. error interrupt
 		    3. wakeup interrupt
 
diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
index 77df94d7a32f..5b72751b98a4 100644
--- a/Documentation/devicetree/bindings/misc/ge-achc.txt
+++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
@@ -1,6 +1,6 @@
 * GE Healthcare USB Management Controller
 
-A device which handles data aquisition from compatible USB based peripherals.
+A device which handles data acquisition from compatible USB based peripherals.
 SPI is used for device management.
 
 Note: This device does not expose the peripherals as USB devices.
diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 44919d48d241..de397de21699 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -109,7 +109,7 @@ increased system lifetime. However, selection of ECC scheme is dependent
 on various other factors also like;
 
 (1) support of built in hardware engines.
-	Some legacy OMAP SoC do not have ELM harware engine, so those SoC cannot
+	Some legacy OMAP SoC do not have ELM hardware engine, so those SoC cannot
 	support ecc-schemes with hardware error-correction (BCHx_HW). However
 	such SoC can use ecc-schemes with software library for error-correction
 	(BCHx_HW_DETECTION_SW). The error correction capability with software
diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
index 0df79d9e07ec..319ab8e0f19a 100644
--- a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -13,7 +13,7 @@ Required properties:
 Optional properties:
 
 - zii,eeprom-name: Unique EEPROM identifier describing its function in the
-  system. Will be used as created NVMEM deivce's name.
+  system. Will be used as created NVMEM device's name.
 
 Data cells:
 
diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index 7556be6e2754..43aa2b888ede 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -95,7 +95,7 @@ patternProperties:
   # It's pretty scary, but the basic idea is that:
   #   - One node name can start with either s- or r- for PRCM nodes,
   #   - Then, the name itself can be any repetition of <string>- (to
-  #     accomodate with nodes like uart4-rts-cts-pins), where each
+  #     accommodate with nodes like uart4-rts-cts-pins), where each
   #     string can be either starting with 'p' but in a string longer
   #     than 3, or something that doesn't start with 'p',
   #   - Then, the bank name is optional and will be between pa and pg,
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
index fa37733e5102..a22b48a762e1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.txt
@@ -139,17 +139,17 @@ to specify in a pin configuration subnode:
 - bias-disable:
 	Usage: optional
 	Value type: <none>
-	Definition: The specified pins should be configued as no pull.
+	Definition: The specified pins should be configured as no pull.
 
 - bias-pull-down:
 	Usage: optional
 	Value type: <none>
-	Definition: The specified pins should be configued as pull down.
+	Definition: The specified pins should be configured as pull down.
 
 - bias-pull-up:
 	Usage: optional
 	Value type: <none>
-	Definition: The specified pins should be configued as pull up.
+	Definition: The specified pins should be configured as pull up.
 
 - output-high:
 	Usage: optional
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-pinctrl.txt
index fd3696eb36bf..a587dfbd9c41 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-pinctrl.txt
@@ -115,7 +115,7 @@ function or a GPIO controller alternatively.
 
   Optional generic properties:
     - input-enable:
-      enable input bufer for pins requiring software driven IO input
+      enable input buffer for pins requiring software driven IO input
       operations.
     - output-high:
       enable output buffer for pins requiring software driven IO output
diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
index 86945502ccb5..61a0ff33e89f 100644
--- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
+++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
@@ -43,7 +43,7 @@ Required properties:
 			    Cell #6 : bit position of the reset in the
 			              reset status register
 			    Cell #7 : Flags used to control reset behavior,
-			              availible flags defined in the DT include
+			              available flags defined in the DT include
 			              file <dt-bindings/reset/ti-syscon.h>
 
 SysCon Reset Consumer Nodes
diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
index 7915897f8a81..8eb0bdf9e25f 100644
--- a/Documentation/devicetree/bindings/sound/cs35l35.txt
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -82,7 +82,7 @@ Optional H/G Algorithm sub-node:
 Optional properties for the "cirrus,classh-internal-algo" Sub-node
 
   Section 7.29 Class H Control
-  - cirrus,classh-bst-overide : Boolean
+  - cirrus,classh-bst-override : Boolean
   - cirrus,classh-bst-max-limit
   - cirrus,classh-mem-depth
 
@@ -155,7 +155,7 @@ cs35l35: cs35l35@20 {
 	cirrus,shared-boost;
 
 	cirrus,classh-internal-algo {
-		cirrus,classh-bst-overide;
+		cirrus,classh-bst-override;
 		cirrus,classh-bst-max-limit = <0x01>;
 		cirrus,classh-mem-depth = <0x01>;
 		cirrus,classh-release-rate = <0x08>;
diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 560762e0a168..f548e6a58240 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -1,7 +1,7 @@
 Mediatek AFE PCM controller for mt2701
 
 Required properties:
-- compatible: should be one of the followings.
+- compatible: should be one of the following.
 	      - "mediatek,mt2701-audio"
 	      - "mediatek,mt7622-audio"
 - interrupts: should contain AFE and ASYS interrupts
diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index e7d17dda55db..1973c0da4cc0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -35,7 +35,7 @@ Optional Properties:
  - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
 			     detection on headset when the mbhc is powered up
 			     by internal current source, this is a low power.
- - qcom,mbhc-vthreshold-high: Array of 5 thresold voltages in mV for 5 buttons
+ - qcom,mbhc-vthreshold-high: Array of 5 threshold voltages in mV for 5 buttons
 			      detection on headset when mbhc is powered up
 			       from micbias.
 - qcom,micbias-lvl:  Voltage (mV) for Mic Bias
diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
index 4b23e84b2e57..fbbcade2181d 100644
--- a/Documentation/devicetree/bindings/sound/sprd-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
@@ -1,4 +1,4 @@
-* Spreadtrum DMA platfrom bindings
+* Spreadtrum DMA platform bindings
 
 Required properties:
 - compatible: Should be "sprd,pcm-platform".
diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index c5b5b4260496..d78671d8b6ab 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -32,7 +32,7 @@ properties:
   reg:
     maxItems: 1
     description: |
-       I2C addresss of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
 
   reset-gpios:
     description: |
diff --git a/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt b/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
index b2d07ad90e9a..201e0c3ec710 100644
--- a/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
+++ b/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
@@ -9,7 +9,7 @@ Required properties:
 Optional properties:
 
 - interrupts : The interrupt number of the first timer.
-- reg : The interrupt acknowledgement registers
+- reg : The interrupt acknowledgment registers
 	(always after timer base address)
 
 If any of the optional properties are not given, the timer is added as a
diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 9809f593c0ab..81513736fc34 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -488,7 +488,7 @@ In this case the typical set-up will look like this:
 
 As you can see pretty similar, but you do not supply a parent handler for
 the IRQ, instead a parent irqdomain, an fwnode for the hardware and
-a funcion .child_to_parent_hwirq() that has the purpose of looking up
+a function .child_to_parent_hwirq() that has the purpose of looking up
 the parent hardware irq from a child (i.e. this gpio chip) hardware irq.
 As always it is good to look at examples in the kernel tree for advice
 on how to find the required pieces.
diff --git a/Documentation/driver-api/md/md-cluster.rst b/Documentation/driver-api/md/md-cluster.rst
index 96eb52cec7eb..49f3895465d6 100644
--- a/Documentation/driver-api/md/md-cluster.rst
+++ b/Documentation/driver-api/md/md-cluster.rst
@@ -351,7 +351,7 @@ The algorithm is:
  it is bound to the array and, if that succeeds, add_new_disk_finish()
  is called the device is fully added.
 
- When a device is added in acknowledgement to a previous
+ When a device is added in acknowledgment to a previous
  request, or when the device is declared "unavailable",
  new_disk_ack() is called.
 
diff --git a/Documentation/driver-api/md/raid5-cache.rst b/Documentation/driver-api/md/raid5-cache.rst
index d7a15f44a7c3..5f947cbc2e78 100644
--- a/Documentation/driver-api/md/raid5-cache.rst
+++ b/Documentation/driver-api/md/raid5-cache.rst
@@ -81,7 +81,7 @@ The write-through and write-back cache use the same disk format. The cache disk
 is organized as a simple write log. The log consists of 'meta data' and 'data'
 pairs. The meta data describes the data. It also includes checksum and sequence
 ID for recovery identification. Data can be IO data and parity data. Data is
-checksumed too. The checksum is stored in the meta data ahead of the data. The
+checksummed too. The checksum is stored in the meta data ahead of the data. The
 checksum is an optimization because MD can write meta and data freely without
 worry about the order. MD superblock has a field pointed to the valid meta data
 of log head.
diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 79c0fd39f2af..5f047fb9ade2 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -757,12 +757,12 @@ internally with a static identifier::
           char devname[50];
 
           snprintf(devname, sizeof(devname), "namespace%d.%d",
-                          ndctl_region_get_id(region), paramaters->id);
+                          ndctl_region_get_id(region), parameters->id);
 
           ndctl_namespace_set_alt_name(ndns, devname);
           /* 'uuid' must be set prior to setting size! */
-          ndctl_namespace_set_uuid(ndns, paramaters->uuid);
-          ndctl_namespace_set_size(ndns, paramaters->size);
+          ndctl_namespace_set_uuid(ndns, parameters->uuid);
+          ndctl_namespace_set_size(ndns, parameters->size);
           /* unlike pmem namespaces, blk namespaces have a sector size */
           if (parameters->lbasize)
                   ndctl_namespace_set_sector_size(ndns, parameters->lbasize);
diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
index 3f6dfb0b3ea6..136cb0972bbe 100644
--- a/Documentation/driver-api/thermal/intel_powerclamp.rst
+++ b/Documentation/driver-api/thermal/intel_powerclamp.rst
@@ -85,7 +85,7 @@ migrated, unless the CPU is taken offline. In this case, threads
 belong to the offlined CPUs will be terminated immediately.
 
 Running as SCHED_FIFO and relatively high priority, also allows such
-scheme to work for both preemptable and non-preemptable kernels.
+scheme to work for both preemptible and non-preemptable kernels.
 Alignment of idle time around jiffies ensures scalability for HZ
 values. This effect can be better visualized using a Perf timechart.
 The following diagram shows the behavior of kernel thread
@@ -233,7 +233,7 @@ The maximum range that idle injection is allowed is capped at 50
 percent. As mentioned earlier, since interrupts are allowed during
 forced idle time, excessive interrupts could result in less
 effectiveness. The extreme case would be doing a ping -f to generated
-flooded network interrupts without much CPU acknowledgement. In this
+flooded network interrupts without much CPU acknowledgment. In this
 case, little can be done from the idle injection threads. In most
 normal cases, such as scp a large file, applications can be throttled
 by the powerclamp driver, since slowing down the CPU also slows down
diff --git a/Documentation/driver-api/usb/usb3-debug-port.rst b/Documentation/driver-api/usb/usb3-debug-port.rst
index b9fd131f4723..d4610457b052 100644
--- a/Documentation/driver-api/usb/usb3-debug-port.rst
+++ b/Documentation/driver-api/usb/usb3-debug-port.rst
@@ -48,7 +48,7 @@ kernel boot parameter::
 	"earlyprintk=xdbc"
 
 If there are multiple xHCI controllers in your system, you can
-append a host contoller index to this kernel parameter. This
+append a host controller index to this kernel parameter. This
 index starts from 0.
 
 Current design doesn't support DbC runtime suspend/resume. As
diff --git a/Documentation/fb/udlfb.rst b/Documentation/fb/udlfb.rst
index 732b37db3504..d25cf0bcde4b 100644
--- a/Documentation/fb/udlfb.rst
+++ b/Documentation/fb/udlfb.rst
@@ -159,4 +159,4 @@ metrics_reset		 Write-only. Any write to this file resets all metrics
 			 period of time (one minute or less is safe).
 ======================== ========================================================
 
-Bernie Thompson <bernie@plugable.com>
+Bernie Thompson <bernie@pluggable.com>
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 93e55d7c1d40..4a1aa8fe5337 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -752,7 +752,7 @@ The ``s_default_mount_opts`` field is any combination of the following:
    * - 0x0010
      - Do not support 32-bit UIDs. (EXT4\_DEFM\_UID16)
    * - 0x0020
-     - All data and metadata are commited to the journal.
+     - All data and metadata are committed to the journal.
        (EXT4\_DEFM\_JMODE\_DATA)
    * - 0x0040
      - All data are flushed to the disk before metadata are committed to the
diff --git a/Documentation/filesystems/fsinfo.rst b/Documentation/filesystems/fsinfo.rst
index 65d88e5a36bc..71b4052c265b 100644
--- a/Documentation/filesystems/fsinfo.rst
+++ b/Documentation/filesystems/fsinfo.rst
@@ -63,7 +63,7 @@ following types:
    this depends on the kernel being able to allocate an internal buffer large
    enough.
 
-Value type is an inherent propery of an attribute and all the values of an
+Value type is an inherent property of an attribute and all the values of an
 attribute must be of that type.  Each attribute can have a single value, a
 sequence of values or a sequence-of-sequences of values.
 
diff --git a/Documentation/filesystems/orangefs.rst b/Documentation/filesystems/orangefs.rst
index 463e37694250..931159e61796 100644
--- a/Documentation/filesystems/orangefs.rst
+++ b/Documentation/filesystems/orangefs.rst
@@ -274,7 +274,7 @@ then contains:
     of kcalloced memory. This memory is used as an array of pointers
     to each of the pages in the IO buffer through a call to get_user_pages.
   * desc_array - a pointer to ``desc_count * (sizeof(struct orangefs_bufmap_desc))``
-    bytes of kcalloced memory. This memory is further intialized:
+    bytes of kcalloced memory. This memory is further initialized:
 
       user_desc is the kernel's copy of the IO buffer's ORANGEFS_dev_map_desc
       structure. user_desc->ptr points to the IO buffer.
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 996f3cfe7030..d330470ac12b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -544,7 +544,7 @@ encoded manner. The codes are the following:
     mm    mixed map area
     hg    huge page advise flag
     nh    no huge page advise flag
-    mg    mergable advise flag
+    mg    mergeable advise flag
     bt  - arm64 BTI guarded page
     ==    =======================================
 
diff --git a/Documentation/filesystems/spufs/spu_create.rst b/Documentation/filesystems/spufs/spu_create.rst
index 83108c099696..7f6cafcd0830 100644
--- a/Documentation/filesystems/spufs/spu_create.rst
+++ b/Documentation/filesystems/spufs/spu_create.rst
@@ -114,7 +114,7 @@ Files
 Conforming to
 =============
        This call is Linux specific and only implemented by the ppc64 architec-
-       ture. Programs using this system call are not portable.
+       true. Programs using this system call are not portable.
 
 
 Bugs
diff --git a/Documentation/filesystems/spufs/spu_run.rst b/Documentation/filesystems/spufs/spu_run.rst
index 7fdb1c31cb91..5c7689b25bef 100644
--- a/Documentation/filesystems/spufs/spu_run.rst
+++ b/Documentation/filesystems/spufs/spu_run.rst
@@ -121,7 +121,7 @@ Notes
 Conforming to
 =============
        This call is Linux specific and only implemented by the ppc64 architec-
-       ture. Programs using this system call are not portable.
+       true. Programs using this system call are not portable.
 
 
 Bugs
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 16efd729bf7c..16dbc28942ec 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -128,7 +128,7 @@ marked as dirty are written to the flash to update the persisted index.
 Journal
 ~~~~~~~
 
-To avoid wearing out the flash, the index is only persisted (*commited*) when
+To avoid wearing out the flash, the index is only persisted (*committed*) when
 certain conditions are met (eg. ``fsync(2)``). The journal is used to record
 any changes (in form of inode nodes, data nodes etc.) between commits
 of the index. During mount, the journal is read from the flash and replayed
diff --git a/Documentation/firmware-guide/acpi/acpi-lid.rst b/Documentation/firmware-guide/acpi/acpi-lid.rst
index 874ce0ed340d..97476173bede 100644
--- a/Documentation/firmware-guide/acpi/acpi-lid.rst
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -34,7 +34,7 @@ state upon the last _LID evaluation. There won't be difference when the
 _LID control method is evaluated during the runtime, the problem is its
 initial returning value. When the AML tables implement this control method
 with cached value, the initial returning value is likely not reliable.
-There are platforms always retun "closed" as initial lid state.
+There are platforms always return "closed" as initial lid state.
 
 Restrictions of the lid state change notifications
 ==================================================
@@ -100,7 +100,7 @@ use the following kernel parameter:
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
-   ensure that the reliable "closed" notifications can always be delievered
+   ensure that the reliable "closed" notifications can always be delivered
    to the userspace by always pairing "closed" input events with complement
    "opened" input events. But there is still no guarantee that the "opened"
    notifications can be delivered to the userspace when the lid is actually
diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index bb6d74f23ee0..bee85e54ae3c 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -191,7 +191,7 @@ The driver might expect to get the right GPIO when it does::
 but since there is no way to know the mapping between "reset" and
 the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
 
-The driver author can solve this by passing the mapping explictly
+The driver author can solve this by passing the mapping explicitly
 (the recommended way and documented in the above chapter).
 
 The ACPI GPIO mapping tables should not contaminate drivers that are not
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 658b52f7ffc6..2cf1d69a48a1 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -164,7 +164,7 @@ Contact: Daniel Vetter, respective driver maintainers
 
 Level: Advanced
 
-Convert logging to drm_* functions with drm_device paramater
+Convert logging to drm_* functions with drm_device parameter
 ------------------------------------------------------------
 
 For drivers which could have multiple instances, it is necessary to
diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 0fe526f36db6..74d1d36e9d77 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -83,7 +83,7 @@ verifications. Generally, HID calls operating on asynchronous channels must be
 running in atomic-context just fine.
 On the other hand, synchronous channels can be implemented by the transport
 driver in whatever way they like. They might just be the same as asynchronous
-channels, but they can also provide acknowledgement reports, automatic
+channels, but they can also provide acknowledgment reports, automatic
 retransmission on failure, etc. in a blocking manner. If such functionality is
 required on asynchronous channels, a transport-driver must implement that via
 its own worker threads.
@@ -144,7 +144,7 @@ allowed on the intr channel and are the only means of data there.
 
  - GET_REPORT: A GET_REPORT request has a report ID as payload and is sent
    from host to device. The device must answer with a data report for the
-   requested report ID on the ctrl channel as a synchronous acknowledgement.
+   requested report ID on the ctrl channel as a synchronous acknowledgment.
    Only one GET_REPORT request can be pending for each device. This restriction
    is enforced by HID core as several transport drivers don't allow multiple
    simultaneous GET_REPORT requests.
@@ -165,8 +165,8 @@ allowed on the intr channel and are the only means of data there.
    according to the given data. Any of the 3 report types can be used. However,
    INPUT reports as payload might be blocked by the underlying transport driver
    if the specification does not allow them.
-   A device must answer with a synchronous acknowledgement. However, HID core
-   does not require transport drivers to forward this acknowledgement to HID
+   A device must answer with a synchronous acknowledgment. However, HID core
+   does not require transport drivers to forward this acknowledgment to HID
    core.
    Same as for GET_REPORT, only one SET_REPORT can be pending at a time. This
    restriction is enforced by HID core as some transport drivers do not support
diff --git a/Documentation/hwmon/abituguru-datasheet.rst b/Documentation/hwmon/abituguru-datasheet.rst
index 6d5253e2223b..f5ced7b18fdb 100644
--- a/Documentation/hwmon/abituguru-datasheet.rst
+++ b/Documentation/hwmon/abituguru-datasheet.rst
@@ -155,7 +155,7 @@ After wider testing of the Linux kernel driver some variants of the uGuru have
 turned up which do not hold 0x08 at DATA within 250 reads after writing the
 bank address. With these versions this happens quite frequent, using larger
 timeouts doesn't help, they just go offline for a second or 2, doing some
-internal callibration or whatever. Your code should be prepared to handle
+internal calibration or whatever. Your code should be prepared to handle
 this and in case of no response in this specific case just goto sleep for a
 while and then retry.
 
diff --git a/Documentation/input/devices/elantech.rst b/Documentation/input/devices/elantech.rst
index c3374a7ce7af..98163a258b83 100644
--- a/Documentation/input/devices/elantech.rst
+++ b/Documentation/input/devices/elantech.rst
@@ -556,7 +556,7 @@ Note on debounce:
 In case the box has unstable power supply or other electricity issues, or
 when number of finger changes, F/W would send "debounce packet" to inform
 driver that the hardware is in debounce status.
-The debouce packet has the following signature::
+The debounce packet has the following signature::
 
     byte 0: 0xc4
     byte 1: 0xff
diff --git a/Documentation/isdn/credits.rst b/Documentation/isdn/credits.rst
index 319323f2091f..fe7eb32bc973 100644
--- a/Documentation/isdn/credits.rst
+++ b/Documentation/isdn/credits.rst
@@ -53,7 +53,7 @@ Thomas Neumann (tn@ruhr.de)
 Jan den Ouden (denouden@groovin.xs4all.nl)
   For contribution of the original teles-driver
 
-Carsten Paeth (calle@calle.in-berlin.de)
+Carsten Paeth (called@calle.in-berlin.de)
   For the AVM-B1-CAPI2.0 driver
 
 Thomas Pfeiffer (pfeiffer@pds.de)
diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index eed2136d847f..d27aa35fa9a4 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -42,7 +42,7 @@ no other softirq will preempt it, but a hardware interrupt can. However,
 any other CPUs in the system execute independently.
 
 We'll see a number of ways that the user context can block interrupts,
-to become truly non-preemptable.
+to become truly non-preemptible.
 
 User Context
 ------------
diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index 23fcbc4d3fc0..8f522fee21a2 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -102,7 +102,7 @@ exact case is for the lock as of the reporting time.
   +--------------+-------------+--------------+
 
 The character '-' suggests irq is disabled because if otherwise the
-charactor '?' would have been shown instead. Similar deduction can be
+character '?' would have been shown instead. Similar deduction can be
 applied for '+' too.
 
 Unused locks (e.g., mutexes) cannot be part of the cause of an error.
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index b72f89d5694c..3144ca8cda4a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1760,7 +1760,7 @@ skip_notify_on_dev_down - BOOLEAN
 
 nexthop_compat_mode - BOOLEAN
 	New nexthop API provides a means for managing nexthops independent of
-	prefixes. Backwards compatibilty with old route format is enabled by
+	prefixes. Backwards compatibility with old route format is enabled by
 	default which means route dumps and notifications contain the new
 	nexthop attribute but also the full, expanded nexthop definition.
 	Further, updates or deletes of a nexthop configuration generate route
diff --git a/Documentation/networking/snmp_counter.rst b/Documentation/networking/snmp_counter.rst
index 4edd0d38779e..5a734df80c3e 100644
--- a/Documentation/networking/snmp_counter.rst
+++ b/Documentation/networking/snmp_counter.rst
@@ -1163,7 +1163,7 @@ The server side nstat output::
   IpExtOutOctets                  52                 0.0
   IpExtInNoECTPkts                1                  0.0
 
-Input a string in nc client side again ('world' in our exmaple)::
+Input a string in nc client side again ('world' in our example)::
 
   nstatuser@nstat-a:~$ nc -v nstat-b 9000
   Connection to nstat-b 9000 port [tcp/*] succeeded!
@@ -1685,7 +1685,7 @@ Send 3 SYN repeatly to nstat-b::
 
   nstatuser@nstat-a:~$ for i in {1..3}; do sudo tcpreplay -i ens3 /tmp/syn_fixcsum.pcap; done
 
-Check snmp cunter on nstat-b::
+Check snmp counter on nstat-b::
 
   nstatuser@nstat-b:~$ nstat | grep -i skip
   TcpExtTCPACKSkippedSynRecv      1                  0.0
diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
index 4b2c437942a0..b9ad6adcc5e5 100644
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -106,7 +106,7 @@ History
 	a much improved version with changes all around.
 
 10-04-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	alot of bugfixes all over.
+	a lot of bugfixes all over.
 	ethernet support, functional http and telnet servers.
 	running many standard linux apps.
 
diff --git a/Documentation/powerpc/vas-api.rst b/Documentation/powerpc/vas-api.rst
index 1217c2f1595e..a48b61499628 100644
--- a/Documentation/powerpc/vas-api.rst
+++ b/Documentation/powerpc/vas-api.rst
@@ -228,7 +228,7 @@ issued. This signal returns with the following siginfo struct:
 	siginfo.si_signo = SIGSEGV;
 	siginfo.si_errno = EFAULT;
 	siginfo.si_code = SEGV_MAPERR;
-	siginfo.si_addr = CSB adress;
+	siginfo.si_addr = CSB address;
 
 In the case of multi-thread applications, NX send windows can be shared
 across all threads. For example, a child thread can open a send window,
diff --git a/Documentation/process/clang-format.rst b/Documentation/process/clang-format.rst
index 6710c0707721..042b49d469c6 100644
--- a/Documentation/process/clang-format.rst
+++ b/Documentation/process/clang-format.rst
@@ -97,7 +97,7 @@ it can be very useful.
 
 There are integrations for many popular text editors. For some of them,
 like vim, emacs, BBEdit and Visual Studio you can find support built-in.
-For instructions, read the appropiate section at:
+For instructions, read the appropriate section at:
 
     https://clang.llvm.org/docs/ClangFormat.html
 
diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 43cdc67e4f8e..6f3914a801b5 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -152,7 +152,7 @@ The disclosing party should provide a list of contacts for all other
 entities who have already been, or should be, informed about the issue.
 This serves several purposes:
 
- - The list of disclosed entities allows communication accross the
+ - The list of disclosed entities allows communication across the
    industry, e.g. other OS vendors, HW vendors, etc.
 
  - The disclosed entities can be contacted to name experts who should
@@ -204,9 +204,9 @@ and the disclosing party is requested to acknowledge the participation. In
 case that the disclosing party has a compelling reason to object, then this
 objection has to be raised within five work days and resolved with the
 incident team immediately. If the disclosing party does not react within
-five work days this is taken as silent acknowledgement.
+five work days this is taken as silent acknowledgment.
 
-After acknowledgement or resolution of an objection the expert is disclosed
+After acknowledgment or resolution of an objection the expert is disclosed
 by the incident team and brought into the development process.
 
 
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1699b7f8e63a..cb82a7828d12 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -531,9 +531,9 @@ mergers will sometimes manually convert an acker's "yep, looks good to me"
 into an Acked-by: (but note that it is usually better to ask for an
 explicit ack).
 
-Acked-by: does not necessarily indicate acknowledgement of the entire patch.
+Acked-by: does not necessarily indicate acknowledgment of the entire patch.
 For example, if a patch affects multiple subsystems and has an Acked-by: from
-one subsystem maintainer then this usually indicates acknowledgement of just
+one subsystem maintainer then this usually indicates acknowledgment of just
 the part which affects that maintainer's code.  Judgement should be used here.
 When in doubt people should refer to the original discussion in the mailing
 list archives.
diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index cdc42ccc12e4..2279cacc70d8 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -869,7 +869,7 @@ The keyctl syscall functions are:
 
 	 - ``char *hashname`` specifies the NUL terminated string identifying
 	   the hash used from the kernel crypto API and applied for the KDF
-	   operation. The KDF implemenation complies with SP800-56A as well
+	   operation. The KDF implementation complies with SP800-56A as well
 	   as with SP800-108 (the counter KDF).
 
 	 - ``char *otherinfo`` specifies the OtherInfo data as documented in
diff --git a/Documentation/sound/designs/seq-oss.rst b/Documentation/sound/designs/seq-oss.rst
index e82ffe0e7f43..ec6304a07441 100644
--- a/Documentation/sound/designs/seq-oss.rst
+++ b/Documentation/sound/designs/seq-oss.rst
@@ -96,7 +96,7 @@ if you use an AWE64 card, you'll see like the following:
     Number of synth devices: 1
     synth 0: [EMU8000]
       type 0x1 : subtype 0x20 : voices 32
-      capabilties : ioctl enabled / load_patch enabled
+      capabilities : ioctl enabled / load_patch enabled
 
     Number of MIDI devices: 3
     midi 0: [Emu8000 Port-0] ALSA port 65:0
diff --git a/Documentation/sparc/oradax/dax-hv-api.txt b/Documentation/sparc/oradax/dax-hv-api.txt
index 73e8d506cf64..794e36ca9223 100644
--- a/Documentation/sparc/oradax/dax-hv-api.txt
+++ b/Documentation/sparc/oradax/dax-hv-api.txt
@@ -22,7 +22,7 @@ Chapter 36. Coprocessor services
         functionality offered may vary by virtual machine implementation.
 
         The DAX is a virtual device to sun4v guests, with supported data operations indicated by the virtual device
-        compatibilty property. Functionality is accessed through the submission of Command Control Blocks
+        compatibility property. Functionality is accessed through the submission of Command Control Blocks
         (CCBs) via the ccb_submit API function. The operations are processed asynchronously, with the status
         of the submitted operations reported through a Completion Area linked to each CCB. Each CCB has a
         separate Completion Area and, unless execution order is specifically restricted through the use of serial-
@@ -690,24 +690,24 @@ Offset   Size   Field Description
 48       8      Output (same fields as Primary Input)
 56       8      Symbol Table (if used by Primary Input). Same fields as Section 36.2.1.2,
                 “Extract command”
-64       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+64       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 40, if needed by the operand size. If first operand
                 is less than 8 bytes, the valid bytes are left-aligned to the lowest address.
-68       4      Next 4 most significant bytes of second scan criteria operand occuring after
+68       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 44, if needed by the operand size. If second
                 operand is less than 8 bytes, the valid bytes are left-aligned to the lowest
                 address.
-72       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+72       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 64, if needed by the operand size. If first operand
                 is less than 12 bytes, the valid bytes are left-aligned to the lowest address.
-76       4      Next 4 most significant bytes of second scan criteria operand occuring after
+76       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 68, if needed by the operand size. If second
                 operand is less than 12 bytes, the valid bytes are left-aligned to the lowest
                 address.
-80       4      Next 4 most significant bytes of first scan criteria operand occuring after the
+80       4      Next 4 most significant bytes of first scan criteria operand occurring after the
                 bytes specified at offset 72, if needed by the operand size. If first operand
                 is less than 16 bytes, the valid bytes are left-aligned to the lowest address.
-84       4      Next 4 most significant bytes of second scan criteria operand occuring after
+84       4      Next 4 most significant bytes of second scan criteria operand occurring after
                 the bytes specified at offset 76, if needed by the operand size. If second
                 operand is less than 16 bytes, the valid bytes are left-aligned to the lowest
                 address.
@@ -1343,7 +1343,7 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.
           EBADALIGN                 address is not on a 64-byte aligned.
           ENORADDR                  The real address provided for address is not valid.
           EINVAL                    The CCB completion area contents are not valid.
-          EWOULDBLOCK               Internal resource contraints prevented the CCB state from being queried at this
+          EWOULDBLOCK               Internal resource constraints prevented the CCB state from being queried at this
                                     time. The guest should retry the request.
           ENOACCESS                 The guest does not have permission to access the coprocessor virtual device
                                     functionality.
@@ -1405,7 +1405,7 @@ EUNAVAILABLE   The requested CCB operation could not be performed at this time.
           EBADALIGN                  address is not on a 64-byte aligned.
           ENORADDR                   The real address provided for address is not valid.
           EINVAL                     The CCB completion area contents are not valid.
-          EWOULDBLOCK                Internal resource contraints prevented the CCB from being killed at this time.
+          EWOULDBLOCK                Internal resource constraints prevented the CCB from being killed at this time.
                                      The guest should retry the request.
           ENOACCESS                  The guest does not have permission to access the coprocessor virtual device
                                      functionality.
diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index f05dbc5ccdbc..7b07b0e971e0 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -139,7 +139,7 @@ NOTES:
       to the SPI device.  It defaults to one page, but that can be changed
       using a module parameter.
 
-    - Because SPI has no low-level transfer acknowledgement, you usually
+    - Because SPI has no low-level transfer acknowledgment, you usually
       won't see any I/O errors when talking to a non-existent device.
 
 
diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
index 5739349649c8..f7811e2ddf34 100644
--- a/Documentation/trace/hwlat_detector.rst
+++ b/Documentation/trace/hwlat_detector.rst
@@ -14,7 +14,7 @@ originally written for use by the "RT" patch since the Real Time
 kernel is highly latency sensitive.
 
 SMIs are not serviced by the Linux kernel, which means that it does not
-even know that they are occuring. SMIs are instead set up by BIOS code
+even know that they are occurring. SMIs are instead set up by BIOS code
 and are serviced by BIOS code, usually for "critical" events such as
 management of thermal sensors and fans. Sometimes though, SMIs are used for
 other tasks and those tasks can spend an inordinate amount of time in the
diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
index 988c832166cd..194cc4fcbc02 100644
--- a/Documentation/usb/usbip_protocol.rst
+++ b/Documentation/usb/usbip_protocol.rst
@@ -401,7 +401,7 @@ USBIP_RET_UNLINK:
 | 0x10      | 4      |            | ep: endpoint number                               |
 +-----------+--------+------------+---------------------------------------------------+
 | 0x14      | 4      |            | status: This is the value contained in the        |
-|           |        |            | urb->status in the URB completition handler.      |
+|           |        |            | urb->status in the URB completion handler.        |
 |           |        |            |                                                   |
 |           |        |            | FIXME:                                            |
 |           |        |            |      a better explanation needed.                 |
diff --git a/Documentation/userspace-api/media/v4l/hist-v4l2.rst b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
index 7913d017cd33..179b827b1c72 100644
--- a/Documentation/userspace-api/media/v4l/hist-v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
@@ -54,7 +54,7 @@ Codec API was released.
 1998-11-08: Many minor changes. Most symbols have been renamed. Some
 material changes to struct :c:type:`v4l2_capability`.
 
-1998-11-12: The read/write directon of some ioctls was misdefined.
+1998-11-12: The read/write direction of some ioctls was misdefined.
 
 1998-11-14: ``V4L2_PIX_FMT_RGB24`` changed to ``V4L2_PIX_FMT_BGR24``,
 and ``V4L2_PIX_FMT_RGB32`` changed to ``V4L2_PIX_FMT_BGR32``. Audio
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 426f94582b7a..dc31d38a9c54 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6037,7 +6037,7 @@ writing to the respective MSRs.
 
 This capability indicates that userspace can load HV_X64_MSR_VP_INDEX msr.  Its
 value is used to denote the target vcpu for a SynIC interrupt.  For
-compatibilty, KVM initializes this msr to KVM's internal vcpu index.  When this
+compatibility, KVM initializes this msr to KVM's internal vcpu index.  When this
 capability is absent, userspace can still query this msr's value.
 
 8.13 KVM_CAP_S390_AIS_MIGRATION
diff --git a/Documentation/virt/kvm/halt-polling.rst b/Documentation/virt/kvm/halt-polling.rst
index 4922e4a15f18..c428d319de45 100644
--- a/Documentation/virt/kvm/halt-polling.rst
+++ b/Documentation/virt/kvm/halt-polling.rst
@@ -14,7 +14,7 @@ before giving up the cpu to the scheduler in order to let something else run.
 Polling provides a latency advantage in cases where the guest can be run again
 very quickly by at least saving us a trip through the scheduler, normally on
 the order of a few micro-seconds, although performance benefits are workload
-dependant. In the event that no wakeup source arrives during the polling
+dependent. In the event that no wakeup source arrives during the polling
 interval or some other task on the runqueue is runnable the scheduler is
 invoked. Thus halt polling is especially useful on workloads with very short
 wakeup periods where the time spent halt polling is minimised and the time
diff --git a/Documentation/virt/kvm/running-nested-guests.rst b/Documentation/virt/kvm/running-nested-guests.rst
index d0a1fc754c84..c8fe0c339227 100644
--- a/Documentation/virt/kvm/running-nested-guests.rst
+++ b/Documentation/virt/kvm/running-nested-guests.rst
@@ -167,7 +167,7 @@ Enabling "nested" (s390x)
     $ modprobe kvm nested=1
 
 .. note:: On s390x, the kernel parameter ``hpage`` is mutually exclusive
-          with the ``nested`` paramter — i.e. to be able to enable
+          with the ``nested`` parameter — i.e. to be able to enable
           ``nested``, the ``hpage`` parameter *must* be disabled.
 
 2. The guest hypervisor (L1) must be provided with the ``sie`` CPU


