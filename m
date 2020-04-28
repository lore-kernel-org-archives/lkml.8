Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F3C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DD2208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMV32pXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgD1QrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgD1QrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:47:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35821C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9aif9GUNHYfNx0gztJaEHQF4lES2H6GccdAcFxZyPxc=; b=GMV32pXt8DNqSEsYCItaZeGcWf
        IUqmX9Tdx3Kjr8wOTbIL/i4QJhxpj1caHiHwZeVJ46mlMpNfgD6M0x7GLpYcVq34pgogE2q/UW8Ra
        uC7lQGWKMgl+hE04kgDy/4YZytOI7wvVVaAnt4J/mPA8SFyVedlST7LhO46+fZ82TICeJwa2U3oAh
        kiDH7ACgkZBmiYLqxzmgJju9UGaoJ131hr3UL2sejxuJZdYCMJEvwotc6Ft3b1B5mIbWD+ExaMG4o
        LX9JwFCnuMXPuo6rSWJBt6bWI6Vi24x0zckAFuvoVkmblAfMoctZsXsxxnPghfn2wlG+ojEeqqSJI
        4WPUdABg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTTO4-0001vA-Sd; Tue, 28 Apr 2020 16:47:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2779F301224;
        Tue, 28 Apr 2020 18:47:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 144C3286CC57E; Tue, 28 Apr 2020 18:47:10 +0200 (CEST)
Date:   Tue, 28 Apr 2020 18:47:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200428164710.GE16910@hirez.programming.kicks-ass.net>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
 <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
 <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
 <20200422114659.GE20730@hirez.programming.kicks-ass.net>
 <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
 <20200427143442.14d929f0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427143442.14d929f0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:34:42PM -0400, Steven Rostedt wrote:
> Arnaldo deals with the userspace perf code. This looks like it needs to go
> through the x86 tree.

Sometimes, when a series crosses both, it'll go through either tree.

I'm fine with picking up the kernel bits I suppose, but then we need to
be careful to have them land in order or something. Whatever people
want.
