Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01162C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D16207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7Sxl+I4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgEWVco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbgEWVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 17:32:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69988C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=euhs23l2LckQQZqClPP1ffQdVbjSsT+bd+0gLo+sW/g=; b=Q7Sxl+I4qXTrbIz8BvGb4iRFil
        QZQoRnqHO1Mz6Wkp21SyoFnG0Ji8aNikGKJt35awZetB2H3MMne3cBHkLncfp/dN+WYEPVzOwpYPE
        lBq5N0SnpFSutrz90UOxS65ArL74R5W5tL0UMYm/RZp7Fm1dBfXiE9qce5L2gl7VPcdZDFTrrEYk5
        ZNi71itYo+xtF/ZJoWmnCBxIlvvahO8GJ8g4cYuxYPbMNtSZ3ug2VNDyodh99QI6QpjhuEv1i/guV
        t+NqbrNgCBLTILBO46cnwzZkwj70Ae3MGTNShVqbA4SLf/UqBn14BeZN+9VXe7SdM0mnICTjhEzsJ
        TYdZxkag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcbkz-0003mK-N4; Sat, 23 May 2020 21:32:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 184D69834A2; Sat, 23 May 2020 23:32:35 +0200 (CEST)
Date:   Sat, 23 May 2020 23:32:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200523213235.GB4496@worktop.programming.kicks-ass.net>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
 <20200523125940.GA2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523125940.GA2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 02:59:40PM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 03:13:57PM -0700, Andy Lutomirski wrote:

> > This is great, except that the unconditional DR7 write is going to
> > seriously hurt perf performance.  Fortunately, no one cares about
> > perf, right? :)
> 
> Good point, so the trivial optimization is below. I couldn't find
> instruction latency numbers for DRn load/stores anywhere. I'm hoping
> loads are cheap.

+	u64 empty = 0, read = 0, write = 0;
+	unsigned long dr7;
+
+	for (i=0; i<100; i++) {
+		u64 s;
+
+		s = rdtsc();
+		barrier_nospec();
+		barrier_nospec();
+		empty += rdtsc() - s;
+
+		s = rdtsc();
+		barrier_nospec();
+		dr7 = native_get_debugreg(7);
+		barrier_nospec();
+		read += rdtsc() - s;
+
+		s = rdtsc();
+		barrier_nospec();
+		native_set_debugreg(7, 0);
+		barrier_nospec();
+		write += rdtsc() - s;
+	}
+
+	printk("XXX: %ld %ld %ld\n", empty, read, write);


[    1.628125] XXX: 2800 2404 19600

IOW, reading DR7 is basically free, and certainly cheaper than looking
at cpu_dr7 which would probably be an insta cache miss.

Which seems to suggest KVM can go pound sand. Maybe they can fix
themselves with some paravirt love.


