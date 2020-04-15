Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B81C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481E62072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDNDsDqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393010AbgDOC1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbgDOC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:26:51 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2EC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:26:51 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h205so8339551ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 19:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVm1mdzhIQulODHe4ViIUFisQeB0C3YOnKOzD5pQ3Tg=;
        b=hDNDsDqr3rMKp1Nc5ucKl1+B3Ge0lECWe6d0K+WqYKSJd5TMjOV4+LP3l5kvFomNJN
         BtinqFB5MoxJK08vxD6MSgH5osxr83VCVAWGahbjoAoMFDfh4cZJ7NZNAYjMvgK0wtSr
         k9Y3KBmgGA1VMJ3BF8wiNd3ePavyEX+mDpuo+HtDEHS8clebtMGNN8NoeCVgG9ucLvRk
         4FPFyQHci+8OpIOC9cWP+Zo93uW2QKZlUF+B5E82a8cy0rAlVFZu8WjxGXcVzNxhMiM7
         vI6ZTW8qvo9RGK97igtx504WMPfEDdb8TQtUyzw8EPBSGY/PudKu4kJYHYX6pt17A22c
         0yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVm1mdzhIQulODHe4ViIUFisQeB0C3YOnKOzD5pQ3Tg=;
        b=PBoocxtM2b9IbjjypG9DrHN+gXdB/eYlZ6plu7Wwnj+RAfUtL/rn+JD32kej/AWn8W
         7qR5+c8y7GRLhpNK8Y1ofUZ6DPa3Omk7xjyG1HPG015HaUzvYXWMhhr8/DPBTutOHIne
         tJ8Lxc2V4HkvW++6Y3+fkoVjtBxzbCNzYzjgIyM5l8/uHnj0K9OPqAx4iXvpkeYwYRoB
         Q33CCw6VbP/7ulEyniH41jpaIezzw2pxz9n13yRSE1F3kP9DbpwI9LE/xMKArYEzkiiU
         aS+woymNaPBgqWI3RINio/q4TE/x7Fud1aT2UPrUSAozhKIq2QXr3ugcRZT7HfkySbAH
         5yrw==
X-Gm-Message-State: AGi0PuZlzGXJg+/Bbc7KfhVGsTSesqM6zSYNX2xO73R5n23l3TJoSvwj
        ocFgNQZbIlw3rA/xSCtwyDgyqOIE6SGLjOkx8rXYYg==
X-Google-Smtp-Source: APiQypJT2O6XhyztsDuWTdyDMNKdRkVRrI5/NWhiiuWdziZ4aTjiT2gEwRG+6J5mnrX1WvcJzxYRvE6IptxThQ9uWgY=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr4821189ybc.47.1586917610171;
 Tue, 14 Apr 2020 19:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200411064248.247530-1-irogers@google.com> <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
 <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com>
 <CAM9d7cgsR7mU_N3BaOz3i2XWY_GchOYWHvNh8g+=2VHTFGEm9Q@mail.gmail.com>
 <CAP-5=fU+rrpK=zNBWWDBxUMYBz6yV3FZV3uhwye7euN7m8saDg@mail.gmail.com> <CAM9d7chvpCOdSAeRH1+1vt_m+-Ecwm7jRXrN2OAjAP5yJwc=og@mail.gmail.com>
