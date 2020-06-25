Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD79C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAA7206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDcqoWJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbgFYJ4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgFYJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:56:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA41BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:56:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x18so5830632lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qYmRiD/jJfBCFAyy8oPZIZhNJKjTgjiWWT+E87xiJZQ=;
        b=vDcqoWJhUA+kzAano0G6qfaOQs8QBlkSchizhKQZnXSGRL17TWjQk7f4Gwmn5TnZqV
         nLyEjECGdfj8SHywEV+8z+KoK3eh/RCN8zgeuE79uFWsgl+xUMkEJ9sNxXoOX6pcj9Ae
         yQfmSeteGkqGVWBJ+E4kEeEw5zP6kvB9b3KqvbaNBzRiIRHnRUdf44mjejX12YMjcAKk
         5TaCuDKkk+I33xvAF7JDPvhpl7hdJQy+iKTz3+xbDdZog5Ii6w8nElYpsOUSJ6lS20PP
         ft6w5dvHsu8c3ds5n5F6Qr//mEcbvy7in8sDdWcFqt35JjJEUOgi1aM0mKvOjDn6abVj
         /kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYmRiD/jJfBCFAyy8oPZIZhNJKjTgjiWWT+E87xiJZQ=;
        b=DWcuFfhbrfJyq3eo1dsAX1DiMaHZ289XWZss0yC5Ytcr33AUSMU1vUSxWrsGniaCxG
         N8mVCJiPtFFzCy/N3NhxQOXSabhfjMHxu5xal+TsRh9rMF9AoB87D61lFo5RO1IcyU5P
         7kBKM+ZL3kGPoWJQ0KTnGFbWz4KS9vnouGfuwXhJTnPUNKtfy09MZjurlmy5fjdP7gKB
         ZsZAK/OPe/tuuTYJJQW+d4RKHSE9fO+PdzDuW3nln9DQQzEHbukTtHa7E+uVNG/0P+Ap
         TARhSlFmEW5474DAupb0yBda6Dxzbs+vDpjuLENkuplrG/+2vxNrywyFs3FA9islKY51
         xyhw==
X-Gm-Message-State: AOAM533hmezy7m8bRDTaqbDXNkveN7PKIiKPjjMiGDBdnbPUTNdlt4JV
        GA/WSXovbt3lIQcBdaYdO+Yoaudt++YVZ36GR55U+w==
X-Google-Smtp-Source: ABdhPJyWT2B1npZbbSL5iuiiFT3wWb9b8k2jTLRCLBCREukTSQulYBm5E/iLTKi/n5F9vAzmQDR3F5QEl7KVhcBGwok=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr17302950ljp.226.1593079004064;
 Thu, 25 Jun 2020 02:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200624154422.29166-1-vincent.guittot@linaro.org> <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
In-Reply-To: <7f2b3135-328b-a510-ce23-49e3f5c20965@applied-asynchrony.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Jun 2020 11:56:32 +0200
Message-ID: <CAKfTPtD4+gUkz7Z2o9yyuK09M0bmP=Y+pZTYswNt=yVC4WVkyQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 at 11:24, Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2020-06-24 17:44, Vincent Guittot wrote:
> > Some performance regression on reaim benchmark have been raised with
> >    commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to =
classify group")
> >
> > The problem comes from the init value of runnable_avg which is initiali=
zed
> > with max value. This can be a problem if the newly forked task is final=
ly
> > a short task because the group of CPUs is wrongly set to overloaded and
> > tasks are pulled less agressively.
> >
> > Set initial value of runnable_avg equals to util_avg to reflect that th=
ere
> > is no waiting time so far.
> >
> > Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to cla=
ssify group")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0424a0af5f87..45e467bf42fc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *=
p)
> >               }
> >       }
> >
> > -     sa->runnable_avg =3D cpu_scale;
> > +     sa->runnable_avg =3D sa->util_avg;
> >
> >       if (p->sched_class !=3D &fair_sched_class) {
> >               /*
> >
>
> Something is wrong here. I woke up my machine from suspend-to-RAM this mo=
rning
> and saw that a completely idle machine had a loadavg of ~7. According to =
my

Just to make sure: Are you speaking about loadavg that is output by
/proc/loadavg or load_avg which is the PELT load ?
The output of /proc/loadavg hasn't any link with runnable_avg. The 1st
one monitors nr_running at 5 sec interval whereas the other one is a
geometrics series of the weight of runnable tasks with a half time of
32ms

> monitoring system this happened to be the loadavg right before I suspende=
d.
> I've reverted this, rebooted, created a loadavg >0, suspended and after w=
ake up
> loadavg again correctly ranges between 0 and whatever, as expected.

I'm not sure to catch why ~7 is bad compared to correctly ranges
between 0 and whatever. Isn't ~7 part of the whatever ?

Vincent

>
> -h
