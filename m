Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313D0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C9E208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCYOTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:19:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCYOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:15 -0400
IronPort-SDR: rJ+wH8GBTdJTMvBtX4w0Sgc6lgubU4NN5qD4e93iNYyF2H6Fg8mQ4sh/caxmyFnJ4BM+HO/99U
 32bvRxZ5yt+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:14 -0700
IronPort-SDR: 4H79Xduv0tr8WhWLlYX2sZf/cFARLTnkV0zUg9oyVLp/e7zBA78wp5ouHmwOYjqAEfAUPre3zy
 PEDsw/BCRJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811091"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:13 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 3/6] selftests: kvm: Use the default linux header path only when INSTALL_HDR_PATH not defined
Date:   Wed, 25 Mar 2020 22:01:30 +0800
Message-Id: <20200325140133.103236-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a way for lib.mk or parent Makefile to tell where the
linux headers are installed.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 504a5fb0fa71..6f08cc512e15 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -47,7 +47,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
 include ../lib.mk
 
-INSTALL_HDR_PATH = $(top_srcdir)/usr
+INSTALL_HDR_PATH ?= $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
-- 
2.20.1

