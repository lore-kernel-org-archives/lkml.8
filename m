Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112582078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4V1bb3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHUM5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:57:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B5C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N5fP/fd8CcOtI6NoRjfS/TyT5EJLmSBJUO2oEjk5ZXs=; b=I4V1bb3rUQZykqWSeFR1Xx6tKS
        Wpvb1sdzt+IWg03HmpfUzsGiEhm4O0bG15WnmNe+OcoTCdCO972P5ybgC0wDIMSiQVeq2W9keuWJx
        1qjncjNK38ys8FLQNyLpFLY8aYrYcliYJpFV23trGO0tKnTP2p1mMEaMbWByguhdCgbPDTJySCMyP
        ZptXxcan0WXqmnvuH/9SU8aMhdM6z6381LS42QX8qLEQeKLiNzFm5A5kkPDN9eL2uRBBt/PU/XVW6
        jX9Xc/k4CG43Pvk4VpazayptoDfR/l47rwedxB4oSWWVwQev0OMQUnDtp1E7LU9dgMB69kUy1VmDW
        j5WKLqpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k96bN-0002eJ-B0; Fri, 21 Aug 2020 12:57:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97106301324;
        Fri, 21 Aug 2020 14:56:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75A312B2C9E70; Fri, 21 Aug 2020 14:56:58 +0200 (CEST)
Date:   Fri, 21 Aug 2020 14:56:58 +0200
From:   peterz@infradead.org
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 0/8] x86/debug: Untangle handle_debug()
Message-ID: <20200821125658.GN1362448@hirez.programming.kicks-ass.net>
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821093912.815135402@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:39:12AM +0200, Peter Zijlstra wrote:
> Hi,
> 
> handle_debug() is a mess, and now that we have separate user and kernel paths,
> try and clean it up a bit.
> 
> Include's amluto's fix for convenience.
> 
> Since v1:
> 
>  - Changelogs!
>  - fixed notifier order (Josh, Daniel)
>  - tested kgdb

Whole set also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/debug
