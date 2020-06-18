Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8419C214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447371;
	bh=nZJGhbo9IBSAjzvkZkeVSYjGPNmAlmVn/KRbXGPmTRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rByF5X8v3tvpGyS1yx9pWMFil7h/T7LxGbr9zWGElwYw9D2OXRxirnbEQoxqRDgVC
	 QMLwLZscWzJ+/e29avx0FKgQzuQqyOP+nwEeDF0FgU5gg9/9aDHgV9fh/R8LU4xRbC
	 vwsAnqIxXjyBQOcfuoTEEkFABKwzooJjvrtywieY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgFRC3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgFRBQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6B221D79;
        Thu, 18 Jun 2020 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442971;
        bh=nZJGhbo9IBSAjzvkZkeVSYjGPNmAlmVn/KRbXGPmTRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bpd7WL6baf3QA5Pbgk40JFRk2iHTqBQwtJa3w/FE+GcJgkNAFSx2d3gxi+AfCdowr
         txs7of+h0jPupQLVi4LdjIzftTFFLNFrLVKqeHA2C90rtaTIEbxgL64DXSgfEt9Zlv
         QeXjI4MUdAngeJWb4C27x+ajzzn9Na44ecr2ZL4E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, kbuild test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 375/388] x86/mce/dev-mcelog: Fix -Wstringop-truncation warning about strncpy()
Date:   Wed, 17 Jun 2020 21:07:52 -0400
Message-Id: <20200618010805.600873-375-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 7ccddc4613db446dc3cbb69a3763ba60ec651d13 ]

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200527182808.27737-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.25.1

