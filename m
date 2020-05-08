Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF7C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A6621BE5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941386;
	bh=Ywg1sC8gAyR7OaVDWrOl3FM7ITijrisGnDgIQ63V4M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xb7681GvKMuBRBf+fq3HBv32yNQEonPtckQMsv8eRy0DrdWF9IShjm6apxCO0a3gT
	 WVRb9PAo2oGLoKVsfCW377vJ0ZsHjqqNEtoqvIWSaFw2yWoiwsK3ZYcVyrTgeVaYRN
	 029032IBdU9dH3FXpAmXGYuNxss/cBvzh75MT6Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEHMgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgEHMgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:36:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25E7207DD;
        Fri,  8 May 2020 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941382;
        bh=Ywg1sC8gAyR7OaVDWrOl3FM7ITijrisGnDgIQ63V4M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnn7x+UvN+PeC7yjSMvbjAXMK3pdoCnKxfJwVnWWykfrl/i8hNG4f8g5wjFy34TYi
         KoHUUnqZaSSLmWYWnkfhTY8uMsjmDHgTSI+hMoGWPaZ75QmIfCaJjNfu4IexPdEl3u
         tG1AoV9XN3byMhPownycGAKBw8Y+BdWxnpdikFJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 010/312] MIPS: ptrace: Drop cp0_tcstatus from regoffset_table[]
Date:   Fri,  8 May 2020 14:30:01 +0200
Message-Id: <20200508123125.237435709@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hogan <james.hogan@imgtec.com>

commit 555fae60b2bbb2d6282d82c5321d3adfa85b22ae upstream.

The cp0_tcstatus member of struct pt_regs was removed along with the
rest of SMTC in v3.16, commit b633648c5ad3 ("MIPS: MT: Remove SMTC
support"), however recent uprobes support in v4.3 added back a reference
to it in the regoffset_table[] in ptrace.c. Remove it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Fixes: 40e084a506eb ("MIPS: Add uprobes support.")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11920/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -670,9 +670,6 @@ static const struct pt_regs_offset regof
 	REG_OFFSET_NAME(c0_badvaddr, cp0_badvaddr),
 	REG_OFFSET_NAME(c0_cause, cp0_cause),
 	REG_OFFSET_NAME(c0_epc, cp0_epc),
-#ifdef CONFIG_MIPS_MT_SMTC
-	REG_OFFSET_NAME(c0_tcstatus, cp0_tcstatus),
-#endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	REG_OFFSET_NAME(mpl0, mpl[0]),
 	REG_OFFSET_NAME(mpl1, mpl[1]),


