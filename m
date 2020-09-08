Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A07C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5027720578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfBN7lc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgIHTma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbgIHPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC4C06135D;
        Tue,  8 Sep 2020 05:35:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so22226058ejo.9;
        Tue, 08 Sep 2020 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2qfq+72yB6R4V2Ta6DJIMSw5cF2WyPtLSpzTzIPnBF8=;
        b=JfBN7lc5rinP/bH1ffAJOmiWgIVIJ5exAoZpTSC5D6b7rqu6CDhufwCXE39HamQGaA
         b7fpHdjyGbFvh+WdEtpBnoP2M3LGFPEImM44jb/BTW3v3kkzmaY5BIMSVgDa0BN9NynV
         G3uYsY6y6obh6tMj6OmbWVfb6f78amZJacCymkfbZGvnrsW1IGaxo8ZRM7uKtYCgtPJL
         8agmVACEwW5YMjuhJ9csH34SUxVbusLwiDT8f3yi3dnEdrEPbkp3DoUZpP0h32sm+7Za
         VUzb+ox/3m79biEYcCo8ZQUvE8IdgtZNWtNwFKHFq/SxcReYEdNWRuA2Z2F2iQZuGt9V
         5WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2qfq+72yB6R4V2Ta6DJIMSw5cF2WyPtLSpzTzIPnBF8=;
        b=hyOr8IuTPsK5DvmAGSikTRVq/BvXfN5tA0iCxrUWMi+0PjfrRxSJCyMuN19wBNTSij
         ejt0iZXRrpyzRVl1RvbodlbU4rX9YGGgi6Smw7FNZPvAfU5Z7HeF6wiglwlnI1iJ87GS
         XBevVvyP54V4FQqBbnt8Vrk2J1oSULz6r4JYr9dztesxBOblFauWFs5pKTfM6daDq7hZ
         rKt64fP6pi8+WbwJSsMfkckadxHm+CRdwAairHFlh6AQaDE2tXp8uWxcjw5QyjiGWCDm
         kW35xMptGk09p+O7y59YnISfdg294ZUFyNdqEoYiDRQZta5vUw5mgXSLqG83soVpDA12
         eSdg==
X-Gm-Message-State: AOAM533nZ99Fki+vMqnsB1P3HcP5eJvIf/h2ZxkxIziJrLgGh60HHDvT
        tap8wmgcBVpxTXdLvdru+Cg=
X-Google-Smtp-Source: ABdhPJwe7vX7VXHWIjhkEeusgP/ad9+U88AXFx5s8GF9338+2FqJj49dybNVqswB1oETBJWO8+lKEA==
X-Received: by 2002:a17:906:c55:: with SMTP id t21mr26676972ejf.276.1599568519707;
        Tue, 08 Sep 2020 05:35:19 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8b:1700:7cee:a9ea:bd04:6924])
        by smtp.gmail.com with ESMTPSA id x6sm9399939ejf.59.2020.09.08.05.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:35:19 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/5] scsi/qla2xxx: Convert to SPDX license identifiers
Date:   Tue,  8 Sep 2020 14:34:48 +0200
Message-Id: <20200908123451.7215-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All files in this driver directory contain the following notice:

  See LICENSE.qla2xxx for copyright and licensing details.

LICENSE.qla2xxx can be found in Documentation/scsi/. The file contains:

  - A copyright notice

    This copyright notice is redundant as all files contain the same
    copyright notice already

  - A license notice

    You may modify and redistribute the device driver code under the
    GNU General Public License (a copy of which is attached hereto as
    Exhibit A) published by the Free Software Foundation (version 2).

    This can be replaced with the corresponding SPDX license identifier
    (GPL-2.0-only) in the source files which reference this license
    file.

  - The full GPLv2 license text

    A redundant copy of LICENSES/preferred/GPL-2.0

Remove the notices and add the SPDX license identifier GPL-2.0-only to the
source files.

