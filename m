Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11768C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC67E217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698288;
	bh=Wvyy3v03P7E1IVhVXI6dTmZh+RPcm3cg0+Jgcl5hbLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJAB349Cs5NRFhCD+X1wmJAFlUMVfMFCMlOdRgBOKeEBBfhZKUUbt1f+ZLoHI145i
	 7ZweszuU322rmpHH+B3Srth3e4hPLkFgc679rhFTgNmHLR5469F39op6J00JT+U8Ll
	 hb9MvaM4ohla7Qw8mRFB9mrYvtHGRuMv/D8i3lsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbgBNQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405700AbgBNQXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:23:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39E92477D;
        Fri, 14 Feb 2020 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697420;
        bh=Wvyy3v03P7E1IVhVXI6dTmZh+RPcm3cg0+Jgcl5hbLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRNt6b6L3JG24tNlU9Rlhdwbf/NJPNbZa9sASQMw64f+j5Q1/H81ve3Ss46HEprML
         h79ZmJCx23RGb7Km57P3PkvNW24+LA643AU9x9K0iAtNMNuCw+mgXvZNM5lon5rMxy
         tFnXSqSK5nJMPRjzEYdPXNSJOyctdOtGJzqxnOe0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 110/141] x86/decoder: Add TEST opcode to Group3-2
Date:   Fri, 14 Feb 2020 11:20:50 -0500
Message-Id: <20200214162122.19794-110-sashal@kernel.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 8b7e20a7ba54836076ff35a28349dabea4cec48f ]

Add TEST opcode to Group3-2 reg=001b as same as Group3-1 does.

Commit

  12a78d43de76 ("x86/decoder: Add new TEST instruction pattern")

added a TEST opcode assignment to f6 XX/001/XXX (Group 3-1), but did
not add f7 XX/001/XXX (Group 3-2).

Actually, this TEST opcode variant (ModRM.reg /1) is not described in
the Intel SDM Vol2 but in AMD64 Architecture Programmer's Manual Vol.3,
Appendix A.2 Table A-6. ModRM.reg Extensions for the Primary Opcode Map.

Without this fix, Randy found a warning by insn_decoder_test related
to this issue as below.

    HOSTCC  arch/x86/tools/insn_decoder_test
    HOSTCC  arch/x86/tools/insn_sanity
    TEST    posttest
  arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  arch/x86/tools/insn_decoder_test: warning: ffffffff81000bf1:	f7 0b 00 01 08 00    	testl  $0x80100,(%rbx)
  arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 2
  arch/x86/tools/insn_decoder_test: warning: Decoded and checked 11913894 instructions with 1 failures
    TEST    posttest
  arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 random instructions with 0 errors (seed:0x871ce29c)

To fix this error, add the TEST opcode according to AMD64 APM Vol.3.

 [ bp: Massage commit message. ]

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/157966631413.9580.10311036595431878351.stgit@devnote2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/x86-opcode-map.txt               | 2 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 0f7eb4f5bdb71..82e105b284e01 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -909,7 +909,7 @@ EndTable
 
 GrpTable: Grp3_2
 0: TEST Ev,Iz
-1:
+1: TEST Ev,Iz
 2: NOT Ev
 3: NEG Ev
 4: MUL rAX,Ev
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
index 0f7eb4f5bdb71..82e105b284e01 100644
--- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
@@ -909,7 +909,7 @@ EndTable
 
 GrpTable: Grp3_2
 0: TEST Ev,Iz
-1:
+1: TEST Ev,Iz
 2: NOT Ev
 3: NEG Ev
 4: MUL rAX,Ev
-- 
2.20.1

