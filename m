Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99323C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706DF208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCYOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:19:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:42324 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgCYOTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:19:18 -0400
IronPort-SDR: jdWQvCxxTRj4iV6A7OAmTec6DGI/ZOs9OX3yKxFEwbr3ZShEO+lW/3AHkRROBWF2nwyofWxCyL
 ThqyBWC7zdNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 07:19:18 -0700
IronPort-SDR: EBZTjwGrszcrOJd1OusRu6pAF/QeY9h6z1Hf9EGzkMHDjiJjEnasC6FGVKWVIRngdfL6Ppj0aU
 0KtJluk4LtAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="270811112"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga004.fm.intel.com with ESMTP; 25 Mar 2020 07:19:16 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 5/6] selftests: Generate build output of linux headers to $(OUTPUT)/linux-header-build
Date:   Wed, 25 Mar 2020 22:01:32 +0800
Message-Id: <20200325140133.103236-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build linux headers for selftests with OUTPUT specified, it makes
linux src tree not clean.

Fix it by generating the output file of "headers_install" to a fixed dir
in $(OUTPUT).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/lib.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b51ff93da4de..bb830e4817fc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -66,6 +66,7 @@ ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
 	make --no-builtin-rules INSTALL_HDR_PATH=$(INSTALL_HDR_PATH) \
+		O=$(OUTPUT)/linux-header-build \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 endif
-- 
2.20.1

