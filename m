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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D342098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXDHoHjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgIHTeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730997AbgIHP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE3C06135C;
        Tue,  8 Sep 2020 05:35:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c10so15799298edk.6;
        Tue, 08 Sep 2020 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/Nfj7ACLzQzeTXMcR9CfM54OsifE9xJrIVoCFhWznc=;
        b=WXDHoHjsoG+fJxb79HOJ1tpvH76HhMX/AR0/LF11Z6Pz7cG7O6BYieRPkHU3Q9Af3C
         nlixl/zkKMxhUxaVkAsMxs5iS2d2OmGS0QJr+gZizjVwOQAVKYxvKmgSdYX7rtLR6kOO
         9QPWVuy37/+c6pCmBe1rzhNvT7I17XKcLINKNpHqeFz4OA8MrpwpTAKa0iNqpHfDVx71
         a5HiqyVFCbl7nB8Mx1gAArHBUxk44PsTz9Tjj6OyNCQtzSKCtWyiiNGE/Axgy1/GrRhV
         xTVk8/yhIMBUU91RDcHIwpoVea7KU/0Mp/JYkgv2qt465PWnZhOvtM/9Jv03pN3fzDQl
         LHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/Nfj7ACLzQzeTXMcR9CfM54OsifE9xJrIVoCFhWznc=;
        b=Dz81idEp6KlMwkcKl6XgJ+fIKY+0azQEQ8lMIzVMR/1bUGJ6QljSOgzDg7ACXH9URT
         leujJbaK+GjROGerESOMKu6X3ZSxmyAOUZz2cdJNfPOdi6WwVnip/WtWr8xTXUGIhS8k
         fgfGUCB4SSn4cTdIwbXaZvaLcbwIRyfXy1AVivH/tUbPvNvCcZG7I8a5XWeZpeLZyL4H
         qDOM4UkAkPfQARX2al/p2lrT5+b6JjPx/1xnB7Ppy60hqyeDnZ3NZH2mEUXUOacwEdUm
         Zjto7QU7GI6a3nbCRQSghCJ5JbNZTwyPmBufrnnkrJrFpHjcatpGEoed9af4vfrAigjw
         cmCg==
X-Gm-Message-State: AOAM530zCD8yZ74UWIoZPjV1HbMbmiYKfV4qiRfVOCIrU18jghreAahB
        3DgqXvfhRiJUDzMUX85HI+A=
X-Google-Smtp-Source: ABdhPJzBJrnLD2w9Oln9SVK+nN1qvhZwS6LluGf0nmMm48637c26eySF4TwqO8wjOI6n0FybP0wNqg==
X-Received: by 2002:aa7:d88a:: with SMTP id u10mr15985398edq.217.1599568515763;
        Tue, 08 Sep 2020 05:35:15 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8b:1700:7cee:a9ea:bd04:6924])
        by smtp.gmail.com with ESMTPSA id x6sm9399939ejf.59.2020.09.08.05.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:35:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/5] scsi/qla4xxx: Convert to SPDX license identifiers
Date:   Tue,  8 Sep 2020 14:34:47 +0200
Message-Id: <20200908123451.7215-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All files in this driver directory contain the following notice:

  See LICENSE.qla4xxx for copyright and licensing details.

LICENSE.qla4xxx can be found in Documentation/scsi/. The file contains:

  - A copyright notice

    This copyright notice is redundant as all files contain the same
    copyright notice already

  - A license notice

    You may modify and redistribute the device driver code under the
    GNU General Public License (a copy of which is attached hereto as
    Exhibit A) published by the Free Software Foundation (version 2).

  - The full GPLv2 license text

    This can be replaced with the corresponding SPDX license identifier
    (GPL-2.0-only) in the source files which reference this license
    file.

  - The full GPLv2 license text

    A redundant copy of LICENSES/preferred/GPL-2.0

Remove the notices and add the SPDX license identifier GPL-2.0-only to the
source files.

