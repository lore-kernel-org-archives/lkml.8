Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71040C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A2021D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeQXF0cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCJRFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:05:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:05:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so16873172wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2pGv/F3fb90BGXpKCDOidB6iWxOC6kQch9TvvDExWQ=;
        b=VeQXF0crM1hy3UQaVzKzxaSVetHnvCqHAfce3p4P/ICUltPZGweTGDdVEoRD4s5x+F
         rM+5BHW8p4Sp5zeCIrR5TQ7yT2fbDYZGyXdvLo0Gyfsb4AtSFsTxuF6jPBjMLcMvEuz7
         5YKSKVa9j0zKk/1rmwu5TYnIuMWklBNPXJ4gI2MnmOuUxMUJ+0EWYhipHIAr/tEVZn+z
         2onNZlqmePWBW1jDLUsmUhCR//SNmFI0VagFKRfhj6DT1khSNLs+35h0zbXFaqQiyvpZ
         oNnwnn7Y2gANz4AExhVId3S+j/l5IcBKQ56tiCwu8YsqZ7ItVXVAU4xca29d1ZyVrqXJ
         DDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2pGv/F3fb90BGXpKCDOidB6iWxOC6kQch9TvvDExWQ=;
        b=RXhDVhUeQgm7PGtZys7xkVZTiULjN2xq/oVxMDb6itXg5J7JvzDhCNuPvY3KLo/CUz
         xZ1FZZOihwQVmqaSfHYJgX7LCSNOuKynnUcM3u1zpfKQJfA/FIGfVln0dMWlg+/cGPGH
         gotG99UJ4aloO+JP61MxLAi8MW7Ktb0W2zFMoPQuRZYdRGet6/U874acnbUubnsYcg91
         0EuLCSprbNWRClK+WQCU9xfwJ+EEbRapROnuRR1Y7f5SH8xRUAnVSPlozGbw2dkyPJZf
         TSI1Q1PDBdkzxEYbimd3M9u47gHouggaCQSGW2CDuY68TD42UkeBGRynCQo1QgfROuDK
         +DYg==
X-Gm-Message-State: ANhLgQ34p/aOtovc5q5bmP3mVgP6Q7wCtCcNTIhNPz8hDGb4hnCYIq1Q
        3s/X+XMXI5elH2N0bHWVMVzXTw==
X-Google-Smtp-Source: ADFU+vv1fzoBgLAS9dMUu/kgFvxBEkZ24A5EkgKtG2cBZw55ztM0JuCdRstUNjkRZCz+N35sqlcK+w==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr27790937wrr.125.1583859938739;
        Tue, 10 Mar 2020 10:05:38 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f4sm11241592wrt.24.2020.03.10.10.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:05:38 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:05:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200310170536.w4p5r2fnsyaorys5@holly.lan>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309141546.5b574908@gandalf.local.home>
 <87fteh73sp.fsf@nanos.tec.linutronix.de>
 <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 05:09:51PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> On Mon, 09 Mar 2020 19:59:18 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > >> #2) Breakpoint utilization
> > >> 
> > >>     As recent findings have shown, breakpoint utilization needs to be
> > >>     extremly careful about not creating infinite breakpoint recursions.
> > >> 
> > >>     I think that's pretty much obvious, but falls into the overall
> > >>     question of how to protect callchains.
> > >
> > > This is rather unique, and I agree that its best to at least get to a point
> > > where we limit the tracing within breakpoint code. I'm fine with making
> > > rcu_nmi_exit() nokprobe too.
> > 
> > Yes, the break point stuff is unique, but it has nicely demonstrated how
> > much of the code is affected by it.
> 
> I see. I had followed the callchain several times, and always found new function.
> So I agree with the off-limit section idea. That is a kind of entry code section
> but more generic one. It is natural to split such sensitive code in different
> place.
> 
> BTW, what about kdb stuffs? (+Cc Jason)

There is some double breakpoint detection code but IIRC this merely
retrospectively warns the user that they have their hurt their system...
and whether the system would run long enough to reach that logic is
relatively unlikely.

For both kdb and kgdb, the main "defence" is the use case. Neither kdb
or kgdb faces the userspace (except via a SysRq, which can be disabled)
and triggering either already implies the user is not especially
concerned about things like availability guarantees since they are happy
for everything running on the system to be halted indefinitely.

Additionally breakpoints in kgdb/kdb are not wildcarded so there are no
need to worry about a user selecting a bad pattern! Setting a breakpoint
with kgdb/kdb needs a user (who is assumed to have kernel knowledge) to
have explicitly chose to study the dynamic behaviour of that particular
bit of code.

I'm not saying kgdb/kdb would not benefit from additional safety
barriers (it would), simply that the problem is less acute.


Daniel.
