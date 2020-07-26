Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02220C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C565720658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGZKTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgGZKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:19:32 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD3C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:19:32 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B04616F63D;
        Sun, 26 Jul 2020 10:19:27 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] MAINTAINERS: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 12:19:20 +0200
Message-Id: <20200726101920.15955-1-grandmaster@al2klimov.de>
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

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 MAINTAINERS | 170 ++++++++++++++++++++++++++--------------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..0f08e52b3aa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,7 +323,7 @@ ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
 M:	Peter Kaestle <peter@piie.net>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-W:	http://piie.net/?section=acerhdf
+W:	https://piie.net/?section=acerhdf
 F:	drivers/platform/x86/acerhdf.c
 
 ACER WMI LAPTOP EXTRAS
@@ -1103,7 +1103,7 @@ M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-W:	http://wiki.analog.com/
+W:	https://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	sound/soc/codecs/ad1*
 F:	sound/soc/codecs/ad7*
@@ -1131,7 +1131,7 @@ ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 S:	Supported
-W:	http://wiki.analog.com/
+W:	https://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
@@ -1432,7 +1432,7 @@ ARM PORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git
 F:	arch/arm/
 X:	arch/arm/boot/dts/
@@ -1787,7 +1787,7 @@ N:	[^a-z]sirf
 ARM/CZ.NIC TURRIS MOX SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 S:	Maintained
-W:	http://mox.turris.cz
+W:	https://mox.turris.cz
 F:	Documentation/ABI/testing/debugfs-moxtet
 F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/ABI/testing/sysfs-firmware-turris-mox-rwtm
@@ -1803,7 +1803,7 @@ ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 F:	arch/arm/mach-ebsa110/
 F:	drivers/net/ethernet/amd/am79c961a.*
 
@@ -1831,7 +1831,7 @@ ARM/FOOTBRIDGE ARCHITECTURE
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 F:	arch/arm/include/asm/hardware/dec21285.h
 F:	arch/arm/mach-footbridge/
 
@@ -2188,7 +2188,7 @@ ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.digriz.org.uk/ts78xx/kernel
+W:	https://www.digriz.org.uk/ts78xx/kernel
 F:	arch/arm/mach-orion5x/ts78xx-*
 
 ARM/OXNAS platform support
@@ -2238,7 +2238,7 @@ ARM/PT DIGITAL BOARD PORT
 M:	Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
@@ -2327,7 +2327,7 @@ ARM/RISCPC ARCHITECTURE
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 F:	arch/arm/include/asm/hardware/entry-macro-iomd.S
 F:	arch/arm/include/asm/hardware/ioc.h
 F:	arch/arm/include/asm/hardware/iomd.h
@@ -2656,7 +2656,7 @@ ARM/VFP SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 F:	arch/arm/vfp/
 
 ARM/VOIPAC PXA270 SUPPORT
@@ -3113,7 +3113,7 @@ M:	Coly Li <colyli@suse.de>
 M:	Kent Overstreet <kent.overstreet@gmail.com>
 L:	linux-bcache@vger.kernel.org
 S:	Maintained
-W:	http://bcache.evilpiepirate.org
+W:	https://bcache.evilpiepirate.org
 C:	irc://irc.oftc.net/bcache
 F:	drivers/md/bcache/
 
@@ -3585,7 +3585,7 @@ M:	Somnath Kotur <somnath.kotur@broadcom.com>
 M:	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.broadcom.com
+W:	https://www.broadcom.com
 F:	drivers/infiniband/hw/bnxt_re/
 F:	include/uapi/rdma/bnxt_re-abi.h
 
@@ -3893,7 +3893,7 @@ F:	drivers/net/wireless/ath/carl9170/
 CAVIUM I2C DRIVER
 M:	Robert Richter <rrichter@marvell.com>
 S:	Supported
-W:	http://www.marvell.com
+W:	https://www.marvell.com
 F:	drivers/i2c/busses/i2c-octeon*
 F:	drivers/i2c/busses/i2c-thunderx*
 
