Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E25C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF1520657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zUHgBjH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgEOOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:07:52 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D68C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+dIiT/UOLZH4C4698DgVf1kBe7ueqiNo1hUe6DDcp2E=; b=zUHgBjH0emURWzjzxEjlGJET2s
        ZvOHdpNZP+Rhh213IP6MKPqnAkZbCZTtTAgjAAqI+HKCWiHP2myw9/usxrIhMOXMuKUnRLRKr+N/p
        DRlliMytMjPkDQEQniytCmPYUxxpkANHZW4/IN1pzrl00wJepPY+pHZsTHTS6Js14IXnjccoBZjyb
        6EuihL9S6IWHC6eKIbXc7zmWqc+U80iL9LZ0IpOW4vasjFMpyomhFcRnE3ajcJ41aaU73b1JG/dC+
        +p8dsqpJmFIKt62bWxSt2w4YmljO52AV1oc/4+3SjJu1UTNH1E4tWDsuvMsuN0zTXy05TfbTU7e2/
        Jp2e4lYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZazl-00027r-FC; Fri, 15 May 2020 14:07:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1D11300261;
        Fri, 15 May 2020 16:07:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8A8E202E0F9C; Fri, 15 May 2020 16:07:20 +0200 (CEST)
Date:   Fri, 15 May 2020 16:07:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200515140720.GE2940@hirez.programming.kicks-ass.net>
References: <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
 <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
 <20200514142450.GC2978@hirez.programming.kicks-ass.net>
 <26283b5bccc8402cb8c243c569676dbd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26283b5bccc8402cb8c243c569676dbd@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:55:43PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 14 May 2020 15:25
> ..
> > Exact same requirements, KASAN even has the data_race() problem through
> > READ_ONCE_NOCHECK(), UBSAN doesn't and might be simpler because of it.
> 
> What happens if you implement READ_ONCE_NOCHECK() with an
> asm() statement containing a memory load?
> 
> Is that enough to kill all the instrumentation?

You'll have to implement it for all archs, but yes, I think that ought
to work.
