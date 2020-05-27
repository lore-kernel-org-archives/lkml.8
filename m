Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25EBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A512088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgE0Tqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgE0Tqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:46:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7BC05BD1E;
        Wed, 27 May 2020 12:46:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1je20g-0005Fo-JB; Wed, 27 May 2020 21:46:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E6FCA1C00ED;
        Wed, 27 May 2020 21:46:41 +0200 (CEST)
Date:   Wed, 27 May 2020 19:46:41 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/dev-mcelog: Fix -Wstringop-truncation warning
 about strncpy()
Cc:     kbuild test robot <lkp@intel.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527182808.27737-1-tony.luck@intel.com>
References: <20200527182808.27737-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <159060880175.17951.17638659980921547843.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     45811ba140593e288a288c2a2e45d25f38d20d73
Gitweb:        https://git.kernel.org/tip/45811ba140593e288a288c2a2e45d25f38d20d73
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 27 May 2020 11:28:08 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 May 2020 21:19:38 +02:00

x86/mce/dev-mcelog: Fix -Wstringop-truncation warning about strncpy()

The kbuild test robot reported this warning:

  arch/x86/kernel/cpu/mce/dev-mcelog.c: In function 'dev_mcelog_init_device':
  arch/x86/kernel/cpu/mce/dev-mcelog.c:346:2: warning: 'strncpy' output \
    truncated before terminating nul copying 12 bytes from a string of the \
    same length [-Wstringop-truncation]

This is accurate, but I don't care that the trailing NUL character isn't
copied. The string being copied is just a magic number signature so that
crash dump tools can be sure they are decoding the right blob of memory.

Use memcpy() instead of strncpy().

Fixes: d8ecca4043f2 ("x86/mce/dev-mcelog: Dynamically allocate space for machine check records")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200527182808.27737-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index a4fd528..43c4660 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -349,7 +349,7 @@ static __init int dev_mcelog_init_device(void)
 	if (!mcelog)
 		return -ENOMEM;
 
-	strncpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
+	memcpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
 	mcelog->len = mce_log_len;
 	mcelog->recordlen = sizeof(struct mce);
 