Finally remove the now redundant LICENSE.qla2xxx file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Richard Fontana <rfontana@redhat.com>
Reviewed-by: Jilayne Lovejoy <opensource@jilayne.com>
Reviewed-by: Alexios Zavras <alexios.zavras@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/scsi/LICENSE.qla2xxx  | 290 ----------------------------
 MAINTAINERS                         |   1 -
 drivers/scsi/qla2xxx/qla_attr.c     |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.c      |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.h      |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.c      |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.h      |   3 +-
 drivers/scsi/qla2xxx/qla_def.h      |   3 +-
 drivers/scsi/qla2xxx/qla_dfs.c      |   3 +-
 drivers/scsi/qla2xxx/qla_fw.h       |   3 +-
 drivers/scsi/qla2xxx/qla_gbl.h      |   3 +-
 drivers/scsi/qla2xxx/qla_gs.c       |   3 +-
 drivers/scsi/qla2xxx/qla_init.c     |   3 +-
 drivers/scsi/qla2xxx/qla_inline.h   |   3 +-
 drivers/scsi/qla2xxx/qla_iocb.c     |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c      |   3 +-
 drivers/scsi/qla2xxx/qla_mbx.c      |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c      |   3 +-
 drivers/scsi/qla2xxx/qla_mr.c       |   3 +-
 drivers/scsi/qla2xxx/qla_mr.h       |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.c     |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.h     |   3 +-
 drivers/scsi/qla2xxx/qla_nx.c       |   3 +-
 drivers/scsi/qla2xxx/qla_nx.h       |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.c      |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.h      |   3 +-
 drivers/scsi/qla2xxx/qla_os.c       |   3 +-
 drivers/scsi/qla2xxx/qla_settings.h |   3 +-
 drivers/scsi/qla2xxx/qla_sup.c      |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.c     |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.h     |   3 +-
 drivers/scsi/qla2xxx/qla_version.h  |   3 +-
 32 files changed, 30 insertions(+), 351 deletions(-)
 delete mode 100644 Documentation/scsi/LICENSE.qla2xxx

diff --git a/Documentation/scsi/LICENSE.qla2xxx b/Documentation/scsi/LICENSE.qla2xxx
deleted file mode 100644
index 52f0b4359234..000000000000
--- a/Documentation/scsi/LICENSE.qla2xxx
+++ /dev/null
@@ -1,290 +0,0 @@
-Copyright (c) 2003-2014 QLogic Corporation
-QLogic Linux FC-FCoE Driver
-
-This program includes a device driver for Linux 3.x.
-You may modify and redistribute the device driver code under the
-GNU General Public License (a copy of which is attached hereto as
-Exhibit A) published by the Free Software Foundation (version 2).
-
-
-
-EXHIBIT A
-
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
- 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
-
-			    Preamble
-
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Lesser General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-
-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-
-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-
-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f72d0aa2dd6..25bb79c28de0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14223,7 +14223,6 @@ M:	Nilesh Javali <njavali@marvell.com>
 M:	GR-QLogic-Storage-Upstream@marvell.com
 L:	linux-scsi@vger.kernel.org
 S:	Supported
