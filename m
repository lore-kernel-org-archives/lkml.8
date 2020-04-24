Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E7C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105792087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDXCrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:47:13 -0400
Received: from m139-178.yeah.net ([123.58.178.139]:57852 "EHLO
        m138-179.yeah.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgDXCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:47:12 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 23DA4104AC2;
        Fri, 24 Apr 2020 10:47:07 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     christophe.leroy@c-s.fr, oss@buserror.net, kernel@vivo.com,
        robh@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v3,0/5] misc: generic user level sram dynamic access support
Date:   Thu, 23 Apr 2020 19:45:49 -0700
Message-Id: <20200424024554.30709-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVOSk9CQkJDTU1PQ05NWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6OCo6Gjg8AlZPEikhORVD
        PkwwFB9VSlVKTkNMTUJNT0lCTUhOVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQU9OSEs3Bg++
X-HM-Tid: 0a71aa14e2029374kuws23da4104ac2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a new misc module that act as an interface for user level
applications to access SRAM memory dynamically. Freescale 85xx Cache-SRAM
is exact an example.

This is extremely helpful for the user level applications that require
high performance memory accesses, such as some embedded networking devices
that need to process data in user space.

The series also fix the compile errors and warning of the freescale 85xx
Cache-SRAM driver, and implement a module to register the SRAM device to
sram_dynamic module, which enables its access for users in user space.

Changes since v1: addressed comments from Arnd
 * Changed the ioctl cmd definitions using _IO micros
 * Export interfaces for HW-SRAM drivers to register apis to available list
 * Modified allocation alignment to PAGE_SIZE
 * Use phys_addr_t as type of SRAM resource size and offset
 * Support compat_ioctl
 * Misc device name:sram
 * Use tristate for SRAM_UAPI
 * Use postcore_initcall

Changes since v2: addressed comments from Arnd, greg and Scott
 * Name the module with sram_dynamic in comparing with drivers/misc/sram.c

    I tried to tie the sram_dynamic with the abstractions in sram.c as
    Arnd suggested, and actually sram.c probes SRAM devices from devicetree
    and manages them with different partitions and create memory pools which
    are managed with genalloc functions.

    Here sram_dynamic acts only as a interface to user space. A SRAM memory
    pool is managed by the module that registers APIs to us, such as the
    backend hardware driver of Freescale 85xx Cache-SRAM.

 * Create one sram_device for each backend SRAM device(from Scott)
 * Allow only one block of SRAM memory allocated to a file descriptor(from Scott)
 * Add sysfs files for every allocated SRAM memory block
 * More documentations(As Greg commented)
 * Make uapi and non-uapi components apart(from Arnd and Greg)
 * Add a new module to register freescale 85xx Cache-SRAM APIs to the
   sram_dynamic module

Wang Wenhu (5):
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  misc: sram_dynamic for user level SRAM access
  powerpc: sysdev: support userspace access of fsl 85xx sram

 .../powerpc/include/asm/fsl_85xx_cache_sram.h |   4 +
 arch/powerpc/platforms/85xx/Kconfig           |  10 +
 arch/powerpc/sysdev/Makefile                  |   1 +
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h     |   6 +
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c     |  15 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c         |   1 +
 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c      |  39 ++
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/sram_dynamic.c                   | 580 ++++++++++++++++++
 drivers/misc/sram_uapi.c                      | 351 +++++++++++
 include/linux/sram_dynamic.h                  |  23 +
 include/uapi/linux/sram.h                     |  11 +
 13 files changed, 1052 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c
 create mode 100644 drivers/misc/sram_dynamic.c
 create mode 100644 drivers/misc/sram_uapi.c
 create mode 100644 include/linux/sram_dynamic.h
 create mode 100644 include/uapi/linux/sram.h

-- 
2.17.1

