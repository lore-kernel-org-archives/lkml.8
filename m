Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF7CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E82D20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzDXqXnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgEMJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgEMJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:13:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:13:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so13036781lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IFyPd5jaNLoWjNXVKhmuzoT4Iff8vuIMwsOFgF6oOY8=;
        b=VzDXqXnMJRY3pyvJu/3XbYwAqBzyftpy8OJkHqzbWgYb8p7+5vAE+S8tQwDVcffOVh
         vYhe1Gps3SR/KgfRjPa6EOReK16zzpV1Oq8iwCbNXmZbqGuUL/6StErGr9eya4qk8Vql
         eoHka4yVI9NAQPOaJTgv9zjzsvmC0rGU4HGlewMOQXkI+z1GCtDOoTjacgx9IU+d8JSb
         a0tke74vkvEZ9G7P056Js0DgY8650Gy/Dj+Zqb1VeJs+BzgMIch349ExS4q8Tp2Jb4Sm
         Cr7aqrN0sHyvcqJcj+Df4O+QsKzlBC7Y1PyOuPiKVIbFJuERD5lA6trip0T+I6yC0V/2
         E/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IFyPd5jaNLoWjNXVKhmuzoT4Iff8vuIMwsOFgF6oOY8=;
        b=HyQzgzJkMI9b06z+/vKfm3xH2gygv3Eo2pXafgDbe4GUFg1WrQgvTkyeG/80d0yubq
         hdgOiP76bGWt+9UaJ+dnAQ/04B142XxLrrBS62na1WgvwN22AvlgwsDQQV9Dfj9zNLoL
         uDu4RSlJgqwLz3aLEeaCYEMyW5hAw4/FPOc6RSuXD5zknFkz2OjTuQ0GFkNDVDAvXGbh
         bixssn1uT3axkUUgazzMEwFhQTxHZrXO8V950KjUnfusPvciYzhllCcU6mEAfbnmARz8
         RM+PF9mhWFBKOWkUYj+pJW04nQJVq/v9wokbu4Q74MTEezsewnHoTxKR9cfEk6jTJdSK
         aDwg==
X-Gm-Message-State: AOAM533i2pX7KtaUVfBxZ57D7TSQAHv8UMWlXTnU0b05/Ae491FE22xJ
        GZN7HjAcXDwQNDBeEyuG2MkNP34S
X-Google-Smtp-Source: ABdhPJyv6JVdvUV6roCDn3iAyUesWz9Opt7yiBKnPF6+R53rtButc0mL1SrF6HiN8rkW4n9bvPO1hg==
X-Received: by 2002:a19:4285:: with SMTP id p127mr17145726lfa.46.1589361219858;
        Wed, 13 May 2020 02:13:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d8sm15447446lfl.51.2020.05.13.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 02:13:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros
 and functions to UAPI
References: <20190923130531.GA27774@asgard.redhat.com>
        <87y2pxvsbr.fsf@osv.gnss.ru> <20200512223103.GC1016@asgard.redhat.com>
        <CALAqxLUGr=+UjYhQSN34fUMCqj1Ya85tbFKu685cN+XTWYfgXg@mail.gmail.com>
Date:   Wed, 13 May 2020 12:13:37 +0300
In-Reply-To: <CALAqxLUGr=+UjYhQSN34fUMCqj1Ya85tbFKu685cN+XTWYfgXg@mail.gmail.com>
        (John Stultz's message of "Tue, 12 May 2020 15:40:07 -0700")
Message-ID: <8736845ha6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Stultz <john.stultz@linaro.org> writes:

> On Tue, May 12, 2020 at 3:31 PM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>> On Tue, May 12, 2020 at 10:58:16PM +0300, Sergey Organov wrote:
>> > Eugene Syromiatnikov <esyr@redhat.com> writes:
>> >
>> > > As of now, there is no interface exposed for converting pid/fd into
>> > > clockid and vice versa; linuxptp, for example, has been carrying these
>> > > definitions in missing.h header for quite some time[1].
>> > >
>> > > [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
>> > >
>> > > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
>> > > ---
>> > > Changes since v1[1]:
>> > >  * Actually tried to build with the patch and fixed the build error
>> > >    reported by kbuild test robot[2].
>> > >
>> > > [1] https://lkml.org/lkml/2019/9/20/698
>> > > [2] https://lkml.org/lkml/2019/9/22/13
>> > > ---
>> > >  include/linux/posix-timers.h | 47 +------------------------------------------
>> > >  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
>> > >  2 files changed, 49 insertions(+), 46 deletions(-)
>> >
>> > Was this patch applied, rejected, lost?
>> >
>> > I can't find it in the current master.
>>
>> IIRC, it was ignored.
>
> Overlooked. :)  Not intentionally ignored.
>
> I don't have any major objection with adding helpers, though I feel
> like you're exporting a lot more to the uapi then applications likely
> need.
>
> Would it be better to add just the bits from the missing.h header you
> pointed to:
> #define CLOCKFD 3
> #define FD_TO_CLOCKID(fd) ((~(clockid_t) (fd) << 3) | CLOCKFD)
> #define CLOCKID_TO_FD(clk) ((unsigned int) ~((clk) >> 3))
>
>  to the uapi header?

Please, no:

1. These macros were copied almost verbatim from the kernel code long
ago, and since then kernel has changed them to inline functions, so
getting back to these obsolete macros is pointless.

2. If we do need to export macroses, then kernel inline functions are
better to be re-implemented in terms of these macros, not to have 2
different points of implementation.

Overall, I'd vote for the current approach of the patch, provided
exporting inline functions to user-space is allowed.

-- Sergey Organov