In-Reply-To: <CAM9d7chvpCOdSAeRH1+1vt_m+-Ecwm7jRXrN2OAjAP5yJwc=og@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Apr 2020 19:26:39 -0700
Message-ID: <CAP-5=fXRV8d7yTWqR=5F2dwg-MtxrMc4BQYVd3v8gDTSMqLJKg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Apr 14, 2020 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 5:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Apr 14, 2020 at 1:22 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Mon, Apr 13, 2020 at 12:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > The synthesize benchmark shows the majority of execution time going to
> > > > > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > > > > reading library that will be used to replace these calls in a follow-up
> > > > > > CL. Add tests for the library to perf test.
> > > > > >
> > > > > > v4 adds the test file missed in v3.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> > > > > > + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> > > > > > + * returns the character after the hexadecimal value which may be -1 for eof.
> > > > >
> > > > > I'm not sure returning -1 is good when it actually reads something and
> > > > > meets EOF.
> > > > > Although it would have a valid value, users might consider it an error IMHO.
> > > > > Why not returning 0 instead? (I'm ok with -1 for the later use of the API).
> > > >
> > > > Thanks for the feedback! In the code for /proc/pid/maps this is a
> > > > hypothetical, but I think having the API right is important. I didn't
> > > > go with 0 as you mention 0 'could' encode a character, for example,
> > > > 7fffabcd\0 wouldn't be distinguishable from 7fffabcd<EOF>.
> > >
> > > Practically I don't think it matters in this case as long as we can
> > > distinguish them in the next call (if the user wants to do).
> > > What users want to do (I think) is whether the returned value
> > > (in *hex) is ok to use or not.  By returning -1 on EOF, it might
> > > be confusing for users..
> >
> > In the /proc/pid/maps case the code for reading an address like
> > "00400000-00452000 " the code is:
> >
> > if (io__get_hex(io, start) != '-')
> >   return false;
> > if (io__get_hex(io, end) != ' ')
> >   return false;
> >
> > If io__get_hex doesn't return the next character it becomes:
> >
> > if (io__get_hex(io, start))
> >   return false;
> > if (io__get_char(io) != '-')
> >   return false;
> > if (io__get_hex(io, end))
> >   return false;
> > if (io__get_char(io) != ' ')
> >   return false;
> >
> > Which is twice as verbose and requires that io have a rewind operation
> > to go backward when io__get_hex and io__get_dec have gone 1 character
> > too far.
>
> Yeah, I'm not against returning the next character - it's good.
> The only concern was whether it should return -1 or 0 when
> it meets EOF after parsing some digits.
>
> But I think we can go with this version as there's no such case
> when parsing /proc/pid/maps.
>
> >
> > > > The updated
> > > > code distinguishes the cases as 0 meaning character \0, -1 meaning EOF
> > > > and -2 meaning bad encoding. Your worry is that a hex number that's
> > > > next to EOF will get a result of -1 showing the EOF came next. and
> > > > code that does 'if ( .. < 0)' would trigger. While clunky, it'd be
> > > > possible in those cases to change the code to 'if ( .. < -1)'.
> > >
> > > Yes, but it's not conventional IMHO.
> > >
> > >
> > > > So my thoughts are:
> > > > 1) being able to tell apart the 3 cases could be important - this is
> > > > all hypothetical;
> > > > 2) keeping EOF and error as negative numbers has a degree of consistency;
> > > > 3) using -1 for EOF comes from get_char, it'd be nice to have one
> > > > value mean EOF.
> > > > Perhaps the issue is the name of the function? It isn't a standard API
> > > > to return the next character, but it simplified things for me as I
> > > > didn't need to add a 'rewind' operation. The function names could be
> > > > something like io__get_hex_then_char and io__get_dec_then_char, EOF
> > > > for the 'then_char' part would be more consistent. I'd tried to keep
> > > > the names short and have a load bearing comment, which isn't ideal but
> > > > generally I believe the style is that function names are kept short.
> > > > Let me know what you think.
> > >
> > > I'm ok with the function name and understand your concerns.
> > > And I don't want to insist it strongly but just sharing my thoughts.
> > >
> > > Thanks
> > > Namhyung
> >
> > Thanks, feedback appreciated! It is useful to discuss and it is
> > straightforward to change the API but I'm in two minds as to whether
> > it would be better.
> >
> > I'd still like to land this and the next patch, as getting rid of
> > fgets/sscanf saves 50us from event synthesis. Breaking out the io part
> > of that change wasn't done so much with a view to replacing stdio, but
> > just something minimal that serves the /proc/pid/maps case.
>
> The performance gain looks nice!  Thanks for working on this.

Thanks for the feedback! I think we can keep an eye on the API, the
idea to change to 0 isn't an unreasonable one. I have some other
multithreaded synthesis improving patches to send from Stephane, and
I've updated the benchmark to measure these. I'll re-send these
patches with the new single and multi-threaded benchmark data.

Thanks,
Ian

> Thanks
> Namhyung
