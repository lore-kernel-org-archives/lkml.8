Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C10C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB2220838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEL5T7by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgBJQrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:47:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:47:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id g3so4183190pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6S/qqrclbzsgs+sboOiImcegGzXap9XdkgMRDQlBr0w=;
        b=CEL5T7byT9BaT02dREx1V+S0eeFRn9TfwoKS+xj2egQaOoxDOCNLNTbepLyeZqiEQg
         UD1h4wCf1FK5AeCh1nGewFw66oN167hpDJFS81zR4YpaBtOw3J6j9RBiKNiRCWancRhI
         nwV56OZ1kV0DaZn5x0Y3prLUuDg0/CyHbxN70InK7kBZP4INT3bZ22p3jhorq7Q1KUDE
         zNAwtibtZc/jfZRTC6sWtYWvcsQZiLlM1y3VwQ/s3uCq9d/i9duHzpcuAnyjyW9inDSf
         TYyZ827FqwUMBv6o+qRPUOoGq9LvtAcYNiws2EjhdKry+Pcvr10qXtoKPhYWynAQmPoO
         9rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6S/qqrclbzsgs+sboOiImcegGzXap9XdkgMRDQlBr0w=;
        b=F0+A6GL4Xp20ctAaWtmlHxWvNb6ev3H/arIL6i5/S9WkNe6mpWBqbbyAcN0uoR0Tqp
         kb08l9iz0lz0R1c8XEHGahQQHTzzDhIWorSc86RRaJaYCdIZWZMqOr6Rr/VLWsj8DwAN
         E8x2kZHyhEV1QNYaw3BViAgFNldp6jZz+b9X5VSVL2cRBIbLyz9s+I8yEW/6n5NBjD4L
         poSXHwcsAPEdd5zh+Q40Y8XPy7GJS/r8inmU69KwVRx5TmTXSz4blrAqGXghzSq02C6P
         Gu8xxtQ5xcDhlvtjA5HQwWTnkmQr3e5lfwLN40DcVQzGbgiQFpPgxaaT5QDakOPLiygp
         bMKA==
X-Gm-Message-State: APjAAAXMUmzTnfUoAJNZiwZI7IkrvFg79v0sR3paqRByK1k7ZdM2F6AG
        u3s8ZO+PU7fZIneMU3YoLU8=
X-Google-Smtp-Source: APXvYqxbcN6fFslsYQuBRd4tNcD50yrE5z+6+8KiffGz+ob3i0+3oDP2xswGxnS14o+RQ737VKX7OQ==
X-Received: by 2002:a63:2c0e:: with SMTP id s14mr2616909pgs.349.1581353255317;
        Mon, 10 Feb 2020 08:47:35 -0800 (PST)
Received: from workstation-portable ([146.196.37.217])
        by smtp.gmail.com with ESMTPSA id e2sm773029pjs.25.2020.02.10.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 08:47:34 -0800 (PST)
Date:   Mon, 10 Feb 2020 22:17:27 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] events: Annotate parent_ctx with __rcu
Message-ID: <20200210164727.GA22283@workstation-portable>
References: <20200208144648.18833-1-frextrite@gmail.com>
 <20200210093624.GB14879@hirez.programming.kicks-ass.net>
 <20200210125948.GA16485@workstation-portable>
 <20200210133459.GJ14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210133459.GJ14897@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:34:59PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 10, 2020 at 06:29:48PM +0530, Amol Grover wrote:
> > On Mon, Feb 10, 2020 at 10:36:24AM +0100, Peter Zijlstra wrote:
> > > On Sat, Feb 08, 2020 at 08:16:49PM +0530, Amol Grover wrote:
> 
> > > > @@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> > > >  static int context_equiv(struct perf_event_context *ctx1,
> > > >  			 struct perf_event_context *ctx2)
> > > >  {
> > > > +	struct perf_event_context *parent_ctx1, *parent_ctx2;
> > > > +
> > > >  	lockdep_assert_held(&ctx1->lock);
> > > >  	lockdep_assert_held(&ctx2->lock);
> > > >  
> > > > +	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
> > > > +	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);
> > > 
> > > Bah.
> > > 
> > > Why are you  fixing all this sparse crap and making the code worse?
> > 
> > Hi Peter,
> > 
> > Sparse is quite noisy and we need to eliminate false-positives, right?
> 
> Dunno, I've been happy just ignoring it all.
> 
> > __rcu will tell the developer, this pointer could change and he needs to
> > take the required steps to make sure the code doesn't break.
> 
> I know what it does; what I don't know is why you need to make the code
> worse. In paricular, __rcu doesn't mandate rcu_dereference(), esp. not
> when you're actually holding the write side lock.

I might've misinterpreted the code. How does replacing rcu_dereference()
with
parent_ctx1 = rcu_dereference_protected(ctx1->parent_ctx,
					lockdep_is_held(&ctx1->lock));
sound?

Thanks
Amol
