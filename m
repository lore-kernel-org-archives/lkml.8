Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE10AC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77F22464
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIALNDBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgBYLWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:22:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44047 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBYLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:22:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so7012276pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EUm9z7WkAiCk1ivsS8Uff7qEBq+u4XWDIwD3YfqnT88=;
        b=ZIALNDBsJ79rIl/zg545heZl09NGHH3PzyR5iRsqOD8S3Cg53zpEx/H3rE59vH2P/c
         rUjuxXkDXQ6vKrjWldp4Jug6HvW0nXKXCkLH9+JE7SH9tLb+9ltHjVm+FeHwvM6xVx+z
         hqQgeTdHJ8GXAfTck5v+pd4aC/IDWkvRhZoHQubmL9dcKbhB4TSJeP7iYUT6JavMY+Fh
         lx613k/duwL9PieW9Ar8DqUUPABr6LvWxIkSq4F7IYtxVpVuwBvKrQ0CjZiJSkRqArT6
         J5uBQAEX5Q0asJFAvqrwXGpvNJxDcJktuSD7Ym9q29gBUx7/AMY5jXoP4hzMNDBeOZjo
         3WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUm9z7WkAiCk1ivsS8Uff7qEBq+u4XWDIwD3YfqnT88=;
        b=Vx4ObsqgKfZy0o5ljc1jkhQaHYn4ezro7azeYiEqYjuwqva5NocbFNYiKbb24Lo5RD
         lnHuzhzZcnIA/V/RRt4bz+imOKM+5yVhIzL8A2cj3NT2L0hkWdfhxcZBI8TLOFDv/Sul
         c5CBz5C7kf2rF481p/eqDJd1JseQd6ZIzQlc9fMvukZhhlAc9ZIGAiV6BRh4TwOz1ZiD
         Opy7gIJ2jbQeAX6fkJqdXhjA5anoPf3peNe2fADzDferwyRVi/i1Afm3BP+tUWHPns1f
         JOSyMh+sB9tGU4u93TPgumLn1F2oiMNho4bAoMer6FQdoXKHL+C/KCIme0Y7s3TTalyx
         3ueA==
X-Gm-Message-State: APjAAAUW1knhMoKc8WxJprXLwzJqc6whrKCs21b+scO37ZDFqwo3X2mT
        YOJpry+1NQU3ozgDnACAxh0=
X-Google-Smtp-Source: APXvYqxEWDB8BEiZ4a3fNfbf3wzXr3d2SPXsKomACVc3xo+rVC4Hj+BRzuNEqn6W72NuTU+Edj1CIA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr57013823pfc.113.1582629723147;
        Tue, 25 Feb 2020 03:22:03 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id r145sm17039849pfr.5.2020.02.25.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 03:22:02 -0800 (PST)
Date:   Tue, 25 Feb 2020 19:21:53 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200225112153.GA618752@ziqianlu-desktop.localdomain>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
 <20200225073446.GA618392@ziqianlu-desktop.localdomain>
 <CAERHkrtraNqWj+RZnUFBaR8Cxk_cprQnzyKEgZ=6K+1mb1Jifw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrtraNqWj+RZnUFBaR8Cxk_cprQnzyKEgZ=6K+1mb1Jifw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:40:02PM +0800, Aubrey Li wrote:
> On Tue, Feb 25, 2020 at 3:34 PM Aaron Lu <aaron.lwe@gmail.com> wrote:
> >
> > On Tue, Feb 25, 2020 at 01:32:35PM +0800, Aubrey Li wrote:
> > > Aaron - did you test this before? In other words, if you reset repo to your
> > > last commit:
> >
> > I did this test only recently when I started to think if I can use
> > coresched to boost main workload's performance in a colocated
> > environment.
> >
> > >
> > > - 5bd3c80 sched/fair : Wake up forced idle siblings if needed
> > >
> > > Does the problem remain? Just want to check if this is a regression
> > >  introduced by the subsequent patchset.
> >
> > The problem isn't there with commit 5bd3c80 as the head, so yes, it
> > looks like indeed a regression introduced by subsequent patchset.
> >
> > P.S. I will need to take a closer look if each cgA's task is running
> > on a different core later but the cpu usage of cgA is back to 800% with
> > commit 5bd3c80.
> 
> Hmm..., I went through the subsequent patches, and I think this one
> 
> - 4041eeb8f3 sched/fair: don't migrate task if cookie not match
> 
> is probably the major cause, can you please revert this one to see
> if the problem is gone?

Yes, reverting this one fixed the problem.
