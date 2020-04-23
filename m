Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEBC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9A020784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684178;
	bh=DswPyppy6DsuZJuxJzz1O49kR/hwUH8NeS16nf4Flnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nEg6qg7OLlGuRbysC88W7rXNps6In5qve8oQpWBdnAu38/fsgEc56zHfT/FO+wY2m
	 Qp+J8CPzGdbdDpSKRatu1MgNDJJprsPINFDncWfPS7kcSxQ5UoVVPDmzHPopxzQRqU
	 odfbcjJQ60YDVvQ1mJtVR9YPcPQ5/n6NEACqTUQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgDWXW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgDWXWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE39321655;
        Thu, 23 Apr 2020 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684152;
        bh=DswPyppy6DsuZJuxJzz1O49kR/hwUH8NeS16nf4Flnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZxI9yXP5f4IqRr55kQzdkLNFSsVtK3EG4N+rXRZIG8PJW+ejQ8EZixt3OgdX+QN5
         CV2py0ZfM8cfNPnKAx9Y6TC2yxKdzv46fAXJm2a8psh+M1k47/Zgfcc/ti/DT6EEbU
         qIlRPCBKh/p50aeFY721C+1iG48CPljcZ/cpxP6s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 15/18] selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE
Date:   Thu, 23 Apr 2020 19:22:04 -0400
Message-Id: <20200423232207.5797-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

This validates that GS selector and base are independently preserved in
ptrace commands.

Suggested-by: Andy Lutomirski <luto@kernel.org>
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
 tools/testing/selftests/x86/fsgsbase.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 950a48b2e3662..9a4349813a30a 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -465,7 +465,7 @@ static void test_ptrace_write_gsbase(void)
 	wait(&status);
 
 	if (WSTOPSIG(status) == SIGTRAP) {
-		unsigned long gs;
+		unsigned long gs, base;
 		unsigned long gs_offset = USER_REGS_OFFSET(gs);
 		unsigned long base_offset = USER_REGS_OFFSET(gs_base);
 
@@ -481,6 +481,7 @@ static void test_ptrace_write_gsbase(void)
 			err(1, "PTRACE_POKEUSER");
 
 		gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
+		base = ptrace(PTRACE_PEEKUSER, child, base_offset, NULL);
 
 		/*
 		 * In a non-FSGSBASE system, the nonzero selector will load
@@ -501,8 +502,14 @@ static void test_ptrace_write_gsbase(void)
 			 */
 			if (gs == 0)
 				printf("\tNote: this is expected behavior on older kernels.\n");
+		} else if (have_fsgsbase && (base != 0xFF)) {
+			nerrs++;
+			printf("[FAIL]\tGSBASE changed to %lx\n", base);
 		} else {
-			printf("[OK]\tGS remained 0x%hx\n", *shared_scratch);
+			printf("[OK]\tGS remained 0x%hx", *shared_scratch);
+			if (have_fsgsbase)
+				printf(" and GSBASE changed to 0xFF");
+			printf("\n");
 		}
 	}
 
-- 
2.20.1

