Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E2C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B02A21974
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220877;
	bh=SgIOKnFekVTZdbg62jtE6S/vCStCN4oFmWjvD0J3m0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XnS3Y2ctmoYWsUrWJcNYV6ppr/o3wBbDy802gKvb5VfZL83eOZkGBOy+iCbVfqknm
	 9XbmRnpa4YmYl3BjLRGWMw15il+5MhsEsxUGjKVaNvNwbePeDvo6f3+Gp75rIgyXlJ
	 x7DOywPmU4fnQs4v8/HztrSLZ9uvEJzzmnr3bKlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgDROlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgDROlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BD121974;
        Sat, 18 Apr 2020 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220869;
        bh=SgIOKnFekVTZdbg62jtE6S/vCStCN4oFmWjvD0J3m0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EhouNq0b9t5KMThH1WQiovYXvI/1VAmFFZP85TdJ7M79AKFVcuZmSOeC6ku445T0P
         2d2gcpF4RzlSIOfL7uRsVjH7fshHybOir2nASnXKqN3FHCTu94BpOsyyAMtRBudKAY
         LaJhiIAJxPog5flGh9fu+Y2pID+OhYTYFhvtf52A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Santosh Sivaraj <santosh@fossix.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.4 18/78] tools/test/nvdimm: Fix out of tree build
Date:   Sat, 18 Apr 2020 10:39:47 -0400
Message-Id: <20200418144047.9013-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Santosh Sivaraj <santosh@fossix.org>

[ Upstream commit 1f776799628139d0da47e710ad86eb58d987ff66 ]

Out of tree build using

   make M=tools/test/nvdimm O=/tmp/build -C /tmp/build

fails with the following error

make: Entering directory '/tmp/build'
  CC [M]  tools/testing/nvdimm/test/nfit.o
linux/tools/testing/nvdimm/test/nfit.c:19:10: fatal error: nd-core.h: No such file or directory
   19 | #include <nd-core.h>
      |          ^~~~~~~~~~~
compilation terminated.

That is because the kbuild file uses $(src) which points to
tools/testing/nvdimm, $(srctree) correctly points to root of the linux
source tree.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Link: https://lore.kernel.org/r/20200114054051.4115790-1-santosh@fossix.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/Kbuild      | 4 ++--
 tools/testing/nvdimm/test/Kbuild | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index c4a9196d794c9..cb80d3b811792 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -21,8 +21,8 @@ DRIVERS := ../../../drivers
 NVDIMM_SRC := $(DRIVERS)/nvdimm
 ACPI_SRC := $(DRIVERS)/acpi/nfit
 DAX_SRC := $(DRIVERS)/dax
-ccflags-y := -I$(src)/$(NVDIMM_SRC)/
-ccflags-y += -I$(src)/$(ACPI_SRC)/
+ccflags-y := -I$(srctree)/drivers/nvdimm/
+ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 
 obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
index fb3c3d7cdb9bd..75baebf8f4ba1 100644
--- a/tools/testing/nvdimm/test/Kbuild
+++ b/tools/testing/nvdimm/test/Kbuild
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(src)/../../../../drivers/nvdimm/
-ccflags-y += -I$(src)/../../../../drivers/acpi/nfit/
+ccflags-y := -I$(srctree)/drivers/nvdimm/
+ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 
 obj-m += nfit_test.o
 obj-m += nfit_test_iomap.o
-- 
2.20.1

