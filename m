Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01352083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588841063;
	bh=0j9gb3VbMGiF/EvJ3PO9bZT2CmPu1NN0rXMZnNTE33A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JyZLhucGHvJjhLMyaCHu8KguYU4B/0aCsaT12F78XAd+T2w0B2IV4mUZOmTHrAyqV
	 nexwXpeZ69vBbFdxyLhUG44AQmS22e/VXX70XMgnznqRxX0CtJQbbz+Ej5WYSUc9Fc
	 GCn0vesnI36hfm1L1ZNN5mGsyrlGGt54lMFXxUas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEGIoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgEGIoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:44:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6454E2075E;
        Thu,  7 May 2020 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588841061;
        bh=0j9gb3VbMGiF/EvJ3PO9bZT2CmPu1NN0rXMZnNTE33A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vSZsbGpxu35QZVpgBcrinWcbpUSEVQ1JGIUnjHfTHB5n8v7FKZgi3150VhHSyep9e
         965qrIKWYVBgdKBvVYnOaW87dGfQF/pF8oHojbIwIxFcl3iXPmgorNWQYTB2n2X/CO
         dANHfdEsBgaRGQy0dGzM8WjqPHiwD/0VP5dpQgiQ=
Date:   Thu, 7 May 2020 17:44:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     yshuiv7@gmail.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf-probe: Accept the instance number of kretprobe
 event
Message-Id: <20200507174416.185e9aead7072d478d3abd5f@kernel.org>
In-Reply-To: <20200506164131.GB22183@kernel.org>
References: <158877535215.26469.1113127926699134067.stgit@devnote2>
        <20200506161723.GA22183@kernel.org>
        <20200506164131.GB22183@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 13:41:31 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, May 06, 2020 at 01:17:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, May 06, 2020 at 11:29:12PM +0900, Masami Hiramatsu escreveu:
> > > Since the commit 6a13a0d7b4d1 ("ftrace/kprobe: Show the
> > > maxactive number on kprobe_events") introduced to show the
> > > instance number of kretprobe events, the length of the 1st
> > > format of the kprobe event will not 1, but it can be longer.
> > > This caused a parser error in perf-probe.
> > 
> > Thanks for the quick fix!
> > 
> > I'll add this right after the Fixes tag:
> > 
> > Reported-by: yshuiv7@gmail.com
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207587
> 
> Sorry, I didn't notice you added it as a Link: :-)
> 
> > Ok?

Yes, I missed the yshuiv's mail so missed it. please add it :)

Thank you,

> > 
> > yshuiv, can I have your name to add to that Reported-by tag? And if you
> > test it, please, I can add a Tested-by: tag as well, credits where
> > credits are due!
> > 
> > Thanks!
> > 
> > - Arnaldo
> >  
> > > Skip the length check the 1st format of the kprobe event
> > > to accept this instance number.
> > > 
> > > Without this fix:
> > > 
> > >   # perf probe -a vfs_read%return
> > >   Added new event:
> > >     probe:vfs_read__return (on vfs_read%return)
> > > 
> > >   You can now use it in all perf tools, such as:
> > > 
> > >   	perf record -e probe:vfs_read__return -aR sleep 1
> > > 
> > >   # perf probe -l
> > >   Semantic error :Failed to parse event name: r16:probe/vfs_read__return
> > >     Error: Failed to show event list.
> > > 
> > > And with this fixes:
> > > 
> > >   # perf probe -a vfs_read%return
> > >   ...
> > >   # perf probe -l
> > >     probe:vfs_read__return (on vfs_read%return)
> > > 
> > > 
> > > Fixes: 6a13a0d7b4d1 ("ftrace/kprobe: Show the maxactive number on kprobe_events")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=207587
> > > ---
> > >  tools/perf/util/probe-event.c |    3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > index eea132f512b0..c6bcf5709564 100644
> > > --- a/tools/perf/util/probe-event.c
> > > +++ b/tools/perf/util/probe-event.c
> > > @@ -1765,8 +1765,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
> > >  	fmt1_str = strtok_r(argv0_str, ":", &fmt);
> > >  	fmt2_str = strtok_r(NULL, "/", &fmt);
> > >  	fmt3_str = strtok_r(NULL, " \t", &fmt);
> > > -	if (fmt1_str == NULL || strlen(fmt1_str) != 1 || fmt2_str == NULL
> > > -	    || fmt3_str == NULL) {
> > > +	if (fmt1_str == NULL || fmt2_str == NULL || fmt3_str == NULL) {
> > >  		semantic_error("Failed to parse event name: %s\n", argv[0]);
> > >  		ret = -EINVAL;
> > >  		goto out;
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
