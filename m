Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F003CC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31BD205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738550;
	bh=F8xxUZqQOqxyErUsW3bKT7syqrDgpPyqGIMaFytz2aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jB95NGRqgP0xzbOc2HM4efWmKH+8e6Km2EI1TDZHLSEe1ggdijmgs3As4JmA1/AD0
	 aLg65quGzOuPCZDm/X/A38/bvYkBG/QMsvqB+Fut7m9DeeKOrVDYO6O69OYI9XvhgY
	 fCBgrpVK2TwO8vHt0fAR7jaAdffhZ4vU8+Rd0Kno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgAKK3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731339AbgAKK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:29:05 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A783B205F4;
        Sat, 11 Jan 2020 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738544;
        bh=F8xxUZqQOqxyErUsW3bKT7syqrDgpPyqGIMaFytz2aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8Qa2wP/ET22jBAzax/qt9jFI5mGhciTtiLznTQxHHbLIag+XSKIFqhz9rWp+nbEh
         6b+cPezV5vkjOX4C/dswEigWdAFQVr+xpJiHNwXhuxo93P6etsUBzFHULp+stjBA8d
         haQnRV2xVmV1DyYL20A7cwDelVjbF0Bmgja3J1jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 116/165] s390/purgatory: do not build purgatory with kcov, kasan and friends
Date:   Sat, 11 Jan 2020 10:50:35 +0100
Message-Id: <20200111094932.607503279@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit c23587c92f6e3260fe3b82bb75b38aa2553b9468 ]

the purgatory must not rely on functions from the "old" kernel,
so we must disable kasan and friends. We also need to have a
separate copy of string.c as the default does not build memcmp
with KASAN.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/purgatory/Makefile | 6 ++++--
 arch/s390/purgatory/string.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/purgatory/string.c

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index bc0d7a0d0394..9de56065f28c 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -15,8 +15,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-$(obj)/string.o: $(srctree)/arch/s390/lib/string.c FORCE
-	$(call if_changed_rule,cc_o_c)
+KCOV_INSTRUMENT := n
+GCOV_PROFILE := n
+UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
diff --git a/arch/s390/purgatory/string.c b/arch/s390/purgatory/string.c
new file mode 100644
index 000000000000..c98c22a72db7
--- /dev/null
+++ b/arch/s390/purgatory/string.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define __HAVE_ARCH_MEMCMP	/* arch function */
+#include "../lib/string.c"
-- 
2.20.1



