Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E9C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52050206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPM3H68r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3KPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:15:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34450 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3KO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:14:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so1414238pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 02:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3YyPLg09Gie8I9immsDwus8bgq4e1f49zZn8bTQ76E=;
        b=CPM3H68rFC7wby/Uyc1WbUYqMfObo7808jXDwUGqEOWfDNkV26QcnGYbtC8yimVHbM
         bHY4PaZGYDcoTmZkioEdFruVwOdGGSKwM4A81Vlx3OqMmOu8IKE1fPZAD50wbz9e0VXn
         u43Z6b9vlsJxnqG3SAZUpVm2PB0NuKdzorxecc7xVXbklK7SHJ4IvzIskIB3kttcdLWa
         LoakCpaPAIM94pjhnwpWo4w5HXz5BU8Fty7aoRFuSCc/Zxgu18oEk/8gDHXBkLI4pW4U
         RMp3JbpWhwySqVXF5MD/ebm22HTHphRQMdzC6ybI3p54geDmLuvR4cKWixCX6u1GfReG
         YfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3YyPLg09Gie8I9immsDwus8bgq4e1f49zZn8bTQ76E=;
        b=szi1kstKhuQF9vgocfLEP3QJfHO7mbGG3Jy/VNzkdaBRQ35v9guJPNB8043u+KFFyZ
         VuAJ7hfifeT7tEn9+l0xeovdRLz4YD4WplT2m/ddPOd/xDfRr8GrjtXoEygeKAcxlCWW
         TyuTglzsdhbRcRMXXnEL4Tmu/kVu7Q0iqRTIqMp7slyWi6BDwAJja+t3inEOpNBGKGa9
         5st6hO+AN47ur3d29spYHcLaGIdh3cWk+2uQ2ZjmZ4KGfl07n5znS7utOpPgBuAQiMij
         bPC/x1CB0rzJTWTUAIIjD1wWE+VqDda6uCS6zxGsYmjefynropS/LJeY8pYfXV/K5N+t
         QSfg==
X-Gm-Message-State: APjAAAUn9GJCZ2xx4egusWYSx/KM5iUxO+JvrkP0sa54+aR0jM0x/WTP
        WGKnkg4GItOWDlcTaQmSfqI=
X-Google-Smtp-Source: APXvYqxis/JJsI65268X2naMGjElymHqNg6Gw3dHiPsMlR6PQdIgWlqMJMTGFKBPssP1EuuNHieyUw==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr4080251pfr.13.1580379298187;
        Thu, 30 Jan 2020 02:14:58 -0800 (PST)
Received: from workstation-portable ([103.211.17.117])
        by smtp.gmail.com with ESMTPSA id e16sm5681485pgk.77.2020.01.30.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:14:57 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:44:51 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] events: callchain: Use RCU API to access RCU pointer
Message-ID: <20200130101451.GA11015@workstation-portable>
References: <20200129160813.14263-1-frextrite@gmail.com>
 <20200129160813.14263-2-frextrite@gmail.com>
 <20200129221909.GA74354@google.com>
 <20200130082321.GX14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130082321.GX14879@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:23:21AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 29, 2020 at 05:19:09PM -0500, Joel Fernandes wrote:
> > On Wed, Jan 29, 2020 at 09:38:13PM +0530, Amol Grover wrote:
> > > callchain_cpus_entries is annotated as an RCU pointer.
> > > Hence rcu_dereference_protected or similar RCU API is
> > > required to dereference the pointer.
> > > 
> > > This fixes the following sparse warning
> > > kernel/events/callchain.c:65:17: warning: incorrect type in assignment
> 
> Seems silly to have this two patches; the first introduces the second
> issue, might as well fix it all in one go.
> 

Got it. I'll combine them into a single patch and re-send.

> Also look at the output of:
> 
>   git log --oneline kernel/events/
> 
> and then at your $subject.
> 
> > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > ---
> > >  kernel/events/callchain.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > index f91e1f41d25d..a672d02a1b3a 100644
> > > --- a/kernel/events/callchain.c
> > > +++ b/kernel/events/callchain.c
> > > @@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
> > >  {
> > >  	struct callchain_cpus_entries *entries;
> > >  
> > > -	entries = callchain_cpus_entries;
> > > +	entries = rcu_dereference_protected(callchain_cpus_entries,
> > > +					    lockdep_is_held(&callchain_mutex));
> > 
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Do we really need that smp_read_barrier_depends() here? Then again, I
> don't suppose this is a fast path.
> 

rcu_dereference_protected is actually a lightweight API and IIRC it
omits the READ_ONCE() and hence the memory barriers.

Thanks
Amol

> IIRC even Alpha got the dependent write ordering right.
> 
> > >  	RCU_INIT_POINTER(callchain_cpus_entries, NULL);
> > >  	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
> > >  }
> > > -- 
> > > 2.24.1
> > > 
