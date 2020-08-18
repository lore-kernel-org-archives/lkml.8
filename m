Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED8E2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TTT0Ymfx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gejVnZTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHRROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:14:49 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55069 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgHRROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:14:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7D0C510EE;
        Tue, 18 Aug 2020 13:14:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Aug 2020 13:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=N
        VSPG5XNKhpGegk/S2rsEcUf1ErS6V+Uzdhp7bPKg7M=; b=TTT0YmfxjtGG1MEEj
        CDW0flEU9rbHzZUjQ3ehzcO0f+MyAK2+VoTJlpSkXhJ8h9zcPZV6VupJ2EpZVmCR
        9sgmiZAmrHIPN13do6bCn4SDkTVfuT+YgwqfprF0d4rfwoG/BF/AuAe6B/bJ0mGe
        JJ2Bq1dIsIkhIAP1aUmjJOnmMjtYP/YHa8QiTkQ2q32PzK4LICrKKue3agep6PSg
        JMIN0rnLUYWlROFa3usN2S9BmtJ2N/vyLxu9YblZ9hO8eoUl+WmhgTMtfp2Kew2H
        lara6kECFpiK4g83u06+4bFsNb8a00s2NL6QL8kmxsI/3eGEIkNWJYSXZfUWURGv
        D6R5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=NVSPG5XNKhpGegk/S2rsEcUf1ErS6V+Uzdhp7bPKg
        7M=; b=gejVnZTC1JTc58kh30UoJF6jlT1Uqz5KPxrSVBBQlcZYs0+ubxPh6hE+I
        mP2zFgfxTOYcsg+4VRpC7xDMJQB+ZtOZr6GWdi1sKcm2zj03PKvHAwsn20W/KM+X
        8n8XpNRdky2KxthemFANm1rixTscJA3o66Eg+jmyMBlbPJhXhflkMOdOpNe5Ft52
        qg4HhVEMQvVVtyiKNbs6qZ2c4Tqe2GL+Y4ccG7F3niso+wAGYQjkeFgLtoXN+tD0
        SjpE4AuWryDxBLQ0zNc1LCChzzlVGj9WBO4RrAeWzQYYgzHYjRrUSQ85At5V/k7h
        9bmJMTlJLGgYo4TlX9HeLkSZNwzEw==
X-ME-Sender: <xms:eAw8XwRcRJqXowD2fnmdBZJFKXVJ9AHbxFMAWtY_g2n0_kmQ8g-smw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuheekheelffefieduteefkeejffdvueehjeejffehle
    dugfetkedvleekudduvdenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:eAw8X9zhbK1Db9kiCbTUU9f3ovT2-_6I-CTlwVYKDri9emoy8QOpIQ>
    <xmx:eAw8X90qeKAcRSNKW69EtdFdTD55-_TIt9sGIWsTEFXd8H1kKbfg_w>
    <xmx:eAw8X0A6TLgjycubKMbzDTAp481vaSor6CzvVEFl3KihsnJ64JX-4A>
    <xmx:eQw8X5LmWu_kG0gwIy05pMmQzcsdcT1LxvEBkc_nLhpzocJJxn7Ewg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A3E83280063;
        Tue, 18 Aug 2020 13:14:32 -0400 (EDT)
Date:   Tue, 18 Aug 2020 19:14:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <20200818171457.GA736234@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > Hi all,
> > >
> > > I’ve two identical Linux systems with only kernel differences.
> >
> > What are the differences in the kernels?

You didn't answer this question, is this the same kernel source being
compared here?  Same version?  Same compiler?  Everything identical?

> > > While doing kernel profiling with perf, I got the below mentioned
> > > metrics for Scheduler benchmarks.
> > >
> > > 1st system (older kernel version compared to the other system) benchmark result:
> > >
> > > $ perf bench sched messaging -g 64
> > > # Running 'sched/messaging' benchmark:
> > > # 20 sender and receiver processes per group
> > > # 64 groups == 2560 processes run
> > >
> > >      Total time: 2.936 [sec]
> > >
> > >
> > > 2nd system benchmark result:
> > >
> > > $ perf bench sched messaging -g 64
> > > # Running 'sched/messaging' benchmark:
> > > # 20 sender and receiver processes per group
> > > # 64 groups == 2560 processes run
> > >
> > >      Total time: 10.074 [sec]
> > >
> > >
> > > So as per scheduler benchmark results, clearly a huge difference
> > > between two systems.
> > > Can anyone suggest to me how to dive deeper to know the root cause for
> > > it.
> >
> > Look a the differences between your different kernels, that would be a
> > great start :)
> I created the difference between two kernel config files and then
> tried to spot the CONFIG*SCHED* differences.
> Interestingly I see the difference in I/O scheduler config, 1st system
> is set to “deadline” and other one is set to “cfq”. So I made it equal
> by echoing to “/sys/block/<disk device>/queue/scheduler" but still no
> change in scheduler benchmark metrics.
> 
> Is it the correct way to find the differences between kernels? If so,
> what other important CONFIG_* variables need to consider?
> 
> 
> $ cat config.patch | grep -i sched
> 
>  CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_FAIR_GROUP_SCHED=y
>  # CONFIG_RT_GROUP_SCHED is not set
>  # IO Schedulers
> @@ -369,10 +434,14 @@ CONFIG_IOSCHED_NOOP=y
>  CONFIG_IOSCHED_DEADLINE=y
>  CONFIG_IOSCHED_CFQ=y
>  CONFIG_CFQ_GROUP_IOSCHED=y
> -CONFIG_DEFAULT_IOSCHED="deadline"
> +CONFIG_DEFAULT_IOSCHED="cfq"
> +CONFIG_MQ_IOSCHED_DEADLINE=m
> +CONFIG_MQ_IOSCHED_KYBER=m
> +CONFIG_IOSCHED_BFQ=m
> +CONFIG_BFQ_GROUP_IOSCHED=y
>  CONFIG_SCHED_SMT=y
>  CONFIG_SCHED_MC=y
> +CONFIG_SCHED_MC_PRIO=y
> +# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

There's lots of other options that affect performance, depending on your
specific benchmark, other than these.

good luck!

greg k-h
