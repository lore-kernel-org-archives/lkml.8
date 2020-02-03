Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A462086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748199;
	bh=BDjz74+6EHpA358Rpo3pAmTLh3gEXKPR3UIGVHtDEV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OORARO1Q+5ti2SasfEeOF5o2jJKh2m3R7ektsR8D8L/mOnWKFHNXE+b5bqXqDQapN
	 3RE0ScBkD7wAf/BOklR1dKyV1RFuAc4qd0A5CtCtqKBRJyCLP0uMZR3XGv4BCBmpls
	 Ku4mYVXr5LdYO5FwDoFhoAFTbZHkeI/lLTE5QAUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgBCQnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbgBCQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:13 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFB72082E;
        Mon,  3 Feb 2020 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747592;
        bh=BDjz74+6EHpA358Rpo3pAmTLh3gEXKPR3UIGVHtDEV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckPW69qhtMJI3lB4tX2Gaf46zLFfJSZABHHzzEdRRBm9+4MCky1WXd1OnK6Rei2cy
         cfbjEJxmcP2KC8wFRwpFu05s56G92RPI0trkc++Am6iIwXYxAXXfc7IyEzML1DC5gC
         trGpxBBXBoJmraCwFw4/dpMYMXenhioBzwuros0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 59/70] tee: optee: Fix compilation issue with nommu
Date:   Mon,  3 Feb 2020 16:20:11 +0000
Message-Id: <20200203161920.746158380@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

[ Upstream commit 9e0caab8e0f96f0af7d1dd388e62f44184a75372 ]

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

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[jw: update commit title]
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 3c59e19029bef..3c1ec4e9ed29a 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -2,6 +2,7 @@
 config OPTEE
 	tristate "OP-TEE"
 	depends on HAVE_ARM_SMCCC
+	depends on MMU
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
-- 
2.20.1



