Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5741C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9AA21D79
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2uKWpn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgIKLgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIKLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:35:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FAC061795
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:35:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so7127299pfi.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KycsOi7S4N/nBLooPbnXXSV4SR9wjUe6iCxexLVUCD0=;
        b=k2uKWpn7H//jNXvjMwXc7Bg+qjc/gvdqG5U6MePPIbX38khfArh8ol3jLT/BX51pKG
         1v3YBzNb6OY1HA4cCTarS0p2U+55oNdx8wHzNQNTdywjvXUqeX/T4Qq+Oo0nJdqLEXXv
         NLFLJmbh7joqZC21BYFlrWwOj8MNI6mtyde2GPs21/0qXrWNq4j5+y0EZV30oAhGjQR8
         HWyipnRynroPOf5h4JwI4Z1gvd3kOMjgdK7af+zgdR2RTV0cgrTXPRuV3X6PgZDGhgKX
         qqw3ySvUcUtBVOcxCTYsHvaNH0OODb0Y491W60rm+Pt+6mqkz64QwIHWHFJPou1RbwiX
         jULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KycsOi7S4N/nBLooPbnXXSV4SR9wjUe6iCxexLVUCD0=;
        b=JyH/QVOv9rSv0KypFhGOkyAftwCxRvJHz5bQPDDcWMVNXrrbMdPFGxG0G7+Wmhhk0E
         1WTMqJsFtvNcZV3B3O7WxKxCS/Dhn7gkTuTa+11A9LzM71fRrqeIxxMAKamvP+nrrKj1
         VtYYSoyfTDx/fW3H4B2MGf7XViJumEswvCnUgjj81diURkDk74HoHijI0aZzC2q9GHbI
         xCEgSOdpKR3YF7lO9759fFUJA+roVLqHDkcl1awtgZLRzcgwjdbczIfaQuHhzu8LUX0g
         JSWNUQzMnkloMNjSGGOpqMCDYRIU77C0KncpC6U6vylZpznKobxuZclEfkrFjpXhyztP
         7hTQ==
X-Gm-Message-State: AOAM5313nVkZJnmz+lyCv0BKQKXUEiR1iefQvExIw6N1m/ksEv2+J72S
        MHo7X97LQZOyzHYe+wyy6qcz7ybJTeRhwQ==
X-Google-Smtp-Source: ABdhPJyyXvGwFaQdsNQbM6++Ut33lLn/dd07b1UkP/3vxznU7kfEoDReiBe9Y7J9oQkDfJu82o1sSw==
X-Received: by 2002:a17:902:c151:: with SMTP id 17mr1638319plj.49.1599824136816;
        Fri, 11 Sep 2020 04:35:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z4sm2109200pfr.197.2020.09.11.04.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:35:35 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:05:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     peterz@infradead.org
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200911113532.zq2bou4swixb2ymk@vireshk-i7>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
 <20200911101132.GC165568@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911101132.GC165568@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-20, 12:11, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 12:54:41PM +0530, Viresh Kumar wrote:
> > +	atomic_t reset_pending;
> 
> > +	atomic_set(&stats->reset_pending, 0);
> > +	if (atomic_read(&stats->reset_pending))
> > +	bool pending = atomic_read(&stats->reset_pending);
> > +	atomic_set(&stats->reset_pending, 1);
> > +	bool pending = atomic_read(&stats->reset_pending);
> > +	if (atomic_read(&stats->reset_pending))
> 
> What do you think atomic_t is doing for you?

I was trying to avoid races while two writes are going in parallel,
but obviously as this isn't a RMW operation, it won't result in
anything for me.

Maybe what I should be doing is just READ_ONCE()/WRITE_ONCE()? So the
other side doesn't see any intermediate value that was never meant to
be set/read ?

-- 
viresh
