Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E820823
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591285388;
	bh=yskL/aleMP3Ow3dhAonKEO0BcvHaU+qMP5J5uIY8HYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdPRtJ2h3qC6Fphsju8EqNRIr5xiRUhr/+PdS4FnjE0JVfAwAe5pj9u9uq1xtvIjq
	 aiLdiIZOXiVAd/1gQnkUjlEtzAOwdJCdwbUs8n12U5B0N8kQAe5s5dnWeFQEyT02Hl
	 YJ4T2Lea+ezveyRF/X63eaR276gL/e9Fy9u0Id2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgFDPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729346AbgFDPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:43:06 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B1220872
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591285386;
        bh=yskL/aleMP3Ow3dhAonKEO0BcvHaU+qMP5J5uIY8HYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0pmAV1a3XYk01uztf3ixz1FeJXq5CSvF8n36CiN0h0RrUE56GKFWmYXvlftTdzjLL
         4czu9evLjzXHtImt6OE1uXcBGK5kotA1gV6dcOaLsEKaBASwEUUpARl311qU0R/jVl
         B3+e7ja//gz0gEAkqVO4vo1GCINxY18hszjt5IV8=
Received: by mail-wm1-f48.google.com with SMTP id j198so7131538wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:43:05 -0700 (PDT)
X-Gm-Message-State: AOAM531d5CFsjJDU6sJv2fGr2YmIHEe47nf1u8bseg4WkHo5o0fppyXb
        Iv6yyhhD6AN8HsPLoEP5C5IZtlfy+crv2+p+JgJeVw==
X-Google-Smtp-Source: ABdhPJzKSMSEa9E517DB7R0bFbJ6JYc7zussXQPDW7A2GzJfaBBcjkhX5ScgxR2lm5z0ccnISjKUdBrpt28uLYQBCyQ=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr4423785wma.36.1591285384365;
 Thu, 04 Jun 2020 08:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200521200513.656533920@linutronix.de> <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net> <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
 <20200604132537.GA3976@hirez.programming.kicks-ass.net> <c150c709-15d6-b126-4522-364b6663dcd5@redhat.com>
 <20200604133545.GB3976@hirez.programming.kicks-ass.net>
In-Reply-To: <20200604133545.GB3976@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Jun 2020 08:42:52 -0700
X-Gmail-Original-Message-ID: <CALCETrV89Sat5Dm5YTF_pcxMMrxygEwa78trpONm8MVMGZtWPg@mail.gmail.com>
Message-ID: <CALCETrV89Sat5Dm5YTF_pcxMMrxygEwa78trpONm8MVMGZtWPg@mail.gmail.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 6:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 04, 2020 at 03:29:26PM +0200, Paolo Bonzini wrote:
> > On 04/06/20 15:25, Peter Zijlstra wrote:
> > > It being enabled through IA32_DEBUGCTL instead of through DR7 means that
> > > the current code doesn't disable it and this then means we can have
> > > nested #DB again.
> >
> > /me bangs head on door
> >
> > > Who sodding throught this was a good idea ?! What happened to #AC that
> > > SLD currently uses?
> >
> > It was per-core and (presumably) considered unfixable?
>
> Yeah, but I don't see how changing the exception vector helps with that.
> #DB is an IST, and it must be, because of that lovely MOV SS thing. #AC
> has none of that, _please_ use #AC.

x86 is not an architecture.  x86 is a gauntlet through which operating
system developers must run.

I think we can tolerate this particular mess -- can't we just say that
a BUS LOCK DEBUG EXCEPTION is fatal if it came from kernel mode?  So
what if it nests inside #DB -- we can survive an oops from a corrupt
context like that.
