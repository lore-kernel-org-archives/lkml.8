Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95127C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B569206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvK/Xx4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCMSqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:46:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45251 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgCMSqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:46:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so14273326qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHmI1zJjsn+RyxJ173WIfEHfpucuAGOsedaISLkubgc=;
        b=MvK/Xx4fyI+Ex0jclsWt5OAhghUZPJbHEBzlSGCao3Aol1d5SijXXdGs2l8cnPyXtj
         Mk2Qo2taZMfylbmaRQuqopYU1l3fF2zYUgj4HF29ZvZcn/eYCKp/vTKdd+fRGnsBUE4v
         tmLzTfb7rW94bLkZqgYtaX82koKk59pEiOikdsB+vTZAjoc0OIL8ZqvYwsAqa1FG3T/S
         8RE6gEJ0poqKNwMQvoh2yxOP83ZKCbx6Dz9ou1N21lHHyKieyMkNQkOKlZSqMQyse5QQ
         hZF6zSnzMy7MUJESNjNdRDc22Be7KXQNVl2GSk0WEvSh7rxWfx37m7R6D6aApsUEiKVw
         QaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHmI1zJjsn+RyxJ173WIfEHfpucuAGOsedaISLkubgc=;
        b=SCHEFMiS3PF9IngnvyacoXNdeEnuaKDJnQAcR/ZR0qv6CPDJbtq7gx6tqvWyiw9WnU
         2c/lhkHcV7X22GK6FsGKagCk28ZEJRXWYv8wrt3/tAQjdXaU14DMXXWs37Sf+NVWvPGG
         Bq+k9xZXmskTg8qOt2wvH5EkqLaxrYRfZO33sIxfrOmwcupZoin6Zmroq9O+mv4EflGE
         kvS0PeTeboxDyEMJZMeXJTSV9Ms5pOzNYdk9jF1LFdE/Xe20q1ccv+jPhEYzMe0hbtMs
         7svyUnrrjJIqp3oRJDjbHdr9accYbHUfrmT9HuxUHjHgGi3ywyU7zSwdDg25XKSH9VGj
         3K9g==
X-Gm-Message-State: ANhLgQ1Krk03khMxTh3+Q/hrRkurngpKY74p6+34UGocAWqzQlf/Icv0
        b2CkP+IHWjYRuEBYZfsvGJc=
X-Google-Smtp-Source: ADFU+vtG+cBbcTIGgfwjcQfigQsjm4POqVr+YE2WauSYbJQ0LiipsaA1a4E9jizhgeWeZheB8q+B/w==
X-Received: by 2002:a37:4fd2:: with SMTP id d201mr14801414qkb.190.1584125173201;
        Fri, 13 Mar 2020 11:46:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id b10sm9070941qto.60.2020.03.13.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:46:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7B4C40009; Fri, 13 Mar 2020 15:46:05 -0300 (-03)
Date:   Fri, 13 Mar 2020 15:46:05 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: give synthetic mmap events an inode
 generation
Message-ID: <20200313184605.GB9917@kernel.org>
References: <20200313053129.131264-1-irogers@google.com>
 <20200313093639.GA389625@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313093639.GA389625@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 10:36:39AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 12, 2020 at 10:31:29PM -0700, Ian Rogers wrote:
> 
> SNIP
> 
> > 
> > SUMMARY: MemorySanitizer: use-of-uninitialized-value tools/perf/util/dsos.c:23:6 in __dso_id__cmp
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/synthetic-events.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index dd3e6f43fb86..5fddb64ec8c7 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -345,6 +345,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> >  			continue;
> >  
> >  		event->mmap2.ino = (u64)ino;
> > +                event->mmap2.ino_generation = 0;
> 
> please use tabs for indent, other than that

I fixed that.
 
> Acked-by: iri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka
> 
> >  
> >  		/*
> >  		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
> > -- 
> > 2.25.1.481.gfbce0eb801-goog
> > 
> 

-- 

- Arnaldo