@@ -3903,20 +3903,20 @@ M:	Satanand Burla <sburla@marvell.com>
 M:	Felix Manlunas <fmanlunas@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.marvell.com
+W:	https://www.marvell.com
 F:	drivers/net/ethernet/cavium/liquidio/
 
 CAVIUM MMC DRIVER
 M:	Robert Richter <rrichter@marvell.com>
 S:	Supported
-W:	http://www.marvell.com
+W:	https://www.marvell.com
 F:	drivers/mmc/host/cavium*
 
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <gcherian@marvell.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
-W:	http://www.marvell.com
+W:	https://www.marvell.com
 F:	drivers/crypto/cavium/cpt/
 
 CAVIUM THUNDERX2 ARM64 SOC
@@ -3954,7 +3954,7 @@ CEC FRAMEWORK
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
 L:	linux-media@vger.kernel.org
 S:	Supported
-W:	http://linuxtv.org
+W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/ABI/testing/debugfs-cec-error-inj
 F:	Documentation/devicetree/bindings/media/cec.txt
@@ -3971,7 +3971,7 @@ CEC GPIO DRIVER
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
 L:	linux-media@vger.kernel.org
 S:	Supported
-W:	http://linuxtv.org
+W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/cec-gpio.txt
 F:	drivers/media/platform/cec-gpio/
@@ -4294,7 +4294,7 @@ M:	Steve French <sfrench@samba.org>
 L:	linux-cifs@vger.kernel.org
 L:	samba-technical@lists.samba.org (moderated for non-subscribers)
 S:	Supported
-W:	http://linux-cifs.samba.org/
+W:	https://linux-cifs.samba.org/
 T:	git git://git.samba.org/sfrench/cifs-2.6.git
 F:	Documentation/admin-guide/cifs/
 F:	fs/cifs/
@@ -4404,7 +4404,7 @@ F:	drivers/hwmon/coretemp.c
 COSA/SRP SYNC SERIAL DRIVER
 M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
 S:	Maintained
-W:	http://www.fi.muni.cz/~kas/cosa/
+W:	https://www.fi.muni.cz/~kas/cosa/
 F:	drivers/net/wan/cosa*
 
 COUNTER SUBSYSTEM
@@ -4541,7 +4541,7 @@ CS3308 MEDIA DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
 S:	Odd Fixes
-W:	http://linuxtv.org
+W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/cs3308.c
 
@@ -4687,7 +4687,7 @@ CYBERPRO FB DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.armlinux.org.uk/
+W:	https://www.armlinux.org.uk/
 F:	drivers/video/fbdev/cyber2000fb.*
 
 CYCLADES ASYNC MUX DRIVER
@@ -4979,7 +4979,7 @@ S:	Maintained
 W:	http://sources.redhat.com/dm
 Q:	http://patchwork.kernel.org/project/dm-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
-T:	quilt http://people.redhat.com/agk/patches/linux/editing/
+T:	quilt https://people.redhat.com/agk/patches/linux/editing/
 F:	Documentation/admin-guide/device-mapper/
 F:	drivers/md/Kconfig
 F:	drivers/md/Makefile
@@ -5001,7 +5001,7 @@ F:	net/core/devlink.c
 DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
-W:	http://www.dialog-semiconductor.com/products
+W:	https://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
@@ -5062,9 +5062,9 @@ F:	include/linux/dnotify.h
 DISK GEOMETRY AND PARTITION HANDLING
 M:	Andries Brouwer <aeb@cwi.nl>
 S:	Maintained
-W:	http://www.win.tue.nl/~aeb/linux/Large-Disk.html
-W:	http://www.win.tue.nl/~aeb/linux/zip/zip-1.html
-W:	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
+W:	https://www.win.tue.nl/~aeb/linux/Large-Disk.html
+W:	https://www.win.tue.nl/~aeb/linux/zip/zip-1.html
+W:	https://www.win.tue.nl/~aeb/partitions/partition_types-1.html
 
 DISKQUOTA
 M:	Jan Kara <jack@suse.com>
@@ -5078,7 +5078,7 @@ DISPLAYLINK USB 2.0 FRAMEBUFFER DRIVER (UDLFB)
 M:	Bernie Thompson <bernie@plugable.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
