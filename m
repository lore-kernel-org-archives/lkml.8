Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F8420746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="e1Nga4Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEDSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEDSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:41:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:41:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so14462688edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHvWqbfEB8yb6qlopm+hJaZs/tFY66VoXPBrPdANidc=;
        b=e1Nga4Z4DjmgOTcZiDC753QUjzHP++XYG2YQiFHg89Q0yvU8WzfMYHB2j8mJIj2RoI
         AmV/VHJXHnHhFm328HaI5kSFBiHbqWaUH4lPdCh6MjCqIkJ9YP1LqqSTO2evFV4rIJz4
         MCaMOHyR7Cwe8RZT4M5PsF4qJ6GPI56Ky6oBaf0KFi3g/G1k8C0h3CfBIDjUWWd47Fc5
         nR6EzKDqEYCiAso1aqesKbJe4GxfB9KOBqCeE06jJrKkjaqeWvRzwcwP2N9cDWrCtgUa
         DywL3x7VgMEGvGrE6zzVSMwJ9amOQ9fQoFHQlpIyF6hgB9MLI90uD9C3OrZJ4SgWVJwk
         pPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHvWqbfEB8yb6qlopm+hJaZs/tFY66VoXPBrPdANidc=;
        b=mhdzAkDU+pzl5FL/8Kw7fRfglsnlyQUh+qMMvdRce5SspDk7X8/b1YLWFj6LuOjsQs
         HNl3oU/kTmvaiyDz9xapxSa9y7ussXwZiDiqNLfaxUuyRrB3Z+9I9KKScIzOLEq1vFMz
         HfBMsHGZQEVOtb6ZtnxqjWjbka6Xe2i9PZRCAzYFNO0xPj/G7Pw7Z6QWEKDOZ06Ajxvd
         AXBKF50OHga0dqE38PwGhfNRecXgdzA4KOlhE4OovUeyGQEOUowzmfI6mjxvZuCZmUZo
         dlO4e7tViV7lizqHJgH1rWu4dfO9CArrbcD9L47hQnY4/EqMmpTqkfb0IQhImM994oTL
         K0+w==
X-Gm-Message-State: AGi0PuaxynHa4+TSPx6SJ2YFxUfQ8PDFDs9+jNsICOfSaZPGYUjb2XKR
        bKKeu0TsZ88PqLSM25MgsEqNKEJwV7qfuqnKbUAJkQ==
X-Google-Smtp-Source: APiQypLxTnA8751anvOoZo3J0pXXFgll7A2I9j5SDc8Fw78+RBagvZqw/Wc4F+EFrt6X87Zjv4JsNamCmk2SLQ5qeTk=
X-Received: by 2002:aa7:cfc3:: with SMTP id r3mr16444897edy.342.1588617684859;
 Mon, 04 May 2020 11:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com> <20200504131500.5f6c8860@gandalf.local.home>
 <202005041111.D803E731@keescook>
In-Reply-To: <202005041111.D803E731@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 14:40:49 -0400
Message-ID: <CA+CK2bAF+cS_H-tU29wE54tsdRnBvBEpewgQ7ZM7BfLhASV1mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        anton@enomsg.org, ccross@android.com,
        Tony Luck <tony.luck@intel.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Kees, I think it is a little cleaner this way.

Thank you,
Pasha


On Mon, May 4, 2020 at 2:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, May 04, 2020 at 01:15:00PM -0400, Steven Rostedt wrote:
> > On Sat,  2 May 2020 10:35:53 -0400
> > Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > kmsg_dump() allows to dump kmesg buffer for various system events: oops,
> > > panic, reboot, etc. It provides an interface to register a callback call
> > > for clients, and in that callback interface there is a field "max_reason"
> > > which gets ignored unless always_kmsg_dump is passed as kernel parameter.
> > >
> > > Allow clients to decide max_reason, and keep the current behavior when
> > > max_reason is not set.
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  include/linux/kmsg_dump.h |  1 +
> > >  kernel/printk/printk.c    | 16 +++++++++-------
> > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > > index 2e7a1e032c71..c0d703b7ce38 100644
> > > --- a/include/linux/kmsg_dump.h
> > > +++ b/include/linux/kmsg_dump.h
> > > @@ -28,6 +28,7 @@ enum kmsg_dump_reason {
> > >     KMSG_DUMP_RESTART,
> > >     KMSG_DUMP_HALT,
> > >     KMSG_DUMP_POWEROFF,
> > > +   KMSG_DUMP_MAX = KMSG_DUMP_POWEROFF
> >
> > Hmm, I didn't realize that enums were allowed to have duplicates. That can
> > usually screw up logic. I would recommend making that a define afterward.
> >
> > #define KMSG_DUMP_MAX KMSG_DUMP_POWEROFF
> >
> > As is done in other locations of the kernel.
>
> I've seen it also be the last item in an enum, then comparisons can just
> do "< KMSG_DUMP_MAX" instead of "<= KMSG_DUMP_MAX".
>
> --
> Kees Cook
