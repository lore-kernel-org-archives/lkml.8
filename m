Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A170C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225EB206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc69JCPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGGOGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:06:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB0C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:06:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so16785501plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GToIjBvKfl5jxeagqk9TJFGmtWteTk1ABesI2tZ+EeY=;
        b=Wc69JCPM6KjXYPhGKnPU06EqeodABLO2BbXlqtWiLANdf0VBWa2rhiv/sxQUccTXqR
         HRVr5g2ek23OXQQJor0MyveECULLWUufOA7vp4AvKhVhix+yjbnWALhnWyXAN+8dP/+V
         9II9k0/7/vuf2neMnmpJ7oZQYYOZA6Z2jPsYOXi430Q0stcug3oqCNip+FXhYuDJ0xCc
         qJh4Gt4utX8/2YExd8Fu5mnUi1ZQG9b9p+bAr6nK3BoFpdyEGtRF/dheeOI3D7lrMtda
         SCgX+fukLfzSwBsc3CbSlyNiFOslodwHcNugHDAb+3zd6UuwBHtCjws7mTRN3qZHn0nT
         fgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GToIjBvKfl5jxeagqk9TJFGmtWteTk1ABesI2tZ+EeY=;
        b=Qt131yTKlI1CkSp6uu1PCnl6FVCooJ3xi0J+K1Ly1TVcOPlWn7bJWau/wuBpLKrmcQ
         259F+ou3xhfDN/j78A3JR9O0dUfBAHj8IHozq7E5SWQnPt9XFtIBqtT4pyU6Z3BV0n+4
         ok2+6rWYNmMpJ7fDq0QAihw/vayZYx1kpjkJ7pcEztD5R1JXZTMd0WCsPs99dSiWHfDK
         BVsGA9jhSMW/iaOoj8bwwVema7v4BmILz6WSvCP2VXRx+ZI3ilvCllPsIgBtG8LL52Bt
         9DDS3LzqgE2f79PK5jTRaOUqDBiW46hHKbWoHPSfNsnUXEzjrzlbk91DsPQluJplF4tv
         CgnQ==
X-Gm-Message-State: AOAM530Y2/1EORuvXeh3XsyE7FLc/aet/534E2fBZ2aygyohLy8N1pa5
        dSwBqj9q07tPMiGabN3PMz2YLfsvNqY=
X-Google-Smtp-Source: ABdhPJy5nTy8tpnHx+NeFR4eHd5KtCV2IhvV74al781jiq41WxZGo/OJAmxsNS7aBPzwdQA9gCtvgw==
X-Received: by 2002:a17:90a:db17:: with SMTP id g23mr4782189pjv.180.1594130784598;
        Tue, 07 Jul 2020 07:06:24 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id t29sm22673654pfq.50.2020.07.07.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:06:23 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:06:10 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/15] perf ftrace: show trace column header
Message-ID: <20200707140610.a7wcu2zml4d5zmcw@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-8-changbin.du@gmail.com>
 <CAM9d7cgSniMTtFY4Mn9=M_C15cQSk4=YtaqZvAzj53brqed3hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgSniMTtFY4Mn9=M_C15cQSk4=YtaqZvAzj53brqed3hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:20:15PM +0900, Namhyung Kim wrote:
> On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This makes perf-ftrace display column header before printing trace.
> >
> > $ sudo perf ftrace
> > \# tracer: function
> > \#
> > \# entries-in-buffer/entries-written: 0/0   #P:8
> > \#
> > \#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
> > \#              | |         |       |         |
> >            <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
> >            <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
> >            <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
> >            <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
> >            <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64
> 
> You'd better indent the example output by 2 spaces to prevent
> the # signs commented out.
>
okay. I even didn't know this recipe befoe so I add a '\' :).  Thanks.

> Thanks
> Namhyung
> 
> 
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index e45496012611..686d744d5025 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -430,6 +430,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
> >         fcntl(trace_fd, F_SETFL, O_NONBLOCK);
> >         pollfd.fd = trace_fd;
> >
> > +       /* display column headers */
> > +       read_tracing_file_to_stdout("trace");
> > +
> >         if (!ftrace->initial_delay) {
> >                 if (write_tracing_file("tracing_on", "1") < 0) {
> >                         pr_err("can't enable tracing\n");
> > --
> > 2.25.1
> >

-- 
Cheers,
Changbin Du
