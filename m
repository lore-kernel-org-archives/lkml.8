Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4973C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DB72076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q4g0TEB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGILQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGILQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:16:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5AC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ooqa5vWkqNrfUinMMhKB5iY5At6V9g3tl2y+nHtUe+g=; b=Q4g0TEB8lcUYwfNNq//XLP/SXg
        D2cBvgjJeadLXtMTGc1PpDuKuFknKKzoCIyUd3+DbeT9kozFd6zfL5sqmIJlr1Aa+wZLgU+nJUnuU
        dii9N63x+KPRxnYdHqudtjK3yPVoM41sDsLHHqFwbkmMI9Szo9tyZZF5fK/wm05aZD6m31uhqWwzB
        07HqS+Ssler9+zllfyLjZ76F3dcV2IoLhb39NYhna9W1obB8z8K9ML9XJvvJV+TEFzzt02HGW1BcK
        z4VMdViKRk2CK1IoRe+E3oH59/nnh82dMZm7k1TAqE1dXKnRWyKmmYehOYKN8P8PvVJdYNtr6VX8W
        Yb9ybQUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtUXc-0006Xv-8D; Thu, 09 Jul 2020 11:16:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 713263003E5;
        Thu,  9 Jul 2020 13:16:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56B7E235B3D15; Thu,  9 Jul 2020 13:16:34 +0200 (CEST)
Date:   Thu, 9 Jul 2020 13:16:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v5 17/17] x86/perf, static_call: Optimize x86_pmu methods
Message-ID: <20200709111634.GV4800@hirez.programming.kicks-ass.net>
References: <20200624153024.794671356@infradead.org>
 <20200624154157.778920463@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624154157.778920463@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:30:41PM +0200, Peter Zijlstra wrote:
> Replace many of the indirect calls with static_call().
> 
> XXX run performance numbers

So I finally got around to doing that, and the average PMI time, as
measured by perf_sample_event_took()*:

PRE:	3283.03 [ns]
POST:	3145.12 [ns]

Which is a ~138 [ns] win per PMI, or ~4.2% decrease.

[*] on my IVB-EP, using: 'perf record -a -e cycles -- make O=defconfig-build/ -j80'
