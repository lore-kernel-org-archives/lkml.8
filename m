Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B62173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHTC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:02:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48944 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:02:28 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jX8GP-0005LN-Us
        for linux-kernel@vger.kernel.org; Fri, 08 May 2020 19:02:26 +0000
Received: by mail-ed1-f69.google.com with SMTP id h2so1036987edj.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 12:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3K8W/xyCm3pY7h2xvaxoZVF5ExAZpZK/UzoZ8wN3Uls=;
        b=hvFLbZL3ut7qqSYNXUyw5NB6DfGTmKdEuQS3tch5ADDf/OOgviz/mYbUAL35gDvuOy
         48qlxShnrxPRKuzAqsyDPs9QiF/tKeIUEdAHnA2Z2sBLXRqzQlAL7RTI0JWwDvIqce8i
         HlBawVpHBxZjyQq+w77gEm+x7lp87fDsPXHPKQGn8mmmJPzq8Obekg2zs/f12IVE4H4T
         d5h4QIDxzfzLrXnRvbC/koRIDcGAqj4mO/GmBWU75l4PYf66pG6DPTUSboXinB0Bo29A
         M6P0CYxlqyWEHHBB8kGQimzFCXGrAEFcYDrdh9V1f+XF2C/av2NJoe5iv6Ip8Gle0O2E
         P9pQ==
X-Gm-Message-State: AGi0Puaj6gInuUcHnERmRSKnwJEe8a4/VpBJisVZMW3wytAJyH0wezTN
        sydto9tS7YeI+45C9hQg88WYBNU8VPywTYwVb7AaEJjshJokZE50o7HMQ53Xg6HD/I4fvyPL3VC
        bMvX1x9qB3sTVkF77AIoeZm1JvJ6MnXvNC8NQQuwyW1tOytsTlUjfaYEp0A==
X-Received: by 2002:a05:6402:6d5:: with SMTP id n21mr3573996edy.82.1588964545591;
        Fri, 08 May 2020 12:02:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypL+It7P9ir85DDzToWoA7YkY+2Z8BcQsFBl1nhtQZIU3wFa15GhLaAD9J4WEPKApGNJ2gMQId51G5ozqQpimjE=
X-Received: by 2002:a05:6402:6d5:: with SMTP id n21mr3573982edy.82.1588964545399;
 Fri, 08 May 2020 12:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com> <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Fri, 8 May 2020 16:01:48 -0300
Message-ID: <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     David Rientjes <rientjes@google.com>
Cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:31 PM David Rientjes <rientjes@google.com> wrote:
> It doesn't make sense because it's only being done here for the entire
> system, there are also per-node sysfs triggers so you could do something
> like iterate over the nodemask of all nodes with memory and trigger
> compaction manually and then nothing is emitted to the kernel log.
>
> There is new statsfs support that Red Hat is proposing that can be used
> for things like this.  It currently only supports KVM statistics but
> adding MM statistics is something that would be a natural extension and
> avoids polluting both the kernel log and /proc/vmstat.

Thanks for the review. Is this what you're talking about [0] ? Very interesting!

Also, I agree about the per-node compaction, it's a good point. But at
the same time, having the information on the number of manual
compaction triggered is interesting, at least for some users. What if
we add that as a per-node stat in zoneinfo?

Cheers,

Guilherme


[0] lore.kernel.org/kvm/20200427141816.16703-1-eesposit@redhat.com