-W:	http://plugable.com/category/projects/udlfb/
+W:	https://plugable.com/category/projects/udlfb/
 F:	Documentation/fb/udlfb.rst
 F:	drivers/video/fbdev/udlfb.c
 F:	include/video/udlfb.h
@@ -6329,7 +6329,7 @@ M:	Ketan Mukadam <ketan.mukadam@broadcom.com>
 M:	Jitendra Bhivare <jitendra.bhivare@broadcom.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
-W:	http://www.broadcom.com
+W:	https://www.broadcom.com
 F:	drivers/scsi/be2iscsi/
 
 EMULEX 10Gbps NIC BE2, BE3-R, Lancer, Skyhawk-R DRIVER (be2net)
@@ -6346,7 +6346,7 @@ M:	Selvin Xavier <selvin.xavier@broadcom.com>
 M:	Devesh Sharma <devesh.sharma@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Odd Fixes
-W:	http://www.broadcom.com
+W:	https://www.broadcom.com
 F:	drivers/infiniband/hw/ocrdma/
 F:	include/uapi/rdma/ocrdma-abi.h
 
@@ -6355,7 +6355,7 @@ M:	James Smart <james.smart@broadcom.com>
 M:	Dick Kennedy <dick.kennedy@broadcom.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
-W:	http://www.broadcom.com
+W:	https://www.broadcom.com
 F:	drivers/scsi/lpfc/
 
 ENE CB710 FLASH CARD READER DRIVER
@@ -7189,7 +7189,7 @@ F:	include/linux/platform_data/i2c-mux-gpio.h
 GENERIC HDLC (WAN) DRIVERS
 M:	Krzysztof Halasa <khc@pm.waw.pl>
 S:	Maintained
-W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
+W:	https://www.kernel.org/pub/linux/utils/net/hdlc/
 F:	drivers/net/wan/c101.c
 F:	drivers/net/wan/hd6457*
 F:	drivers/net/wan/hdlc*
@@ -7723,7 +7723,7 @@ F:	drivers/net/hamradio/scc.c
 HIGHPOINT ROCKETRAID 3xxx RAID DRIVER
 M:	HighPoint Linux Team <linux@highpoint-tech.com>
 S:	Supported
-W:	http://www.highpoint-tech.com
+W:	https://www.highpoint-tech.com
 F:	Documentation/scsi/hptiop.rst
 F:	drivers/scsi/hptiop.c
 
@@ -7843,7 +7843,7 @@ HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
 L:	linux-wireless@vger.kernel.org
 S:	Obsolete
-W:	http://w1.fi/hostap-driver.html
+W:	https://w1.fi/hostap-driver.html
 F:	drivers/net/wireless/intersil/hostap/
 
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
@@ -7867,7 +7867,7 @@ F:	arch/x86/kernel/hpet.c
 HPFS FILESYSTEM
 M:	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
 S:	Maintained
-W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
+W:	https://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 F:	fs/hpfs/
 
 HSI SUBSYSTEM
@@ -8630,7 +8630,7 @@ M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
 L:	intel-gfx@lists.freedesktop.org
 S:	Supported
 W:	https://01.org/linuxgraphics/
-Q:	http://patchwork.freedesktop.org/project/intel-gfx/
+Q:	https://patchwork.freedesktop.org/project/intel-gfx/
 B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
 C:	irc://chat.freenode.net/intel-gfx
 T:	git git://anongit.freedesktop.org/drm-intel
@@ -8643,7 +8643,7 @@ INTEL ETHERNET DRIVERS
 M:	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
 L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
 S:	Supported
-W:	http://www.intel.com/support/feedback.htm
+W:	https://www.intel.com/support/feedback.htm
 W:	http://e1000.sourceforge.net/
 Q:	http://patchwork.ozlabs.org/project/intel-wired-lan/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git
@@ -9158,7 +9158,7 @@ M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Odd Fixes
-W:	http://www.isdn4linux.de
+W:	https://www.isdn4linux.de
 F:	Documentation/isdn/
 F:	drivers/isdn/capi/
 F:	include/linux/isdn/
