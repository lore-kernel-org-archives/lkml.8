Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D6AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03F0206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596740584;
	bh=561ATR13rQXzuRTAtFxkvTWmpcfeNlsdzdyWuVL2DzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iiHFGudL0avQ+XpbOYyCwxyMp5nZ3rMBNRqikqZ2+b0hezZukn+aPszKPEfW9q8eb
	 EoWPUBVrq57d91wrZAY9nDjOc+r1C/qvRkR1bT+6jxa3fVf/TBqMxK4HOvbuhLCG5m
	 IxllHmBJI4KwIonTYmZg5q+I7d+w6xh1q60eSNxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgHFTDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:03:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FAAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:03:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so52991699ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w/6rBN9gcH8mjIzzvZHXOpvgS1VvdyWbP7CAnustac=;
        b=LAScYD2k6fWNwYZVw30EOyN6VIFM+unJeE4Ac4q6MGpK5Upggmy70yXYew/uAy1VGW
         2t5EZC5rxF2cpYmLmUWgAbMI7Jq9mHw+U+Lm7wvautoxVNUtfmTjG7Y4SeOk+rCib/WJ
         u8quIegVgsBFetyHqsXvomXjqzM8wZDcWUMgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w/6rBN9gcH8mjIzzvZHXOpvgS1VvdyWbP7CAnustac=;
        b=ojVcPnf5wOxyWUg4nATT0hYXS8a8rKD+ovlGlB5C5Z4e5/5ZcB0T0KJ+5OtSgCoCXh
         nzkfjDG9gftayiansg90WrE5NEutTitoCmUJlTZ7A1TgdCb1S2mOTODu4OpaCaNc22Li
         6hxpjrmhF2hPqDNkVAx2+TK6y1+tuTFLrjbhDQyRiIIjRmZCu/sa2BgHiZYojt7BFArI
         BpZXyH+qiMqntpI2jaLeDpppm3+nOQylKusE39fWsuwW5rnGBCcTnmdynerJ46qmvf8C
         +uwjLQ1vgsW/36CNlA5UpqXfO24XG3/RfO0f2agOBw5wYN0/mcsdhAKtp6+Qv8Ju8R75
         2Shw==
X-Gm-Message-State: AOAM5301AOGo5QUDXCai6Fuz8XeQpW9fSDabFf3ZOx/VeTOEph00IKxg
        KIxTtJUzpA9BIfx9Mlp9Bix8h1Tiy50=
X-Google-Smtp-Source: ABdhPJw8HPpxxgxojaCbnKE9rk63nBTP8L0hV6NmTWw7gaWKyk0oIubGqHJmUKF8ztVFpbxhFAt52Q==
X-Received: by 2002:a2e:2f02:: with SMTP id v2mr4724451ljv.391.1596740578147;
        Thu, 06 Aug 2020 12:02:58 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x2sm2792903ljc.123.2020.08.06.12.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:02:57 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id s9so26705699lfs.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:02:56 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr4695357lfo.142.1596740576374;
 Thu, 06 Aug 2020 12:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200803190354.GA1293087@gmail.com> <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com> <20200806185723.GA24304@suse.de>
In-Reply-To: <20200806185723.GA24304@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 12:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
Message-ID: <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 11:57 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Thu, Aug 06, 2020 at 03:10:34PM +0200, Ingo Molnar wrote:
> >
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > So apparently the "the page-table pages are all pre-allocated now" is
> > > simply not true. Joerg?
>
> It pre-allocates the whole vmalloc/ioremap PUD/P4D pages, but I actually
> only tested it with 4-level paging, as I don't have access to 5-level
> paging hardware.

I don't think Jason has either.

The

        PGD 0 P4D 0

line tells us that "pgd_present()" is true, even though PGD is 0
(otherwise it wouldn't print the P4D part). That means that he doesn't
have l5 enabled.

But you may obviously have different settings for CONFIG_X86_5LEVEL,
and maybe that ends up changing something?

But since apparently it's not immediately obvious what the problem is,
I'll revert it for now.

                Linus
