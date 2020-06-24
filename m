Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F446C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9198206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIiZHRkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404708AbgFXPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbgFXPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8803C061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GsWllK5pgx/TUSGQaev87Ae0zAG5IoGs74qFbGpXYH0=; b=QIiZHRkjy5LafAkPonWxC5Li5a
        bH5Znyh9airl1pdF/eDK/lyBBcFq3X8aqraLIarNJ8c4mvF8xPPmwk5BdhJVAHmDLXZndwmrEVwA0
        PlaeUKltlBKtmj/QUhKlJ5mSnhx/9JYzr0HknUTo1PGcqGRVttUHfrIl22CuiOyqKZ5pKZgsLUHK5
        K5jn+SgsbzeXhY8CYjagp8KbWPYlWDeKzzrvr9ZtIc518PaS0BJuMNCkshRGb8xuyAvcbyypAxMLc
        ZqnpyATbvNUWqpmHhyQXKehPwNH2cPLrNahVz/S6BjlZKmHGlLL2xFsS8n+kJjf4xLnLL9suPlVJW
        oaf5OFOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gC-0001ca-7o; Wed, 24 Jun 2020 15:51:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF48F304BAE;
        Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB629236E7743; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624153024.794671356@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 00/17] Add static_call()
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

Patches go on top of tip/objtool/core + tip/perf/core

Patches can also be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call

Changes since the last time:

 - Better documentation
 - More consistent macro names
 - Changed key prefix
 - Folded trampoline definitions
 - Renamed DEFINE_STATIC_COND_CALL / DEFINE_STATIC_CALL_NULL



