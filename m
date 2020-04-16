Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717AFC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F1221D79
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504457AbgDPJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:55:33 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:49146 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504241AbgDPJzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:55:22 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 129C84E65D5;
        Thu, 16 Apr 2020 15:42:02 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3,3/4] powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
Date:   Thu, 16 Apr 2020 00:41:40 -0700
Message-Id: <20200416074141.3555-4-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416074141.3555-1-wenhu.wang@vivo.com>
References: <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200416074141.3555-1-wenhu.wang@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVCTU5LS0tKTklOQ0xDQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Kio*Djg6DgguHSNPKj8d
        KRNPCQxVSlVKTkNMS0lJQklJT0NLVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlDSUw3Bg++
X-HM-Tid: 0a7181f002689376kuws129c84e65d5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function instantiate_cache_sram should not be linked into the init
section for its caller mpc85xx_l2ctlr_of_probe is none-__init.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <oss@buserror.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Fixes: 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Warning information:
  MODPOST vmlinux.o
WARNING: modpost: vmlinux.o(.text+0x1e540): Section mismatch in reference from the function mpc85xx_l2ctlr_of_probe() to the function .init.text:instantiate_cache_sram()
The function mpc85xx_l2ctlr_of_probe() references
the function __init instantiate_cache_sram().
This is often because mpc85xx_l2ctlr_of_probe lacks a __init
annotation or the annotation of instantiate_cache_sram is wrong.
---
Changes since v1:
 * None
Changes since v2:
 * None
---
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index be3aef4229d7..3de5ac8382c0 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -68,7 +68,7 @@ void mpc85xx_cache_sram_free(void *ptr)
 }
 EXPORT_SYMBOL(mpc85xx_cache_sram_free);
 
-int __init instantiate_cache_sram(struct platform_device *dev,
+int instantiate_cache_sram(struct platform_device *dev,
 		struct sram_parameters sram_params)
 {
 	int ret = 0;
-- 
2.17.1

