Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F3C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9303F2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698646;
	bh=bUl18KgYsD1pERCGM7Tr1bxlg61pSdWjL5hSVsWT+90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d0Z0+/g2AsecVMKN5aVY/meirtzme6DkDMGIgdNiYgh8bC2k95+VnHIf26bW8pUWc
	 3T/6Uwjhdvswu1eBbIgzNZAtWo9mKsjgP6LXnNDuPgpfsqr+I/VdFlqqkjU/JUqwad
	 PLIvnGqH2sqtM1ALVY97vMVChoi/UoGbsjUeKFw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393975AbgBNQoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393081AbgBNQVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA665246BB;
        Fri, 14 Feb 2020 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697306;
        bh=bUl18KgYsD1pERCGM7Tr1bxlg61pSdWjL5hSVsWT+90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02vcwAtnAuMSd8xFb4cCqsINh94vGz8pK+gYNDXDR/Byfm6U0NvyS+N+rhY1NaqlT
         eY2Xakvmc1ok5zVKc02wQgGr3vrvkjuZ2o+56QhNBAFNTMDgfKeQNamvK1FgNBR2Pc
         fIc3dXvJFEJ1+yEWZkTZP1Gc1+CvpOe4tgWSMqbU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 018/141] sparc: Add .exit.data section.
Date:   Fri, 14 Feb 2020 11:19:18 -0500
Message-Id: <20200214162122.19794-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 548f0b9a5f4cffa0cecf62eb12aa8db682e4eee6 ]

This fixes build errors of all sorts.

Also, emit .exit.text unconditionally.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 572db686f8458..385d6d04564d5 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -151,12 +151,14 @@ SECTIONS
 	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
-#ifdef CONFIG_JUMP_LABEL
 	. = ALIGN(PAGE_SIZE);
 	.exit.text : {
 		EXIT_TEXT
 	}
-#endif
+
+	.exit.data : {
+		EXIT_DATA
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-- 
2.20.1

