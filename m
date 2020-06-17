Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46504C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F7520888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Solw5c3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgFQO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:57:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3319FC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:57:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so2701460wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f8R6+zIKfV8EgYXJurZI4VMS7QzuJ/1BzAnXtO1t5b8=;
        b=Solw5c3BRT8SvtzwHB56s5jNRJwxy64m/zVG3rJxC1mkoD9j1LgzC7cgAcfNlU+SG2
         iSk+g2Lfz2qVyIExYUKjw1i3w4yzVcDSUB+PYijm6bgme04zMbR4yDvj7jnb2ZBNrigy
         AfKmp9OWDhpkHtH0XoW+tBVXZbvJTwbMedswwpYtv2o9JVo3x9HmNI9aNTL/QWsK85ZJ
         hL/AoSy+PwWZwtZ+LGIPiTHjCBneX6Q3UnX6eis5WtbFwDQOHrsYS/0wU9WwaRGWJOPq
         xvKdmlPdp1NimHt6I0tzKpRuTlo9ZucdkSqaqV/7bQwg15CdOwDduR23HRK32HaaOeW7
         pOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f8R6+zIKfV8EgYXJurZI4VMS7QzuJ/1BzAnXtO1t5b8=;
        b=gQI9L7mmvAGtsRUd3GatdIYeNelJohGfFOcsZPaIjORRgTnE125Q8slr68cMiIdmto
         MKPd36IgDTqaOUGKCinjtJQzNscONnHDfQq7J+60SRvyNwJlRQCHNlKhBCpXcwA9SiHZ
         OSSg1g99oLXddspBTsCXXU+tlv69Y/pQEeudtRwhjk5/GxC2DD+vAdsmr44XOSGlkvpU
         l0du46NsORf0dKcdjZkcqf2OB6A1pXUKLKBlHd4QOLDVVrzr7UUzZvCqSjxBYD6L5NPN
         Db5GuqpNT31Wcnj4zYr+RiAhXJhk7iPNO1sgTAQTbyIL8MhusdG42JSW+9LWQW8ZMEf2
         KmpA==
X-Gm-Message-State: AOAM5301XN/XzBBRERZ/q2cCOpTcZuloJiotJSxt471t7JP4Sdjw/c2C
        syrGWOhc+Jy3nYCMeLphF8tGbXrRkKA=
X-Google-Smtp-Source: ABdhPJwpIHR1ZinNUmAfaJ8usaV4r/Q/TrhzXAzHjDfaXGo7qORWxdKFIEo35FjV1fiN8/DzhLGqNg==
X-Received: by 2002:adf:a396:: with SMTP id l22mr8788665wrb.24.1592405847764;
        Wed, 17 Jun 2020 07:57:27 -0700 (PDT)
Received: from vingu-book (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id c68sm31143wmd.12.2020.06.17.07.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 07:57:26 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:57:25 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
Message-ID: <20200617145725.GA12524@vingu-book>
References: <20200319023819.GO11705@shao2-debian>
 <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
 <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com>
 <20200616065432.GA18401@vingu-book>
 <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 17 juin 2020 à 08:30:21 (+0800), Xing Zhengjun a écrit :
> 
> 
> On 6/16/2020 2:54 PM, Vincent Guittot wrote:
> > 
> > Hi Xing,
> > 
> > Le mardi 16 juin 2020 à 11:17:16 (+0800), Xing Zhengjun a écrit :
> > > 
> > > 
> > > On 6/15/2020 4:10 PM, Vincent Guittot wrote:
> > > > Hi Xing,
> > > > 
> > > > Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
> > > > > 
> > > > > 
> > > > > On 6/12/2020 7:06 PM, Hillf Danton wrote:
> > > > > > 
> > > > > > On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
> > > > 
> > 
> > ...
> > 
> > > > 
> > > 
> > > I apply the patch based on v5.7, the test result is as the following:
> > 
> > TBH, I didn't expect that the results would still be bad, so i wonder if the threshold are
> > the root problem.
> > 
> > Could you run tests with the patch below that removes condition with runnable_avg ?
> > I just want to make sure that those 2 conditions are the root cause.
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index da3e5b54715b..f5774d0af059 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8210,10 +8210,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >          if (sgs->sum_nr_running < sgs->group_weight)
> >                  return true;
> > 
> > -       if ((sgs->group_capacity * imbalance_pct) <
> > -                       (sgs->group_runnable * 100))
> > -               return false;
> > -
> >          if ((sgs->group_capacity * 100) >
> >                          (sgs->group_util * imbalance_pct))
> >                  return true;
> > @@ -8239,10 +8235,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
> >                          (sgs->group_util * imbalance_pct))
> >                  return true;
> > 
> > -       if ((sgs->group_capacity * imbalance_pct) <
> > -                       (sgs->group_runnable * 100))
> > -               return true;
> > -
> >          return false;
> >   }
> > 
> > 
> > 
> > Thanks.
> > Vincent
> > 
> 
> 
> I apply the patch based on v5.7, the test result is as the following:
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
> 
> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
> 
> commit:
>   9f68395333ad7f5bfe2f83473fed363d4229f11c
>   070f5e860ee2bf588c99ef7b4c202451faa48236
>   v5.7
>   63a5d0fbb5ec62f5148c251c01e709b8358cd0ee (the test patch)
> 
> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> 63a5d0fbb5ec62f5148c251c01e
> ---------------- --------------------------- ---------------------------
> ---------------------------
>          %stddev     %change         %stddev     %change %stddev     %change
> %stddev
>              \          |                \          |                \
> |                \
>       0.69           -10.3%       0.62            -9.1%       0.62
> +1.0%       0.69        reaim.child_systime
>       0.62            -1.0%       0.61            +0.5%       0.62
> -0.1%       0.62        reaim.child_utime
>      66870           -10.0%      60187            -7.6%      61787
> +1.1%      67636        reaim.jobs_per_min
>      16717           -10.0%      15046            -7.6%      15446
> +1.1%      16909        reaim.jobs_per_min_child

