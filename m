Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D788EC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C5F20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkK5M2ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgIGQYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgIGQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BFC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AlY6K7nk4h/9FDXvqafZ5ameUxU+w3HsZJFnlBkrX8k=; b=NkK5M2iaWEVbBqiE4MDuObwGPo
        7eAy+vAZPOdDFDW+EHPdjN3T9TcZlfrLNwA0/ILJKDaeL6teYG/SiOmalktG+P2dqO3rQxwXJB8vp
        24N4g6xeQuJXJJ8KAk61DxcNacPlzgpyZwcJQuZ7t8sfFy9sY588j5jGN+WDXJPpgXofTYovGBGLV
        HqdI4LAiEHOVEm0IeFeluVbzyiO7BKgCsdWeFKpwhmEGZTQaBBDm28B+vtganJIKhfP9oOrOmwtM5
        j2eBv9iBuGHCE0XeK2NsFKjMb8XmsNMVFyenHJuS46wT4RGmyusoUxu39wDhEjpZolTYS4wjfMCJ6
        CWVYoOBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFJvg-0008Mb-5n; Mon, 07 Sep 2020 16:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D51A6305C16;
        Mon,  7 Sep 2020 18:23:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9D2220CB2046; Mon,  7 Sep 2020 18:23:38 +0200 (CEST)
Date:   Mon, 7 Sep 2020 18:23:38 +0200
From:   peterz@infradead.org
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
Message-ID: <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
References: <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
 <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 02:03:09PM +0200, Joerg Vehlow wrote:
> 
> 
> On 9/7/2020 1:46 PM, peterz@infradead.org wrote:
> > I think it's too complicated for that is needed, did you see my
> > suggestion from a year ago? Did i miss something obvious?
> > 
> This one? https://lore.kernel.org/linux-fsdevel/20191219090535.GV2844@hirez.programming.kicks-ass.net/
> 
> I think it may be a bit incorrect?
> According to the original comment in __crash_kexec, the mutex was used to
> prevent a sys_kexec_load, while crash_kexec is executed. Your proposed patch
> does not lock the mutex in crash_kexec.

Sure, but any mutex taker will (spin) wait for panic_cpu==CPU_INVALID.
And if the mutex is already held, we'll not run __crash_kexec() just
like the trylock() would do today.

> This does not cover the original use
> case anymore. The only thing that is protected now are two panicing cores at
> the same time.

I'm not following. AFAICT it does exactly what the old code did.
Although maybe I didn't replace all kexec_mutex users, I now see that
thing isn't static.

> Actually, this implementation feels even more hacky to me....

It's more minimal ;-) It's simpler in that it only provides the required
semantics (as I understand them) and does not attempt to implement a
more general trylock() like primitive that isn't needed.

Also, read the kexec_lock() implementation you posted and explain to me
what happens when kexec_busy is elevated. Also note the lack of
confusing loops in my code.
