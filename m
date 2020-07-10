Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A840C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4092C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGJTny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJTnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:43:53 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFABC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:43:53 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id AE5C0BC071;
        Fri, 10 Jul 2020 19:43:48 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net,
        davej@codemonkey.org.uk, kvalo@codeaurora.org,
        luis.f.correia@gmail.com, cyphar@cyphar.com, paulburton@kernel.org,
        ribalda@kernel.org, martink@posteo.de, geert+renesas@glider.be,
        mchehab+samsung@kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] CREDITS: replace HTTP links with HTTPS ones and add myself
Date:   Fri, 10 Jul 2020 21:43:42 +0200
Message-Id: <20200710194342.33107-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the links:

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

Regarding the addition of myself:

Rationale:
* 93431e0607e5
* the replaced links in this patch

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 CREDITS | 87 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0787b5872906..ae0ea365c0e0 100644
--- a/CREDITS
+++ b/CREDITS
@@ -34,7 +34,7 @@ S: Romania
 
 N: Mark Adler
 E: madler@alumni.caltech.edu
-W: http://alumnus.caltech.edu/~madler/
+W: https://alumnus.caltech.edu/~madler/
 D: zlib decompression
 
 N: Monalisa Agrawal
@@ -62,7 +62,7 @@ S: United Kingdom
 
 N: Werner Almesberger
 E: werner@almesberger.net
-W: http://www.almesberger.net/
+W: https://www.almesberger.net/
 D: dosfs, LILO, some fd features, ATM, various other hacks here and there
 S: Buenos Aires
 S: Argentina
@@ -96,7 +96,7 @@ S: USA
 
 N: Erik Andersen
 E: andersen@codepoet.org
-W: http://www.codepoet.org/
+W: https://www.codepoet.org/
 P: 1024D/30D39057 1BC4 2742 E885 E4DE 9301  0C82 5F9B 643E 30D3 9057
 D: Maintainer of ide-cd and Uniform CD-ROM driver, 
 D: ATAPI CD-Changer support, Major 2.1.x CD-ROM update.
@@ -114,7 +114,7 @@ S: Canada K2P 0X3
 
 N: H. Peter Anvin
 E: hpa@zytor.com
-W: http://www.zytor.com/~hpa/
+W: https://www.zytor.com/~hpa/
 P: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
 D: Author of the SYSLINUX boot loader, maintainer of the linux.* news
 D: hierarchy and the Linux Device List; various kernel hacks
@@ -124,7 +124,7 @@ S: USA
 
 N: Andrea Arcangeli
 E: andrea@suse.de
-W: http://www.kernel.org/pub/linux/kernel/people/andrea/
+W: https://www.kernel.org/pub/linux/kernel/people/andrea/
 P: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
 P: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
 D: Parport hacker
@@ -339,7 +339,7 @@ S: Haifa, Israel
 
 N: Johannes Berg
 E: johannes@sipsolutions.net
-W: http://johannes.sipsolutions.net/
+W: https://johannes.sipsolutions.net/
 P: 4096R/7BF9099A C0EB C440 F6DA 091C 884D  8532 E0F3 73F3 7BF9 099A
 D: powerpc & 802.11 hacker
 
@@ -376,7 +376,7 @@ D: Original author of the Linux networking code
 
 N: Anton Blanchard
 E: anton@samba.org
-W: http://samba.org/~anton/
+W: https://samba.org/~anton/
 P: 1024/8462A731 4C 55 86 34 44 59 A7 99  2B 97 88 4A 88 9A 0D 97
 D: sun4 port, Sparc hacker
 
@@ -483,7 +483,7 @@ D: Intel Wireless WiMAX Connection 2400 SDIO driver
 
 N: Derrick J. Brashear
 E: shadow@dementia.org
-W: http://www.dementia.org/~shadow
+W: https://www.dementia.org/~shadow
 P: 512/71EC9367 C5 29 0F BC 83 51 B9 F0  BC 05 89 A0 4F 1F 30 05
 D: Author of Sparc CS4231 audio driver, random Sparc work
 S: 403 Gilmore Avenue
@@ -509,7 +509,7 @@ S: Sweden
 
 N: Paul Bristow
 E: paul@paulbristow.net
