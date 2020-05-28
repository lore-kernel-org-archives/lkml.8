Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49915C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1B8207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696975;
	bh=mlq9mjd9i3OvLkIbEfKiuimRPI+OO5yjsoj+PUunLx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTc7ryTgQ4+4rsIs2mk6fUCYqPcMdfOCYnZmw7FfRGj3I2QZXefE7Yu/Y1ZVJbMSL
	 a2BZm4o6osfRaF/7vQd0EyEHPRrmmGnGWh/IoHG5NC/PAY1lrsFWu93qBK2Y2EtQD6
	 zihT6VW+Fnp7Z6Wsrki/d6X8sXD0GLndcXHrN5QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407188AbgE1UQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407054AbgE1UOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E00921508;
        Thu, 28 May 2020 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696881;
        bh=mlq9mjd9i3OvLkIbEfKiuimRPI+OO5yjsoj+PUunLx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrXPba83pJySxfbiDQeF+GuTvltVY4Sw/vu76ACO4otbqNYUDlBmpwx0naWiiEtZ2
         tp1qaCow5XueglVssIqY+3NxougoIaFCXn341IvDTcNxR1dgc+9fL1ACOS3Aj3ybgo
         2J9CsiyEIwVct0nSVtqz3TPXIPEsnP7aH1eGASxA=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 15/16] selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base write
Date:   Thu, 28 May 2020 16:14:01 -0400
Message-Id: <20200528201402.1708239-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

The test validates that the selector is not changed when a ptracer writes
the ptracee's GS base.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/x86/fsgsbase.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 15a329da59fa..950a48b2e366 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -465,7 +465,7 @@ static void test_ptrace_write_gsbase(void)
 	wait(&status);
 
 	if (WSTOPSIG(status) == SIGTRAP) {
-		unsigned long gs, base;
+		unsigned long gs;
 		unsigned long gs_offset = USER_REGS_OFFSET(gs);
 		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
 
@@ -481,7 +481,6 @@ static void test_ptrace_write_gsbase(void)
 			err(1, "PTRACE_POKEUSER");
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
-		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
 
 		/*
 		 * In a non-FSGSBASE system, the nonzero selector will load
@@ -489,11 +488,21 @@ static void test_ptrace_write_gsbase(void)
 		 * selector value is changed or not by the GSBASE write in
 		 * a ptracer.
 		 */
-		if (gs == 0 && base == 0xFF) {
-			printf("[OK]\tGS was reset as expected\n");
-		} else {
+		if (gs != *shared_scratch) {
 			nerrs++;
-			printf("[FAIL]\tGS=0x%lx, GSBASE=0x%lx (should be 0, 0xFF)\n", gs, base);
+			printf("[FAIL]\tGS changed to %lx\n", gs);
+
+			/*
+			 * On older kernels, poking a nonzero value into the
+			 * base would zero the selector.  On newer kernels,
+			 * this behavior has changed -- poking the base
+			 * changes only the base and, if FSGSBASE is not
+			 * available, this may not effect.
+			 */
+			if (gs == 0)
+				printf("\tNote: this is expected behavior on older kernels.\n");
+		} else {
+			printf("[OK]\tGS remained 0x%hx\n", *shared_scratch);
 		}
 	}
 
-- 
2.25.1

