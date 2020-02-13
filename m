Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD972073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccgET+Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgBMOB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:01:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51226 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgBMOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:01:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so6377765wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CXRnycs//UYiPxdZCa63k0uV1OBjtasqeSGoE8crBaE=;
        b=ccgET+VsV3Q0g+fihkTjEbtI/xCXPqG38coyGhoLSkgWhHcF88Wp041y1GoFgCm0Ot
         STs+stw40Mc8RcqPHk2gCtg8rANP5Wrr4J9PGyJp5dMAngpCKNGGE3UTKNrUxBtVPUjW
         QZorTZO2pG7VESCKeYqmkrBr0zSwzGdEUCbPkZ9T9Gj3hVBfWmnMC3KADrbOjsFX1050
         sF571E+3AYRALPKBhpk6uKQ7FAh5iRBbgl3gegACBkeeWgeZ6iKKJjL3jaru7AVhoOdY
         y15cxJ8hVfNJC8rf9GLIWnuZ1JjRR2+IEhvbdyOP5R0oJnagr8gbGi/6KF0Osue1u/7r
         dtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CXRnycs//UYiPxdZCa63k0uV1OBjtasqeSGoE8crBaE=;
        b=EA7FRva4fSGXpyXzFo6LizPlZTLsWF+iaJp+vuWqF9uK7jf/ptTL4Hkhf3GN82NyiD
         ARt+7dgMzqkJ2yvVNKt/Bvzn4b35eU7Vs1xr8mlMxsE953eKvtRoTYSh0N0ijTvw1ZLn
         bNYFZJ18AyDquccji7F2Phxd3LbCKpbjn+Sxc9HAcvxKPCrEvJ67Xpkhh8njIQxoatop
         lt6GPyJ+GHNBzihpUXmXCoJ7mputEcoOaJUCBoylDs+++2qCe+BQznVy1RCk9do+m5ec
         LaBJ0AghQIfcxfwoeQjUH3dTZaUAp8zaW9pb3XMgVL3eWQzfMIjmEEIc9B0BAfX5jTNY
         /w1g==
X-Gm-Message-State: APjAAAX5cRhCWhnSyZy+CN/mh534YRIsVQIY5SUVx90Wg/2rfoHMmXuc
        9PbTwA37APyKEptymSA8zNQ=
X-Google-Smtp-Source: APXvYqzJpi898A4OUwyAmnZBHOE3KRFE0RrOnPgdfoCvNsXZI1x7IJFXIu00t+wUntns3i9JvZ+QeQ==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr6011226wme.90.1581602483317;
        Thu, 13 Feb 2020 06:01:23 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id b16sm2946739wmj.39.2020.02.13.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:01:22 -0800 (PST)
Date:   Thu, 13 Feb 2020 15:01:17 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Will Deacon <will@kernel.org>,
        paulmck@kernel.org, Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213140117.GA16550@andrea>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213113432.GF69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200213113812.GG69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200213135138.GA5843@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213135138.GA5843@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:38PM +0100, Andrea Parri wrote:
> Hi,
> 
> On Thu, Feb 13, 2020 at 07:38:12PM +0800, Boqun Feng wrote:
> > (Forget to copy Andrea in the previous email)
> > 
> > Andrea, could you tell us more about how to use klitmus to generate test
> > modules from litmus test?
> 
> The basic usage is described in "tools/memory-model/README", cf., in
> particular, the section dedicated to klitmus7 and the "REQUIREMENTS"
> section.  For example, given the test,
> 
> andrea@andrea:~$ cat atomicity.litmus
> C atomicity
> 
> {
> 	atomic_t x = ATOMIC_INIT(0);
> }
> 
> P0(atomic_t *x)
> {
> 	int r0;
> 
> 	r0 = atomic_fetch_inc_relaxed(x);
> }
> 
> P1(atomic_t *x)
> {
> 	atomic_set(x, 2);
> }
> 
> exists (0:r0=0 /\ x=1)
> 
> You should be able to do:
> 
> $ mkdir mymodules
> $ klitmus7 -o mymodules atomicity.litmus
> $ cd mymodules ; make
> [...]
> 
> $ sudo sh run.sh
> Thu 13 Feb 2020 02:21:52 PM CET
> Compilation command: klitmus7 -o mymodules atomicity.litmus
> OPT=
> uname -r=5.3.0-29-generic
> 
> Test atomicity Allowed
> Histogram (2 states)
> 1963399 :>0:r0=0; x=2;
> 2036601 :>0:r0=2; x=3;
> No
> 
> Witnesses
> Positive: 0, Negative: 4000000
> Condition exists (0:r0=0 /\ x=1) is NOT validated
> Hash=11bd2c90c4ca7a8acd9ca728a3d61d5f
> Observation atomicity Never 0 4000000
> Time atomicity 0.15
> 
> Thu 13 Feb 2020 02:21:52 PM CET
> 
> Where the "Positive: 0 Negative: 4000000" indicates that, during four
> million trials, the state specified in the test's "exists" clause was
> not reached/observed (as expected).
> 
> More information are available at:
> 
>   http://diy.inria.fr/doc/litmus.html#klitmus

And I forgot to Cc: Luc and Jade, the main developers (and current
maintainers) of the tool suite in question.

Thanks,
  Andrea