-W: http://paulbristow.net/linux/idefloppy.html
+W: https://paulbristow.net/linux/idefloppy.html
 D: Maintainer of IDE/ATAPI floppy driver
 
 N: Stefano Brivio
@@ -518,7 +518,7 @@ D: Broadcom B43 driver
 
 N: Dominik Brodowski
 E: linux@brodo.de
-W: http://www.brodo.de/
+W: https://www.brodo.de/
 P: 1024D/725B37C6  190F 3E77 9C89 3B6D BECD  46EE 67C3 0308 725B 37C6
 D: parts of CPUFreq code, ACPI bugfixes, PCMCIA rewrite, cpufrequtils
 S: Tuebingen, Germany
@@ -761,7 +761,7 @@ D: Ralink rt2x00 WLAN driver
 S: Belas, Portugal
 
 N: Alan Cox
-W: http://www.linux.org.uk/diary/
+W: https://www.linux.org.uk/diary/
 D: Linux Networking (0.99.10->2.0.29)
 D: Original Appletalk, AX.25, and IPX code
 D: 3c501 hacker
@@ -865,7 +865,7 @@ D: Promise DC4030VL caching HD controller drivers
 
 N: Todd J. Derr
 E: tjd@fore.com
-W: http://www.wordsmith.org/~tjd
+W: https://www.wordsmith.org/~tjd
 D: Random console hacks and other miscellaneous stuff
 S: 3000 FORE Drive
 S: Warrendale, Pennsylvania 15086
@@ -894,8 +894,8 @@ S: USA
 
 N: Matt Domsch
 E: Matt_Domsch@dell.com
-W: http://www.dell.com/linux
-W: http://domsch.com/linux
+W: https://www.dell.com/linux
+W: https://domsch.com/linux
 D: Linux/IA-64
 D: Dell PowerEdge server, SCSI layer, misc drivers, and other patches
 S: Dell Inc.
@@ -992,7 +992,7 @@ S: USA
 
 N: Randy Dunlap
 E: rdunlap@infradead.org
-W: http://www.infradead.org/~rdunlap/
+W: https://www.infradead.org/~rdunlap/
 D: Linux-USB subsystem, USB core/UHCI/printer/storage drivers
 D: x86 SMP, ACPI, bootflag hacking
 D: documentation, builds
@@ -1063,7 +1063,7 @@ S: Sweden
 
 N: Pekka Enberg
 E: penberg@cs.helsinki.fi
-W: http://www.cs.helsinki.fi/u/penberg/
+W: https://www.cs.helsinki.fi/u/penberg/
 D: Various kernel hacks, fixes, and cleanups.
 D: Slab allocators
 S: Finland
@@ -1157,7 +1157,7 @@ S: Germany
 
 N: Jeremy Fitzhardinge
 E: jeremy@goop.org
-W: http://www.goop.org/~jeremy
+W: https://www.goop.org/~jeremy
 D: author of userfs filesystem
 D: Improved mmap and munmap handling
 D: General mm minor tidyups
@@ -1460,7 +1460,7 @@ S: The Netherlands
 
 N: Oliver Hartkopp
 E: oliver.hartkopp@volkswagen.de
-W: http://www.volkswagen.de
+W: https://www.volkswagen.de
 D: Controller Area Network (network layer core)
 S: Brieffach 1776
 S: 38436 Wolfsburg
@@ -1599,13 +1599,13 @@ S: Germany
 
 N: Kenji Hollis
 E: kenji@bitgate.com
-W: http://www.bitgate.com/
+W: https://www.bitgate.com/
 D: Berkshire PC Watchdog Driver
 D: Small/Industrial Driver Project
 
 N: Nick Holloway
 E: Nick.Holloway@pyrites.org.uk
-W: http://www.pyrites.org.uk/
+W: https://www.pyrites.org.uk/
 P: 1024/36115A04 F4E1 3384 FCFD C055 15D6  BA4C AB03 FBF8 3611 5A04
 D: Occasional Linux hacker...
 S: (ask for current address)
@@ -1655,7 +1655,7 @@ S: USA
 
 N: Harald Hoyer
 E: harald@redhat.com
-W: http://www.harald-hoyer.de
+W: https://www.harald-hoyer.de
 D: ip_masq_quake
 D: md boot support
 S: Am Strand 5
