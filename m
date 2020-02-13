Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B41C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E012082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOt+CKba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBMGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34324 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbgBMGo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so1962436plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 22:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTjJW5WkW3WINmBSd47NRsGrdkm7l3mFig0Vv87JoHI=;
        b=fOt+CKbaa0hK1SD+Dy3Gz8bkHD+cshmpLIT8v+VWyrtWI20L8EU2KYeZeIS4rt8NC4
         v2C0B1s63ubGJUhO1XnAezBRS6Bl3gqUaQx0jhQPDFgUwsj4WU+jb9De89x8LVVkxCVh
         kQYGq2caYpKvRl3s2Uaouw5RUk2UcZxWhfKRF+uI/UB9sRroBDPHW/AsaxXuIkXp+y1x
         4xDnPRcWpYRdZZQDtjN029HZpLQZR8kVwn3EHkJbDxcIp5IuRUxkYaOUZ9xtTg7d9zwV
         qb6+D2jEIHi2q9SIpVRpEc2ZDU5OgD+SdH6c+9PGs+FAMKDFVED6KmP1wxX1lPk6YlqG
         2hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTjJW5WkW3WINmBSd47NRsGrdkm7l3mFig0Vv87JoHI=;
        b=UrdBkL75rh4x9JyzfTQGJMtf2WP4sqRQ5eoSHjnyJLRSJIeifpJv7a3qGOAh37Es6P
         whcYghgjbPdYtbMcL4fYcUXj/Elz6i4LL6ivST4RZuSoMcHy+zkJ/g5fwe+RCoGAFSsi
         jrnD1xq8FO8Jb77ON8tcZU86tvBw+rGAwhROU2k6TwFAvu3Bmhwk4Vtkuf2GUHARFq02
         2WkvHpkmecHArs8oCmXbKgwDeCb2+iDXe/9RUlI16mEI0WlSYwfiX9+WEodXDO9TKPfy
         OA8nSMYNAbNxbpIAHHv9/O2C5UrLys4dqRnd5r7VjpRmLzNx8RnxuSa+pLutlzPfxBSm
         bDgg==
X-Gm-Message-State: APjAAAVI2h53LHV4+CtIdxDWEp864vlZSn0alwwS0e07XOf1tGJiwkYw
        mzxxRujbBvTtirnqDb/eogkF2p/v2pI=
X-Google-Smtp-Source: APXvYqwNMnGMEqnUw+BD3d356YdrBTWxcZDVrpMEjClwMVJdXshDYsdlX3TJyZLVvbTGGXZqEsja7Q==
X-Received: by 2002:a17:90a:17c2:: with SMTP id q60mr3225606pja.111.1581576264849;
        Wed, 12 Feb 2020 22:44:24 -0800 (PST)
Received: from workstation-portable ([103.211.17.23])
        by smtp.gmail.com with ESMTPSA id x4sm1412685pff.143.2020.02.12.22.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 22:44:24 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:14:18 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] events: Annotate parent_ctx with __rcu
Message-ID: <20200213064418.GA26550@workstation-portable>
References: <20200208144648.18833-1-frextrite@gmail.com>
 <20200210093624.GB14879@hirez.programming.kicks-ass.net>
 <20200210125948.GA16485@workstation-portable>
 <20200210133459.GJ14897@hirez.programming.kicks-ass.net>
 <20200210164727.GA22283@workstation-portable>
 <20200210170831.GB246160@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210170831.GB246160@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:08:31PM -0500, Joel Fernandes wrote:
> On Mon, Feb 10, 2020 at 10:17:27PM +0530, Amol Grover wrote:
> > On Mon, Feb 10, 2020 at 02:34:59PM +0100, Peter Zijlstra wrote:
> > > On Mon, Feb 10, 2020 at 06:29:48PM +0530, Amol Grover wrote:
> > > > On Mon, Feb 10, 2020 at 10:36:24AM +0100, Peter Zijlstra wrote:
> > > > > On Sat, Feb 08, 2020 at 08:16:49PM +0530, Amol Grover wrote:
> > > 
> > > > > > @@ -3106,26 +3106,31 @@ static void ctx_sched_out(struct perf_event_context *ctx,
> > > > > >  static int context_equiv(struct perf_event_context *ctx1,
> > > > > >  			 struct perf_event_context *ctx2)
> > > > > >  {
> > > > > > +	struct perf_event_context *parent_ctx1, *parent_ctx2;
> > > > > > +
> > > > > >  	lockdep_assert_held(&ctx1->lock);
> > > > > >  	lockdep_assert_held(&ctx2->lock);
> > > > > >  
> > > > > > +	parent_ctx1 = rcu_dereference(ctx1->parent_ctx);
> > > > > > +	parent_ctx2 = rcu_dereference(ctx2->parent_ctx);
> 
> You can probably remove the earlier lockdep_assert_held(s) if you're going to
> use rcu_dereference_protected() here, since that would do the checking anyway.
> 

Ah yes, I was thinking this aswell.

> > > > > 
> > > > > Bah.
> > > > > 
> > > > > Why are you  fixing all this sparse crap and making the code worse?
> > > > 
> > > > Hi Peter,
> > > > 
> > > > Sparse is quite noisy and we need to eliminate false-positives, right?
> > > 
> > > Dunno, I've been happy just ignoring it all.
> 
> FWIW some of the sparse fixes Amol made recently did uncover so existing
> "bugs" :) (Not in perf but other code).
> 
> > > > __rcu will tell the developer, this pointer could change and he needs to
> > > > take the required steps to make sure the code doesn't break.
> > > 
> > > I know what it does; what I don't know is why you need to make the code
> > > worse. In paricular, __rcu doesn't mandate rcu_dereference(), esp. not
> > > when you're actually holding the write side lock.
> > 
> > I might've misinterpreted the code. How does replacing rcu_dereference()
> > with
> > parent_ctx1 = rcu_dereference_protected(ctx1->parent_ctx,
> > 					lockdep_is_held(&ctx1->lock));
> > sound?
> 
> FWIW, some maintainers do hate calling RCU APIs when write side lock is held.
> Evidently it does make the code readability a bit worse and I can see Peter's
> point of view because the existing code is correct. I leave it to you guys to
> decide how you want to handle it.
> 

In that case, I think the code is fine as it is. Thank you for the review both!

Thanks
Amol

> thanks!
> 
>  - Joel
> 
