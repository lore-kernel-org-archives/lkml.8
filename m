Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6608C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16C920767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kyZeUH5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgGJNqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgGJNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B3C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3BWFwGO4Xdi2JfAeDNFfNOWtThIzEJ9leOj9Vzu/b/0=; b=kyZeUH5CF/W5Oqw87hovOrUYNK
        FeojyQKN3cqbt7oeFdPAR5tfSxwrXC2wGwMU/oR9M41SUd1YTZFbQZrXB5zlkboBY2upXI3V73Gzk
        b2cdychMFfiywSfGmbaEIDzhYkTqb7oq2bCJ2MdAD6gMG96krVLHhtkzV/MBLXq7UULDeZCh49XiO
        1AyHHA80KuhOpWtZ/fFqTRnmHIAATwgYVeGq7aDKYyBKNCU5+aOp1rI5nocXils++TLO5GZaVUh3K
        sATo3rw3RnUcCOow91I+eAvZu/0y1Y6Z3ZLSzxJzznWy0TP8GpAWAuhQ+uFmfZxCHhIdikwwcz2ps
        uHtxPFgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttK2-000180-0q; Fri, 10 Jul 2020 13:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23AB930769C;
        Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C8E712B7A732F; Fri, 10 Jul 2020 15:44:09 +0200 (CEST)
Message-ID: <20200710133831.943894387@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Jul 2020 15:38:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v6 00/17] Add static_call
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Hopefully for the last time...

static_call(), is the idea of static_branch() applied to indirect function
calls. Remove a data load (indirection) by modifying the text.

The inline implementation still relies on objtool to generate the
.static_call_sites section, mostly because this is a natural place for x86_64
and works for both GCC and LLVM.  Other architectures can pick other means
if/when they implement the inline patching. The out-of-line (aka. trampoline)
variant doesn't require this.

Patches go on top of: linus + tip/objtool/core

Patches can also be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call

Changes since the last time:

 - rebased
 - fixed ftrace synthetic events (rostedt)


