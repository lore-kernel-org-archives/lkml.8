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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378CD2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM5g2y0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgIHTh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgIHPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:55:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC6C061360;
        Tue,  8 Sep 2020 05:35:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lo4so22255990ejb.8;
        Tue, 08 Sep 2020 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MEwhElLwva4aOBYmOf3kKKArhiciy+PPTlQ3gWLCNXI=;
        b=nM5g2y0L5ufQzmEoJIi/gApeb09uu8iLUlcuACqTFv0e1u6jGb3Nn4WGKh+6V1ncro
         UW86ZXQmGWk0ZkMvzOAZ0h7EQcs2aizEY+VFlAeGIWzC60KNkw6hCnFa4JrVdFV84ldG
         jnN/CIR8ir2qBjYPdWk2uKesxYoIlPWAt3hBUVyv0OiyjDdyXIXBXTbsrQoWqAQ8HiBC
         8zyPVsF3lPGmE6cRq7rVjXArvBJCx/Z0pLBll6PCfRrReHuVv4CcltCogFO8XuSavTxY
         JPQlrOJhZ5+nMcn2jCCJnjiGKJcgy5e0AM1dpcNMVTkWg/VdeG6T8RjWwI0J8aXFr0EH
         zFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MEwhElLwva4aOBYmOf3kKKArhiciy+PPTlQ3gWLCNXI=;
        b=avsWIc4iqQ4yWzvuJxfEo8BZcjlxQE2F3MPvl6SHr82NQfe8B5Q+SC0OLS5YizxsoC
         aeJuSMXqloJ3WgsCuiS+MPdEOYTYyBH1YRak/iPSULGgq5gfqI+/8mg9BXuOb5+u2uFZ
         J81qpPH2ACNVayuugvJEEE4w8r9/70IuC8enF5/ImYqPrh486uDqC3MpbfS5qO8y/HbQ
         PmtK5benqm/DbD2VDYxA1epACYTn5GkNnWDNAP6FHh1NTaZNz5LwzVFnJyzjfskmLLZ7
         za6sV5PXFDAIW0p+7KTrOCnp3wd9U2VAg2Iw0vMpc4vIo56LhDw+/TDN6g/I5t3MS2N8
         p0HA==
X-Gm-Message-State: AOAM5335AGdSosxkIO/E/PwfwIsluL313ZcGIRP54haTHKy8H4hM1kdl
        k2itOQxvD8uY/JH+w+FP5kA=
X-Google-Smtp-Source: ABdhPJxlDVnQHP6V7S47v/si7qa/ANtphTNXDOm2Z/jI1W62qZvQo3UqiVG7lc/XrY6kmEtep6ksEg==
X-Received: by 2002:a17:906:a24f:: with SMTP id bi15mr26418103ejb.379.1599568526869;
        Tue, 08 Sep 2020 05:35:26 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8b:1700:7cee:a9ea:bd04:6924])
        by smtp.gmail.com with ESMTPSA id x6sm9399939ejf.59.2020.09.08.05.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:35:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 5/5] net/qla3xxx: Convert to SPDX license identifiers
Date:   Tue,  8 Sep 2020 14:34:51 +0200
Message-Id: <20200908123451.7215-6-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All files related to this driver contain the following notice:

  See LICENSE.qla3xxx for copyright and licensing details.

