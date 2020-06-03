Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A92EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58F52067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXa9VETT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFCTYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgFCTYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:24:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455BFC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 12:24:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so3594664wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKmZFODxU/V1iE906T8Ef11jEu4sRvf6rW5JJEx9JQQ=;
        b=UXa9VETTQawjhSxj5nM4Agh4SuVLfZUM4nVsTXhDxHn9yFXnREMQcZHfCjFaa9fwgq
         bHQyRdjqyJtlIooe0p9xhkBnY4sVBygZA1PIoXK8WuNoMtu81VJxPRvBgO4carCzyP4S
         smzbFIgNE70FDiBofuMgkmpqGVV9OAfWwhWPf5ldMwrj/aEKrRKDbycFQk/SSjBufiaQ
         U/lMESMtiJnqmAlnxxkvwN6LVHowWRR9O6Wo615JHFMKXdpOfVNoL/nbhJLDZqoTBq5D
         qXKqwOl40cVDnqhf4hv0+6vL8PXKpiS7cgdzmqEreFJUJZgCzaVj0wzApm35HvPkZWn7
         53vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKmZFODxU/V1iE906T8Ef11jEu4sRvf6rW5JJEx9JQQ=;
        b=LqSkqH8UIAMoFj0X1n97zwzqdOG488TrzVlPKzdhwhuBVvVn4JrfRni0BwozLQS841
         LMjrdgRC24ru8DExV7NOkqAnGGFwoN1gsG7nP4yXKC5i2pjhNY/OPZdTUY4/dlxBLGlK
         33sWpagX4ncVAeFZOEOkYqrnLh04Tu7gqcGcfdOGdESyq7eJVjxjTaZbhXN0i4TM/W1v
         KLix1ELxhvFtzMe/0sdoT10aemey5Xw4mXJunrwkXI/a2qpELlBZZ0ui0lgY8fRQEiI+
         JBKu53Z5Xl86PbVlAq8Pep7geBQX8htwbAoDPulLEGvKB/Lg927fNtMc407OSOEWmgtI
         THLw==
X-Gm-Message-State: AOAM533ol8YKLlRc8l9SB0teeKDXxFCZFTHWT32HZ9jP+w1DzHBc/uvV
        ufTdMf9EjAASi/W9CSWTlwLtrA==
X-Google-Smtp-Source: ABdhPJwUVTOFpofE2C3k3f+UFBTdrMS7aFklqZgR7nOCOKaMeOPcUFbCTX3L6GOWSrdfPPMMa4Na9Q==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr892040wrp.82.1591212239832;
        Wed, 03 Jun 2020 12:23:59 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z25sm4131038wmf.10.2020.06.03.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:23:59 -0700 (PDT)
Date:   Wed, 3 Jun 2020 21:23:53 +0200
From:   Marco Elver <elver@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200603192353.GA180529@google.com>
References: <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
 <20200603185220.GA20613@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603185220.GA20613@zn.tnic>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 03 Jun 2020, Borislav Petkov wrote:

> On Thu, May 14, 2020 at 12:05:38PM +0100, Will Deacon wrote:
> > Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
> > and the behaviour for __always_inline is:
> > 
> >   * An __always_inline function inlined into a __no_sanitize function is
> >     not instrumented
> >   * An __always_inline function inlined into an instrumented function is
> >     instrumented
> >   * You can't mark a function as both __always_inline __no_sanitize, because
> >     __no_sanitize functions are never inlined
> > 
> > GCC, on the other hand, may still inline __no_sanitize functions and then
> > subsequently instrument them.
> 
> Yeah, about that: I've been looking for a way to trigger this so that
> I can show preprocessed source to gcc people. So do you guys have a
> .config or somesuch I can try?

For example take this:

	int x;

	static inline __attribute__((no_sanitize_thread)) void do_not_sanitize(void) {
	  x++;
	}

	void sanitize_this(void) {
	  do_not_sanitize();
	}

Then

	gcc-10 -O3 -fsanitize=thread -o example.o -c example.c
	objdump -D example.o

will show that do_not_sanitize() was inlined into sanitize_this() and is
instrumented. (With Clang this doesn't happen.)

Hope this is enough.

Thanks,
-- Marco
