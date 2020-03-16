Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A18C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAD220658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="L/6FcIuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbgCPVpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:45:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46358 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732691AbgCPVpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:45:53 -0400
Received: by mail-il1-f196.google.com with SMTP id e8so18080601ilc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25oGfnAMapreWVrdW3M5TiwQKc3mxX8/6TlU8vJbmXY=;
        b=L/6FcIuAdA5FvZRHhSn5Hmz/voiJetply/Li6W/jrmoJ6MmOIl/qHIksuqlw09vo1o
         4Ca3KeXkbU5Cewvrdxfl7lm8jcJCoTDx/F/1L1XS1Vs8WpDU6UBQlGkcJdSF38/VMNSI
         /sKXgpeHPbSeDfS3FyGo+OGtmYMoL2VPrh3XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25oGfnAMapreWVrdW3M5TiwQKc3mxX8/6TlU8vJbmXY=;
        b=jfud/Ry74GPOIlepBAIUKv9vWImPgVxgU5G2SaPRDnIetaGTTCrcE2SFTlus+8CkFX
         Q9aS3vOYMCTlYJtw7HxrzWtTybP17W1LRGH1Idygdk2CRdIMxEwoqtQL4uzdWt/Z7UXz
         I05j2rFnd0YErueX/TKzmnUs253hWq31UFJYOXguRkFuEUaDAXIIZvP0YNKEaCucDnxc
         4DbT8JiFvKBFmwzNaW20qoBfpGGFlfZLAWRsXyUTX/D2oBKOSExLNwzeS4HrbDdGByB4
         QDezbq/W1ng0AT+698SIoXxXOR6AyPwY1ClAlPAHe4lLE6MFfJ3zHW3uyUJjl2ptet3G
         tJ7Q==
X-Gm-Message-State: ANhLgQ0cSMWI39yQbcAD3JBkyUYXQEKDoCp7B4rBAfTmxHqhusgxKSeT
        XAVp417kJIkr8T7eJAtRJ7nYh/TgD7pYz/ZCqJY3pw==
X-Google-Smtp-Source: ADFU+vvUmmAwXlq13f181KZrcmyIEcAbNlQA2abcn+CqTyyjy3PKFII5C9B/RBr+2C2iYegyQFmxTWP9r7FqOY+XAVc=
X-Received: by 2002:a92:8901:: with SMTP id n1mr2043465ild.176.1584395152003;
 Mon, 16 Mar 2020 14:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200312181702.8443-9-paulmck@kernel.org>
 <20200316194754.GA172196@google.com> <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
 <20200316203241.GB3199@paulmck-ThinkPad-P72> <20200316173219.1f8b7443@gandalf.local.home>
In-Reply-To: <20200316173219.1f8b7443@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Mar 2020 17:45:40 -0400
Message-ID: <CAEXW_YRtGhiaz+86pTL2WTyx5tqrpjB-bgQbnMLXjSQXPCmYfw@mail.gmail.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude variant
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 5:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 16 Mar 2020 13:32:41 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>
> > > Just curious, why is the "rude" version better than SRCU? Seems the
> > > schedule_on_each_cpu() would be much slower than SRCU especially if
> > > there are 1000s of CPUs involved. Is there any reason that is a better
> > > alternative?
> >
> > The rude version has much faster readers, and the story I hear is that
> > there are not expected to be all that many concurrent updaters.
> >
> > But to get more detail, why not ask Steven why he chose not to use SRCU?
> > (I know the story for the BPF guys, and it is because of SRCU's read-side
> > overhead.)
>
> Same for the function side (if not even more so). This would require adding
> a srcu_read_lock() to all functions that can be traced! That would be a huge
> kill in performance. Probably to the point no one would bother even using
> function tracer.

Point well taken! Thanks,

  -Joel
