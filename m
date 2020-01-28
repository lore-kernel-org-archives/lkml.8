Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDACC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A9E24656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580172119;
	bh=lsGiniElf7t1vQe/yeZPYjWpHBZUL0oj3j1WyfVYCKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hyrh2d/2zcDyg544F7Vx1945bp0TTm2alKhYkhB5anG+60eMcyb1vmvA+EoGWYF9g
	 iApElx1dGlpmjDotWLaE03D1xKEMLSOaxg2LwrfxA3z5lgAmFyIEsF8rPvI5urDITw
	 OyP8uaGIcSvDLA0bTMBhgZY6kF0GmG7uBuXHJWuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1Al6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:41:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39587 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Al6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:41:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id o11so12907908ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WT6OQboDqDdBVguxGZPI8tN+5N4G/SkgccbL5p+tTyg=;
        b=G2AO03J+N/TYYht42zHBkx3+WSJwntkNO580Grzbw1f3GZCm33p2lDW6SJyd65pai2
         pyCuD9Sjiapd/Cg8Kh0j3fXE8aryjYxbBedl4B25FMu9X6rrH5YsZBffYXhwmrZaGhEY
         vp3YDWhWn2ofDOnXD3z+MRi1229Q4CuUsiHFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT6OQboDqDdBVguxGZPI8tN+5N4G/SkgccbL5p+tTyg=;
        b=CcfIp+pQx6QODiV+U/Dv5E8zHcjhc68BCjdoh/eZTZxMionspPCe2kqPEioIh52xFX
         457yVtdB10bdfb20d0jXiafZ8gsK3Ij7xzJftp9K83tDmNh4yYm/JCRLitqKQitkDjaX
         YqnnlKdQd863BnV//6XMG0zQeZl6MJLoBF8psiB7zm1/Lw5my8SEHFNf/4W58hxO/3L7
         FpIo8s9xiAYY8bUQGYfoD1Id8+EQJBdwArHptCqFLIyLvx1XZRx+AMyGNEukqlydtOd8
         V5hZHElylILMpV8H9L5pXUU1DAUiqVpmgW8ooUZyhyWpR3+WjX1PFDi8ZRyd60keg0zD
         4fJA==
X-Gm-Message-State: APjAAAVbl7aMymb8f8KvauFtCy8/Ea2J1ImNlt5WRKMvcxsNngw9yzxw
        QhV+LlGxytBzyPlhVD3e/gM8+OMW/j8=
X-Google-Smtp-Source: APXvYqy/6tD1cttuKKQf+pmsQ/aeD4E+mN++WAuJNQ+D7wQ/OvR9JZDDHTh7GNCpGAsR6dMD0VciLg==
X-Received: by 2002:a2e:6815:: with SMTP id c21mr2921lja.10.1580172115166;
        Mon, 27 Jan 2020 16:41:55 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u19sm8804298lfu.68.2020.01.27.16.41.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 16:41:54 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 203so7707255lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:41:54 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr779881lfa.30.1580172113744;
 Mon, 27 Jan 2020 16:41:53 -0800 (PST)
MIME-Version: 1.0
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 16:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQYcq=tFqGDm7HVHozrf4ijWyCBWqT61NJ9DYcHVKZjg@mail.gmail.com>
Message-ID: <CAHk-=wjQYcq=tFqGDm7HVHozrf4ijWyCBWqT61NJ9DYcHVKZjg@mail.gmail.com>
Subject: Re: [GIT pull 0/7] Various tip branches
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 4:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> the following pull request are my first attempt of using signed
> tags. Please double check and yell if something went wrong.

Well, the first one looked fine, but the subject lines were a bit odd
on most of them.

They say "[GIT pull] xyz for" without saying what they are for.  So
there's a missing "5.6-rc1" there ;)

Not a big deal, and I don't think it has anything to do with the
tagging, which looked fine in at least the timer fixes case.

              Linus
