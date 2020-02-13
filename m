Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486FCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1343120675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607984;
	bh=0JpwmsZ/dCRnbxb/Vf6ssYndXNRWnjW85QYgYtuvBFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRKsG6Dqd252C53I+NviY5sRbqmy4l2aQLHLrzxhBy87/VVyS5gntRFlkxD2xZFkp
	 v9f0vv/u6KyainMJLalIAD/V3L2Zy8cXHUNlxepTq5yyiOPW/UMqc0Icy+29xxAfXZ
	 q2Vgo1LVsxrOLV6AErShVVWZXtVED4VNseDcuCIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgBMPdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbgBMP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:52 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208B620661;
        Thu, 13 Feb 2020 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607731;
        bh=0JpwmsZ/dCRnbxb/Vf6ssYndXNRWnjW85QYgYtuvBFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsWdwhAOV45095KZLx6j/UvyhHeAnxTGw6OXtqHKImEQIulbCWiq3VSGsMg4kTVbe
         Ly6RxXvaV68BVsgIXrFv81gTyLrstvl1NA+yeYMmK8mLFNgzCV2rWYhOfNurLaxQ6J
         sAmAW0pTzI02C62nSOjta1KZRvk5UvbqWnSHN4Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.5 080/120] arm64: kernel: Correct annotation of end of el0_sync
Date:   Thu, 13 Feb 2020 07:21:16 -0800
Message-Id: <20200213151928.453083582@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 73d6890fe8ff40e357039b626537ac82d8782aeb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/entry.S |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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


