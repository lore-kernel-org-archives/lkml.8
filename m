Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266B2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="0Jqzg/8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBMOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:41:33 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37077 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:41:33 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so2339182uah.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J779YON9uXVRro7BGK0tXhP/Oo0gi4GUYBiuHQyaVyQ=;
        b=0Jqzg/8jS7q/m+anLQFA3dl6edVyzN8qWuUewX72bM3z20R7TvJQccuuP6dpk8Ll+7
         RLSq3uIaZYp/aZtHiIa2pBmUHjLXDYxV7IzZClCGjGtDkiAXXMDaPM9GfFXAUrj8cGxj
         2rcr2dFDr+SudUCQY4fBdWwwmsmkf/15Lj5TemSVZw/LXxakLqC6zlogUK+LOajAkOX/
         p8XgRKJPcuW5YbuYvBgeUR4toRCNm32JtHeKyRsFhbiFJQspnejUe4LAUTwnGWnmQlXV
         lxV4Mq2nu1HfGwXRqV2tPy6zjyeM4pv0epldQyNBAAA9yRNfWZoUNLaJTGe5mEVZtZQY
         uzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J779YON9uXVRro7BGK0tXhP/Oo0gi4GUYBiuHQyaVyQ=;
        b=U25Y4zYMKFFE3GJMD8rCbyxQoHLAubXe2IcpXM6z6yZ2haMy45uNtqySfPlOxNSp+R
         f7AScer0rUBijZjp80Yp6Bt8cXdRut07b9DsdwUQPhQgQJfvYf5T9NehPphau1Zum+nr
         k6pTzun1M5tUzoLB62JYu8BTtcA5kW8/Xm5aQnJxp+Q1iVtbAsIaSzVghpDrD7R75lm9
         EyvXRMW+T0dySbTUmE3W3Wk1mj5+sJNERrg3jI7G51FxyQs0hE8WXXqEfdQnZEN8honw
         rh669PIYLPzW5gSLHC8fCLoylQWu0+VyLghxBiRafl4RnRm08FxZOqKanrMcDFUmkkvA
         MTmA==
X-Gm-Message-State: APjAAAUjfQhCC73+pruEsEM7Fxc7qy4LiERDvvDrC1eq25GBASo+zJaT
        YLD0QMoJ+ugCUlBRkI+dLWIPFatCDA6lYlJHNY1A4Q==
X-Google-Smtp-Source: APXvYqw5dOYIpbBA3qmi/5zV7Qysb6igwpYM3+ZPSEWLBA6J6rNSDTQIaiLFO93CV98rFt+9iOrv6TisGDAmTFifX4Y=
X-Received: by 2002:ab0:7653:: with SMTP id s19mr7502074uaq.94.1581604890615;
 Thu, 13 Feb 2020 06:41:30 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-2-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerM9xi4BqmGhfzsq-BQ+gEhP3n70T=RvBrpriXiXChLebQ@mail.gmail.com> <5E455919.5090506@linaro.org>
In-Reply-To: <5E455919.5090506@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 13 Feb 2020 20:11:19 +0530
Message-ID: <CAHLCerM_c8GTd2pqxtThaE7npR=SCk3cktt583LfDRVYUN1Aaw@mail.gmail.com>
Subject: Re: [Patch v9 1/8] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 7:41 PM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> On 02/13/2020 07:29 AM, Amit Kucheria wrote:
> > On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> > <thara.gopinath@linaro.org> wrote:
> >>

<snip>

> >> + * Unlike rt/dl utilization tracking that track time spent by a cpu
> >> + * running a rt/dl task through util_avg, the average thermal pressure is
> >> + * tracked through load_avg. This is because thermal pressure signal is
> >> + * weighted "delta" capacity and is not binary(util_avg is binary). "delta
> >
> > May I suggest a slight rewording here and in the commit description,
> >
> >    This is because the thermal pressure signal is weighted "delta"
> > capacity unlike util_avg which is binary.
>
> Sure! Will fix it.
>
> >
> > It would also help, if you expanded on what you mean by binary in the
> > commit description and how the delta capacity is weighted.
>
> I don't understand this. Binary means  0 or 1.

So the value returned by util_avg is literally 0 or 1? In which case
ignore my comment. I'll read the math again later.

> delta capacity is time
> weighted, i will update this.

Thanks.
