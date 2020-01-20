Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4898FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBE922522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2iEv9VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgATOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:41:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4vIHUP9As2MHt/JTSJQoVlkdeNmF2zWPaSmNysm1Qn8=; b=E2iEv9VXGSdatAc8hrd7dKhN6
        mi3zF/s/rHUeynfPDWwXxwIz6Klpgs1KdfzSA/Rbz0F5rZWQhjwaEOTeDXgBAaTLoECb7iwHNKiOw
        gc4OLOvoedumQN3JBP+iGJGPdh0hkZslBHd6s5xLz0VQokrrJN7T2o80hxuLRlBQXSBxiN/MY3rSN
        WrEMQn5Q7f8EKzjbV06mn6k/SO61Yax+mHLCGb5kpE/hBa0qOIy2185/wg1uqgnkFlXtBX9JAuVtD
        zxDWnGMpCJYA8KCnbaoV6VBmh2460Sbx0v7BpgFunUBauIL/L5R4+hcacPDl6cblrWBU77yuAMRTf
        uzm+DqXKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itYEV-0001Bj-4K; Mon, 20 Jan 2020 14:40:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC36E3010D2;
        Mon, 20 Jan 2020 15:39:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 643E92020D90A; Mon, 20 Jan 2020 15:40:48 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:40:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de,
        viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net,
        mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@kernel.org, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Message-ID: <20200120144048.GB14914@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120141927.114373-3-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> Add explicit KCSAN checks for bitops.
> 
> Note that test_bit() is an atomic bitop, and we instrument it as such,

Well, it is 'atomic' in the same way that atomic_read() is. Both are
very much not atomic ops, but are part of an interface that facilitates
atomic operations.