LICENSE.qla3xxx can be found in
Documentation/networking/device_drivers/qlogic/. The file contains:

  - A copyright notice

    This copyright notice is redundant as all files contain the same
    copyright notice already

  - A license notice

    You may modify and redistribute the device driver code under the GNU
    General Public License (a copy of which is attached hereto as Exhibit
    A) published by the Free Software Foundation (version 2 or a later
    version).

    This can be replaced with the corresponding SPDX license identifier
    (GPL-2.0-or-later) in the source files which reference this license
    file.

  - A license for the device firmware

    This license is pointless in the context of the kernel as the firmware
    is not distributed as part of the kernel.

    LICENSE.qla2xxx contained exactly the same firmware license which was
    removed with commit bc3f957c069f ("[SCSI] qla2xxx: Update
    LICENSE.qla2xxx.").

    The firmware license is there due to the fact that the out of tree
    driver tarball which was available from the qlogic website contained
    the firmware binary. The firmware license in the qla3xxx license file
    got probably forgotten when the other qlogic license files were
    updated.

Remove the notices and add the SPDX license identifier GPL-2.0-or-later to
the source files.

Finally remove the now redundant LICENSE.qla3xxx file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Richard Fontana <rfontana@redhat.com>
Reviewed-by: Alexios Zavras <alexios.zavras@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 .../device_drivers/qlogic/LICENSE.qla3xxx     | 46 -------------------
 MAINTAINERS                                   |  1 -
 drivers/net/ethernet/qlogic/qla3xxx.c         |  3 +-
 drivers/net/ethernet/qlogic/qla3xxx.h         |  3 +-
 4 files changed, 2 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx

diff --git a/Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx b/Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
deleted file mode 100644
index 2f2077e34d81..000000000000
--- a/Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
+++ /dev/null
@@ -1,46 +0,0 @@
-Copyright (c)  2003-2006 QLogic Corporation
-QLogic Linux Networking HBA Driver
-
-This program includes a device driver for Linux 2.6 that may be
-distributed with QLogic hardware specific firmware binary file.
-You may modify and redistribute the device driver code under the
-GNU General Public License as published by the Free Software
-Foundation (version 2 or a later version).
-
-You may redistribute the hardware specific firmware binary file
-under the following terms:
-
-	1. Redistribution of source code (only if applicable),
-	   must retain the above copyright notice, this list of
-	   conditions and the following disclaimer.
-
-	2. Redistribution in binary form must reproduce the above
-	   copyright notice, this list of conditions and the
-	   following disclaimer in the documentation and/or other
-	   materials provided with the distribution.
-
-	3. The name of QLogic Corporation may not be used to
-	   endorse or promote products derived from this software
-	   without specific prior written permission
-
-REGARDLESS OF WHAT LICENSING MECHANISM IS USED OR APPLICABLE,
-THIS PROGRAM IS PROVIDED BY QLOGIC CORPORATION "AS IS'' AND ANY
-EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
-PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR
-BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
-EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
-TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
-ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
-OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
-OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGE.
-
-USER ACKNOWLEDGES AND AGREES THAT USE OF THIS PROGRAM WILL NOT
-CREATE OR GIVE GROUNDS FOR A LICENSE BY IMPLICATION, ESTOPPEL, OR
-OTHERWISE IN ANY INTELLECTUAL PROPERTY RIGHTS (PATENT, COPYRIGHT,
-TRADE SECRET, MASK WORK, OR OTHER PROPRIETARY RIGHT) EMBODIED IN
-ANY OTHER QLOGIC HARDWARE OR SOFTWARE EITHER SOLELY OR IN
-COMBINATION WITH THIS PROGRAM.
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 25bb79c28de0..434274804028 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14229,7 +14229,6 @@ QLOGIC QLA3XXX NETWORK DRIVER
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	Documentation/networking/device_drivers/ethernet/qlogic/LICENSE.qla3xxx
 F:	drivers/net/ethernet/qlogic/qla3xxx.*
 
 QLOGIC QLA4XXX iSCSI DRIVER
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 569e2a7a64e5..27740c027681 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * QLogic QLA3xxx NIC HBA Driver
  * Copyright (c)  2003-2006 QLogic Corporation
- *
- * See LICENSE.qla3xxx for copyright and licensing details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.h b/drivers/net/ethernet/qlogic/qla3xxx.h
index 73e234366a82..fb4398303ae1 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.h
+++ b/drivers/net/ethernet/qlogic/qla3xxx.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * QLogic QLA3xxx NIC HBA Driver
  * Copyright (c)  2003-2006 QLogic Corporation
- *
- * See LICENSE.qla3xxx for copyright and licensing details.
  */
 #ifndef _QLA3XXX_H_
 #define _QLA3XXX_H_
-- 
2.17.1

