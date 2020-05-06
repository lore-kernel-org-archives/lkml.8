Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3387420708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ76z3+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgEFQlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729443AbgEFQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:41:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A700C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:41:35 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so1055908qvz.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ok/3tSMXGak9r9P1e44ajZ1e4j9R2uzhTZfXRx7Byqs=;
        b=mJ76z3+FCKlKlyom3PyUumWbmA89VbLIHoSaqsP8MoYsDlJrVz+oD5rmZOrMKCHXYa
         IieDnHe3OISmsR3AJDdBZ5bEaa1yv0GuU4IX4zmYe3SQT9KOgIoPuccUbw6PcRU9Fuub
         Ik0sZ8Za38A0ELu8as2SjerJdss9KKFo+52ymtDIhWfCcl5NpcrmuGpSTR3LuiCBbpx1
         S9og7KylBr45Jxrh/BrQqiFOsPIe3Dpdy70zqr55Clth6bdNgyjRZ3WLkDh2yr8GT0gQ
         26uquGoAUQgCs2tjeN0Y2lH01V8PcDrsyG/8RTJuRwvps/hvU9NjZuLL6fQu8dR3I82y
         nDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ok/3tSMXGak9r9P1e44ajZ1e4j9R2uzhTZfXRx7Byqs=;
        b=qMFuIfPJ3HITZJNm7140E9wXJECvD3V2FE4VutdZTv8wpWg8AUUG6DqH5Y3cgRqB9q
         I5GjvwXpcfxgiNCXpKLEJhBabqweJv78C9Z9B8ELVw+MtzVyeBmjsgwWIqLEQy3a72RX
         2mFVhNR6OYU4vBUYvB9F22/i5IO42Uo7N48AT1OHLCHtXiXdbAo0cvIzXXIPQVkiaj6N
         W1D/2Tw8aNx6dXDFdXFDNaXCH7H1r4jOYt+8LCgOVzJpLIvhcvLe/QsOVQiNOyhkp/jI
         amAMKNustLkP2+0Gp55g6wlyGy+gyLIKT7Tj0R6awCRp6otMA8L9yek7DYmVBOZiOBv5
         K8lA==
X-Gm-Message-State: AGi0PubV3y5WGpJtjxcf2aJ/ZJhrOjHhAIYSlozBwIqcemVLmdoJ/MXS
        bqBEHiHqm92P4GYmbXH+El4=
X-Google-Smtp-Source: APiQypJSH9Q65I1hZNzJSC3u3i50Te4XNGFndwEDAgn3AMfSNv2jIKbvi7qV1bENAOKqJ/ZtNMFFiA==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr8923483qvb.6.1588783294264;
        Wed, 06 May 2020 09:41:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i5sm1830087qtw.97.2020.05.06.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:41:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 97513409A3; Wed,  6 May 2020 13:41:31 -0300 (-03)
Date:   Wed, 6 May 2020 13:41:31 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     yshuiv7@gmail.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf-probe: Accept the instance number of kretprobe event
Message-ID: <20200506164131.GB22183@kernel.org>
References: <158877535215.26469.1113127926699134067.stgit@devnote2>
 <20200506161723.GA22183@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506161723.GA22183@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 01:17:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 06, 2020 at 11:29:12PM +0900, Masami Hiramatsu escreveu:
> > Since the commit 6a13a0d7b4d1 ("ftrace/kprobe: Show the
> > maxactive number on kprobe_events") introduced to show the
> > instance number of kretprobe events, the length of the 1st
> > format of the kprobe event will not 1, but it can be longer.
> > This caused a parser error in perf-probe.
> 
> Thanks for the quick fix!
> 
> I'll add this right after the Fixes tag:
> 
> Reported-by: yshuiv7@gmail.com
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207587

Sorry, I didn't notice you added it as a Link: :-)

> Ok?
> 
> yshuiv, can I have your name to add to that Reported-by tag? And if you
> test it, please, I can add a Tested-by: tag as well, credits where
> credits are due!
> 
> Thanks!
> 
> - Arnaldo
>  
> > Skip the length check the 1st format of the kprobe event
> > to accept this instance number.
> > 
> > Without this fix:
> > 
> >   # perf probe -a vfs_read%return
> >   Added new event:
> >     probe:vfs_read__return (on vfs_read%return)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe:vfs_read__return -aR sleep 1
> > 
> >   # perf probe -l
> >   Semantic error :Failed to parse event name: r16:probe/vfs_read__return
> >     Error: Failed to show event list.
> > 
> > And with this fixes:
> > 
> >   # perf probe -a vfs_read%return
> >   ...
> >   # perf probe -l
> >     probe:vfs_read__return (on vfs_read%return)
> > 
> > 
> > Fixes: 6a13a0d7b4d1 ("ftrace/kprobe: Show the maxactive number on kprobe_events")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=207587
> > ---
> >  tools/perf/util/probe-event.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index eea132f512b0..c6bcf5709564 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1765,8 +1765,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
> >  	fmt1_str = strtok_r(argv0_str, ":", &fmt);
> >  	fmt2_str = strtok_r(NULL, "/", &fmt);
> >  	fmt3_str = strtok_r(NULL, " \t", &fmt);
> > -	if (fmt1_str == NULL || strlen(fmt1_str) != 1 || fmt2_str == NULL
> > -	    || fmt3_str == NULL) {
> > +	if (fmt1_str == NULL || fmt2_str == NULL || fmt3_str == NULL) {
> >  		semantic_error("Failed to parse event name: %s\n", argv[0]);
> >  		ret = -EINVAL;
> >  		goto out;
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
