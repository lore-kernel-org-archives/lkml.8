Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95813C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E65C207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nKgiiGbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHVMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgHVMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:33:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C1EC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kebkrhfhu6FPNViCpaO1wfA5wFtK+FeFG3araNR8KPY=; b=nKgiiGbkv1l/FNuGk5sC/nTGC8
        Ba33e00rjGn5WJrhiUMLnb1YaOCdORtni4a2Lgi+QSVXXylHlKiM/WwiZUBIiAK7YM6B2jnp/EmtJ
        vw+FZr3SqKAINwoSc/qnGT+0y82lihEsBoH5AUREochGeGYKt/SxJ+FEvRRAGeyNQLq3munwv0v7K
        GwMp8grQRydiPeJNlAhDg9KwmdpCOXHAfpe2Tqr6fb8jaku6jO5QVuCguSuk6kJ7e0sXyz8ApO/OI
        6rJfCepWL//v075Fz0Dxdlnc+05m+HZ9soBSYkOE/HEWbedIC1d+RaBUuTfhqG/BhRWTcVfqpAiL3
        DKLQqOsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Shb-0002C5-4A; Sat, 22 Aug 2020 12:32:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60D143003E1;
        Sat, 22 Aug 2020 14:32:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4578A2363BF90; Sat, 22 Aug 2020 14:32:52 +0200 (CEST)
Date:   Sat, 22 Aug 2020 14:32:52 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>, dave@stgolabs.net
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
Message-ID: <20200822123252.GQ1362448@hirez.programming.kicks-ass.net>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821170334.73b52fdd@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 05:03:34PM -0400, Steven Rostedt wrote:

> > Sigh.  Is it too hard to make mutex_trylock() usable from interrupt
> > context?
> 
> 
> That's a question for Thomas and Peter Z.

You should really know that too, the TL;DR answer is it's fundamentally
buggered, can't work.

The problem is that RT relies on being able to PI boost the mutex owner.

ISTR we had a thread about all this last year or so, let me see if I can
find that.

Here goes:

  https://lkml.kernel.org/r/20191218135047.GS2844@hirez.programming.kicks-ass.net

Kexec even gets mentioned:

  https://lkml.kernel.org/r/20191219090535.GV2844@hirez.programming.kicks-ass.net


