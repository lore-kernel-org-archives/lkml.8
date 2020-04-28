Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4ADC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F84520B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JxE6PMPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgD1TUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728993AbgD1TTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:52 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B9AC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9MwTIMpdaC4VygWnq1XRJh2I8O/EbbREN7voJhdd838=; b=JxE6PMPs3REEx23oqVhEoLAhE2
        k7HPFKA4UX84OqQrSj9nVeqfSQGqj+xLSawxNXQ+FWgXgdU/gKG6NX89G1jgesXfc0F9d2KkPWF10
        khDJvHz8hZKoUsmT0zuc3BJA7w7zdxt3LFWrcwLwi4+fguaNA5hQ9D6byTmofX7ZEFDrMKy0I6gek
        NN4ztJpeKimgLE4rIb9t5R70JxYc0iT95JbBZVYCz2hMv7ZLzfQkN2Sy4Q+EL3s0l4/dKrqzSjzaI
        ihVhdAl/fixC7WdZycKXphrw106NlXL/FElAG8Gw55CwHIfbnEz2l9/n9PTKNwDPupQoWGkKKb31q
        7M7ATHng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlP-0007kr-Uq; Tue, 28 Apr 2020 19:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC05330767F;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 87AEE25D01312; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.677096772@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 05/14] objtool: UNWIND_HINT_RET_OFFSET should not check registers
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

UNWIND_HINT_RET_OFFSET will adjust a modified stack. However if a
callee-saved register was pushed on the stack then the stack frame
will still appear modified. So stop checking registers when
UNWIND_HINT_RET_OFFSET is used.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200407073142.20659-3-alexandre.chartre@oracle.com
---
 tools/objtool/check.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1513,6 +1513,14 @@ static bool has_modified_stack_frame(str
 	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
+	/*
+	 * If there is a ret offset hint then don't check registers
+	 * because a callee-saved register might have been pushed on
+	 * the stack.
+	 */
+	if (ret_offset)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)