-F:	Documentation/scsi/LICENSE.qla2xxx
 F:	drivers/scsi/qla2xxx/
 
 QLOGIC QLA3XXX NETWORK DRIVER
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 5d93ccc73153..69ae215a3160 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 67efde1d4b8e..23b604832a54 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 
diff --git a/drivers/scsi/qla2xxx/qla_bsg.h b/drivers/scsi/qla2xxx/qla_bsg.h
index 7594fad7b5b5..1a09b5512267 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.h
+++ b/drivers/scsi/qla2xxx/qla_bsg.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_BSG_H
 #define __QLA_BSG_H
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 1be811a5d69d..75a008512d4c 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 /*
diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index e1d7de63e8f8..2e59e75c62b5 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 #include "qla_def.h"
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 1bc090d8a71b..aa2a6e83a5e7 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_DEF_H
 #define __QLA_DEF_H
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index e62b2115235e..1db2eded569c 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 
diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
index bba1b77fba7e..bcb5eac7daa4 100644
--- a/drivers/scsi/qla2xxx/qla_fw.h
+++ b/drivers/scsi/qla2xxx/qla_fw.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_FW_H
 #define __QLA_FW_H
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 0ced18f3104e..2e0060a59353 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_GBL_H
 #define	__QLA_GBL_H
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index b569fd6e96d6..30fae605bacb 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 507919d4ab36..13cf54733eac 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_gbl.h"
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 861dc522723c..41e607d7211b 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0954fa41911c..146bed76bc44 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 25e0a1684763..ab16dcacf705 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 226f1428d3e5..e2b5408bd270 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_target.h"
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 15efe2f04b86..afa59b485a4b 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_gbl.h"
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index a8fe4f725fa0..ca7306685325 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include <linux/delay.h>
diff --git a/drivers/scsi/qla2xxx/qla_mr.h b/drivers/scsi/qla2xxx/qla_mr.h
index 762250891a8f..73be8348402a 100644
--- a/drivers/scsi/qla2xxx/qla_mr.h
+++ b/drivers/scsi/qla2xxx/qla_mr.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_MR_H
 #define __QLA_MR_H
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 90bbc61f361b..18c7d4b9c705 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2017 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_nvme.h"
 #include <linux/scatterlist.h>
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index fbb844226630..67206bb13b80 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2017 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_NVME_H
 #define __QLA_NVME_H
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index 71273eb634d3..b3ba0de5d4fb 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include <linux/delay.h>
diff --git a/drivers/scsi/qla2xxx/qla_nx.h b/drivers/scsi/qla2xxx/qla_nx.h
index 93344a05910a..8567eaf1bddd 100644
--- a/drivers/scsi/qla2xxx/qla_nx.h
+++ b/drivers/scsi/qla2xxx/qla_nx.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #ifndef __QLA_NX_H
 #define __QLA_NX_H
diff --git a/drivers/scsi/qla2xxx/qla_nx2.c b/drivers/scsi/qla2xxx/qla_nx2.c
index 50e57603ce3d..3a415b12dcec 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.c
+++ b/drivers/scsi/qla2xxx/qla_nx2.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/scsi/qla2xxx/qla_nx2.h b/drivers/scsi/qla2xxx/qla_nx2.h
index 8ba7c1db07c3..2fc902a9fade 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.h
+++ b/drivers/scsi/qla2xxx/qla_nx2.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 #ifndef __QLA_NX2_H
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 8da00ba54aec..c8a4f83074ad 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 
diff --git a/drivers/scsi/qla2xxx/qla_settings.h b/drivers/scsi/qla2xxx/qla_settings.h
index 2fb7ebfbbc38..a5f3000ae53b 100644
--- a/drivers/scsi/qla2xxx/qla_settings.h
+++ b/drivers/scsi/qla2xxx/qla_settings.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #define MAX_RETRIES_OF_ISP_ABORT	5
 
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index 411b8a9ff393..0f92e9a044dc 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index 8dc82cfd38b2..03fff32b59cd 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 #include "qla_def.h"
 #include "qla_tmpl.h"
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.h b/drivers/scsi/qla2xxx/qla_tmpl.h
index 89280b3477aa..c47184db5081 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.h
+++ b/drivers/scsi/qla2xxx/qla_tmpl.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 
 #ifndef __QLA_DMP27_H__
diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index 8ccd9ba1ddef..3ca1fb96812a 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic Fibre Channel HBA Driver
  * Copyright (c)  2003-2014 QLogic Corporation
- *
- * See LICENSE.qla2xxx for copyright and licensing details.
  */
 /*
  * Driver version
-- 
2.17.1

