Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE572166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204112;
	bh=vGUOX+Fc8v/Nw6WwDblSI4csNM6cyIMB9lzoBuNt5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUih+HM9BL8XPEc/E/AFro01Bpz1Sv0q2S5ffmhf4CCkyr2J7h0pWXsZNuOmDC+Is
	 YS6utvoQio5HK24Bdt5vNPFLsEy8ZMZG+iLuQSlr6VGoeovptmXn1NyA8wLOqHxDaK
	 f36o8W2TeFW4lINJ+YKimP48KTV3JOhsb9/vhhLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgCCCtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgCCCst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55DC24684;
        Tue,  3 Mar 2020 02:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203728;
        bh=vGUOX+Fc8v/Nw6WwDblSI4csNM6cyIMB9lzoBuNt5d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8y3ay/MIPXr6b2OfZidn1jIRou1JAa4kgLCJVbVwUzqDZCLmga0cGNka4tqszCvk
         WEydxVzetcJY2aeXvoZE+UTfXowz1hL7Jr04UOU9NgZlZbR8SQU2IUPUBa8joUqvXm
         qoj+g0R7iFNzlnWR6Trz0q8lbz+CYejNp71pPiHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Guo Ren <guoren@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 57/58] arch/csky: fix some Kconfig typos
Date:   Mon,  2 Mar 2020 21:47:39 -0500
Message-Id: <20200303024740.9511-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
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
index 3973847b5f42e..25de20e526e50 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -74,7 +74,7 @@ config CPU_HAS_TLBI
 config CPU_HAS_LDSTEX
 	bool
 	help
-	  For SMP, CPU needs "ldex&stex" instrcutions to atomic operations.
+	  For SMP, CPU needs "ldex&stex" instructions for atomic operations.
 
 config CPU_NEED_TLBSYNC
 	bool
-- 
2.20.1

