Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F2424689
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695430;
	bh=srniN4CiNuP4PYbnTDO3bRXaLP6mOfMqnGdnkOmKyYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3malTKuiOP/z6o9iN2E4N56IUJJrzj5HPMJJhpWL2QW50jprcrnCtBKxwvTXgyAI
	 bmayWM8bzZmv1JHFPXqAZdcH/2C0bql1KklfU0aGJnpCZhyd4mphkelY9J7thCf4Wc
	 RmOuVrp3MS8rQfmq2SZ8+9z/pDhZ6DPR42NyGLMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgBNPua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbgBNPuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:50:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19EEA2467E;
        Fri, 14 Feb 2020 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695420;
        bh=srniN4CiNuP4PYbnTDO3bRXaLP6mOfMqnGdnkOmKyYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h91e6ucP0T1At2KSsiBxu3uWtYfE2QPqdJy2cOnNe+NUmbNIiZ81/uy9UK+kJAgf6
         AH65qD3JDG2sYqQEe2rvIWX7Ymz8nT3vpUR2hxhjg3SHiR0QB79pzUYShzj9pLYzkl
         jIZMRspggnACBLI2/09au2znCaIMrTe2b6b5VaTE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 065/542] sparc: Add .exit.data section.
Date:   Fri, 14 Feb 2020 10:40:57 -0500
Message-Id: <20200214154854.6746-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index 7ec79918b566b..f99e99e58075f 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -171,12 +171,14 @@ SECTIONS
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