Finally remove the now redundant LICENSE.qla4xxx file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Richard Fontana <rfontana@redhat.com>
Reviewed-by: Jilayne Lovejoy <opensource@jilayne.com>
Reviewed-by: Alexios Zavras <alexios.zavras@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/scsi/LICENSE.qla4xxx | 289 -----------------------------
 MAINTAINERS                        |   1 -
 drivers/scsi/qla4xxx/ql4_83xx.c    |   3 +-
 drivers/scsi/qla4xxx/ql4_83xx.h    |   3 +-
 drivers/scsi/qla4xxx/ql4_attr.c    |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.c     |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.h     |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.c     |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.h     |   3 +-
 drivers/scsi/qla4xxx/ql4_def.h     |   3 +-
 drivers/scsi/qla4xxx/ql4_fw.h      |   3 +-
 drivers/scsi/qla4xxx/ql4_glbl.h    |   3 +-
 drivers/scsi/qla4xxx/ql4_init.c    |   3 +-
 drivers/scsi/qla4xxx/ql4_inline.h  |   3 +-
 drivers/scsi/qla4xxx/ql4_iocb.c    |   3 +-
 drivers/scsi/qla4xxx/ql4_isr.c     |   3 +-
 drivers/scsi/qla4xxx/ql4_mbx.c     |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.c   |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.h   |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.c      |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.h      |   3 +-
 drivers/scsi/qla4xxx/ql4_os.c      |   3 +-
 drivers/scsi/qla4xxx/ql4_version.h |   3 +-
 23 files changed, 21 insertions(+), 332 deletions(-)
 delete mode 100644 Documentation/scsi/LICENSE.qla4xxx

diff --git a/Documentation/scsi/LICENSE.qla4xxx b/Documentation/scsi/LICENSE.qla4xxx
deleted file mode 100644
index fcc27ad27d74..000000000000
--- a/Documentation/scsi/LICENSE.qla4xxx
+++ /dev/null
@@ -1,289 +0,0 @@
-Copyright (c) 2003-2013 QLogic Corporation
-QLogic Linux iSCSI Driver
-
-This program includes a device driver for Linux 3.x.
-You may modify and redistribute the device driver code under the
-GNU General Public License (a copy of which is attached hereto as
-Exhibit A) published by the Free Software Foundation (version 2).
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
index b5cfab015bd6..0f72d0aa2dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14237,7 +14237,6 @@ QLOGIC QLA4XXX iSCSI DRIVER
 M:	QLogic-Storage-Upstream@qlogic.com
 L:	linux-scsi@vger.kernel.org
 S:	Supported
-F:	Documentation/scsi/LICENSE.qla4xxx
 F:	drivers/scsi/qla4xxx/
 
 QLOGIC QLCNIC (1/10)Gb ETHERNET DRIVER
diff --git a/drivers/scsi/qla4xxx/ql4_83xx.c b/drivers/scsi/qla4xxx/ql4_83xx.c
index de10e67de8c0..5f56122f6664 100644
--- a/drivers/scsi/qla4xxx/ql4_83xx.c
+++ b/drivers/scsi/qla4xxx/ql4_83xx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)   2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include <linux/ratelimit.h>
diff --git a/drivers/scsi/qla4xxx/ql4_83xx.h b/drivers/scsi/qla4xxx/ql4_83xx.h
index f34583e5f8de..f10167c71dd3 100644
--- a/drivers/scsi/qla4xxx/ql4_83xx.h
+++ b/drivers/scsi/qla4xxx/ql4_83xx.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #ifndef __QL483XX_H
diff --git a/drivers/scsi/qla4xxx/ql4_attr.c b/drivers/scsi/qla4xxx/ql4_attr.c
index 463239c972b0..ec4352818fbf 100644
--- a/drivers/scsi/qla4xxx/ql4_attr.c
+++ b/drivers/scsi/qla4xxx/ql4_attr.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_bsg.c b/drivers/scsi/qla4xxx/ql4_bsg.c
index 9231917066d3..c447a9d598a1 100644
--- a/drivers/scsi/qla4xxx/ql4_bsg.c
+++ b/drivers/scsi/qla4xxx/ql4_bsg.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c) 2011-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_bsg.h b/drivers/scsi/qla4xxx/ql4_bsg.h
index 88c2401910c0..06db38561566 100644
--- a/drivers/scsi/qla4xxx/ql4_bsg.h
+++ b/drivers/scsi/qla4xxx/ql4_bsg.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c) 2011 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 #ifndef __QL4_BSG_H
 #define __QL4_BSG_H
