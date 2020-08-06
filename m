Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B26C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B849206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596736374;
	bh=Fc4HAKafihti5FdGXQTq8xE8L/v0aezeTqjq8flYAis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DA+U7DrbwhbQquY2g1KKGUj93pr0EhyJco/k/CJtJZF5cvD/C4i6+ArtpByIzTso+
	 6JYPf5V2TIfruPpJBdWZ3sAbysZMUXY29XjcnB/odsajDj7wwZs8YY+f9nsur2IXl7
	 x0QdLh8dri53WbCQbs3MEb/rgLw7mV0nUdh+nHSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgHFRww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:52:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42113 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgHFRwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:52:49 -0400
Received: by mail-yb1-f196.google.com with SMTP id a34so21128399ybj.9;
        Thu, 06 Aug 2020 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgg7zjRmtBHf2LasBRhwIDC6917kX0SOQm5jVjzS8IY=;
        b=nCh3eFAgcnGVQJwt76xeSrzviRhoMjBHsIuHNXqkAq8EOA6dy151e3y+EG3BLYtRsh
         QVeqmj+OgHWIwCP9EHVbkmOZsDgAbBuH0dI7NHHm319inLAaqbVq/v+48emOBsxM6sWB
         4Uou/DL6sXdDtY+GNzLwQ0+7EzprdDbQfmVlF0N+uCoYrknPp3yYJZ6yA+knEqTqoBsU
         XVN16pumaeUUCx+7anFWCojmZ0K8GyeljDlxH4WvNJlOFyN76PG3WtFTD8rFogDet6Z8
         yOvGcAKvVIEHQsT1SH3N+Xmmmu/i9Lfmau5NboSDdDGB1SlooRci5+T8xpI66ULIppIl
         BKiA==
X-Gm-Message-State: AOAM53190UqgjPg+EZxVr2A0wv07M7iXN69bNIdS4VZwdt5D43irDMsD
        2tGgc1XaPcR21iWPafAUO1lK94+qINHbf97L/4p8cg==
X-Google-Smtp-Source: ABdhPJxULzaMdb2r5HtAoGgvyO5tjHQhRFpUAVkZo1s1fFBs4k39zAEGh6ZRygcyIDYC1Ra54huZqcZBjxPgAvBb0BE=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr6761257oth.262.1596713126064;
 Thu, 06 Aug 2020 04:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
 <3226770.pJcYkdRNc2@kreacher> <004701d66bb6$22a11410$67e33c30$@net>
In-Reply-To: <004701d66bb6$22a11410$67e33c30$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Aug 2020 13:25:13 +0200
Message-ID: <CAJZ5v0gz89CXmNmFE50oB78JigrDzo=EPYcGQORRtz7WbWv9fQ@mail.gmail.com>
Subject: Re: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:04 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2020.08.05 09:56 Rafael J. Wysocki wrote:
>
> > v6 -> v7:
> >    * Cosmetic changes in store_energy_performance_prefernce() to reduce the
> >      LoC number and make it a bit easier to read.  No intentional functional
> >      impact.
>
> ??
> V7 is identical to V6.
>
> Diff:

Oh.

It looks like I sent the v6 instead of it, then.

I'll send the right one shortly, sorry for the confusion.
