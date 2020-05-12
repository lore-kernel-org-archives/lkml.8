Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31036C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAFA20722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP5ckQta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgELOM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgELOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:12:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD71C061A0C;
        Tue, 12 May 2020 07:12:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so7592455qtp.6;
        Tue, 12 May 2020 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLlHheD6LOkmkommetBCdbZlMJmwyT7+bS4yMcoDtq4=;
        b=hP5ckQtarO3Kj2nj5YGtyndG5YmjzNrFFoURaiK9DOHfFW+5RqSnBCa/ynEUUBC9uk
         2d52d/YNEj/iT3NKyAXlNkF4ZNdbrbf0N7GyAUrA/1L1uqgZyulITpdOM9ELLEt/CUwh
         T0EArrE+qeQB7w5LYO8P4CRnZ0w2AsEim15cBQiz5ZbCOCS9jtjBlgMSRg7zHLmbJ+IF
         ZQpqoxirjxNMZqTbeT8STLeMg32z7XaOkyueKlwYHkxW8nnoNKhLx0WchVzt4qw5EW+F
         +GNw6RhrQ3kEJjqv1Hb7UBG8gkVz8LYEDmmd7QGNckqr7jcxAo/7+GJJRE9mMrNvrdfj
         6iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLlHheD6LOkmkommetBCdbZlMJmwyT7+bS4yMcoDtq4=;
        b=kHe8b3Oa5NAgu2MOeMjrmjmHXnpyi/LZLX4Q000IlyCiAT/DbQXHEo4JAZTOCwJyds
         vs/xHumrDSfe7bqwYDQdNhPFJAS4NIvbH7yI4VutQ7FrMaQHSshNTJvKOcQX64QicmJA
         Dfox6P7bPEzXfVdZKKGh19vacIE1NNglIacWVnPS2MIcylcR+4X9RexgystZPpEjeelT
         ShGAWSNyJXnPDvUxWAFj7+cB+nMbxyfzgOiq98sSSyScqvaZalFuak9F0wbnmegIRV/r
         f+kBR7b70wjLIMJly4uUxVUuf6ODF9D9NSQlLTOHoXUq/RcMlE3oCocLLiPFMKZSABfk
         dt2w==
X-Gm-Message-State: AGi0PuZrjLM6Ym/NJJ3Fc2txdHw0UYqW7wz3yE7z2enabvWaD+BpzZij
        WBzQ0bMBKBBPKhlDONlXb/Y=
X-Google-Smtp-Source: APiQypI3k0xeziYG1jIzfgKOe3gnva/JyjdSsUpGZm6jRWl20uv/OD9lMPWeJjTm5z7gpHxr43CUKw==
X-Received: by 2002:ac8:66c6:: with SMTP id m6mr22446881qtp.25.1589292744880;
        Tue, 12 May 2020 07:12:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y28sm6811400qtc.62.2020.05.12.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:12:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F19C940AFD; Tue, 12 May 2020 11:12:21 -0300 (-03)
Date:   Tue, 12 May 2020 11:12:21 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anand K Mistry <amistry@google.com>,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Use an eventfd to wakeup when done
Message-ID: <20200512141221.GL28888@kernel.org>
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
 <20200512121232.GB3150977@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121232.GB3150977@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 02:12:32PM +0200, Jiri Olsa escreveu:
> On Tue, May 12, 2020 at 02:59:36PM +1000, Anand K Mistry wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe90469..099ecaa66732a2 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -53,6 +53,7 @@
> >  #include <unistd.h>
> >  #include <sched.h>
> >  #include <signal.h>
> > +#include <sys/eventfd.h>
> >  #include <sys/mman.h>
> >  #include <sys/wait.h>
> >  #include <sys/types.h>
> > @@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
> >  
> >  static volatile int signr = -1;
> >  static volatile int child_finished;
> > +static int done_fd = -1;
> >  
> >  static void sig_handler(int sig)
> >  {
> > +	u64 tmp = 1;
> >  	if (sig == SIGCHLD)
> >  		child_finished = 1;
> >  	else
> >  		signr = sig;
> >  
> >  	done = 1;
> > +
> > +	/*
> > +	 * It is possible for this signal handler to run after done is checked
> > +	 * in the main loop, but before the perf counter fds are polled. If this
> > +	 * happens, the poll() will continue to wait even though done is set,
> > +	 * and will only break out if either another signal is received, or the
> > +	 * counters are ready for read. To ensure the poll() doesn't sleep when
> > +	 * done is set, use an eventfd (done_fd) to wake up the poll().
> > +	 */
> > +	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
> > +		pr_err("failed to signal wakeup fd\n");
> >  }
> >  
> >  static void sigsegv_handler(int sig)
> > @@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >  	int fd;
> >  	float ratio = 0;
> >  
> > +	done_fd = eventfd(0, EFD_NONBLOCK);
> > +	if (done_fd < 0) {
> > +		pr_err("Failed to create wakeup eventfd, error: %m\n");
> > +		return -1;
> > +	}
> > +	err = evlist__add_pollfd(rec->evlist, done_fd);
> > +	if (err < 0) {
> > +		pr_err("Failed to add wakeup eventfd to poll list\n");
> > +		return -1;
> > +	}
> 
> sorry I did not notice before, but I think we also
> need to close done_fd descriptor on the exit path
> 
> also please change subject to PATCHv3 for the next version

Yeah, and, and don't take this as a requirement for this patch to be
processed, this can be made as a follow up patch by you or someone else
(me, maybe :)), that maybe tools/perf/builtin-top.c and
tools/perf/builtin-trace.c have the same issue?

Could you please take a look there as well?

- Arnaldo
 
> thanks,
> jirka
> 
> > +
> >  	atexit(record__sig_exit);
> >  	signal(SIGCHLD, sig_handler);
> >  	signal(SIGINT, sig_handler);
> > -- 
> > 2.26.2.645.ge9eca65c58-goog
> > 
> 

-- 

- Arnaldo
