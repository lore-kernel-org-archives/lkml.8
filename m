Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F09C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EBE212CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ve3ytCGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGBQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgGBQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:37:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C982C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 09:37:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so27701827wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fnuWmlXLjirzYouN6+gZo7kUrpDYboNODzPAe5CcqpQ=;
        b=ve3ytCGDue3yKA4w4IeO9pBH60YZ2lezY/MIWMAeI8GC8DhvGZtRWivTpbJbJ+tXjZ
         APwXScg0Ro0qDkuU5u24m1rYjO3lPuAe4YaLbhPgr1EIbSXhfq7llLvYRx6rRuym2R6o
         grxmhiP8D4WVq1zXmYH8yCV+CYFxzVVxhEWf41cduprGGFqY5+K+BuHpVgTxbPLj8inb
         tIYQIDP/6ovb8uLn3ysDaSemvtMxKK1JAIaz3/Abe5oxhgcVcd9mqzOGi3uNZRm3mhzJ
         md+hEZAcI7iCGRl6yzsX/x37D+qVz9LsystgrRp03g1h8JRK/6jzIAdot5t3WEcNORsZ
         r7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnuWmlXLjirzYouN6+gZo7kUrpDYboNODzPAe5CcqpQ=;
        b=P8hvFHef/+0ozg3FZ65kkK8hWMQj6lMJSYTKNz6QTMfbfkUi/bZadRjyDgBEPCSw3n
         NUKBx9TeSJX1scGW9UpE7/H4yk1P6j7RHe4lwnKRh+7lEcSokh/MlfXtNJtjDyVeTXKw
         7yJUEEUQ5OfpeWsKlVbwvh4y4vF5AvHmIJ6avC+sRwak40Lgculq++h4HaeYsO1J6DmZ
         1otiGazCGBgJb7EbDvg+SSScuVR6koH/GRlE2FCCc1t3wldr4TXD+Yr0CttZc0M8HBvW
         0kHAegi2JeL5ByBaQgruCLW7Fqhx8a6rnor8F63JAACYP98WOcY0Ex80IslOKdi9oHER
         pFPQ==
X-Gm-Message-State: AOAM530OLFtUH6M6rEt1LtaWV2LZBI8yRIwNOyaFOAnECRjSym49abKI
        Hf1gWz0A8xgXBs14OttRwB32RA==
X-Google-Smtp-Source: ABdhPJxIFC+lrryIN81TaC5Mkvjoi8Nger8ERK6Pbz7y69ACzpAiwuCqd7taGuAJSz6C6AapmDEfEw==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr32283269wmj.136.1593707871931;
        Thu, 02 Jul 2020 09:37:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id z8sm8954938wmg.39.2020.07.02.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:37:51 -0700 (PDT)
Date:   Thu, 2 Jul 2020 17:37:48 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain
 flag metadata
Message-ID: <20200702163748.GA1125675@google.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-3-valentin.schneider@arm.com>
 <20200702121536.GA765585@google.com>
 <jhjk0zm7zv8.mognet@arm.com>
 <20200702154514.GA1072702@google.com>
 <jhjfta9994q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjfta9994q.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Jul 2020 at 17:25:41 (+0100), Valentin Schneider wrote:
> It's actually pretty close to what happens with the LLC domain on SMP -
> select_idle_sibling() doesn't look outside of it. The wake_affine() stuff
> might steer the task towards a different LLC, but that's about it for
> wakeups. We rely on load balancing (fork/exec, newidle, nohz and periodic)
> to spread this further - and we would here too.

Sure, but on SMP the search space in select_idle_sibling is always
consistent -- you search within the LLC. With the fix you suggested,
CPUs 0-3 will search within their LLCs, while CPU4 searches the entire
system, which creates an imbalanced mess IMO.

For affine wake-ups, you could migrate from CPU4 -> CPU0-3, but CPU0-3
to CPU4 is not possible, so this asymmetry is almost guaranteed to
actively create imbalance. And sure, the periodic load balancer ought to
fix it, but really wake-up balance and periodic load balance should be
pushing in the same direction and not fighting against each other.

Anyways, enough bikeshedding for today, I'll try and have look at the
rest of the series :)

Cheers,
Quentin
