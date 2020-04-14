Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E0720732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586823406;
	bh=nQD+rRnEAgx/IvsyEV7dDoL3r/40mc64NINc8uHKV+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RUReYtbDNBKDKBHwAcImcvxm0vO4Po/OzNXLxjPn6r8vZ4tucW8Z2pwys3Jaju3h9
	 hSoTMqi1uEx1v41cLLhO/oDGoRQu1w17lKaozQwBvNaEV7xnBp3SpT4VRU+blCb3O0
	 i490rcWp4HJtwwXq9X8l0mxrx9BK2qSTaCZNB67E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbgDNAQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:16:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgDNAQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:16:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so12058796wml.2;
        Mon, 13 Apr 2020 17:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RISXgIajZ87yJmsUWWGV5umu1hRxmh0RZZCB4OCsBDE=;
        b=qYoUB/Cn7Zx4n8Pa/ujQdh77JPS784ab6cWPqqGU5PCKu90fZ3P8OHxSR+EfXjn5NH
         9eQvuPEu3XC7aa7VqBGEI4sxNiJxTTtYXIrVjXzC51uANLqm7g8DY0obmuPqqk+LEjjW
         Rns8D+jgPh8LFNiOOq018xOq5mB9ILXkUR22armXjpixvc9W9ImVosFvwLmEtwwf68vC
         mTDMr+ofBWmkEtVWoWHCx6Cfa8X6srRgQsQfH5i+IqHP9I9NDiCD04AKkPb0XPpOzoRt
         fAYTg6wprU8zANyY01t/iv4zH6wXcNrGMdVzsDe8LxzNbQnVlaufat490CB3OF2fcmKw
         hm1g==
X-Gm-Message-State: AGi0PuYIstcyz8vIgFMTAsGoher28KKcFF+obZx2YbkMZbi7+0zh5woq
        1suviZIW+1AuG0anL3+RJ15807QAUakJOt30Ob4=
X-Google-Smtp-Source: APiQypIM2L3P47hMg0FrdorUsEZwoV9HzU0ob23RQh7wsMWqceAoOYbE2Hg+8YD2S38Lecw6Qn8VIfOVgYtBnB/0Eqw=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr13427580wmb.128.1586823402250;
 Mon, 13 Apr 2020 17:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200411064248.247530-1-irogers@google.com> <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
 <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW_5pPZTA3bXdT9d9Tt_d5aJw=4bf_fr9eqzGPfoVs3aQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Apr 2020 09:16:30 +0900
Message-ID: <CAM9d7cgsR7mU_N3BaOz3i2XWY_GchOYWHvNh8g+=2VHTFGEm9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
To:     Ian Rogers <irogers@google.com>
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

On Tue, Apr 14, 2020 at 1:22 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Apr 13, 2020 at 12:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The synthesize benchmark shows the majority of execution time going to
> > > fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> > > reading library that will be used to replace these calls in a follow-up
> > > CL. Add tests for the library to perf test.
> > >
> > > v4 adds the test file missed in v3.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> > > + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> > > + * returns the character after the hexadecimal value which may be -1 for eof.
> >
> > I'm not sure returning -1 is good when it actually reads something and
> > meets EOF.
> > Although it would have a valid value, users might consider it an error IMHO.
> > Why not returning 0 instead? (I'm ok with -1 for the later use of the API).
>
> Thanks for the feedback! In the code for /proc/pid/maps this is a
> hypothetical, but I think having the API right is important. I didn't
> go with 0 as you mention 0 'could' encode a character, for example,
> 7fffabcd\0 wouldn't be distinguishable from 7fffabcd<EOF>.

Practically I don't think it matters in this case as long as we can
distinguish them in the next call (if the user wants to do).
What users want to do (I think) is whether the returned value
(in *hex) is ok to use or not.  By returning -1 on EOF, it might
be confusing for users..


> The updated
> code distinguishes the cases as 0 meaning character \0, -1 meaning EOF
> and -2 meaning bad encoding. Your worry is that a hex number that's
> next to EOF will get a result of -1 showing the EOF came next. and
> code that does 'if ( .. < 0)' would trigger. While clunky, it'd be
> possible in those cases to change the code to 'if ( .. < -1)'.

Yes, but it's not conventional IMHO.


> So my thoughts are:
> 1) being able to tell apart the 3 cases could be important - this is
> all hypothetical;
> 2) keeping EOF and error as negative numbers has a degree of consistency;
> 3) using -1 for EOF comes from get_char, it'd be nice to have one
> value mean EOF.
> Perhaps the issue is the name of the function? It isn't a standard API
> to return the next character, but it simplified things for me as I
> didn't need to add a 'rewind' operation. The function names could be
> something like io__get_hex_then_char and io__get_dec_then_char, EOF
> for the 'then_char' part would be more consistent. I'd tried to keep
> the names short and have a load bearing comment, which isn't ideal but
> generally I believe the style is that function names are kept short.
> Let me know what you think.

I'm ok with the function name and understand your concerns.
And I don't want to insist it strongly but just sharing my thoughts.

Thanks
Namhyung
