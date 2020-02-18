Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBDC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665DB24656
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582067030;
	bh=twuymwAEbzZB2Snt3cp9Ply0T+JnEhamIytBOlWdSIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tALdlxRfI0AXtLxZiuwyfGQlwFBR27UW1sRPIm7RISy+qwqbU7vQLx28gF5FNsvKJ
	 8fZvmONg+eW6+TY2E9IgG+EXva3oInYBO2W5CdIk45DE2cOil7iLeNi1bIg+tsm6FB
	 QbxGNPAaj/y++i4Djf9cmPvoNM3GClv7pvBh2EPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgBRXDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:03:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35811 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgBRXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:03:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id n20so709036lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2b+2qHSICAQfk4L4lxWTYsNq58C+5hPouycMXdDVlQ=;
        b=JCZ5z9TA9DJiwkWsOfjqukijyaYu0aIusI6XEIZJ9+uLhWezmsELqdwSOurjue6DxK
         c6QUuHorl5ixd65q+iv2YKr9OG1u4Mo/dy5UiXnuaNvNOx/7Y6I+vO1va++1CJzm9RTr
         AwzmCCvxwCjKFS8uBbdqY2NddxWSXfkklkYpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2b+2qHSICAQfk4L4lxWTYsNq58C+5hPouycMXdDVlQ=;
        b=sJC6l0tOvNxlxv5u5eveWTDLait7YswNfLYRQ9XA/j0oGC0LYgkqiLgpC222mx0yu+
         IrKM4uH8wu6SOss5FYeweH4cMUNHUBnBZJqDWxh10jJeg27kdEVNInVyJbsrlBvch41e
         d0vSsjHu8qWUpEbo/xuweqzzeNChj39uli79USYuzhoukQwdIrzZcHihStdYeebDIG9L
         8isc5+glSw9Pfhy+a97Hw0g7B+MoRfR8ZRAPPRml/0Ik5TCVS5TCbWMWihW/3663+x5V
         LZe/MVQmG573uYUFkv5Le1Q09B0Hbi0DuZ1fjE8F+DvauiI0KmyUkIdoN8DU8iwidJbY
         qu+A==
X-Gm-Message-State: APjAAAU43APeAu17ikRHWKboLoWe+wsSk0zS3qYxPmpsjm3kWBccYI4Q
        LQ8r4nwlFMztUlK6jjZu95CRevxp3HA=
X-Google-Smtp-Source: APXvYqzPKNfww1H6oXh/dVRKGre4gX6QFSVPE6KWi+ma46XBODjV2vabVPfWQvPHWzfnVikY+MeiAQ==
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr11373137lfh.140.1582067026323;
        Tue, 18 Feb 2020 15:03:46 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h5sm104106lja.16.2020.02.18.15.03.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 15:03:45 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id q8so24913019ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 15:03:45 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr14935845ljj.265.1582067024793;
 Tue, 18 Feb 2020 15:03:44 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
 <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
 <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
 <CAHk-=wiaDvYHBt8oyZGOp2XwJW4wNXVAchqTFuVBvASTFx_KfA@mail.gmail.com>
 <20200218182041.GB24185@bombadil.infradead.org> <CAHk-=wi8Q8xtZt1iKcqSaV1demDnyixXT+GyDZi-Lk61K3+9rw@mail.gmail.com>
 <20200218223325.GA143300@gmail.com>
In-Reply-To: <20200218223325.GA143300@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 15:03:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKHFB9-XggwOmBCJde3V35Mw9g+vGnt0JGjfGbSgtWhQ@mail.gmail.com>
Message-ID: <CAHk-=wgKHFB9-XggwOmBCJde3V35Mw9g+vGnt0JGjfGbSgtWhQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 2:33 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> I run CRIU tests on the kernel with both these patches. Everything work
> as expected.

Thanks. I've added your tested-by and pushed out the fix.

           Linus
