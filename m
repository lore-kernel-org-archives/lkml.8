Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1273C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8326F2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgE0SzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:55:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:2321 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0SzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:55:15 -0400
IronPort-SDR: Qs8/aBLzN6JTGMJXJ264P70K96skj7TptC1aJI3jRdePyYk8t+skRZVKXp3yYfpYQk4x+XdpR7
 lCVRC+TpXoKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 11:28:08 -0700
IronPort-SDR: tKsjVEh3ZU7P2XLmx+VAu0BhXojIKhFHGwG0/drSmLISM9x6iAPrzIiBUgty6CCbj/6kUZ9t/8
 oR2fMULD04uQ==
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="468840528"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 11:28:08 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, kbuild test robot <lkp@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce/dev-mcelog: Fix "make W=1" warning about strncpy
Date:   Wed, 27 May 2020 11:28:08 -0700
Message-Id: <20200527182808.27737-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild test robot reported this warning:

arch/x86/kernel/cpu/mce/dev-mcelog.c: In function 'dev_mcelog_init_device':
arch/x86/kernel/cpu/mce/dev-mcelog.c:346:2: warning: 'strncpy' output truncated before terminating nul copying 12 bytes from a string of the same length [-Wstringop-truncation]

This is accurate, but I don't care that the trailing NUL character isn't copied.
The string being copied is just a magic number signature so that crash dump
tools can be sure they are decoding the right blob of memory.

Change to use memcpy() instead of strncpy()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index d089567a9ce8..bcb379b2fd42 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -343,7 +343,7 @@ static __init int dev_mcelog_init_device(void)
 	if (!mcelog)
 		return -ENOMEM;
 
-	strncpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
+	memcpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
 	mcelog->len = mce_log_len;
 	mcelog->recordlen = sizeof(struct mce);
 
-- 
2.21.1

