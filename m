Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85189C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5684322A99
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753022;
	bh=iRx1+1p0vuvi3P51WF8Ek61xIZ9udJj8O2ghz7fif+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tu1ibukCXAotnfmbS2Z6ZgZE4XaVQ0QyYtC7G4Dzlr+wBvnd+n5UD3dEEqAIHDIEk
	 V4GI3TnFfpFZxNk58iEy+atPgzeNclIxedCzgd0gNqtxJNs3GvFXGlIMQv1tet8DZ8
	 ZeCix8g8IsawWGlL0xh1Itp0nrA8e/6IJgrpFgJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgGNS5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbgGNS4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F956229CA;
        Tue, 14 Jul 2020 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753011;
        bh=iRx1+1p0vuvi3P51WF8Ek61xIZ9udJj8O2ghz7fif+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkteAJYMrzERJ7AUJbYV3xWhX3eXhQGkNE0ieFTxLaTldTCEXUyMqSX2gY7CQBgLg
         2M0pDfjLKVBLkpLJeo2xd1F5FdXk2nz2Xv+Ff0/pXRfE1IjaB+E3PHAtfd6a8XgLG8
         6onPx2G0ptDyacImHe8BXaxYzZZ7rsZkJffeb2Ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 085/166] powerpc/64s/exception: Fix 0x1500 interrupt handler crash
Date:   Tue, 14 Jul 2020 20:44:10 +0200
Message-Id: <20200714184119.922263353@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 4557ac6b344b8cdf948ff8b007e8e1de34832f2e ]

A typo caused the interrupt handler to branch immediately to the
common "unknown interrupt" handler and skip the special case test for
denormal cause.

This does not affect KVM softpatch handling (e.g., for POWER9 TM
assist) because the KVM test was moved to common code by commit
9600f261acaa ("powerpc/64s/exception: Move KVM test to common code")
just before this bug was introduced.

Fixes: 3f7fbd97d07d ("powerpc/64s/exception: Clean up SRR specifiers")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
[mpe: Split selftest into a separate patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200708074942.1713396-1-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d9ddce40bed89..fd99d4feec7a4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -2547,7 +2547,7 @@ EXC_VIRT_NONE(0x5400, 0x100)
 INT_DEFINE_BEGIN(denorm_exception)
 	IVEC=0x1500
 	IHSRR=1
-	IBRANCH_COMMON=0
+	IBRANCH_TO_COMMON=0
 	IKVM_REAL=1
 INT_DEFINE_END(denorm_exception)
 
-- 
2.25.1



