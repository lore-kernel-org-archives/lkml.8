Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBEEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04D20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCIHDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:03:55 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:61130 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:03:55 -0400
X-Greylist: delayed 792 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 03:03:53 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 8610F261D10;
        Mon,  9 Mar 2020 14:49:37 +0800 (CST)
From:   WANG Wenhu <wenhu.wang@vivo.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Wenhu <wenhu.wang@vivo.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, wenhu.pku@gmail.com
Subject: [PATCH] powerpc/fsl-85xx: fix compile error
Date:   Sun,  8 Mar 2020 23:49:22 -0700
Message-Id: <20200309064926.27107-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVITkxCQkJDS0pNSE5MT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6Cgw6ATgzEj0YGUIpTDcZ
        HiFPCy1VSlVKTkNITEhNTkNLS0NNVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlDSEs3Bg++
X-HM-Tid: 0a70be0e5fb09375kuws8610f261d10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include "linux/of_address.h" to fix the compile error
while compiling file fsl_85xx_cache_sram.c.

  CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c: In function ‘mpc85xx_l2ctlr_of_probe’:
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:11: error: implicit declaration of function ‘of_iomap’; did you mean ‘pci_iomap’? [-Werror=implicit-function-declaration]
  l2ctlr = of_iomap(dev->dev.of_node, 0);
           ^~~~~~~~
           pci_iomap
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:9: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  l2ctlr = of_iomap(dev->dev.of_node, 0);
         ^
cc1: all warnings being treated as errors
scripts/Makefile.build:267: recipe for target 'arch/powerpc/sysdev/fsl_85xx_l2ctlr.o' failed
make[2]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1

Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
---
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 2d0af0c517bb..7533572492f0 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <asm/io.h>
 
 #include "fsl_85xx_cache_ctlr.h"
-- 
2.17.1

