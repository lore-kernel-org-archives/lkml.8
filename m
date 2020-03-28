Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A051C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E94206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0wERdKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1MA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:00:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44521 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1MA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:00:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so14907690wrw.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rqn4yl76OrREiNZnQJmPD+oo2g6msHaIbhbXJHXi1Lw=;
        b=W0wERdKVBixAngiGAQBPBAXwXdU9Mq3SR3umd3rubMrFchYhcFHkvj91+MRg+iNtia
         ylf88hvgi5mKBUN0baXXdM1UKCICIERrbNDfpkJ9omRtzC1oD27s94pO4rvvAxgk4tNd
         Mta8cz8608KkqnnoCWl1m1Ros8LLcnp25OKen4XskzJtHwB4MZQQ+UOnN4ccFW+FUJos
         CCOQ6Xhvg+lUOlgKXFjq+7vOlUwrqlVNEWArgrGcj0qu4/QcX9emIYVJRPvmisL/nY1S
         mi20iMS+IX2MJaZJUFnkxTofkNATjc0gG3rLru32zumJBPMqonzZ10XAXnBFPjNKgB6r
         TYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rqn4yl76OrREiNZnQJmPD+oo2g6msHaIbhbXJHXi1Lw=;
        b=L4mu+YfpNJA9TsiEOrL/rodlrc792InmdoXWmlCmkJVkUEygThpsaTkQ3Pr68NZSTL
         ap67HsakyZIA7W6ITI/PiEdCJ5r2YdSFdf8zreN/zk0WlJ+rGyGujE1ojgB7tm1ew0fj
         YRaVqmDstwsMj/UuUEZHLCeV/UcAadO4E5vrh1MU8QdyL5sFk59EmsMkhQmxAkYy0/kb
         MHuTQ68trXVKW45vtIZjjI9awrsGF8Bg1xyTtsdDYZCBexO4IcaImKvudyIsnbBQZKXa
         SHP55wMSf68i5bvVn39nOY0dGeilSZr8OZlliMbWGX6CVO24qGWO1cc0VPsonIsXj2pV
         VpDA==
X-Gm-Message-State: ANhLgQ2tnjMXA+ezKzbwszVhHWzwNMLWBfmQ6QuTJeRv04/Wn3tbOL/H
        uxdNAU1SH4KMBeoYY6cawA==
X-Google-Smtp-Source: ADFU+vvnEjscbcILXRu9PxtjHwX5KRoCwHy/IaxWCLq6aibTYPngbD4kPGWW08h6d9hx362nvT9UKQ==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr4856100wrq.16.1585396854006;
        Sat, 28 Mar 2020 05:00:54 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id l12sm12434087wrt.73.2020.03.28.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:00:53 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahost.lan>
Date:   Sat, 28 Mar 2020 12:00:32 +0000 (GMT)
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] trace: Replace printk and WARN_ON with WARN
In-Reply-To: <20200327185138.5e98e17b@gandalf.local.home>
Message-ID: <alpine.LNX.2.21.1.2003281159330.20453@ninjahost.lan>
References: <0/10> <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-11-jbi.octave@gmail.com> <20200327185138.5e98e17b@gandalf.local.home>
User-Agent: Alpine 2.21.1 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Mar 2020, Steven Rostedt wrote:

> On Fri, 27 Mar 2020 21:23:57 +0000
> Jules Irenge <jbi.octave@gmail.com> wrote:
> 
> > Coccinelle suggests replacing printk and WARN_ON with WARN
> > 
> > SUGGESTION: printk + WARN_ON can be just WARN.
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  kernel/trace/trace.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 6b11e4e2150c..1fe31272ea73 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1799,9 +1799,7 @@ static int run_tracer_selftest(struct tracer *type)
> >  	/* the test is responsible for resetting too */
> >  	tr->current_trace = saved_tracer;
> >  	if (ret) {
> > -		printk(KERN_CONT "FAILED!\n");
> > -		/* Add the warning after printing 'FAILED' */
> 
> NACK! Did you not read the above comment. The FAILED goes with another
> print and should NOT be part of the WARN_ON.
> 
> -- Steve
> 
> > -		WARN_ON(1);
> > +		WARN(1, "FAILED!\n");
> >  		return -1;
> >  	}
> >  	/* Only reset on passing, to avoid touching corrupted buffers */
> 
> 
Thanks for the feedback, I will be more careful next time.
Kind regards,
Jules
