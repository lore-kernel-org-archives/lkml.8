Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A5CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BBC206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgD1V0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:26:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1V0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:26:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLAAs-1jll502fZq-00IASJ; Tue, 28 Apr 2020 23:26:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Brauner <christian@brauner.io>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] samples: fix binderfs sample
Date:   Tue, 28 Apr 2020 23:25:33 +0200
Message-Id: <20200428212555.2806258-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rYdXf2edjRSRRytj6ux8j82psWH/1dATQIpT7zNrCZo6yq2nPvj
 rUgKTicGV0V1PzkBeFhKjT2EE/PlK1X3ZwA4m+WeEM8/AMy7eRkq5buoVSIdjQlD/pFChtB
 kOGmaCS7t5CC8elXbTt4dXYGl1SsYitmQh14DGY5S3fCnxBW+FCN2Y6Ms/5KXt58Fvw7fX9
 RJw7Q5dyuVFPQ6M0A5DMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VrJRv7ZviYY=:3duZvQoyNDq1uTBx7mgKhL
 Q4fOk4rGDHdl+kNBGgIrWW/wuKzioDm0LeKlC9hLtTOViLru6HZyh2R8EjbU7Qhy5bkk6nZoN
 6NUXMyKqteYDoNKLGp8f7u3mStsGuxQH3MxRwRKL2dn/uZwxAF327sBG0d+69T5WGaHDmghWo
 hKxCylj/Z75x9PsgUb5Uvv7a7YE9cs8uN2QHiKDDamKWLXmNWH0jeO6A/aqlBy8KHU3y7OnIP
 IF3QEsnREGeKSYsDfkiRCYpdXuZeT6t5Y+TWaLWEUyqha2i3XwKcoq4iwpug72w11nr0P3wKB
 GkF0QMrZFfYLgChLZSAj3odKUHxz/7cVbymPEWNHHhFNEwZMPOJPb4M+VA7q1Ps3n41jLxa2A
 r0TjVsXdbxw+c2pChqlHFue3j9daxzjzwz5p5hfL0ndLASJ81/gRj5hSmA7npqtfpyA6ylMUW
 qkzorM/AtindhfWa4eBvoJKN5cm+jBP8ZGUi3tERFv29RS5N79QBAPBM3CkM4vpHUGarcB/NU
 lNcVQcHxryx0d89aB+LqvWAzqcCa3GYxhIV7R8T5jR9QypXKEWJyYsqXMh45/fOYyLvox1UnT
 QYxOD0FD3xeXpMXc5SgvFVpXhLFzzE+BBC2xDyGg86+AFCota6wY0Q4Wg5Yoyny0appx5SyVD
 0wgRkWIJAz1nSLcB8o/tskdGOOa5mE5ITLVoGcwbN2fBy1G7SbNPgIngW1j+mUvGW/Hg451bc
 t+giw0xUUCPTF82oFaZRPMfFdRilJHwN2n9UZCNBCk3HEPprVuik7/uyfta/8rVN434331cCg
 t6qgEiO65dIzZfwaws7CbuXqSu1Ajt9JKMaeQupRfgvKPme5Zs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A routine check for misspelled Kconfig symbols showed on instance
from last year, the correct symbol name is CONFIG_ANDROID_BINDERFS,
not CONFIG_CONFIG_ANDROID_BINDERFS, so the extra prefix must
be removed in the Kconfig file to allow enabling the sample.

As the actual sample fails to build as a kernel module, change the
Makefile enough to get to build as a hostprog instead.

Fixes: 9762dc1432e1 ("samples: add binderfs sample program")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Kconfig           | 2 +-
 samples/binderfs/Makefile | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 5c31971a5745..e0b747cc90c9 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -171,7 +171,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 
 config SAMPLE_ANDROID_BINDERFS
 	bool "Build Android binderfs example"
-	depends on CONFIG_ANDROID_BINDERFS
+	depends on ANDROID_BINDERFS
 	help
 	  Builds a sample program to illustrate the use of the Android binderfs
 	  filesystem.
diff --git a/samples/binderfs/Makefile b/samples/binderfs/Makefile
index ea4c93d36256..a3ac5476338a 100644
--- a/samples/binderfs/Makefile
+++ b/samples/binderfs/Makefile
@@ -1,2 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs_example.o
+ifndef CROSS_COMPILE
+ifdef CONFIG_SAMPLE_ANDROID_BINDERFS
+hostprogs := binderfs_example
+endif
+endif
-- 
2.26.0

