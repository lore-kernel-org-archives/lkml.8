Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53625C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB38206E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGKFvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:51:40 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:33218 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGKFvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:51:39 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2D4FCBC069;
        Sat, 11 Jul 2020 05:51:34 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, corbet@lwn.net, f4bug@amsat.org,
        cyphar@cyphar.com, davej@codemonkey.org.uk,
        geert+renesas@glider.be, ribalda@kernel.org,
        luis.f.correia@gmail.com, grandmaster@al2klimov.de,
        paulburton@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] CREDITS: Replace HTTP links with HTTPS ones
Date:   Sat, 11 Jul 2020 07:51:27 +0200
Message-Id: <20200711055127.92418-1-grandmaster@al2klimov.de>
In-Reply-To: <20200710154630.31521104@lwn.net>
References: <20200710154630.31521104@lwn.net>
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
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 This is not a recall of the wish to be in CREDITS.
 Just preforming the requested changes.
 
 CREDITS | 80 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/CREDITS b/CREDITS
index 0787b5872906..e5267acb98e0 100644
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
@@ -2017,7 +2017,7 @@ S: Prague, Czech Republic
 
 N: Gene Kozin
 E: 74604.152@compuserve.com
-W: http://www.sangoma.com
+W: https://www.sangoma.com
 D: WAN Router & Sangoma WAN drivers
 S: Sangoma Technologies Inc.
 S: 7170 Warden Avenue, Unit 2
@@ -2112,7 +2112,7 @@ D: Original author of software suspend
 
 N: Jaroslav Kysela
 E: perex@perex.cz
-W: http://www.perex.cz
+W: https://www.perex.cz
 D: Original Author and Maintainer for HP 10/100 Mbit Network Adapters
 D: ISA PnP
 S: Sindlovy Dvory 117
@@ -2241,7 +2241,7 @@ S: France
 
 N: Siegfried "Frieder" Loeffler (dg1sek)
 E: floeff@tunix.mathematik.uni-stuttgart.de, fl@LF.net
-W: http://www.mathematik.uni-stuttgart.de/~floeff
+W: https://www.mathematik.uni-stuttgart.de/~floeff
 D: Busmaster driver for HP 10/100 Mbit Network Adapters
 S: University of Stuttgart, Germany and
 S: Ecole Nationale Superieure des Telecommunications, Paris
@@ -2316,7 +2316,7 @@ S: Finland
 
 N: Daniel J. Maas
 E: dmaas@dcine.com
-W: http://www.maasdigital.com
+W: https://www.maasdigital.com
 D: dv1394
 
 N: Hamish Macdonald
@@ -2647,7 +2647,7 @@ D: bug fixes, documentation, minor hackery
 
 N: Paul Moore
 E: paul@paul-moore.com
-W: http://www.paul-moore.com
+W: https://www.paul-moore.com
 D: NetLabel, SELinux, audit
 
 N: James Morris
@@ -2786,7 +2786,7 @@ N: David C. Niemi
 E: niemi@tux.org
 W: http://www.tux.org/~niemi/
 D: Assistant maintainer of Mtools, fdutils, and floppy driver
-D: Administrator of Tux.Org Linux Server, http://www.tux.org
+D: Administrator of Tux.Org Linux Server, https://www.tux.org
 S: 2364 Old Trail Drive
 S: Reston, Virginia 20191
 S: USA
@@ -2850,7 +2850,7 @@ S: USA
 
 N: Mikulas Patocka
 E: mikulas@artax.karlin.mff.cuni.cz
-W: http://artax.karlin.mff.cuni.cz/~mikulas/
+W: https://artax.karlin.mff.cuni.cz/~mikulas/
 P: 1024/BB11D2D5 A0 F1 28 4A C4 14 1E CF  92 58 7A 8F 69 BC A4 D3
 D: Read/write HPFS filesystem
 S: Weissova 8
@@ -2872,7 +2872,7 @@ D: RFC2385 Support for TCP
 
 N: Barak A. Pearlmutter
 E: bap@cs.unm.edu
-W: http://www.cs.unm.edu/~bap/
+W: https://www.cs.unm.edu/~bap/
 P: 512/602D785D 9B A1 83 CD EE CB AD 93  20 C6 4C B7 F5 E9 60 D4
 D: Author of mark-and-sweep GC integrated by Alan Cox
 S: Computer Science Department
