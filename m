Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E818C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75701206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="sGkUgr2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgBQT44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:56:56 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33847 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgBQT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:56:56 -0500
Received: by mail-il1-f196.google.com with SMTP id l4so15285222ilj.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anZc7OW31U8MO5ygkvDDyIY0GQBGMdLs3iSe01Jj7l0=;
        b=sGkUgr2hS2qh3wTv0ktQzRELdeLNVOJRw8PZLR83DdUf9jRoBChFnzmLtAXvRX0ad9
         C4Vpbg4AjpwXtzZGSDBzumuHuXBm77L3DHxhhI4bCkVQkbZZHcIkB0lMVmzQJM/WKLFk
         YOMXm8H4OMQC1q+U1UmngJUHT7IGElm9QTtHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anZc7OW31U8MO5ygkvDDyIY0GQBGMdLs3iSe01Jj7l0=;
        b=WFQgnfKXhhzxCADD3Soaq2PL3MZ2gijnC2Ly0o91zz+r8Y+hiugCdnq2Ue7zyQpYGE
         MN/LAWeWFl+z/vrMU4gbxKYJzVdD4/b4saFPwdPlFqVAum7ZDGEjlsiVUoY9KpePqykg
         VO9NkWGO5ZSkNAUC2y3TyU/LAgbbFdxd1Y6Ch7mcKdJF1JaW6D/wvhaBJEackoOwAXFx
         5R1wAqI42ywTcE2VfgUUwAf7oqOgIP1WJOel2LHTpBMPYrV+Ps8zcqFz03AtkwCz6XNY
         CEoj5eI9rP2yDNm1aaOn7kH4sHbLKV+Sjxi85flj1YBFhm+nphcDAho7y26/hlDxVuX2
         YxrA==
X-Gm-Message-State: APjAAAU4D8Y9g8QOGfR8v7dvHUNQbgr9N3q3ZjbhFxgeSjMsyKzRHm0n
        AlRhb5PTQYPa1iJSyQ8ucF1AaXijv/Mh7xCf15hWzQ==
X-Google-Smtp-Source: APXvYqwBzoyntxTeoQ1/iTsKDa+b39U1AxBVdktu7QkWK/jPttX+KkBytSdqwTI1f4OywKIQ1y1o8mbNHj/TDBXsYEw=
X-Received: by 2002:a92:9c52:: with SMTP id h79mr15265830ili.213.1581969415072;
 Mon, 17 Feb 2020 11:56:55 -0800 (PST)
MIME-Version: 1.0
References: <157476581065.5793.4518979877345136813.stgit@buzz>
 <CAC=E7cU8TeNHDRnrHiFxmiHUKviVU9KaDvMq-U16VRgcohg6-w@mail.gmail.com> <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Mon, 17 Feb 2020 13:56:29 -0600
Message-ID: <CAC=E7cUgALi4g19GsDZQemHafQfaSpjY1XUo3Swrv_g1PaWejQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: add burst to cgroup cpu bandwidth controller
To:     Ben Segall <bsegall@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:55 PM <bsegall@google.com> wrote:
> I'm not sure that starting with full burst runtime is best, though it
> definitely seems likely to be one of those things where sometimes it's
> what you want and sometimes it's not.

We (Indeed) definitely want to start with a full burst bank in most
cases, as this would help with slow/throttled start-up times for our
Jitted and interpreter-based language applications.  I agree that it
would be nice to have it be configurable.

Dave.
fyi.  Unfortunately, this e-mail may be temporarily turned off for the
next few weeks, I apologize in advance for any bounced messages to me.
