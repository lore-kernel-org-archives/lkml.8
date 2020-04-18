Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508522054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 16:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDRQWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:22:34 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:5208 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgDRQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:22:33 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 4C9004E14C2;
        Sun, 19 Apr 2020 00:22:23 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, rdunlap@infradead.org,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v6,0/4] misc: new driver sram_uapi for user level SRAM access
Date:   Sat, 18 Apr 2020 09:21:53 -0700
Message-Id: <20200418162157.50428-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVLSkhCQkJCSENCTU9DT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Fww5Ijg4PA0YOCgvLD8S
        SAwaCypVSlVKTkNMSUlNQk9OTEtNVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlJTk43Bg++
X-HM-Tid: 0a718e1920799376kuws4c9004e14c2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a new misc device driver which act as an interface to
access the Cache-SRAM from user level. This is extremely helpful for
some user space applications that require high performance memory
accesses.

It also fixes the compile errors and warning of the Freescale MPC85xx
Cache-SRAM hardware driver.

The former five version implemented the driver with UIO but they were
commented of not fitful. This version uses a misc divice and implements
the memory allocation and free operations via file operation as suggested
by Scott.

Wang Wenhu (4):
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  drivers: misc: new driver sram_uapi for user level SRAM  access

 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |   3 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   1 +
 drivers/misc/Kconfig                      |  25 ++
 drivers/misc/Makefile                     |   1 +
 drivers/misc/sram_uapi.c                  | 294 ++++++++++++++++++++++
 5 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/sram_uapi.c

-- 
2.17.1

