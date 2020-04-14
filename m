Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC9420732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLm8EFE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbgDNAsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgDNAsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:48:42 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC98EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:48:41 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f13so4545520ybk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gvjFatiCywE1S9wviPP5PEAkXXrvKZmXNwlidIrsLA=;
        b=MLm8EFE0n161ZHUhGKsyTbvFbRoioWzffRuGRl7AV/azUk8YQDvFDLp+1uua1jcmb+
         rxiip0ft5DjKWW+wuECV4ML79/UiRajxhPcPHj/85fC3qxuLOWEG3Sqvg4otuhB83v+4
         z73hvJt6B18yXAN3rMDYzXkt8P8N8Ot8ikZkgbEQkKFe2U9XL0p7SW3fSvnCVDiukiA/
         gMTbEzdHJTHUIGXBs+qaXE4lC77PE75Scfd/sLsWHMtnrfHCLCR37+qnjGaNs76PmYUG
         8VhUy9J1mvvdSh63zTEMME0TyeVdEWeH8MyhU5/+4D9Z/DxxUBq2iNmTI7S2PTBDrsVO
         HjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gvjFatiCywE1S9wviPP5PEAkXXrvKZmXNwlidIrsLA=;
        b=jYtGfiINVnJfsDnAuJWhRAvKmScjSQI+2UwOxjGgerCNzgB22b+anYhqnrkrUeKbI0
         6e32lURQ/yC05vewZko/NrsiCCxMmXS/ralaXDqbv9fNZUhBlScIrcgJWrZLNXTb+s44
         mmLX5mcCKYh56vgr4P45KOfna+Xgjg9v/LLI5+2wYPjau5JfvG/PUxpxgZFA1TWON9/V
         apw2iZ8m+PFpPt7zygzAdTCcwAQ9FdobYb8YYouhPANOlMvk7OsRB/VA4v4hqVBCHCiM
         dMJeYKbRRtJOSx0I6KW8kmhryWDFplOfCyyVSnXFnZkN59KqZ71cUsR5foh0tpCbiPo9
         XALw==
X-Gm-Message-State: AGi0PuYGd5TxicvpuzVSJhopnuqvPMwSewt53vf6fdm/oHxSZ0OgTFKH
        fgzeuFMNtyMva9JAkma52kFsMDfYK6rZNCEybWXSkw==
X-Google-Smtp-Source: APiQypIXy2HlUHvlV29NY0kTqpfs+vlrjf8j6QaEAxQTGkqhygG7qKdrt0TQpwbvdcA39NIVnOgJKM5IxfOHarOaiY4=
X-Received: by 2002:a25:c64b:: with SMTP id k72mr32444297ybf.177.1586825319586;
 Mon, 13 Apr 2020 17:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200411064248.247530-1-irogers@google.com> <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
 <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com> <CAM9d7cgsR7mU_N3BaOz3i2XWY_GchOYWHvNh8g+=2VHTFGEm9Q@mail.gmail.com>
In-Reply-To: <CAM9d7cgsR7mU_N3BaOz3i2XWY_GchOYWHvNh8g+=2VHTFGEm9Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Apr 2020 17:48:28 -0700
Message-ID: <CAP-5=fU+rrpK=zNBWWDBxUMYBz6yV3FZV3uhwye7euN7m8saDg@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 5:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Apr 14, 2020 at 1:22 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 12:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The synthesize benchmark shows the majority of execution time going to
> > > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > > reading library that will be used to replace these calls in a follow-up
> > > > CL. Add tests for the library to perf test.
> > > >
> > > > v4 adds the test file missed in v3.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> > > > + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> > > > + * returns the character after the hexadecimal value which may be -1 for eof.
> > >
> > > I'm not sure returning -1 is good when it actually reads something and
> > > meets EOF.
> > > Although it would have a valid value, users might consider it an error IMHO.
> > > Why not returning 0 instead? (I'm ok with -1 for the later use of the API).
> >
> > Thanks for the feedback! In the code for /proc/pid/maps this is a
> > hypothetical, but I think having the API right is important. I didn't
> > go with 0 as you mention 0 'could' encode a character, for example,
> > 7fffabcd\0 wouldn't be distinguishable from 7fffabcd<EOF>.
>
> Practically I don't think it matters in this case as long as we can
> distinguish them in the next call (if the user wants to do).
> What users want to do (I think) is whether the returned value
> (in *hex) is ok to use or not.  By returning -1 on EOF, it might
> be confusing for users..

In the /proc/pid/maps case the code for reading an address like
"00400000-00452000 " the code is:

if (io__get_hex(io, start) != '-')
  return false;
if (io__get_hex(io, end) != ' ')
  return false;

If io__get_hex doesn't return the next character it becomes:

if (io__get_hex(io, start))
  return false;
if (io__get_char(io) != '-')
  return false;
if (io__get_hex(io, end))
  return false;
if (io__get_char(io) != ' ')
  return false;

Which is twice as verbose and requires that io have a rewind operation
to go backward when io__get_hex and io__get_dec have gone 1 character
too far.

> > The updated
> > code distinguishes the cases as 0 meaning character \0, -1 meaning EOF
> > and -2 meaning bad encoding. Your worry is that a hex number that's
> > next to EOF will get a result of -1 showing the EOF came next. and
> > code that does 'if ( .. < 0)' would trigger. While clunky, it'd be
> > possible in those cases to change the code to 'if ( .. < -1)'.
>
> Yes, but it's not conventional IMHO.
>
>
> > So my thoughts are:
> > 1) being able to tell apart the 3 cases could be important - this is
> > all hypothetical;
> > 2) keeping EOF and error as negative numbers has a degree of consistency;
> > 3) using -1 for EOF comes from get_char, it'd be nice to have one
> > value mean EOF.
> > Perhaps the issue is the name of the function? It isn't a standard API
> > to return the next character, but it simplified things for me as I
> > didn't need to add a 'rewind' operation. The function names could be
> > something like io__get_hex_then_char and io__get_dec_then_char, EOF
> > for the 'then_char' part would be more consistent. I'd tried to keep
> > the names short and have a load bearing comment, which isn't ideal but
> > generally I believe the style is that function names are kept short.
> > Let me know what you think.
>
> I'm ok with the function name and understand your concerns.
> And I don't want to insist it strongly but just sharing my thoughts.
>
> Thanks
> Namhyung

Thanks, feedback appreciated! It is useful to discuss and it is
straightforward to change the API but I'm in two minds as to whether
it would be better.

I'd still like to land this and the next patch, as getting rid of
fgets/sscanf saves 50us from event synthesis. Breaking out the io part
of that change wasn't done so much with a view to replacing stdio, but
just something minimal that serves the /proc/pid/maps case.

Thanks,
Ian
