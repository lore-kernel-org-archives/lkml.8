Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF03C207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590768150;
	bh=j16oqG0d3JC8Kaftc53VIsgS/8TyHAlk7NVIlo7m5XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WnXh83BUQuw+Sw3jlAGZanoL+l243/iQbB4gr9urczwbEv2peRDwzVjBi8UTVJAIh
	 nqCK89lcAxPzSnaUE9/F2xpTrb7O/ZwvmTmYn5yOKvMK1uO3EO78EqxsO5/FN2GpVz
	 KuUwGMiYBhDegMgOcds4HNjls9tCTxM5FfBYEQcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgE2QC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgE2QC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:02:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EE52207BC;
        Fri, 29 May 2020 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590768147;
        bh=j16oqG0d3JC8Kaftc53VIsgS/8TyHAlk7NVIlo7m5XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKCjTooQF/qckSlhqOFpXbm0IWyijzZHVuR7Fkmr3bSgpiFQ49fQcYE88tDuhduIy
         xPDQ/QBHTjJ3DjCWspnYsON3wBFc+kTICMCmoM4U0MB9hA9PH3E8MUU+hNfvU0zwq2
         LNB6wFAd//ZATHnubEUKPleXNuYusrqRbnolwEE4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D7D940AFD; Fri, 29 May 2020 13:02:25 -0300 (-03)
Date:   Fri, 29 May 2020 13:02:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Nick Gasson <nick.gasson@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf jit: Fix inaccurate DWARF line table
Message-ID: <20200529160225.GB537@kernel.org>
References: <20200528051916.6722-1-nick.gasson@arm.com>
 <CAP-5=fWCLq+2xjViJaYxFs9b=3BxSvKmVAdv6xX3re8AoBLHWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWCLq+2xjViJaYxFs9b=3BxSvKmVAdv6xX3re8AoBLHWg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 28, 2020 at 12:44:56AM -0700, Ian Rogers escreveu:
> On Wed, May 27, 2020 at 10:19 PM Nick Gasson <nick.gasson@arm.com> wrote:
> >
> > Fix an issue where addresses in the DWARF line table are offset by
> > -0x40 (GEN_ELF_TEXT_OFFSET). This can be seen with `objdump -S` on the
> > ELF files after perf inject.
> 
> Without too much knowledge this looks good to me. The original code
> came from oprofile's jit support:
> https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/opjitconv/debug_line.c#l325
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied and added your comment,

- Arnaldo
 
> > Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> > ---
> >  tools/perf/util/genelf_debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
> > index 30e9f618f6cd..dd40683bd4c0 100644
> > --- a/tools/perf/util/genelf_debug.c
> > +++ b/tools/perf/util/genelf_debug.c
> > @@ -342,7 +342,7 @@ static void emit_lineno_info(struct buffer_ext *be,
> >          */
> >
> >         /* start state of the state machine we take care of */
> > -       unsigned long last_vma = code_addr;
> > +       unsigned long last_vma = 0;
> >         char const  *cur_filename = NULL;
> >         unsigned long cur_file_idx = 0;
> >         int last_line = 1;
> > @@ -473,7 +473,7 @@ jit_process_debug_info(uint64_t code_addr,
> >                 ent = debug_entry_next(ent);
> >         }
> >         add_compilation_unit(di, buffer_ext_size(dl));
> > -       add_debug_line(dl, debug, nr_debug_entries, 0);
> > +       add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);
> >         add_debug_abbrev(da);
> >         if (0) buffer_ext_dump(da, "abbrev");
> >
> > --
> > 2.26.2
> >

-- 

- Arnaldo
