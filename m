Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA95C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB02054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217955;
	bh=gepK8epY5y1X2So4zmONyxVbZIzOOcoBP1WVOXiBqls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfPfjoJ7B+fq4JjXl7lu4TUgmC/V+ZMPhPZgPqkgUWejB+9qPybK2x9ZmFSjIn0tN
	 9/dFbHVqKINqL09g54IFB4MNXzDG6k/NBUSdqQpN1a/Aqg6q0o3xXQ2w17+Rd2LoPB
	 0Ix/H2AsdLSnbDVrt7VUFL9RD6UI1zgi0bhKHTfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDRNwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgDRNsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:48:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9B92220A;
        Sat, 18 Apr 2020 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217721;
        bh=gepK8epY5y1X2So4zmONyxVbZIzOOcoBP1WVOXiBqls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obVOWQLq7ASNnaD/55Y9rWq+Lb/pmJBhaDaC7gsgiSVo5IaCKQZX/Nhe7pmlg2KL0
         wLMqCxpO1gtB2hO/TEenlE3hdDdfOMXvnZWuleu/rnmzsCnGSSo7G6DT157vXyjPYn
         AjmPbtRGxhO6u+4yS3kXd9NZ0OzXULfDaFy1ZQF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Santosh Sivaraj <santosh@fossix.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.6 21/73] tools/test/nvdimm: Fix out of tree build
Date:   Sat, 18 Apr 2020 09:47:23 -0400
Message-Id: <20200418134815.6519-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
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
index dbebf05f59313..47f9cc9dcd94b 100644
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

