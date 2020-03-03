Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C5DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052624677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204377;
	bh=egww1Wfu3m+4RPSFeQYfw/gb9+6hKwExwbsqGir9EUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mrXX3cJ0uy5Qkq4uwi2iFYvOlBNv404ZV030ocffk0rtgxFxEsoAlJQAILL13H425
	 UHP6hZDUukKK+Zh9PCROF5xTa2dFBoryVEFENhA5xooqM+FdUjlm0BgO4EdIJK3NYa
	 igbUvFF4ynNLLXz/cY4Q88qv0lNOOd0UUIDITGyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCCCri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgCCCrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FF124684;
        Tue,  3 Mar 2020 02:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203655;
        bh=egww1Wfu3m+4RPSFeQYfw/gb9+6hKwExwbsqGir9EUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUuPcJkKdu6vVYPxbksyDV45sfvnWh4bs2XeRo1TjCsPF+gnB2aNHn6JwLpkphThL
         GhVi7e73oRnPrQbn0KMqA2rRTAaV/ueBjBcTWKAtlcE+qPiMwtE/QeCkq+IpQAF08f
         eHCUgkVUHlxdlM8IQxblsOeNfWwMQKorI1orYDTQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Guo Ren <guoren@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 65/66] arch/csky: fix some Kconfig typos
Date:   Mon,  2 Mar 2020 21:46:14 -0500
Message-Id: <20200303024615.8889-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit bebd26ab623616728d6e72b5c74a47bfff5287d8 ]

Fix wording in help text for the CPU_HAS_LDSTEX symbol.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index da09c884cc305..2265227b7df8f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -75,7 +75,7 @@ config CPU_HAS_TLBI
 config CPU_HAS_LDSTEX
 	bool
 	help
-	  For SMP, CPU needs "ldex&stex" instrcutions to atomic operations.
+	  For SMP, CPU needs "ldex&stex" instructions for atomic operations.
 
 config CPU_NEED_TLBSYNC
 	bool
-- 
2.20.1

