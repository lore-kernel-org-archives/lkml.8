Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C589C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9492088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696966;
	bh=BqmnFnU6JQ5sVJZD7pDiEmHsE9uhUAQzeEl2GAeaCaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2jJ+Ddl7FOMVtR9MDoEn5nolvFvwKylhL7QiC26/Qd19Syktf76GKXSj+/s2bXIaa
	 ivL3JD4zFeLIEOnyF+hwWs2gvzW53zd+VQWshOfFCM/SK4TcMtIoQI+VifVK/+oI+e
	 nOkbifxp884m0qMKtKtZlfTu+SHLjpOPP7dF31J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406882AbgE1UQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407058AbgE1UOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3124A2158C;
        Thu, 28 May 2020 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696884;
        bh=BqmnFnU6JQ5sVJZD7pDiEmHsE9uhUAQzeEl2GAeaCaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOtWhQA4VrqO+lc1MKMukEK7nmnA+eVi2fNq1NkcbbUwMMc3eqNdzpgAxfIfQ5D5a
         KASFwA+3rjyN/D/6B/ArD03vIOuDguf5WpYCL8c9fCi0pj8LV83tacZJNDTIUhfSlh
         dBh5/bMADaGIaptsLbLHcC6kHxet2jrFpcT0LO7c=
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
Subject: [PATCH v13 16/16] selftests/x86/fsgsbase: Test ptracer-induced GS base write with FSGSBASE
Date:   Thu, 28 May 2020 16:14:02 -0400
Message-Id: <20200528201402.1708239-17-sashal@kernel.org>
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
index 950a48b2e366..9a4349813a30 100644
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
2.25.1

