Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B4C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC03206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HV2jZc1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgHOVwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgHOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000DC03B3C9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HxEBNAuG/9bpj+bzYuVBBMIwUj7odSR2wvWZDu/4RS8=; b=HV2jZc1uSmthNyuShRKlJF0/K1
        Z5ykvYW4x0w5XuHkDOLqgGuxSARkr0ZyIX2oxEzCyffzj7ddgAr30fBn2xUmrHiHsxSyfXJcQQuVT
        EEvlcRfYK66KfVV5Vui69s2jERV08W+M3v3plyQyTurqA6XZNB2OGMzxmQK8NtzfU5nB8MdlKxO/R
        CkwECRvYCQmrKRsyDOAMJmk7tsiDaT8x8XsuaoR/I220s2giyj0xJYvy6qQpEvRo8wa0VcK7JDfDW
        HZ+NKOqL/FNAxksZBzZs/hfclgI3mQEUS9gk5ktPgwBDalXtI6jVgb8SYChskwydPcrsXFb63IaKe
        NkjmD/Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6rKv-0000HX-2W; Sat, 15 Aug 2020 08:14:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3747D304D58;
        Sat, 15 Aug 2020 10:14:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF3262C369E5F; Sat, 15 Aug 2020 10:14:41 +0200 (CEST)
Date:   Sat, 15 Aug 2020 10:14:41 +0200
From:   peterz@infradead.org
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH RFC 02/12] entry/idle: Add a common function for
 activites during idle entry/exit
Message-ID: <20200815081441.GG2674@hirez.programming.kicks-ass.net>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
 <20200815031908.1015049-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815031908.1015049-3-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:18:58PM -0400, Joel Fernandes (Google) wrote:
> Currently only RCU hooks for idle entry/exit are called. In later
> patches, kernel-entry protection functionality will be added.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

NAK, rcu_idle_enter() is broken where it is now, it needs to be pushed
in deeper:

http://lkml.kernel.org/r/20200807193017.962482579@infradead.org