@@ -9170,7 +9170,7 @@ M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Maintained
-W:	http://www.isdn4linux.de
+W:	https://www.isdn4linux.de
 F:	drivers/isdn/Kconfig
 F:	drivers/isdn/Makefile
 F:	drivers/isdn/hardware/
@@ -9375,7 +9375,7 @@ F:	scripts/package/
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
 S:	Odd Fixes
-W:	http://kernelnewbies.org/KernelJanitors
+W:	https://kernelnewbies.org/KernelJanitors
 
 KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
 M:	"J. Bruce Fields" <bfields@fieldses.org>
@@ -9479,7 +9479,7 @@ R:	Cornelia Huck <cohuck@redhat.com>
 R:	Claudio Imbrenda <imbrenda@linux.ibm.com>
 L:	kvm@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
 F:	Documentation/virt/kvm/s390*
 F:	arch/s390/include/asm/gmap.h
@@ -9525,7 +9525,7 @@ KEXEC
 M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
-W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+W:	https://kernel.org/pub/linux/utils/kernel/kexec/
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
@@ -10177,7 +10177,7 @@ M:	Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
 M:	Alexey Kodanev <alexey.kodanev@oracle.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
-W:	http://linux-test-project.github.io/
+W:	https://linux-test-project.github.io/
 T:	git git://github.com/linux-test-project/ltp.git
 
 M68K ARCHITECTURE
@@ -10252,7 +10252,7 @@ MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
 M:	Michael Kerrisk <mtk.manpages@gmail.com>
 L:	linux-man@vger.kernel.org
 S:	Maintained
-W:	http://www.kernel.org/doc/man-pages
+W:	https://www.kernel.org/doc/man-pages
 
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
 M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
@@ -10597,7 +10597,7 @@ MEDIA DRIVERS FOR CXD2880
 M:	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
