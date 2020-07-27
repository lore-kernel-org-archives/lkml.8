Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B312065E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRky4Y9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgG0Kk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgG0Kk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:40:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vICvujNE5DQDVbb09De076gN3ysj6ZPhMu6s83cBKEA=; b=pRky4Y9kmw5UICHW8UEnMcbIu3
        TuHSwlZeI86WglYvVXBFLRzG7NsId2HMn6z7QQdS1rBc2GWRsZe7POHtYyw0f+H11I/P/9GdeZRaq
        VeMdCDKILtIju0FgqbGcJJkZC/Fkf6IGfDWjwrQIoBYR7DXBNGcdHPdhrcoJ0pCLJPtbl7jbphMof
        BUnkpU6ITrzF2yhhLTv26QhT13HOUB2mySmaEkCtW1eQMGxhkbMwhPQmLmXuos99zVbjL5Fy6KnIs
        aHV2r9NXU8BGXfTR+aRt0mUIuyFKWv/J/Uyi4aJQvclxTKYHArsMP5hSdrt0aWKsDnWxqWlTMiPX7
        oHY8abCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k00Yu-0001c6-U0; Mon, 27 Jul 2020 10:40:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC03A30411F;
        Mon, 27 Jul 2020 12:40:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF108285770B2; Mon, 27 Jul 2020 12:40:50 +0200 (CEST)
Date:   Mon, 27 Jul 2020 12:40:50 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
Message-ID: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
anything.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -551,6 +551,14 @@ static const char *uaccess_safe_builtin[
 	"__memcpy_mcsafe",
 	"mcsafe_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
+	/*
+	 * Abuse alert!
+	 *
+	 * poke_int3_handler() is not in fact related to uaccess at all, we
+	 * abuse the uaccess rules to ensure poke_int3_handler() is self
+	 * contained and doesn't CALL out to other code.
+	 */
+	"poke_int3_handler",
 	NULL
 };
 
