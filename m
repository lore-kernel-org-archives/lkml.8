Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E66C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3130D20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098824;
	bh=SgIOKnFekVTZdbg62jtE6S/vCStCN4oFmWjvD0J3m0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1iKIlHlUlamD5XtiRYyLt9Zv3asnDloIg3+DecTumG07xmdiCGUP5deuB5dA9O2c
	 BLmMlngn5R7gF/lQ2mOTfVF9SYXnseP0XcNdFM+dkHTA/ZzoS3qS1SaBOKgZ0SxXzI
	 0Ix3jS1mEw+Pqu2waSuVUszuxLZGYuzqrWLiL/88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgD1Sdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgD1Sdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:33:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A9920575;
        Tue, 28 Apr 2020 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098817;
        bh=SgIOKnFekVTZdbg62jtE6S/vCStCN4oFmWjvD0J3m0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPnSjBZI3EguP1QbqGM2S2u0YcAmlXXJW2r+1N6FLD5MX8hhXLfvOSDz+h4Yq6wMn
         c9DpUJ2MsQ4TvF+l5VRqOvBaLaRUOCcTWJKnqEr+Nvs0/iDkrhqg6Z8g334wCk2HFp
         UDy7WtJu4jH3X+bdplqu0lwIE1B94Gn23gly0kOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 019/168] tools/test/nvdimm: Fix out of tree build
Date:   Tue, 28 Apr 2020 20:23:13 +0200
Message-Id: <20200428182234.119453496@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



