Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC15EC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A553220732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052362;
	bh=AkmUSef8AZSysoXpdP9BYzpEVG+EqMyehV9XhTMGm60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OYuV9BtutLQe70LWfOOmybMs7aqvnJzfP+8M+Eda7EEm8+VxcHWSkrK1n18t5+F5G
	 p64TL9eaoE6LGPci70SFOrSSZyJw8ac91APTVsajr1+dSNU+1/fd+MwDdAdJDN97in
	 RVz4e94+4q/eN+P2SZnPirjY6/6qd/3uwWr9c/LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442617AbgDPPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896576AbgDPNcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:32:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8396722260;
        Thu, 16 Apr 2020 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043913;
        bh=AkmUSef8AZSysoXpdP9BYzpEVG+EqMyehV9XhTMGm60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8WVjATeowDhcyybtHUAnFK8hC5n4rkyDGmSp7mwpM6jDhnWNJDZAiCOk+VymnG2w
         2CwVmZBHSoz1WGy3XYgO1FHi93kSMVhFIQEB2aIGqiS5v6zqrPEHuiTwyrYUOkxuSb
         YTOVMhUb/PiXM2ovqZZ0TOPlqBmf2M1lkupfPIu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 125/146] powerpc/64/tm: Dont let userspace set regs->trap via sigreturn
Date:   Thu, 16 Apr 2020 15:24:26 +0200
Message-Id: <20200416131259.643833652@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit c7def7fbdeaa25feaa19caf4a27c5d10bd8789e4 upstream.

In restore_tm_sigcontexts() we take the trap value directly from the
user sigcontext with no checking:

	err |= __get_user(regs->trap, &sc->gp_regs[PT_TRAP]);

This means we can be in the kernel with an arbitrary regs->trap value.

Although that's not immediately problematic, there is a risk we could
trigger one of the uses of CHECK_FULL_REGS():

	#define CHECK_FULL_REGS(regs)	BUG_ON(regs->trap & 1)

It can also cause us to unnecessarily save non-volatile GPRs again in
save_nvgprs(), which shouldn't be problematic but is still wrong.

It's also possible it could trick the syscall restart machinery, which
relies on regs->trap not being == 0xc00 (see 9a81c16b5275 ("powerpc:
fix double syscall restarts")), though I haven't been able to make
that happen.

Finally it doesn't match the behaviour of the non-TM case, in
restore_sigcontext() which zeroes regs->trap.

So change restore_tm_sigcontexts() to zero regs->trap.

This was discovered while testing Nick's upcoming rewrite of the
syscall entry path. In that series the call to save_nvgprs() prior to
signal handling (do_notify_resume()) is removed, which leaves the
low-bit of regs->trap uncleared which can then trigger the FULL_REGS()
WARNs in setup_tm_sigcontexts().

Fixes: 2b0a576d15e0 ("powerpc: Add new transactional memory state to the signal context")
Cc: stable@vger.kernel.org # v3.9+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200401023836.3286664-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/signal_64.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -477,8 +477,10 @@ static long restore_tm_sigcontexts(struc
 	err |= __get_user(tsk->thread.ckpt_regs.ccr,
 			  &sc->gp_regs[PT_CCR]);
 
+	/* Don't allow userspace to set the trap value */
+	regs->trap = 0;
+
 	/* These regs are not checkpointed; they can go in 'regs'. */
-	err |= __get_user(regs->trap, &sc->gp_regs[PT_TRAP]);
 	err |= __get_user(regs->dar, &sc->gp_regs[PT_DAR]);
 	err |= __get_user(regs->dsisr, &sc->gp_regs[PT_DSISR]);
 	err |= __get_user(regs->result, &sc->gp_regs[PT_RESULT]);


