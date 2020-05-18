Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D3FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15ACF2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823886;
	bh=YJ+ZL8Gk6sA7MQHo52M5Pih7/8OQABFuySkueOQZfW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHxG4z/oBkb2SuyP0/z/+fZ8zDeZ7quNM7G1FC3jlK3Pkwb7eBzIrpeUv7jUjkFDB
	 j9GnH6cuciwrHPNJ/ld7hOwAEzR70PfQ8EX8hEzTh5sSlxOvdsKrOI9Ex/+X731pY/
	 xuZtNs1CLWfi+vtI/sPPEd8wFEZ4iduvju//H8C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgERRop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgERRod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:44:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439FA207C4;
        Mon, 18 May 2020 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823872;
        bh=YJ+ZL8Gk6sA7MQHo52M5Pih7/8OQABFuySkueOQZfW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Svn5KNGX9Q/G21lydwIy1X+W55yeVXoNm1riLhpp2CBHZDt8nRoo7cwY51Tp33VsJ
         V+udtrLY+kxTtOO732LgTv9UzF3Jj5347U7jEiQ5FfRzsjGmpBS3QrNJv1Kl2kdaFo
         wru5N3yYtOeC7O+F9xRtpSmnYrzShlZJIHEwm+sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Joe Mario <jmario@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 23/90] objtool: Fix stack offset tracking for indirect CFAs
Date:   Mon, 18 May 2020 19:36:01 +0200
Message-Id: <20200518173455.871408373@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit d8dd25a461e4eec7190cb9d66616aceacc5110ad upstream.

When the current frame address (CFA) is stored on the stack (i.e.,
cfa->base == CFI_SP_INDIRECT), objtool neglects to adjust the stack
offset when there are subsequent pushes or pops.  This results in bad
ORC data at the end of the ENTER_IRQ_STACK macro, when it puts the
previous stack pointer on the stack and does a subsequent push.

This fixes the following unwinder warning:

  WARNING: can't dereference registers at 00000000f0a6bdba for ip interrupt_entry+0x9f/0xa0

Fixes: 627fce14809b ("objtool: Add ORC unwind table generation")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Reported-by: Dave Jones <dsj@fb.com>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Reported-by: Joe Mario <jmario@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/853d5d691b29e250333332f09b8e27410b2d9924.1587808742.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1264,7 +1264,7 @@ static int update_insn_state_regs(struct
 	struct cfi_reg *cfa = &state->cfa;
 	struct stack_op *op = &insn->stack_op;
 
-	if (cfa->base != CFI_SP)
+	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
 		return 0;
 
 	/* push */


