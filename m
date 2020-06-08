Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA73720884
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659502;
	bh=O8IWCH0+m0cboLHYQfjEKVL7l4XdRgeHAKtk8lol+os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJXH+0Zc+L+RrgtwhyjFbhbk2q8etjw0iJ7jI6kbj3mXavhPs4k2BXvsIo5TFMrmb
	 +cUzr2CoxC+M5a2umEOpjMLmJb56hHz7WA2ua0+4JBnSF7dIpWKyj0tYPy5NEW4w3n
	 Gm6E47wrtTCDNy5lt1UxcBbEw+EX1ZJKwgWwBa1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgFHXiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbgFHX23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:28:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1767D20853;
        Mon,  8 Jun 2020 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658908;
        bh=O8IWCH0+m0cboLHYQfjEKVL7l4XdRgeHAKtk8lol+os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcxGmjX0rp4dI3fXjvthygaTjwmFo2H0DTljS6KERvhMLBaBN2UCvZcThoXeCyook
         kioM/lojLhUZ/Qx2Zs4BbaMIVbHZXtLirBXDFE09gAtro1Y9gQH2GE4RmgP0ngEUKU
         Kb9vPbEylNA8kYFeY+AwBr7FMwanQXmTiVhGAGsg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 28/37] x86/mm: Stop printing BRK addresses
Date:   Mon,  8 Jun 2020 19:27:40 -0400
Message-Id: <20200608232750.3370747-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232750.3370747-1-sashal@kernel.org>
References: <20200608232750.3370747-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit 67d631b7c05eff955ccff4139327f0f92a5117e5 ]

This currently leaks kernel physical addresses into userspace.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/20200229231120.1147527-1-nivedita@alum.mit.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f00eb52c16a6..17eb564901ca 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -109,8 +109,6 @@ __ref void *alloc_low_pages(unsigned int num)
 	} else {
 		pfn = pgt_buf_end;
 		pgt_buf_end += num;
-		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
-			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
 	}
 
 	for (i = 0; i < num; i++) {
-- 
2.25.1

