Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B58C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F03206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKjby2j8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGGIy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:54:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28BCC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:54:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so8671984pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a/XgwapGx7PaAizT65mHU7yvNl7PTQ8EJ96Y04zIcHI=;
        b=kKjby2j8BdluGT1d4d1Uc52pLcQ41qgyUsoa3BPodKoSXLQp/tMjfHm6Oin7RKRhku
         Z9Cw6EJhuZekt1PUPfxxbSb1/FuKT2v5FSFWeqE35861BhRIWGBc6lJQfHFXZX4Pn/fo
         O3oxw9XWxQdXqm6HPR7ETPTAPMzfc7UdnWqVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/XgwapGx7PaAizT65mHU7yvNl7PTQ8EJ96Y04zIcHI=;
        b=KmVQL0Vu0gKjQwkFj/mgryPdVMjOWCmmRHbw7IhgcI/z9GRWDDWnsGQPcvgIl19NpW
         DQPG4w6IHmLrv52psegLGgeP6GMdWUqYv6ONQ9WmGKhyX2BWIdvIy0nOYthQTKVvLSz2
         gaFtPfXfbjVgzEzBYX+j4Ere9z/OYig24NiqfZMXL4Xx6+C1Hmzo0hyoHhuogK7VU0tl
         /TKC2aeLfX3L4PLcqP9CgXF4/bGvNU4xeQoeGJVWzDDWaIHw8nnQGXJox/LjEg2B/zOU
         drACzXTFC/qXL8wM4ZqUUWU+pM3XOjrwNbIlUIYcTfk1A2HpfWKF2jayfiVHdrie+TTI
         prIA==
X-Gm-Message-State: AOAM531BIBOjldKKpmdmdrQmB7VaQsMxN0grjAvlBXSfmShtgiPpeew8
        4O6PDSefrGnxJayldzADu0XHCQ==
X-Google-Smtp-Source: ABdhPJypazJZ9697LiGRccbUmXufo/yd1FT8MI/itchdPIrTuUcvQJCZXUBOE65xNLvuRU+tTfRibw==
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr3189920pjs.114.1594112065184;
        Tue, 07 Jul 2020 01:54:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15sm244618pgs.25.2020.07.07.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:54:24 -0700 (PDT)
Date:   Tue, 7 Jul 2020 01:54:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <202007070137.3ADBEDC@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook>
 <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 06:56:53AM +0000, Harrosh, Boaz wrote:
> Kees Cook wrote:
> > I have struggled with this as well. The parts of speech change, and my
> > grammar senses go weird. whitelist = adjective noun. allow-list = verb
> > noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is
> > weird.
> 
> > And just using "allowed" and "denied" doesn't impart whether it refers
> > to a _single_ instance or a _list_ of instances.
> 
> > But that's all fine. The change is easy to do and is more descriptive
> > even if I can't find terms that don't collide with my internal grammar
> > checker. ;)
> 
> But why. In English many times a verb when it comes before the noun means an adjective, or an adjective like, describing some traits of the noun.

This is kind of my problem being a native English speaker: I can't
entirely describe _why_ a grammar construct feels wrong. :(

> Example: 
> I work - work is a verb here.
> I used the work bench. - Work is saying something about the type of bench, an adjective. Same as you would say "I used the green bench".

Right, so the verb-noun being used as a noun is find, just as adj-noun
is. To me, "add it to the allow-list" is entirely sensible just like
"set it on the work-bench." It's the "verbing" of a noun that trips me
up.

"I will whitelist the syscall" -- sounds correct to me (same for
"it is whitelisted" or "it is in whitelisting mode").

"I will allow-list the syscall" -- sounds wrong to me (same for
"it is allow-listed" or "it is in allow-listing mode").

Similarly, "I will work-bench" sounds wrong to me as does "it is
work-benched" or "it is in work-benching mode".

> I am not an English native at all but allow-list sounds totally English to me. (I guess the very correct English way is "allowed-list"  where the past tense may convert the verb to a noun. but allow-list sounds very good to me as well. Say work-list as opposed to vacation-list do you need to say worked-list? I don't think so.)
> 
> run mate, running mate. cutting board. these are all examples of verbs used as adjectives. Are they not English? What am I missing I would like to learn?

"it is in allowing-list mode" sounds even worse. :) But other
things require the tense follow the merged verb: "It's already in the
allowed-list" sounds fine, where "It's already in the whitelist" had no
tense since it lacked a verb. I haven't been able to find an comfortable
adjective that means "allow"; "allowable-list" is just long.

But, as mentioned earlier -- I have just switched to more descriptive
and less weird (to me) sentences. "It is set to deny by default"
(instead of "it's a whitelist") or "It's already in the allowed-list".

*shrug*

-- 
Kees Cook
