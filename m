Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D17C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C0120857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="sYHDE5ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDTQlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726671AbgDTQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38EC025490
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:32:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so420638wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=acWWPzmaQW27xNanSJeIRIY/L2jzIwyKS2KUn4ii4yY=;
        b=sYHDE5ieByXI+VBlh4AwOfEMN78KnBQoGXrMdWDqHsq/d/O4WAfCG/L0sgwr5lFBAx
         kOQQYlarB1GjYuFFWl9Oyl5RCXz0dTvFRbnIYqEBMEA9EQaGhzaU6hT5nLBBS3lH4Czu
         z+RqfkXZkgBXpU4Rbsy9comzYVVmwZqhYBdPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=acWWPzmaQW27xNanSJeIRIY/L2jzIwyKS2KUn4ii4yY=;
        b=adNUrfP/T26FwRmjdBn/jwOAPfHfhTZ5DWx7+Cu4V9rqxcvrJqv0KJjZPZdLplXUxx
         M5OsSDyTMcfqSBsKh+ZWSPlAMxRVd+NKaI+M93GV74Gt+2fRBxDstbzc/fRvCojEkPX9
         4UMbYHbp71eJgc4mj31AliVD057enVTe3QlfWLJhOlSPU/9RQrxbxlZ1X6pvKFIpYHhI
         XfI55W0fqdNgKzaD1RaNJS3a4EzIPSTHGmw7QQPyTPTvVBZVsoS8+36Iel1vOh+TzMRI
         RjmH2vU3SrOWqXb793Qr/ole4SxSobWgy/9B9KKlgeLOJ+2K5XR0h3mKXOfbhDsgoCSD
         33ZA==
X-Gm-Message-State: AGi0Pubq935VMuDlnhsFuj5RNvv/XhQdeAL++IX0a+/C+YkOvns0vtFX
        qmLzgEEVft70nlzCSNtMwlA2UiXPo5M=
X-Google-Smtp-Source: APiQypKu5siu6x5z4nZE2uzrNDMPyrb7orMB0oSDjCOQwuYBMHsWxg+aZuvF6v4jB7n+81W+V5BlDQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr172545wmc.142.1587400337578;
        Mon, 20 Apr 2020 09:32:17 -0700 (PDT)
Received: from carbon ([94.26.108.4])
        by smtp.gmail.com with ESMTPSA id z76sm186638wmc.9.2020.04.20.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:32:16 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:32:15 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200420163215.GA43378@carbon>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420150545.GB17661@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-20 08:05:45, Paul E. McKenney wrote:
> On Sun, Apr 19, 2020 at 09:37:10PM +0000, David Laight wrote:
> > From: Petko Manolov
> > > Sent: 19 April 2020 19:30
> > > 
> > > On 20-04-19 18:02:50, David Laight wrote:
> > > > From: Petko Manolov
> > > > > Sent: 19 April 2020 10:45
> > > > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > > > >
> > > > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> > > >
> > > > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > > > field 'volatile'?
> > > 
> > > This is a bit heavy.  I guess you've read this one:
> > > 
> > > 	https://lwn.net/Articles/233479/
> > 
> > I remember reading something similar before.
> > I also remember a very old gcc (2.95?) that did a readback
> > after every volatile write on sparc (to flush the store buffer).
> > That broke everything.
> > 
> > I suspect there is a lot more code that is attempting to be lockless
> > these days.
> > Ring buffers (one writer and one reader) are a typical example where
> > you don't need locks but do need to use a consistent value.
> > 
> > Now you may also need ordering between accesses - which I think needs
> > more than volatile.
> 
> In Petko's patch, all needed ordering is supplied by the fact that it is the 
> same variable being read and written.  But yes, in many other cases, more 
> ordering is required.

There's pros and cons, as usual.  Yet another macro(s) versus sorter/more 
readable code.  This is why i decided to spam the list (and Paul) - in search 
for another opinion.

> > > And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> > > example, all others are from withing spin_lock/unlock pairs then we _may_ not
> > > need READ/WRITE_ONCE().
> > 
> > The cost of volatile accesses is probably minimal unless the
> > code is written assuming the compiler will only access things once.
> 
> And there are variables marked as volatile, for example, jiffies.
> 
> But one downside of declaring variables volatile is that it can prevent KCSAN 
> from spotting violations of the concurrency design for those variables.

Which would be unfortunate.

I just wish there was C type declaration that would force the compiler to do 
what READ/WRITE_ONCE() does now, but i also know this is too naive... :)


		Petko


> > > I merely proposed the _INC() variant for better readability.
> > 
> > More like shorter code lines :-)
> 
> That too!  ;-)
> 
> 							Thanx, Paul
