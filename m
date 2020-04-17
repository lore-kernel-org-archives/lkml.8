Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC6C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5A22083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgDQHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:17:04 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:32003 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDQHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:17:04 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 3055A4E1A4A;
        Fri, 17 Apr 2020 15:17:01 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5,2/4] powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
Date:   Fri, 17 Apr 2020 00:16:14 -0700
Message-Id: <20200417071616.44598-3-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417071616.44598-1-wenhu.wang@vivo.com>
References: <20200417071616.44598-1-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVDTk1CQkJDTE9KSk9CQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORA6IQw5Ejg4Qw4rAwo5DipM
        VikwCxRVSlVKTkNMSktMQ0lKTUNIVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhITUI3Bg++
X-HM-Tid: 0a7186ff77b89376kuws3055a4e1a4a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include linux/io.h into fsl_85xx_cache_sram.c to fix the
implicit-declaration compile error when building Cache-Sram.

arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                          ^~~~~~~~~~~~~~~~
                          bitmap_complement
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
                        ^
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
  iounmap(cache_sram->base_virt);
  ^~~~~~~
  roundup
cc1: all warnings being treated as errors

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
Changes since v1:
 * None
Changes since v2:
 * None
Changes since v3:
 * None
Changes since v4:
 * None
---
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index f6c665dac725..be3aef4229d7 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <asm/pgtable.h>
 #include <asm/fsl_85xx_cache_sram.h>
+#include <linux/io.h>
 
 #include "fsl_85xx_cache_ctlr.h"
 
-- 
2.17.1