@@ -1856,7 +1856,7 @@ E: kas@fi.muni.cz
 D: Author of the COSA/SRP sync serial board driver.
 D: Port of the syncppp.c from the 2.0 to the 2.1 kernel.
 P: 1024/D3498839 0D 99 A7 FB 20 66 05 D7  8B 35 FC DE 05 B1 8A 5E
-W: http://www.fi.muni.cz/~kas/
+W: https://www.fi.muni.cz/~kas/
 S: c/o Faculty of Informatics, Masaryk University
 S: Botanicka' 68a
 S: 602 00 Brno
@@ -1933,6 +1933,11 @@ S: Schwalbenstr. 96
 S: 85551 Ottobrunn
 S: Germany
 
+N: Alexander A. Klimov
+E: grandmaster@al2klimov.de
+W: https://github.com/Al2Klimov
+D: documentation
+
 N: Ian Kluft
 E: ikluft@thunder.sbay.org
 W: http://www.kluft.com/~ikluft/
@@ -2017,7 +2022,7 @@ S: Prague, Czech Republic
 
 N: Gene Kozin
 E: 74604.152@compuserve.com
-W: http://www.sangoma.com
+W: https://www.sangoma.com
 D: WAN Router & Sangoma WAN drivers
 S: Sangoma Technologies Inc.
 S: 7170 Warden Avenue, Unit 2
@@ -2112,7 +2117,7 @@ D: Original author of software suspend
 
 N: Jaroslav Kysela
 E: perex@perex.cz
-W: http://www.perex.cz
+W: https://www.perex.cz
 D: Original Author and Maintainer for HP 10/100 Mbit Network Adapters
 D: ISA PnP
 S: Sindlovy Dvory 117
@@ -2241,7 +2246,7 @@ S: France
 
 N: Siegfried "Frieder" Loeffler (dg1sek)
 E: floeff@tunix.mathematik.uni-stuttgart.de, fl@LF.net
-W: http://www.mathematik.uni-stuttgart.de/~floeff
+W: https://www.mathematik.uni-stuttgart.de/~floeff
 D: Busmaster driver for HP 10/100 Mbit Network Adapters
 S: University of Stuttgart, Germany and
 S: Ecole Nationale Superieure des Telecommunications, Paris
@@ -2316,7 +2321,7 @@ S: Finland
 
 N: Daniel J. Maas
 E: dmaas@dcine.com
-W: http://www.maasdigital.com
+W: https://www.maasdigital.com
 D: dv1394
 
 N: Hamish Macdonald
@@ -2647,7 +2652,7 @@ D: bug fixes, documentation, minor hackery
 
 N: Paul Moore
 E: paul@paul-moore.com
-W: http://www.paul-moore.com
+W: https://www.paul-moore.com
 D: NetLabel, SELinux, audit
 
 N: James Morris
@@ -2786,7 +2791,7 @@ N: David C. Niemi
 E: niemi@tux.org
 W: http://www.tux.org/~niemi/
 D: Assistant maintainer of Mtools, fdutils, and floppy driver
-D: Administrator of Tux.Org Linux Server, http://www.tux.org
+D: Administrator of Tux.Org Linux Server, https://www.tux.org
 S: 2364 Old Trail Drive
 S: Reston, Virginia 20191
 S: USA
@@ -2850,7 +2855,7 @@ S: USA
 
 N: Mikulas Patocka
 E: mikulas@artax.karlin.mff.cuni.cz
-W: http://artax.karlin.mff.cuni.cz/~mikulas/
+W: https://artax.karlin.mff.cuni.cz/~mikulas/
 P: 1024/BB11D2D5 A0 F1 28 4A C4 14 1E CF  92 58 7A 8F 69 BC A4 D3
 D: Read/write HPFS filesystem
 S: Weissova 8
@@ -2872,7 +2877,7 @@ D: RFC2385 Support for TCP
 
 N: Barak A. Pearlmutter
 E: bap@cs.unm.edu
-W: http://www.cs.unm.edu/~bap/
+W: https://www.cs.unm.edu/~bap/
 P: 512/602D785D 9B A1 83 CD EE CB AD 93  20 C6 4C B7 F5 E9 60 D4
 D: Author of mark-and-sweep GC integrated by Alan Cox
 S: Computer Science Department
