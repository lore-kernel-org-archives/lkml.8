Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00587C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDCB2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgAJM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:43916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgAJM2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:28:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7AC1063;
        Fri, 10 Jan 2020 04:28:37 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BA73F534;
        Fri, 10 Jan 2020 04:28:37 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH] drivers: optee: Fix compilation issue.
Date:   Fri, 10 Jan 2020 12:28:07 +0000
Message-Id: <20200110122807.49617-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optee driver uses specific page table types to verify if a memory
region is normal. These types are not defined in nommu systems. Trying
to compile the driver in these systems results in a build error:

  linux/drivers/tee/optee/call.c: In function ‘is_normal_memory’:
  linux/drivers/tee/optee/call.c:533:26: error: ‘L_PTE_MT_MASK’ undeclared
     (first use in this function); did you mean ‘PREEMPT_MASK’?
     return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
                             ^~~~~~~~~~~~~
                             PREEMPT_MASK
  linux/drivers/tee/optee/call.c:533:26: note: each undeclared identifier is
     reported only once for each function it appears in
  linux/drivers/tee/optee/call.c:533:44: error: ‘L_PTE_MT_WRITEALLOC’ undeclared
     (first use in this function)
     return (pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC;
                                            ^~~~~~~~~~~~~~~~~~~

Make the optee driver depend on MMU to fix the compilation issue.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/tee/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index d1ad512e1708..3ca71e3812ed 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -3,6 +3,7 @@
 config OPTEE
 	tristate "OP-TEE"
 	depends on HAVE_ARM_SMCCC
+	depends on MMU
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
-- 
2.24.1

