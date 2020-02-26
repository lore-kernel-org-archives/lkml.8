Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38895C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CA20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eYNPZ77i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgBZIPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:15:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgBZIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0kjUyzMjeOEz+xsComIMxJTOe6oXb4qqcIYNnmPqXfw=; b=eYNPZ77iaJ8rseQhO6rmLzMmfD
        666nJ2xoF6m4IWCQOAGKICmRlX48tSUV4/lfLWlnj1TZ5su8tsJgTKYUUOJG11Vl+KEyVAOMVvlUB
        R1MF/HAiZCgH1XQezlpDjExdfbsDbQjsH/tfPEhviHnCdHn8S01fgmbJVN7E3f/3J8in3KhyxAguD
        H/9MNJ5zkAaFEzvC9M1PQXEQ5yKaJiChshe4hXgGQ0AoiRwxUO6m/45fqbMmZdJ8701r6lbsL8vDi
        yBCvxoNMcmwq7eqqI6mwiJ3vsyz2BLbM7GIn/0tsOXF+XFjgYWQ0CqnyvBr0qWrPx3r83aeGfQfk4
        Psodjt2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6rqV-0003zu-US; Wed, 26 Feb 2020 08:15:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 673B7300478;
        Wed, 26 Feb 2020 09:13:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8015203CBB5F; Wed, 26 Feb 2020 09:15:05 +0100 (CET)
Date:   Wed, 26 Feb 2020 09:15:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 5/8] x86/entry/common: Provide trace/kprobe safe exit to
 user space functions
Message-ID: <20200226081505.GP18400@hirez.programming.kicks-ass.net>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.719921962@linutronix.de>
 <f6f11204-4277-fad0-c1c2-a21e0a380e3b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f11204-4277-fad0-c1c2-a21e0a380e3b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:45:11PM -0800, Andy Lutomirski wrote:
> On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> > Split prepare_enter_to_user_mode() and mark it notrace/noprobe so the irq
> > flags tracing on return can be put into it.
> 
> Is our tooling clever enough for thsi to do anything?  You have a static
> inline that is only called in one place, and the caller is notrace and
> NOKPROBE.  Does this actually allow tracing in the static inline callee?

tracing, no, but the NOKPROBE on inline functions is buggered afaiu.
