Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A5CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BBF2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RuDarup/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2KU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgD2KTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:19:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047CC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aiyMISgJU8trSwUkRDZ8tNmypa9sBSdyxqBeshLo1x0=; b=RuDarup/cu6qiHBZQo9EpstJP6
        eKV+DWORwtqqOxp9vfCyCEuFoKEjFDn3xpEkzCWwY0wHz2DsjnRSN0GRVAyXUew6kwSxiuqxtFIYk
        vC8y1wgBOHP9N4/uErCi4RHtKprKtacN4gikCbyCnVuz+77zncnaehny1QJGqV89U/2KuFHbq0s5I
        0IKwf32L0ioeQm3Cj0Wp/6Vngw4uKLrDaBFpsxfndx+wlgu1GKUFz8gimgV20mNUz7OHZJ8CbLulj
        eShlYSaNLC7BSHVeyBhMGeH4y6Fyz9L8glSHYjPPI+e4cUB/bncMUMzcQmvlyDe4h2LDcz+fFYE+4
        uPiWfBxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTjoi-0005R5-7D; Wed, 29 Apr 2020 10:19:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7944303F45;
        Wed, 29 Apr 2020 12:19:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 933E4201F9F0B; Wed, 29 Apr 2020 12:19:45 +0200 (CEST)
Date:   Wed, 29 Apr 2020 12:19:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz
Subject: [PATCH v2.1 01-A/14] objtool: Remove check preventing branches
 within alternative
Message-ID: <20200429101945.GJ13592@hirez.programming.kicks-ass.net>
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428191101.886208539@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Remove check preventing branches within alternative
From: Julien Thierry <jthierry@redhat.com>
Date: Fri, 27 Mar 2020 15:28:42 +0000

From: Julien Thierry <jthierry@redhat.com>

While jumping from outside an alternative region to the middle of an
alternative region is very likely wrong, jumping from an alternative
region into the same region is valid. It is a common pattern on arm64.

The first pattern is unlikely to happen in practice and checking only
for this adds a lot of complexity.

Just remove the current check.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200327152847.15294-6-jthierry@redhat.com
---
 tools/objtool/check.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2180,12 +2180,6 @@ static int validate_branch(struct objtoo
 
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
-		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
-			  sec, insn->offset);
-		return 1;
-	}
-
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
