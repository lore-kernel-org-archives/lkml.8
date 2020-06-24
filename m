Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC04F20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PP2H5yDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390625AbgFXMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbgFXMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:32:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FDC061573;
        Wed, 24 Jun 2020 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=it9VsGosZwW2AP+pfNnE7lbVlyMIxAC0ndaAV7moVK0=; b=PP2H5yDL6sw2rzJ9wwDgYU5npx
        DegwUhHRBC74l2k/7QgLFXzQ5D+rkWEwAvKbR1I5BlI3E3ORsNoJvAslgybSzD5AK5rhJzXFD9sm3
        mt64QM+6t3xLhYJDfrIEQpnM0hDmOYoIVcwI8VD8r0PDAcNUZuwgBIVdbWNDkDXIJQOxE1FsInSLv
        Sf+tHA7qRjaCnJTY/+JKlEIEsbrcHXeyfpbpuBdU/2wzslLrG1aUsGLBJWajvVmeAXZX600RE+BpO
        OFaoNN3K7C/ocakwoK8OLA1wyT8a/7ZWsuYQfmNbVvXBJzgiVQ1+T+wiZ9xpB65R7HiUVOMsvyoCB
        Z12SiQnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo4ZB-000677-UW; Wed, 24 Jun 2020 12:31:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51910301A7A;
        Wed, 24 Jun 2020 14:31:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D90821211CCA; Wed, 24 Jun 2020 14:31:47 +0200 (CEST)
Date:   Wed, 24 Jun 2020 14:31:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, bigeasy@linutronix.de,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200624123147.GH4781@hirez.programming.kicks-ass.net>
References: <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <20200623202404.GE2483@worktop.programming.kicks-ass.net>
 <20200624090033.GD4800@hirez.programming.kicks-ass.net>
 <CANpmjNMj8FZuBrZsH62V3bZEhFvT2zXwLusVOLwNuH_-kLhp2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMj8FZuBrZsH62V3bZEhFvT2zXwLusVOLwNuH_-kLhp2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:17:56PM +0200, Marco Elver wrote:
> On Wed, 24 Jun 2020 at 11:01, Peter Zijlstra <peterz@infradead.org> wrote:

> > And I figured a quick way to get rid of that would be something like the
> > below, seeing how volatile gets auto annotated... but that doesn't seem
> > to actually work.
> >
> > What am I missing?
> 
> There's one more in include/linux/rcupdate.h. I suggested this at some point:
> 
>     https://lore.kernel.org/lkml/20200220213317.GA35033@google.com/
> 
> To avoid volatiles as I don't think they are needed here.

Urgghh.. local_t is very expensive for this. The current code is
actually fine, even on load-store architectures. Using local_t will only
result in it being more expensive for no gain.

I'll go put data_race() around it.
