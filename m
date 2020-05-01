Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61CC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E4F208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zVbYz8Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgEAR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728933AbgEAR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:29:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rUGXi06MLSLZmPXKsPRzx5D4SfH1VEHWsmE2/iYzOLY=; b=zVbYz8ZdzE2w1Cm57VztaRKX+i
        kaVo24QVe7VVbkqbIh3ZMTQ3eGK3fxymbLOSLoXSy48dIPXvzcb4jNuWOH1jipzfyK4ADAEnrV9pW
        km4STbKOdQu2pS8BJ7k9oRPv10xt7jlwtq/zhSqct58JeMKVwtv8XrbrxV/W57/Vh7I18QEoINTsG
        Py4LMqpAlRUuw0Mbn4vh9+1RyuAdSK9Z8AR+1c6HW7p9/0i5RvOVb2lJb/HRN07kNIdwdZOhT+XaD
        HnlZRcVFgdK96nkWta/qyaVM+xhcIM8WgoU+lEv4AzzzW8x8cgAQRvQlsayD+Iec7cLHzhiY9hSGe
        frrbXN4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUZTM-0003Q4-2s; Fri, 01 May 2020 17:29:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F56D300739;
        Fri,  1 May 2020 19:29:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C14229D9C0A7; Fri,  1 May 2020 19:29:10 +0200 (CEST)
Date:   Fri, 1 May 2020 19:29:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH] x86/ftrace: Have ftrace trampolines turn read-only
 at the end of system boot up
Message-ID: <20200501172910.GH3762@hirez.programming.kicks-ass.net>
References: <20200430202147.4dc6e2de@oasis.local.home>
 <20200501044733.eqf6hc6erucsd43x@treble>
 <20200501051706.4wkrqwovybt2p6hr@treble>
 <20200501092404.06d1adcb@gandalf.local.home>
 <20200501151310.zo5bhnxpu5gubofj@treble>
 <20200501121916.310942b8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501121916.310942b8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 12:19:16PM -0400, Steven Rostedt wrote:
> 
> Peter, what about you?

It's all a bit unfortunate, but yeah, seems reasonable. Ack.
