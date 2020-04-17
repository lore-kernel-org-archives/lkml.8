Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77276C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D97F2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgDQHQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:16:59 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:41134 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDQHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:16:59 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id CC3B04E1AC1;
        Fri, 17 Apr 2020 15:16:53 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, oss@buserror.net, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v5,0/4] drivers: uio: new driver uio_fsl_85xx_cache_sram
Date:   Fri, 17 Apr 2020 00:16:12 -0700
Message-Id: <20200417071616.44598-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVITkpCQkJMTkJNTE9LTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6Cyo*Tzg8Gg4aEwoBDhoU
        ITBPFBdVSlVKTkNMSktMQ0pNSUlCVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhLQk83Bg++
X-HM-Tid: 0a7186ff5ad89376kuwscc3b04e1ac1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a new uio driver for freescale 85xx platforms to
access the Cache-Sram form user level. This is extremely helpful
for the user-space applications that require high performance memory
accesses.

It fixes the compile errors and warning of the hardware level drivers
and implements the uio driver in uio_fsl_85xx_cache_sram.c.

Changes since v1:
 * Addressed comments from Greg K-H
 * Moved kfree(info->name) into uio_info_free_internal()

Changes since v2:
 * Drop the patch that modifies Kconfigs of arch/powerpc/platforms
   and modified the sequence of patches:
    01:dropped, 02->03, 03->02, 04->01, 05->04
 * Addressed comments from Greg, Scott and Christophe
 * Use "uiomem->internal_addr" as if condition for sram memory free,
   and memset the uiomem entry
 * Modified of_match_table make the driver apart from Cache-Sram HW info
   which belong to the HW level driver fsl_85xx_cache_sram to match
 * Use roundup_pow_of_two for align calc
 * Remove useless clear block of uiomem entries.
 * Use UIO_INFO_VER micro for info->version, and define it as
   "devicetree,pseudo", meaning this is pseudo device and probed from
   device tree configuration
 * Select FSL_85XX_CACHE_SRAM rather than depends on it

Changes since v3:
 * Addressed comments from Christophe(use devm_xxx memory alloc interfaces)
 
Changes since v4:
 * Use module_param_string for of_match_table, no binding to devicetree

Wang Wenhu (4):
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  drivers: uio: new driver for fsl_85xx_cache_sram

 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
 drivers/uio/Kconfig                       |   9 ++
 drivers/uio/Makefile                      |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c     | 154 ++++++++++++++++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

-- 
2.17.1