-W:	http://linuxtv.org/
+W:	https://linuxtv.org/
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/dvb-frontends/cxd2880/*
 F:	drivers/media/spi/cxd2880*
@@ -10964,7 +10964,7 @@ MELLANOX ETHERNET DRIVER (mlx4_en)
 M:	Tariq Toukan <tariqt@mellanox.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx4/en_*
 
@@ -10972,7 +10972,7 @@ MELLANOX ETHERNET DRIVER (mlx5e)
 M:	Saeed Mahameed <saeedm@mellanox.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_*
 
@@ -10980,7 +10980,7 @@ MELLANOX ETHERNET INNOVA DRIVERS
 R:	Boris Pismenny <borisp@mellanox.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/accel/*
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_accel/*
@@ -10992,7 +10992,7 @@ M:	Jiri Pirko <jiri@mellanox.com>
 M:	Ido Schimmel <idosch@mellanox.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlxsw/
 F:	tools/testing/selftests/drivers/net/mlxsw/
@@ -11001,7 +11001,7 @@ MELLANOX FIRMWARE FLASH LIBRARY (mlxfw)
 M:	mlxsw@mellanox.com
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlxfw/
 
@@ -11020,7 +11020,7 @@ M:	Tariq Toukan <tariqt@mellanox.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	drivers/net/ethernet/mellanox/mlx4/
 F:	include/linux/mlx4/
@@ -11029,7 +11029,7 @@ MELLANOX MLX4 IB driver
 M:	Yishai Hadas <yishaih@mellanox.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx4/
 F:	include/linux/mlx4/
@@ -11041,7 +11041,7 @@ M:	Leon Romanovsky <leonro@mellanox.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.ozlabs.org/project/netdev/list/
 F:	Documentation/networking/device_drivers/mellanox/
 F:	drivers/net/ethernet/mellanox/mlx5/core/
@@ -11051,7 +11051,7 @@ MELLANOX MLX5 IB driver
 M:	Leon Romanovsky <leonro@mellanox.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.mellanox.com
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx5/
 F:	include/linux/mlx5/
@@ -11101,7 +11101,7 @@ MEMORY MANAGEMENT
 M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-W:	http://www.linux-mm.org
+W:	https://www.linux-mm.org
 T:	quilt https://ozlabs.org/~akpm/mmotm/
 T:	quilt https://ozlabs.org/~akpm/mmots/
 T:	git git://github.com/hnaz/linux-mm.git
@@ -11202,7 +11202,7 @@ F:	include/linux/mhi.h
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 S:	Supported
-W:	http://www.monstr.eu/fdt/
+W:	https://www.monstr.eu/fdt/
 T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 F:	arch/microblaze/
 
@@ -11768,7 +11768,7 @@ NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-W:	http://www.native-instruments.com
+W:	https://www.native-instruments.com
 F:	sound/usb/caiaq/
 
 NATSEMI ETHERNET DRIVER (DP8381x)
@@ -11829,9 +11829,9 @@ M:	Florian Westphal <fw@strlen.de>
 L:	netfilter-devel@vger.kernel.org
 L:	coreteam@netfilter.org
 S:	Maintained
-W:	http://www.netfilter.org/
+W:	https://www.netfilter.org/
 W:	http://www.iptables.org/
-W:	http://www.nftables.org/
+W:	https://www.nftables.org/
 Q:	http://patchwork.ozlabs.org/project/netfilter-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git
@@ -12740,7 +12740,7 @@ M:	Rob Herring <robh+dt@kernel.org>
 M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
-W:	http://www.devicetree.org/
+W:	https://www.devicetree.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
@@ -12773,7 +12773,7 @@ M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 M:	Stafford Horne <shorne@gmail.com>
 L:	openrisc@lists.librecores.org
 S:	Maintained
-W:	http://openrisc.io
+W:	https://openrisc.io
 T:	git git://github.com/openrisc/linux.git
 F:	Documentation/devicetree/bindings/openrisc/
 F:	Documentation/openrisc/
@@ -12842,7 +12842,7 @@ ORINOCO DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/orinoco
-W:	http://www.nongnu.org/orinoco/
+W:	https://www.nongnu.org/orinoco/
 F:	drivers/net/wireless/intersil/orinoco/
 
 OV2659 OMNIVISION SENSOR DRIVER
@@ -13627,7 +13627,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 W:	http://hwmon.wiki.kernel.org/
-W:	http://www.roeck-us.net/linux/drivers/
+W:	https://www.roeck-us.net/linux/drivers/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
 F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -13905,7 +13905,7 @@ M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
 L:	linux-media@vger.kernel.org
 S:	Maintained
-W:	http://www.isely.net/pvrusb2/
+W:	https://www.isely.net/pvrusb2/
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/driver-api/media/drivers/pvrusb2*
 F:	drivers/media/usb/pvrusb2/
@@ -14105,7 +14105,7 @@ F:	drivers/media/tuners/qm1d1c0042*
 QNX4 FILESYSTEM
 M:	Anders Larsen <al@alarsen.net>
 S:	Maintained
-W:	http://www.alarsen.net/linux/qnx4fs/
+W:	https://www.alarsen.net/linux/qnx4fs/
 F:	fs/qnx4/
 F:	include/uapi/linux/qnx4_fs.h
 F:	include/uapi/linux/qnxtypes.h
@@ -14848,7 +14848,7 @@ M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
 F:	Documentation/driver-api/s390-drivers.rst
 F:	Documentation/s390/
@@ -14860,7 +14860,7 @@ M:	Vineeth Vijayan <vneethv@linux.ibm.com>
 M:	Peter Oberparleiter <oberpar@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/cio/
 
 S390 DASD DRIVER
@@ -14868,7 +14868,7 @@ M:	Stefan Haberland <sth@linux.ibm.com>
 M:	Jan Hoeppner <hoeppner@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	block/partitions/ibm.c
 F:	drivers/s390/block/dasd*
 F:	include/linux/dasd_mod.h
@@ -14878,7 +14878,7 @@ M:	Matthew Rosato <mjrosato@linux.ibm.com>
 M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/iommu/s390-iommu.c
 
 S390 IUCV NETWORK LAYER
@@ -14887,7 +14887,7 @@ M:	Karsten Graul <kgraul@linux.ibm.com>
 M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/net/*iucv*
 F:	include/net/iucv/
 F:	net/iucv/
@@ -14898,7 +14898,7 @@ M:	Karsten Graul <kgraul@linux.ibm.com>
 M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/net/
 
 S390 PCI SUBSYSTEM
@@ -14906,7 +14906,7 @@ M:	Niklas Schnelle <schnelle@linux.ibm.com>
 M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	arch/s390/pci/
 F:	drivers/pci/hotplug/s390_pci_hpc.c
 F:	Documentation/s390/pci.rst
@@ -14917,7 +14917,7 @@ M:	Pierre Morel <pmorel@linux.ibm.com>
 M:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	Documentation/s390/vfio-ap.rst
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_ops.c
@@ -14938,7 +14938,7 @@ S390 ZCRYPT DRIVER
 M:	Harald Freudenberger <freude@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/crypto/
 
 S390 ZFCP DRIVER
@@ -14946,7 +14946,7 @@ M:	Steffen Maier <maier@linux.ibm.com>
 M:	Benjamin Block <bblock@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
 S3C24XX SD/MMC Driver
@@ -15448,7 +15448,7 @@ M:	Ursula Braun <ubraun@linux.ibm.com>
 M:	Karsten Graul <kgraul@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-W:	http://www.ibm.com/developerworks/linux/linux390/
+W:	https://www.ibm.com/developerworks/linux/linux390/
 F:	net/smc/
 
 SHARP GP2AP002A00F/GP2AP002S00F SENSOR DRIVER
@@ -17188,7 +17188,7 @@ TI VPE/CAL DRIVERS
 M:	Benoit Parrot <bparrot@ti.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-W:	http://linuxtv.org/
+W:	https://linuxtv.org/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/ti,cal.yaml
 F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
@@ -17328,7 +17328,7 @@ F:	drivers/platform/x86/toshiba_haps.c
 TOSHIBA SMM DRIVER
 M:	Jonathan Buzzard <jonathan@buzzard.org.uk>
 S:	Maintained
-W:	http://www.buzzard.org.uk/toshiba/
+W:	https://www.buzzard.org.uk/toshiba/
 F:	drivers/char/toshiba.c
 F:	include/linux/toshiba.h
 F:	include/uapi/linux/toshiba.h
@@ -17468,7 +17468,7 @@ TW686X VIDEO4LINUX DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-W:	http://linuxtv.org
+W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/pci/tw686x/
 
@@ -17555,7 +17555,7 @@ F:	arch/unicore32/
 UNIFDEF
 M:	Tony Finch <dot@dotat.at>
 S:	Maintained
-W:	http://dotat.at/prog/unifdef
+W:	https://dotat.at/prog/unifdef
 F:	scripts/unifdef.c
 
 UNIFORM CDROM DRIVER
@@ -17886,7 +17886,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-uvc-devel@lists.sourceforge.net (subscribers-only)
 L:	linux-media@vger.kernel.org
 S:	Maintained
-W:	http://www.ideasonboard.org/uvc/
+W:	https://www.ideasonboard.org/uvc/
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/uvc/
 F:	include/uapi/linux/uvcvideo.h
@@ -17976,7 +17976,7 @@ UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
 L:	util-linux@vger.kernel.org
 S:	Maintained
-W:	http://en.wikipedia.org/wiki/Util-linux
+W:	https://en.wikipedia.org/wiki/Util-linux
 T:	git git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git
 
 UUID HELPERS
@@ -18464,7 +18464,7 @@ M:	Wim Van Sebroeck <wim@linux-watchdog.org>
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-watchdog.org/
+W:	https://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
 F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
@@ -18882,7 +18882,7 @@ XLP9XX I2C DRIVER
 M:	George Cherian <gcherian@marvell.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-W:	http://www.marvell.com
+W:	https://www.marvell.com
 F:	Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt
 F:	drivers/i2c/busses/i2c-xlp9xx.c
 
-- 
2.27.0

