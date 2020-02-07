Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D95C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E9920715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="algzC8Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:19:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52760 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:19:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2171708wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktJUwyZ/l3OLpS1ntG9E1LZb1+o+ZtOP66hUkNpo0MM=;
        b=algzC8Vv822RyppIJqJATBhlj67/oo9GybyYOBS3bsXLwXfJAYvf0LOXwt15iC/1fk
         6+H6V0azSu33ABchoJxsJnIEATN3b+dGO6xOPYAEUVz2v80fol+bwtWKwuzigcIAWhaI
         h26zgU/lSzzi9Sae3xNnvZBZADJvcm88TDxzPUQL1OnVeRHH1c9GCcI2hY2+wio6T6kX
         N5lE/b71ZQgnZJEAdTn8vWDyzUUlt2zNlwmh0uEQ0s43d5eO0aBh1YJTufGCXGtkHOZV
         i0XYEHQuUnUDAtejK6JOSwagpJ4Rqtpqjjd0+W9QVElPUxwQgIQt7RRBO5qV+G3VTwO4
         5VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktJUwyZ/l3OLpS1ntG9E1LZb1+o+ZtOP66hUkNpo0MM=;
        b=hO8eQSZ8zUXdWpIc06sbSNcIEUFB+i4sc1oSZTgK22+Aos6f6DDs6j8IA92lpHOHVl
         yWrf2Ri3SFWPAnYRYVh0BxoLpC3hu8aTd/UDzrBIY4wyD0MSE/6My1deE54jufXeP9fi
         4h581irTjoMWYVXkMe2qWB0YD6BowY2NrmOADAtSzF7OX4BVVkro3ZXvl24gyEGV8raZ
         OoyQtONMbGX6+RflumrzmDDKYf80irOgkIom0IsbcXP7P0NdZ5kZ9MXV3147Ghjr/I/t
         yjbLwkXBXvKFyAR3IH9JUpG9faQCX3t048PU2UNZMrVNGY1o+OcxtO4njVQ9DxJbxzp+
         axeQ==
X-Gm-Message-State: APjAAAWHtYtl+VwyvFk00Dzrdv2Mq4uY3ZBH7a9xR70qQWwV3eJgwcHP
        8srxxko6I49rE3pKTUJPlU83/Q==
X-Google-Smtp-Source: APXvYqysLO64E3CCn4oFvQD6o9Cgnwc5o9B/5m/tPQvh96VB3ZrmTbB/hUIsSQ55qh4cJNSr7Q2lSg==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr4020530wmh.174.1581074348850;
        Fri, 07 Feb 2020 03:19:08 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id g128sm2915471wme.47.2020.02.07.03.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 03:19:07 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:19:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v4 4/4] sched/fair: Kill wake_cap()
Message-ID: <20200207111904.GC239598@google.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-5-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Feb 2020 at 19:19:57 (+0000), Valentin Schneider wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> Capacity-awareness in the wake-up path previously involved disabling
> wake_affine in certain scenarios. We have just made select_idle_sibling()
> capacity-aware, so this isn't needed anymore.
> 
> Remove wake_cap() entirely.
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> [Changelog tweaks]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

I wanted to suggest removing the CA code from update_sg_wakeup_stats()
which is now called only on fork/exec, but I suppose we still want it
for util_clamp, so n/m.

Thanks for the series,
Quentin
