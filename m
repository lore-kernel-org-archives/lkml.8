Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99637C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684832084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcCJLGco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgANGQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:16:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35362 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANGQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:16:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so6074579pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 22:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZW1Kr5RunKt89ySLs0ifejwyEOZ7KGLEQsv6kiSYYIQ=;
        b=dcCJLGcoIwuw1+CPq418hByPhBdhEF9DsclVmF9sjx97qlV18p2OorXTNMYTPMHMEl
         TuneoVmqp3D0yY3OGzXYiPsA0mdK2XgYML/zopdzbiFDFWVbNs1ahNmlEQO9Ye2WWPba
         seKHLTreOa0djmOezhzNWJkzJ2aU+S5/zu3H3yaNes8mciqwE6fhKMGa74NLuxBDcv27
         3MtKlPKq7T1mQB/CyPteAttzJARm1xTfgO7PJ9OoO5UT3gc1VzaM06ergseY1uQMyEtj
         XfAuBFt8vGT1NI+JhBSebn3bv3azJD+Pe18Qda5ITG33EXTPP7fwDhMXDZ8mIA5QrV23
         mZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZW1Kr5RunKt89ySLs0ifejwyEOZ7KGLEQsv6kiSYYIQ=;
        b=EiKMN+rOhBvnBNIKqTq1sanIGQL23fGqEh6d8j9ZH3PAVb70bIlpNJBfAZrCzntC5E
         3KcQP9ehZIy4qCSsLXjHuLP/jeYLPYk5KNDISJgka1JBQWQWYmYWC7/8DLq4Vu6SD29K
         9lok/As/DK0PMwHEoOoqgkZ2ghs9RegiImeM8cwKoQHxAFGjgTN4fb3RTLw/mNZhU11O
         MowUyFwumN0wkSh1UJsH90qaTaQbe8DQNesu+Afo4frl1xh1ow8LgtPVhfeRhiYkbPCQ
         HDIj1yiv5NGdfVfPuD5Mil0kGaFXkrnr2Cf1Fdq09zXFFo6E7l44G3ZrMLxXPUjMvv41
         HKzw==
X-Gm-Message-State: APjAAAVpgnHNkDqKHSYngkFltGrX/OKL2md3KHrlCQEwGBqtpZWU6FGj
        q8o3W9w6I5iesumVcvQNo9kYKRxE13w=
X-Google-Smtp-Source: APXvYqwOuTQqk7tfP4RUvnQNhJZrAQrnJo8PGpS+kX9+xHK/qdAdMiRxqsGSxp2F2ebF+7JDyqbBNw==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr25811896pgt.145.1578982614792;
        Mon, 13 Jan 2020 22:16:54 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id s131sm17914820pfs.135.2020.01.13.22.16.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Jan 2020 22:16:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:16:51 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        oleg@redhat.com, elena.reshetova@intel.com, jgg@ziepe.ca,
        christian@kellner.me, aarcange@redhat.com, viro@zeniv.linux.org.uk,
        cyphar@cyphar.com, ldv@altlinux.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/fork: put some fork variables into read-mostly
 section
Message-ID: <20200114061651.GA8818@cqw-OptiPlex-7050>
References: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
 <20200113094342.5ghlgttmhuxfqv2v@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113094342.5ghlgttmhuxfqv2v@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:43:43AM +0100, Christian Brauner wrote:
> On Mon, Jan 13, 2020 at 11:23:13AM +0800, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > Since total_forks/nr_threads/max_threads global variables are
> > frequently used for process fork, putting these variables into
> > read_mostly section can avoid unnecessary cache line bouncing.
> > 
> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> >  kernel/fork.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 0808095..163e152 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -120,10 +120,10 @@
> >  /*
> >   * Protected counters by write_lock_irq(&tasklist_lock)
> >   */
> > -unsigned long total_forks;	/* Handle normal Linux uptimes. */
> > -int nr_threads;			/* The idle threads do not count.. */
> > +unsigned long total_forks __read_mostly; /* Handle normal Linux uptimes. */
> > +int nr_threads __read_mostly;  /* The idle threads do not count.. */
> 
> total_forks is incremented at every ~CLONE_THREAD and nr_threads at
> CLONE_THREAD I wouldn't exactly say that this qualifies as mostly
> reading.
>

Hi Christian,
I'm holding different views on this matter.
1) total_forks is incremented when any process does sys_fork() reasonablely,
   it counts for every process fork.
2) nr_threads counts for any parent process (except for idle thread) does
   fork successfully, it never exceeds than max_threads.

For an example of arm64 kdump, the system has been running at 119057s,
we can see total_forks is very large, so total_forks is very qualified
as mostly reading because it is referenced frequntly.

crash> p max_threads
max_threads = $2 = 39150
crash> p nr_threads
nr_threads = $1 = 2676
crash> p total_forks
total_forks = $3 = 2413880

nr_threads and max_threads is also qualified as mostly reading because
they are frequntly referenced in the following code of copy_process():
	if (nr_threads >= max_threads)
		goto bad_fork_cleanup_count;
   
> >  
> > -static int max_threads;		/* tunable limit on nr_threads */
> > +static int max_threads __read_mostly; /* tunable limit on nr_threads */
> 
> That make sense.
> 
> Christian

Thanks for your review!
Qiwu