@@ -3035,7 +3040,7 @@ S: United Kingdom
 
 N: Daniel Quinlan
 E: quinlan@pathname.com
-W: http://www.pathname.com/~quinlan/
+W: https://www.pathname.com/~quinlan/
 D: FSSTND coordinator; FHS editor
 D: random Linux documentation, patches, and hacks
 S: 4390 Albany Drive #41A
@@ -3130,7 +3135,7 @@ S: France
 
 N: Rik van Riel
 E: riel@redhat.com
-W: http://www.surriel.com/
+W: https://www.surriel.com/
 D: Linux-MM site, Documentation/admin-guide/sysctl/*, swap/mm readaround
 D: kswapd fixes, random kernel hacker, rmap VM,
 D: nl.linux.org administrator, minor scheduler additions
@@ -3246,7 +3251,7 @@ S: Germany
 
 N: Paul `Rusty' Russell
 E: rusty@rustcorp.com.au
-W: http://ozlabs.org/~rusty
+W: https://ozlabs.org/~rusty
 D: Ruggedly handsome.
 D: netfilter, ipchains with Michael Neuling.
 S: 52 Moore St
@@ -3369,7 +3374,7 @@ S: Germany
 
 N: Robert Schwebel
 E: robert@schwebel.de
-W: http://www.schwebel.de
+W: https://www.schwebel.de
 D: Embedded hacker and book author,
 D: AMD Elan support for Linux
 S: Pengutronix
@@ -3545,7 +3550,7 @@ S: Australia
 N: Henrik Storner
 E: storner@image.dk
 W: http://www.image.dk/~storner/
-W: http://www.sslug.dk/
+W: https://www.sslug.dk/
 D: Configure script: Invented tristate for module-configuration
 D: vfat/msdos integration, kerneld docs, Linux promotion
 D: Miscellaneous bug-fixes
@@ -3579,7 +3584,7 @@ S: USA
 
 N: Eugene Surovegin
 E: ebs@ebshome.net
-W: http://kernel.ebshome.net/
+W: https://kernel.ebshome.net/
 P: 1024D/AE5467F1 FF22 39F1 6728 89F6 6E6C  2365 7602 F33D AE54 67F1
 D: Embedded PowerPC 4xx: EMAC, I2C, PIC and random hacks/fixes
 S: Sunnyvale, California 94085
@@ -3609,7 +3614,7 @@ S: France
 
 N: Urs Thuermann
 E: urs.thuermann@volkswagen.de
-W: http://www.volkswagen.de
+W: https://www.volkswagen.de
 D: Controller Area Network (network layer core)
 S: Brieffach 1776
 S: 38436 Wolfsburg
@@ -3656,7 +3661,7 @@ S: Canada K2L 1S2
 
 N: Andrew Tridgell
 E: tridge@samba.org
-W: http://samba.org/tridge/
+W: https://samba.org/tridge/
 D: dosemu, networking, samba
 S: 3 Ballow Crescent
 S: MacGregor A.C.T 2615
@@ -3894,7 +3899,7 @@ D: The Linux Support Team Erlangen
 N: David Weinehall
 E: tao@acc.umu.se
 P: 1024D/DC47CA16 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
-W: http://www.acc.umu.se/~tao/
+W: https://www.acc.umu.se/~tao/
 D: v2.0 kernel maintainer
 D: Fixes for the NE/2-driver
 D: Miscellaneous MCA-support
@@ -3919,7 +3924,7 @@ S: USA
 N: Harald Welte
 E: laforge@netfilter.org
 P: 1024D/30F48BFF DBDE 6912 8831 9A53 879B  9190 5DA5 C655 30F4 8BFF
-W: http://gnumonks.org/users/laforge
+W: https://gnumonks.org/users/laforge
 D: netfilter: new nat helper infrastructure
 D: netfilter: ULOG, ECN, DSCP target
 D: netfilter: TTL match
@@ -4113,7 +4118,7 @@ S: Japan
 
 N: Eric Youngdale
 E: eric@andante.org
-W: http://www.andante.org
+W: https://www.andante.org
 D: General kernel hacker
 D: SCSI iso9660 and ELF
 S: 6389 Hawk View Lane
-- 
2.27.0

