Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D004C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0105F20715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDXCrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:47:21 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:6526 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXCrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:47:20 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 5D17A101EC4;
        Fri, 24 Apr 2020 10:47:17 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     christophe.leroy@c-s.fr, oss@buserror.net, kernel@vivo.com,
        robh@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3,1/5] powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
Date:   Thu, 23 Apr 2020 19:45:50 -0700
Message-Id: <20200424024554.30709-2-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424024554.30709-1-wenhu.wang@vivo.com>
References: <20200424024554.30709-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPTE1LS0tLTEtOTEpCWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46Fyo6TDg5T1YfKC9KOUs#
        PjNPFE9VSlVKTkNMTUJNT0hMQkpNVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhJTkI3Bg++
X-HM-Tid: 0a71aa150a1a9374kuws5d17a101ec4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include "linux/of_address.h" to fix the compile error for
mpc85xx_l2ctlr_of_probe() when compiling fsl_85xx_cache_sram.c.

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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
No changes
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

