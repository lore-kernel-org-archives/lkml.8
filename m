Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D7720674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmI0xcwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgHRRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:31:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB98C061389;
        Tue, 18 Aug 2020 10:31:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so22339390ljc.10;
        Tue, 18 Aug 2020 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6SkpU4jTKjuyYa1KoeZ1+SjC9XhD7REGKE6+aNvKF4=;
        b=DmI0xcwUQ7Akv+E/NPE0adMGAvPlMHKBnBGKpP/23RJpUfmj++2MADef9mklcNdEuK
         jNF19KPnUM1rUDYvNIf7qaY51RaVQy6HECRc7xLrudr+Kh8VU9iM5bM21SvY3DmJjPxF
         7twf4dWwqpk9fE8uUQZZEfaiLNCnFeuyRIEIo4yHyrYFLRhN7JhKN+rJCuFLgmKTfQaX
         mM54681ksd5ww4mWRx9zVqz5lt0NuQhg+5OwMzT3GF1thIYDkZOhbZiRmNMOeMijTea9
         2BMw17iUm+thAB9OeCF9WfyGeso3r5S7BTFlxL60dsfKkWmIJHipW67nqBqUGZ4+abwl
         DGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6SkpU4jTKjuyYa1KoeZ1+SjC9XhD7REGKE6+aNvKF4=;
        b=dXadAxn5RSD3WUX9fAHovQtmPSqXTxOaWkxT+i/QTRSye1tzHL+GjJCRUC22v6q4Wc
         mWzbL0LyzSEEyNpyqK1c4z07K63ObUbevlDSKyEzZxFIzPY8qH4m+ZtH1BKkCvfPr3lZ
         93edH/J++odON8Z1SrzVbJH2uYWL/Mr5x/l/8bHt216FLgAHrA0r94VEUhzqOL9N47tc
         T6hO2FqEqeTcPEzO6KwBjniZfw9jlxZcXreXL6UuC05sRwi3vJxyNUjrs4CxqYclAz6a
         PuZr46KFlk+Xn1JrCk36kEdBGo5Nqw2wE8m6sJonTNTcyXrvHhZrasMNaCIZWoBd1Got
         vGPg==
X-Gm-Message-State: AOAM531xwkCYfVTYv7mtzAddjoSZznHSAEYmagPpakc4xoCjXYE6E4tO
        brxpob8hhUI1wd1N8gfhpvOpCvCgdSSqMKvWx4M=
X-Google-Smtp-Source: ABdhPJwKFZCeKWwly2bWeYf/XxnCr2IqcfbTcuVmc3eyw7boAnql3cPwv02+GIlUZ5byYgzixuBBlFfvJGktFNlmD6Y=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr7001381ljm.200.1597771908025;
 Tue, 18 Aug 2020 10:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
In-Reply-To: <20200818171457.GA736234@kroah.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 18 Aug 2020 23:01:35 +0530
Message-ID: <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
Subject: Re: Scheduler benchmarks
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > > Hi all,
> > > >
> > > > I=E2=80=99ve two identical Linux systems with only kernel differenc=
es.
> > >
> > > What are the differences in the kernels?
>
> You didn't answer this question, is this the same kernel source being
> compared here?  Same version?  Same compiler?  Everything identical?
Both systems are having exactly the same hardware configuration.
Compiler and kernel versions are different. One system has Ubuntu
16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
version 7.5.0).



>
> > > > While doing kernel profiling with perf, I got the below mentioned
> > > > metrics for Scheduler benchmarks.
> > > >
> > > > 1st system (older kernel version compared to the other system) benc=
hmark result:
> > > >
> > > > $ perf bench sched messaging -g 64
> > > > # Running 'sched/messaging' benchmark:
> > > > # 20 sender and receiver processes per group
> > > > # 64 groups =3D=3D 2560 processes run
> > > >
> > > >      Total time: 2.936 [sec]
> > > >
> > > >
> > > > 2nd system benchmark result:
> > > >
> > > > $ perf bench sched messaging -g 64
> > > > # Running 'sched/messaging' benchmark:
> > > > # 20 sender and receiver processes per group
> > > > # 64 groups =3D=3D 2560 processes run
> > > >
> > > >      Total time: 10.074 [sec]
> > > >
> > > >
> > > > So as per scheduler benchmark results, clearly a huge difference
> > > > between two systems.
> > > > Can anyone suggest to me how to dive deeper to know the root cause =
for
> > > > it.
> > >
> > > Look a the differences between your different kernels, that would be =
a
> > > great start :)
> > I created the difference between two kernel config files and then
> > tried to spot the CONFIG*SCHED* differences.
> > Interestingly I see the difference in I/O scheduler config, 1st system
> > is set to =E2=80=9Cdeadline=E2=80=9D and other one is set to =E2=80=9Cc=
fq=E2=80=9D. So I made it equal
> > by echoing to =E2=80=9C/sys/block/<disk device>/queue/scheduler" but st=
ill no
> > change in scheduler benchmark metrics.
> >
> > Is it the correct way to find the differences between kernels? If so,
> > what other important CONFIG_* variables need to consider?
> >
> >
> > $ cat config.patch | grep -i sched
> >
> >  CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
> >  CONFIG_CGROUP_SCHED=3Dy
> >  CONFIG_FAIR_GROUP_SCHED=3Dy
> >  # CONFIG_RT_GROUP_SCHED is not set
> >  # IO Schedulers
> > @@ -369,10 +434,14 @@ CONFIG_IOSCHED_NOOP=3Dy
> >  CONFIG_IOSCHED_DEADLINE=3Dy
> >  CONFIG_IOSCHED_CFQ=3Dy
> >  CONFIG_CFQ_GROUP_IOSCHED=3Dy
> > -CONFIG_DEFAULT_IOSCHED=3D"deadline"
> > +CONFIG_DEFAULT_IOSCHED=3D"cfq"
> > +CONFIG_MQ_IOSCHED_DEADLINE=3Dm
> > +CONFIG_MQ_IOSCHED_KYBER=3Dm
> > +CONFIG_IOSCHED_BFQ=3Dm
> > +CONFIG_BFQ_GROUP_IOSCHED=3Dy
> >  CONFIG_SCHED_SMT=3Dy
> >  CONFIG_SCHED_MC=3Dy
> > +CONFIG_SCHED_MC_PRIO=3Dy
> > +# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>
> There's lots of other options that affect performance, depending on your
> specific benchmark, other than these.
>
> good luck!
>
> greg k-h



--=20
Thanks,
Sekhar