diff --git a/drivers/scsi/qla4xxx/ql4_dbg.c b/drivers/scsi/qla4xxx/ql4_dbg.c
index 5649e9ef59a8..f43e675c5693 100644
--- a/drivers/scsi/qla4xxx/ql4_dbg.c
+++ b/drivers/scsi/qla4xxx/ql4_dbg.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2012 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_dbg.h b/drivers/scsi/qla4xxx/ql4_dbg.h
index 51c365bcf912..171c89165009 100644
--- a/drivers/scsi/qla4xxx/ql4_dbg.h
+++ b/drivers/scsi/qla4xxx/ql4_dbg.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2012 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 /*
diff --git a/drivers/scsi/qla4xxx/ql4_def.h b/drivers/scsi/qla4xxx/ql4_def.h
index 817f312023a9..f5b382ed0a1b 100644
--- a/drivers/scsi/qla4xxx/ql4_def.h
+++ b/drivers/scsi/qla4xxx/ql4_def.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #ifndef __QL4_DEF_H
diff --git a/drivers/scsi/qla4xxx/ql4_fw.h b/drivers/scsi/qla4xxx/ql4_fw.h
index 699575efc9ba..b9142464d3f0 100644
--- a/drivers/scsi/qla4xxx/ql4_fw.h
+++ b/drivers/scsi/qla4xxx/ql4_fw.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #ifndef _QLA4X_FW_H
diff --git a/drivers/scsi/qla4xxx/ql4_glbl.h b/drivers/scsi/qla4xxx/ql4_glbl.h
index bce96a58f14e..b8f02210aeb0 100644
--- a/drivers/scsi/qla4xxx/ql4_glbl.h
+++ b/drivers/scsi/qla4xxx/ql4_glbl.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #ifndef __QLA4x_GBL_H
diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 4a7ef971a387..92d9868757af 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include <scsi/iscsi_if.h>
diff --git a/drivers/scsi/qla4xxx/ql4_inline.h b/drivers/scsi/qla4xxx/ql4_inline.h
index 655b7bb644d9..9ced6b325cb3 100644
--- a/drivers/scsi/qla4xxx/ql4_inline.h
+++ b/drivers/scsi/qla4xxx/ql4_inline.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 /*
diff --git a/drivers/scsi/qla4xxx/ql4_iocb.c b/drivers/scsi/qla4xxx/ql4_iocb.c
index a8df2d7eb069..cbd1e6ffcd67 100644
--- a/drivers/scsi/qla4xxx/ql4_iocb.c
+++ b/drivers/scsi/qla4xxx/ql4_iocb.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index ade5eafdf81e..a51910ae9525 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index bc8de7d402d5..17b719a8b6fb 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include <linux/ctype.h>
diff --git a/drivers/scsi/qla4xxx/ql4_nvram.c b/drivers/scsi/qla4xxx/ql4_nvram.c
index 3bf418fbd432..f08a5abcb31a 100644
--- a/drivers/scsi/qla4xxx/ql4_nvram.c
+++ b/drivers/scsi/qla4xxx/ql4_nvram.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #include "ql4_def.h"
diff --git a/drivers/scsi/qla4xxx/ql4_nvram.h b/drivers/scsi/qla4xxx/ql4_nvram.h
index e97d79ff16f7..b96c06f50402 100644
--- a/drivers/scsi/qla4xxx/ql4_nvram.h
+++ b/drivers/scsi/qla4xxx/ql4_nvram.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #ifndef _QL4XNVRM_H_
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index 038e19b1e3c2..fd3aabb6a190 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/drivers/scsi/qla4xxx/ql4_nx.h b/drivers/scsi/qla4xxx/ql4_nx.h
index b7a6e7f169ca..52a5209ae42a 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.h
+++ b/drivers/scsi/qla4xxx/ql4_nx.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 #ifndef __QLA_NX_H
 #define __QLA_NX_H
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 676778cbc550..99ce284f53f2 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
diff --git a/drivers/scsi/qla4xxx/ql4_version.h b/drivers/scsi/qla4xxx/ql4_version.h
index f11eaa773339..fb1c14269f00 100644
--- a/drivers/scsi/qla4xxx/ql4_version.h
+++ b/drivers/scsi/qla4xxx/ql4_version.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * QLogic iSCSI HBA Driver
  * Copyright (c)  2003-2013 QLogic Corporation
- *
- * See LICENSE.qla4xxx for copyright and licensing details.
  */
 
 #define QLA4XXX_DRIVER_VERSION	"5.04.00-k6"
-- 
2.17.1

