Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC47C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E372087E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660408;
	bh=1oK27HoEFJF1QmKyJidF9LZ7dDibAQb3VONl+MODBtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EIDDiaWah3Uj6IlZPgvf+Z1iKIMGAZAyOkTTzCCK6CWXfYCTl0+u2vNO2EbzueILY
	 NvqN4eQveGr4BsM4jKjgjoYfzHZsOkaC6dOJoqzTfyrXnWUGTgxwZ33UQOglAMSGvT
	 ZWN0o4AzYOu/2hQiBhmP7+YJLN2w59QzO/ttAABo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgFHXx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbgFHXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1714A20814;
        Mon,  8 Jun 2020 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658669;
        bh=1oK27HoEFJF1QmKyJidF9LZ7dDibAQb3VONl+MODBtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GI/ZIFyZGBURgql/+1yEdSr8Rt/DKB9N0N+IZAbEHGIiqsOqDeQofp8niG7OwAxD+
         aj9x5yP6HEGF76m4Lmt9KiBRqIHXG3U7W+9WkvAaKoCGIddKJzhX+Ie0QwUVUpufsA
         AHVCZR4uJx4Hfv8j7H3sBn614nQPpvMJlMUZzlSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 084/106] x86/mm: Stop printing BRK addresses
Date:   Mon,  8 Jun 2020 19:22:16 -0400
Message-Id: <20200608232238.3368589-84-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
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
index fb5f29c60019..b1dba0987565 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -120,8 +120,6 @@ __ref void *alloc_low_pages(unsigned int num)
 	} else {
 		pfn = pgt_buf_end;
 		pgt_buf_end += num;
-		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
-			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
 	}
 
 	for (i = 0; i < num; i++) {
-- 
2.25.1

