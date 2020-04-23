Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B617C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34AB420728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhRJWKSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgDWOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbgDWOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:34:28 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8CDC08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:34:27 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p7so1095999ybo.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahhB8gKFQ4XotYdzHyj/XtKemZNSbpxgHCOKoxrtoG0=;
        b=EhRJWKStL870o0ryXjxPzEFkYSk65oCNcB4PGAX0ajXV6OOTQB0q90ibYXtZbHb0DN
         jK3KItlichcs+5Juct3188jyecs4osQekdroWE6JY9PSLXYKSrQ2uVWF+zv3rGsLxQf/
         Kp4VuL7JG1XFgBxovEjbLpzXN+MO9NKkgGEjP6KPRAn+8Z18DQb+hW+b89Pev4vDl4OH
         BUZnhEnPqCRILnnqdai2HZalMI4gC8yRbIFqxrUr8UZ6aD0JoYtSVlV9sze+MZsgMMQl
         fwGbsl78sM2ewgtQ7rrB2FQHAG6m6hSqDhsrino3mjbmPN+Rzrm/EqNNXQjFSjAey7AB
         plrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahhB8gKFQ4XotYdzHyj/XtKemZNSbpxgHCOKoxrtoG0=;
        b=WLnGsgHl7XxRQ8tQWwNQq/u5cZJhGwhos4nRDLBW5mbeXDXjEA/z6j1fyx2V1IZEkG
         6lvKUjfprQWKktfy7BGNubA20RaegWOZPBDprKFNU7LP5CIoVX8R5S5OlxUDRIHnYAfK
         SBUzo8h9F7wMkKqEbyciaw8C70i1TkCpaWUotO/cJ4TrrRGFHAQS71onHTM1NTnIbSFF
         hiPCvpGrMzUROERtiuGZgGY9saAFmWz9yHEIiQJGrQ56+bVi3y7+dXNY6OLgKUVlYLsd
         PdQ3SEYGmQ7aNGirIta+0aoTfoI0G00BNKxbOhcHXlXXEundYCy1/i00aX8yCeUrUfPP
         URaQ==
X-Gm-Message-State: AGi0PuY1yCMiP98bcCCNY5NGLPyLWxd+s/DMW3Ghb1HTRs5SBipHV7zV
        RDCjbdmqFMoaduxtHwTWjZpgCgo+XTqDdweHG0iHxg==
X-Google-Smtp-Source: APiQypI5kp9cVn0OhIpf9QnHMVgZumfe4jIJ0W+uy5Oy5YVmaSRH11QGbPgbyM8YcX5SAHEMsA8eS2nFO0beVBVXwh4=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr7261913ybg.383.1587652466771;
 Thu, 23 Apr 2020 07:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com> <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com> <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
 <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
 <abec8f03-ecb5-9bfe-c8ab-2c6d2aad2a60@linux.intel.com> <20200423101030.GB1136647@krava>
 <20200423101120.GC1136647@krava>
In-Reply-To: <20200423101120.GC1136647@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 07:34:15 -0700
Message-ID: <CAP-5=fU499V1XE2WyhhuBgJ64--5dUeVg-zhXmuSEMsdyU-cBA@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 3:11 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 23, 2020 at 12:10:36PM +0200, Jiri Olsa wrote:
> > On Thu, Apr 23, 2020 at 03:51:18PM +0800, Jin, Yao wrote:
> > > Hi Ian,
> > >
> > > On 4/23/2020 2:09 PM, Ian Rogers wrote:
> > > > On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > > >
> > > > > Hi Jiri,
> > > > >
> > > > > Bisected to this commit which introduced the regression.
> > > > >
> > > > > 26226a97724d ("perf expr: Move expr lexer to flex")
> > > > >
> > > > > Would you like to look at that?
> > > >
> > > > Hi Jin,
> > > >
> > > > that commit breaks parsing of things like ','. See fixes in this patch
> > > > set such as:
> > > > https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
> > > > Fixing the lex issues then exposes other bugs that need to be
> > > > corrected in the json. I've added Fixes to the commit message of:
> > > > https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
> > > > https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
> > > > and would be glad of a review. If we can land:
> > > > https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
> > > > then expr as the source of parse errors can go away :-) The next
> > > > problem is the parse events code, but some of that logic is dependent
> > > > on the machine it is running on. It'd be good to add a test that
> > > > parsed events code can handle the events in metrics too, filtering out
> > > > things like duration_time that are special to metrics.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > >
> > > Only with the fix
> > > "https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/"
> > > (without other json modifications), the issue was still there.
> > >
> > > localhost:~ # perf stat -M DRAM_Read_Latency
> > > event syntax error:
> > > '../event=0x36,,umask=0x21/,cha/event=0x35,cha_0/event=0x0/}:W,duration_time'
> > >                                   \___ parser error
> > >
> > >  Usage: perf stat [<options>] [<command>]
> > >
> > >     -M, --metrics <metric/metric group list>
> > >                           monitor specified metrics or metric groups
> > > (separated by ,)
> >
> > hum, I don't have that metric, is there another example of broken metric?
> >
> > [jolsa@krava perf]$ sudo ./perf stat -M DRAM_Read_Latency
> > Cannot find metric or group `DRAM_Read_Latency'
> >
> > >
> > > So you added other commits which changed the json to let the parse work. But
> > > I don't know if we have to do with this way because it should be a
> > > regression issue.
> > >
> > > In my opinion, we'd better fix the issue in 26226a97724d ("perf expr: Move
> > > expr lexer to flex") and try not to change the json if possible.
> >
> > yea, that change definitely had a potential of breaking things ;-)
> > but it should be easy to fix them
> >
> > I'll go through the v3 of the patchset
>
> ok, there's v2 now ;-)

Fwiw, you can use the test CL without the others and then it should
reproduce the problems. I placed it at the end of the series as
otherwise the test is broken until all the fixes land.

Thanks,
Ian

> jirka
>
