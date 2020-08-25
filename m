Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72D02074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JePRDUdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHYNaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHYNaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:30:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50170C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T0iA/ESQ7g89ajHduy7nVinGEeYb5qspM1YNkrQY/OQ=; b=JePRDUdSk6wTLpH+cDjmhVmoCP
        iKx9/roB2SULZZms3G5d07MEjORCH/osBFueYs1IdIS8T62B3Zb0FV8YZVJPYijn74LljtZAH3Qst
        jITFluYmF2XPojsZy4VrYPd2cj11vHmyhtHLqW4ZcPZ6LuvAfP2JTGV7FCgM6BJhjzDQ3bq8+LJFX
        cHvaN8Vanpl7dVO29V3pfVQoaU+vdi5ZvCEIoqMPrgJvagRZaBEG0PGrZtK3+RB1qivIGMl3/4S+t
        HywWwaisgot7VbZ3rYSPUC7hJemtaoOQ5RL7m+6Sc4bAWrnAOFYOdRT/NC3OlfEWdlUF9YyxXiHLe
        SpibzOMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAZ1b-0001Lp-5c; Tue, 25 Aug 2020 13:30:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40F1A3003D8;
        Tue, 25 Aug 2020 15:30:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29B3421F9DB48; Tue, 25 Aug 2020 15:30:05 +0200 (CEST)
Date:   Tue, 25 Aug 2020 15:30:05 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <20200825221555.a2d72c9754284feced6a8536@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825221555.a2d72c9754284feced6a8536@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:

> > damn... one last problem is dangling instances.. so close.
> > We can apparently unregister a kretprobe while there's still active
> > kretprobe_instance's out referencing it.
> 
> Yeah, kretprobe already provided the per-instance data (as far as
> I know, only systemtap depends on it). We need to provide it for
> such users.
> But if we only have one lock, we can avoid checking NMI because
> we can check the recursion with trylock. It is needed only if the
> kretprobe uses per-instance data. Or we can just pass a dummy
> instance on the stack.

I think it is true in general, you can unregister a rp while tasks are
preempted.

Anyway,. I think I have a solution, just need to talk to paulmck for a
bit.

> > Ignoring that issue for the moment, the below seems to actually work.
> 
> OK, this looks good to me too.
> I'll make a series to rewrite kretprobe based on this patch, OK?

Please, I'll send the fix along when I have it.
