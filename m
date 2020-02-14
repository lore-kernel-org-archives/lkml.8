Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8101E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703312;
	bh=FLZzOL6P9wTGzHQT/Jx3T0luRs0YyHB9UZhwVaCmjqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2aHyMTrLYdv+lNfaF/tE6KJK3A3w5+OVBoQ6gPIf4Elmv5lfcJeYCLvZ2AoB0RfV4
	 U6p8hr+8T2wIVdh/pHlz5Sr7NqM/8cy0dotGeOp2D7rRqLU9zoxN1QZvWGfAHCqE+C
	 zgNHcmG8DzRPMS8l29PA47VQuNNPIWvPDNVnK/0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgBNSBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbgBNP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA39124685;
        Fri, 14 Feb 2020 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695767;
        bh=FLZzOL6P9wTGzHQT/Jx3T0luRs0YyHB9UZhwVaCmjqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qohPAfKSxy/jbnHoxt93Tm4CpCvnLUxvGFo0kjJoGqvSpXyPEz1xBkrlR+tT1jbOz
         dR0uPbaIbdOpL9dwDw9/U0frfK+3WjXxuZkj7mvViJLhkHPOa2x6xx5cgc1jU7EYWj
         ykqS7Wzhpn9UJfjZrKwl8jsS4YR0qMC3/p0Lh/uQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 334/542] arm64: kernel: Correct annotation of end of el0_sync
Date:   Fri, 14 Feb 2020 10:45:26 -0500
Message-Id: <20200214154854.6746-334-sashal@kernel.org>
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 73d6890fe8ff40e357039b626537ac82d8782aeb ]

Commit 582f95835a8fc812c ("arm64: entry: convert el0_sync to C") caused
the ENDPROC() annotating the end of el0_sync to be placed after the code
for el0_sync_compat. This replaced the previous annotation where it was
located after all the cases that are now converted to C, including after
the currently unannotated el0_irq_compat and el0_error_compat. Move the
annotation to the end of the function and add separate annotations for
the _compat ones.

Fixes: 582f95835a8fc812c (arm64: entry: convert el0_sync to C)
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7c6a0a41676f8..d54d165b286a3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -653,6 +653,7 @@ el0_sync:
 	mov	x0, sp
 	bl	el0_sync_handler
 	b	ret_to_user
+ENDPROC(el0_sync)
 
 #ifdef CONFIG_COMPAT
 	.align	6
@@ -661,16 +662,18 @@ el0_sync_compat:
 	mov	x0, sp
 	bl	el0_sync_compat_handler
 	b	ret_to_user
-ENDPROC(el0_sync)
+ENDPROC(el0_sync_compat)
 
 	.align	6
 el0_irq_compat:
 	kernel_entry 0, 32
 	b	el0_irq_naked
+ENDPROC(el0_irq_compat)
 
 el0_error_compat:
 	kernel_entry 0, 32
 	b	el0_error_naked
+ENDPROC(el0_error_compat)
 #endif
 
 	.align	6
-- 
2.20.1