OK. So the regression disappears when the conditions on runnable_avg are removed.

In the meantime, I have been able to understand more deeply what was happeningi
for this bench and how it is impacted by
  commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")

This bench forks a new thread for each and every new step. But a newly forked
threads start with a load_avg and a runnable_avg set to max whereas the threads
are running shortly before exiting. This makes the CPU to be set overloaded in
some case whereas it isn't.

Could you try the patch below ?
It fixes the problem on my setup (I have finally been able to reproduce the problem)

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0aeffff62807..b33a4a9e1491 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
-	sa->runnable_avg = cpu_scale;
+	sa->runnable_avg = sa->util_avg;
 
 	if (p->sched_class != &fair_sched_class) {
 		/*
-- 
2.17.1



>      97.84            -1.1%      96.75            -0.4%      97.43
> +0.3%      98.09        reaim.jti
>      72000           -10.8%      64216            -8.3%      66000
> +0.0%      72000        reaim.max_jobs_per_min
>       0.36           +10.6%       0.40            +7.8%       0.39
> -1.1%       0.36        reaim.parent_time
>       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
> -11.9%       1.39 ±  4%  reaim.std_dev_percent
>       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
> -27.3%       0.00 ± 15%  reaim.std_dev_time
>      50800            -2.4%      49600            -1.6%      50000
> +0.0%      50800        reaim.workload
> 
> 
> > > 
> > > =========================================================================================
> > > tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
> > > 
> > > lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
> > > 
> > > commit:
> > >    9f68395333ad7f5bfe2f83473fed363d4229f11c
> > >    070f5e860ee2bf588c99ef7b4c202451faa48236
> > >    v5.7
> > >    3e1643da53f3fc7414cfa3ad2a16ab2a164b7f4d (the test patch)
> > > 
> > > 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> > > 3e1643da53f3fc7414cfa3ad2a1
> > > ---------------- --------------------------- ---------------------------
> > > ---------------------------
> > >           %stddev     %change         %stddev     %change %stddev     %change
> > > %stddev
> > >               \          |                \          |                \
> > > |                \
> > >        0.69           -10.3%       0.62            -9.1%       0.62
> > > -7.1%       0.64        reaim.child_systime
> > >        0.62            -1.0%       0.61            +0.5%       0.62
> > > +1.3%       0.63        reaim.child_utime
> > >       66870           -10.0%      60187            -7.6%      61787
> > > -6.1%      62807        reaim.jobs_per_min
> > >       16717           -10.0%      15046            -7.6%      15446
> > > -6.1%      15701        reaim.jobs_per_min_child
> > >       97.84            -1.1%      96.75            -0.4%      97.43
> > > -0.5%      97.34        reaim.jti
> > >       72000           -10.8%      64216            -8.3%      66000
> > > -5.7%      67885        reaim.max_jobs_per_min
> > >        0.36           +10.6%       0.40            +7.8%       0.39
> > > +6.9%       0.38        reaim.parent_time
> > >        1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
> > > +32.5%       2.09 ±  6%  reaim.std_dev_percent
> > >        0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
> > > +61.7%       0.01 ±  8%  reaim.std_dev_time
> > >       50800            -2.4%      49600            -1.6%      50000
> > > -1.3%      50133        reaim.workload
> > > 
> > > 
> > > > > 
> > > > > =========================================================================================
> > > > > tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
> > > > > 
> > > > > lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
> > > > > 
> > > > > commit:
> > > > >     9f68395333ad7f5bfe2f83473fed363d4229f11c
> > > > >     070f5e860ee2bf588c99ef7b4c202451faa48236
> > > > >     v5.7
> > > > >     6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
> > > > > 
> > > > > 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
> > > > > 6b33257768b8dd3982054885ea3
> > > > > ---------------- --------------------------- ---------------------------
> > > > > ---------------------------
> > > > >            %stddev     %change         %stddev     %change %stddev     %change
> > > > > %stddev
> > > > >                \          |                \          |                \
> > > > > |                \
> > > > >         0.69           -10.3%       0.62            -9.1%       0.62
> > > > > -10.1%       0.62        reaim.child_systime
> > > > >         0.62            -1.0%       0.61            +0.5%       0.62
> > > > > +0.3%       0.62        reaim.child_utime
> > > > >        66870           -10.0%      60187            -7.6%      61787
> > > > > -8.3%      61305        reaim.jobs_per_min
> > > > >        16717           -10.0%      15046            -7.6%      15446
> > > > > -8.3%      15326        reaim.jobs_per_min_child
> > > > >        97.84            -1.1%      96.75            -0.4%      97.43
> > > > > -0.5%      97.37        reaim.jti
> > > > >        72000           -10.8%      64216            -8.3%      66000
> > > > > -8.3%      66000        reaim.max_jobs_per_min
> > > > >         0.36           +10.6%       0.40            +7.8%       0.39
> > > > > +9.4%       0.39        reaim.parent_time
> > > > >         1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
> > > > > +33.2%       2.11        reaim.std_dev_percent
> > > > >         0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
> > > > > +65.3%       0.01 ±  3%  reaim.std_dev_time
> > > > >        50800            -2.4%      49600            -1.6%      50000
> > > > > -1.8%      49866        reaim.workload
> > > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Zhengjun Xing
> > > 
> > > -- 
> > > Zhengjun Xing
> 
> -- 
> Zhengjun Xing