@@ -3035,7 +3035,7 @@ S: United Kingdom
 
 N: Daniel Quinlan
 E: quinlan@pathname.com
-W: http://www.pathname.com/~quinlan/
+W: https://www.pathname.com/~quinlan/
 D: FSSTND coordinator; FHS editor
 D: random Linux documentation, patches, and hacks
 S: 4390 Albany Drive #41A
@@ -3130,7 +3130,7 @@ S: France
 
 N: Rik van Riel
 E: riel@redhat.com
-W: http://www.surriel.com/
+W: https://www.surriel.com/
 D: Linux-MM site, Documentation/admin-guide/sysctl/*, swap/mm readaround
 D: kswapd fixes, random kernel hacker, rmap VM,
 D: nl.linux.org administrator, minor scheduler additions
@@ -3246,7 +3246,7 @@ S: Germany
 
 N: Paul `Rusty' Russell
 E: rusty@rustcorp.com.au
-W: http://ozlabs.org/~rusty
+W: https://ozlabs.org/~rusty
 D: Ruggedly handsome.
 D: netfilter, ipchains with Michael Neuling.
 S: 52 Moore St
@@ -3369,7 +3369,7 @@ S: Germany
 
 N: Robert Schwebel
 E: robert@schwebel.de
-W: http://www.schwebel.de
+W: https://www.schwebel.de
 D: Embedded hacker and book author,
 D: AMD Elan support for Linux
 S: Pengutronix
@@ -3545,7 +3545,7 @@ S: Australia
 N: Henrik Storner
 E: storner@image.dk
 W: http://www.image.dk/~storner/
-W: http://www.sslug.dk/
+W: https://www.sslug.dk/
 D: Configure script: Invented tristate for module-configuration
 D: vfat/msdos integration, kerneld docs, Linux promotion
 D: Miscellaneous bug-fixes
@@ -3579,7 +3579,7 @@ S: USA
 
 N: Eugene Surovegin
 E: ebs@ebshome.net
-W: http://kernel.ebshome.net/
+W: https://kernel.ebshome.net/
 P: 1024D/AE5467F1 FF22 39F1 6728 89F6 6E6C  2365 7602 F33D AE54 67F1
 D: Embedded PowerPC 4xx: EMAC, I2C, PIC and random hacks/fixes
 S: Sunnyvale, California 94085
@@ -3609,7 +3609,7 @@ S: France
 
 N: Urs Thuermann
 E: urs.thuermann@volkswagen.de
-W: http://www.volkswagen.de
+W: https://www.volkswagen.de
 D: Controller Area Network (network layer core)
 S: Brieffach 1776
 S: 38436 Wolfsburg
@@ -3656,7 +3656,7 @@ S: Canada K2L 1S2
 
 N: Andrew Tridgell
 E: tridge@samba.org
-W: http://samba.org/tridge/
+W: https://samba.org/tridge/
 D: dosemu, networking, samba
 S: 3 Ballow Crescent
 S: MacGregor A.C.T 2615
@@ -3894,7 +3894,7 @@ D: The Linux Support Team Erlangen
 N: David Weinehall
 E: tao@acc.umu.se
 P: 1024D/DC47CA16 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
-W: http://www.acc.umu.se/~tao/
+W: https://www.acc.umu.se/~tao/
 D: v2.0 kernel maintainer
 D: Fixes for the NE/2-driver
 D: Miscellaneous MCA-support
@@ -3919,7 +3919,7 @@ S: USA
 N: Harald Welte
 E: laforge@netfilter.org
 P: 1024D/30F48BFF DBDE 6912 8831 9A53 879B  9190 5DA5 C655 30F4 8BFF
-W: http://gnumonks.org/users/laforge
+W: https://gnumonks.org/users/laforge
 D: netfilter: new nat helper infrastructure
 D: netfilter: ULOG, ECN, DSCP target
 D: netfilter: TTL match
@@ -4113,7 +4113,7 @@ S: Japan
 
 N: Eric Youngdale
 E: eric@andante.org
-W: http://www.andante.org
+W: https://www.andante.org
 D: General kernel hacker
 D: SCSI iso9660 and ELF
 S: 6389 Hawk View Lane
-- 
2.27.0

