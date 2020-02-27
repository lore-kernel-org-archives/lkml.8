Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC80BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AA324656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814532;
	bh=Wvyy3v03P7E1IVhVXI6dTmZh+RPcm3cg0+Jgcl5hbLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ManYjDzVjQqaCf8NRioBC/AvJerJdrU9hEh83Hl0h4/v6zdOyC5QFQFuMYGX0cY5h
	 JGJMFUfg28WhtV0po1CkSI1i3+mUIkbYpy1hO82BG+ysLMRMbZ2sC0k2uc8lgriGQQ
	 OLRYJFsXuMbQbQdD58hGdxjCh8PXoi8wy14HhOdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgB0Nue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgB0Nub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E90420578;
        Thu, 27 Feb 2020 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811431;
        bh=Wvyy3v03P7E1IVhVXI6dTmZh+RPcm3cg0+Jgcl5hbLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQ3C9JrgRLMuqskPiTXcgqOwzGVL74BL8bsOmNnloLeRnEkb2KvReXEXQJzy4To97
         Xbm+Uh5786GJKkyN7whd+RTAJ+o5tWFZi7Vtbypu4JnG95esqtWsOMv0K2nYT7x3vt
         oilxMzNySsPbuUSkqvfDMqALW+CxUJbtnsdyGq4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 091/165] x86/decoder: Add TEST opcode to Group3-2
Date:   Thu, 27 Feb 2020 14:36:05 +0100
Message-Id: <20200227132244.605299517@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



