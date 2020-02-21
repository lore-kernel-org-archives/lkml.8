Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB94C3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B42071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JNcMF1Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgBUS6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:58:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34373 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgBUS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:58:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so1714824pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X7YUq5od3M/2TN7ugJSsAL6lYQ9XwqefEDuKdD1PqAs=;
        b=JNcMF1TjdTarFup/EM8aDwnWuLH7JKMWtkRBV5PEvy6I11QbX9XV9KabcTJwlFsfw8
         9Mr36EBYX5+iDFB4slTWF2XJcOssDO8Nvrvo6lIxxSqK1tMXigmetsyqBAhgthsN7Vk+
         TmL7rEVZElRAYyeueFB9I+Xo0NBdkFO310ycJcMKTYwGg3OI//YYJqoXBhJ27f0P/OOq
         Zatjps8RSeTWtkagG8iXf73fOkNNiMNoUp2w413Z3sFEmkjizzvq9GbwLUafA0v/5D+0
         Dvs2bD5w356Iti/lU8nFJCMMH6hXuWhBDe3VGT6oDofIuwwoAArYnqgwsXKskSvy8Ndc
         N39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X7YUq5od3M/2TN7ugJSsAL6lYQ9XwqefEDuKdD1PqAs=;
        b=XE1+udd9TE5FIwh6zBLIrMUsnRMWRa+1kSvSi88deuyjOh2td91vI3DeWXvD+IEZOY
         2f6unfSpN1CFsLtgoY0k+LFa9GF5Lpltime96uKhVAcXqYEIng/eDoki0ODhVRoY4aYR
         tXZoW7H3GorID9Omfoa09NS0JuVmqmZP1lbamjoboaZXjez9S2/zadiNxMqhNQEo39/l
         4piAJXO3SgCaKJ8OLeQRK/5UU+SM7Owi28AwbncBNg6TcFEqRBgZnjgMeqFi+1N8P5z5
         0WKvwuCxHwdcvLR7TMJL5zQJZ8GnZjmcrfY7I1VsHd0IqQpbx6dhrnXhqRJwJ0N+De+s
         n5yQ==
X-Gm-Message-State: APjAAAVE4ubxGo9xfYaEGdPl5vrAlVs2mFhOhaUtAhSWGeVmyyNljf1i
        1e8qT0geqqHgUOoPXpu0C5dBSg==
X-Google-Smtp-Source: APXvYqwjk5taAXZOALpF3n1rQRg3DSlji7oMI2Z3TQIxfofQHUo4NLtnoALcVYUGAO3xx8A3M+WcqA==
X-Received: by 2002:a62:820c:: with SMTP id w12mr16904143pfd.92.1582311522637;
        Fri, 21 Feb 2020 10:58:42 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::d660])
        by smtp.gmail.com with ESMTPSA id x65sm3715325pfb.171.2020.02.21.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 10:58:41 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:58:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200221185839.GB70967@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200221171256.GB23476@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221171256.GB23476@blackbody.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:12:56PM +0100, Michal Koutný wrote:
> On Thu, Dec 19, 2019 at 03:07:18PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Unfortunately, this limitation makes it impossible to protect an
> > entire subtree from another without forcing the user to make explicit
> > protection allocations all the way to the leaf cgroups - something
> > that is highly undesirable in real life scenarios.
> I see that the jobs in descedant cgroups don't know (or care) what
> protection is above them and hence the implicit distribution is sensible
> here.
> 
> However, the protection your case requires can already be reached thanks
> to the the hierachical capping and overcommit normalization -- you can
> set memory.low to "max" at all the non-caring descendants.
> IIUC, that is the same as setting zeroes (after your patch) and relying
> on the recursive distribution of unused protection -- or is there a
> mistake in my reasonineg?

That is correct, but it comes with major problems. We did in fact try
exactly this as a workaround in our fleet, but had to revert and
develop the patch we are discussing now instead.

The reason is this: max isn't a "don't care" value. It's just a high
number with actual meaning in the configuration, and that interferes
when you try to compose it with other settings, such as limits.

Here is a configuration we actually use in practice:

                workload.slice (memory.low=20G)
                /                      \
              job (max=12G, low=10G)    job2 (max=12G, low=10G)
             /   \
           task logger

The idea is that we want to mostly protect the workload from other
stuff running in the system (low=20G), but we also want to catch a job
when it goes wild, to ensure reproducibility in testing regardless of
how loaded the host otherwise is (max=12G).

When you set task's and logger's memory.low to "max" or 10G or any
bogus number like this, a limit reclaim in job treats this as origin
protection and tries hard to avoid reclaiming anything in either of
the two cgroups. memory.events::low skyrockets even though no intended
protection was violated, we'll have reclaim latencies (especially when
there are a few dying cgroups accumluated in subtree).

So we had to undo this setting because of workload performance and
problems with monitoring workload health (the bogus low events).

The secondary problem with requiring explicit downward propagation is
that you may want to protect all jobs on the host from system
management software, as a very high-level host configuration. But a
random job that gets scheduled on a host, that lives in a delegated
cgroup and namespace, and creates its own nested tree of cgroups to
manage stuff - that job can't possibly *know* about the top-level host
protection that lies beyond the delegation point and outside its own
namespace, and that it needs to propagate protection against rpm
upgrades into its own leaf groups for each tasklet and component.

Again, in practice we have found this to be totally unmanageable and
routinely first forgot and then had trouble hacking the propagation
into random jobs that create their own groups.

[ And these job subgroups don't even use their *own* memory.low
  prioritization between siblings yet - god knows how you would
  integrate that with the values that you may inherit from higher
  level ancestors. ]

And when you add new hardware configurations, you cannot just make a
top-level change in the host config, you have to update all the job
specs of workloads running in the fleet.

My patch brings memory configuration in line with other cgroup2
controllers. You can make a high-level decision to prioritize one
subtree over another, just like a top-level weight assignment in CPU
or IO, and then you can delegate the subtree to a different entity
that doesn't need to be aware of and reflect that decision all the way
down the tree in its own settings.

And of course can compose it properly with limits.

> So in my view, the recursive distribution doesn't bring anything new,
> however, its new semantics of memory.low doesn't allow turning the
> protection off in a protected subtree (delegating the decision to
> distribute protection within parent bounds is IMO a valid use case).

I've made the case why it's not a supported usecase, and why it is a
meaningless configuration in practice due to the way other controllers
already behave.

I think at this point in the discussion, the only thing I can do is
remind you that the behavior I'm introducing is gated behind a mount
option that nobody is forced to enable if they insist on disagreeing
against all evidence to the contrary.
