Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB2C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA042083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YSNRusfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgEEQ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729593AbgEEQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:57:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3450C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:57:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h26so2536486qtu.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEeh741pti+zQtUqiU+d//divWdQ0COuz+a61BTeqwc=;
        b=YSNRusfE9U5u8q3v9LefCY1rU6K93jnDg4I/Se7sXa6/yvJwAIFJruFuN/+VjtbSYG
         WLGgbW8jcLo909cVZHzUEp9Vl+j+1knpGhiLLF/8yO7xI4PhQHn2jKn/XZ+7gIEL8BH/
         PhBIW0QTlorsqAK3ECYQ7eylm0EjiRTeEix3nV7MDzfl4adlAlpi/WyRmqf5Ia/KQN4O
         w1BXffany2R/o7burzJHOvzi7xx7uGRaTy/SVArfU9go+3KLVzW3kV2yZOZWk8hdENnp
         gMwRI/VptGu32D36XJgI8z1S2S8eSXN0uchSFh2cN9VI3jrNmhOGTKXONkufx5pguBgZ
         O5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEeh741pti+zQtUqiU+d//divWdQ0COuz+a61BTeqwc=;
        b=rDSm7ni2/drLrbptTq87e/OM7psSBILcTxvNOP+vyAb6n50NcGSxh9jicSo2OzH7rA
         2qWhSnmelNiQK/spA7ZoLjt2ZuxpgOB0Fnk7ALPQIveoX7L4CseLhu7Hmj2NHXr8lJQF
         KSbqcCVugMfiVhF6llksBugrvRjcdncTggQO6AwLq19RqAmSycPAxTjaKWY/MDXUKvTd
         3yViF4/2b0VsctmRonQWfQYz3bJXckU8mtxJz+bqpA04ReI57llSe6acAWbwWkIFmGEF
         xY850ZBeElf9IxLTiM292DhYrkdCuox99EAo+NunGkI9sl18PIM9hqr7dQP/JD4NUjC2
         Hj7Q==
X-Gm-Message-State: AGi0PuajhYD7MynjV5rHIxehwsXCM72RjuMcXYTQ1fWUNdgmyNl3Uo6K
        EolZNk9nfQxkYg36k28pp0Tlsg==
X-Google-Smtp-Source: APiQypKo4D/DEYlsK/2z0fDu/HkNmZbZN2I+uP29hg08y0CiHEZZLic4UCq7t4Eov0dhnnf7ClF+Ug==
X-Received: by 2002:ac8:2f15:: with SMTP id j21mr3745654qta.259.1588697869788;
        Tue, 05 May 2020 09:57:49 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z40sm2371728qtj.45.2020.05.05.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:57:48 -0700 (PDT)
Date:   Tue, 5 May 2020 12:57:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505165734.GD58018@cmpxchg.org>
References: <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505071324.GB16322@dhcp22.suse.cz>
 <CALvZod5H-fDbvu73=hkzN0Man_+03ZW0d5zc1N0YObVHSiy0Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5H-fDbvu73=hkzN0Man_+03ZW0d5zc1N0YObVHSiy0Tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:03:17AM -0700, Shakeel Butt wrote:
> On Tue, May 5, 2020 at 12:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> > So instead of potentially removing a useful information can we focus on
> > the remote charging side of the problem and deal with it in a sensible
> > way? That would make memory.high usable for your usecase and I still
> > believe that this is what you should be using in the first place.
> 
> We talked about this at LSFMM'19 and I think the decision was to not
> fix high reclaim for remote memcg until it will be an actual issue. I
> suppose now we can treat it as an actual issue.
> 
> There are a couple of open questions:
> 1) Should the remote chargers be throttled and do the high reclaim?

I would say it depends on the caller. We may need both: a centralized
charger like a kthread that does work on behalf of many cgroups should
not be throttled, or we risk priority inversions - maybe not even held
up for reclaim, although that would need some thinking about
memory.max as well - whether remote charges should be allowed to
overrun memory.max temporarily, and we punt all reclaim from such
contexts to a worker. (Preferrably, in the future, with all the cpu
cycles of that worker accounted to the cgroup. We want that for
kswapd-style background reclaim as well).

We do similar things with IO for example, when offloading IO to a
central kthread. The kthread is allowed to proceed past a cgroup's
allowance in order to make forward progress, and the cgroup will be
forced to pay up retroactively when it comes back for more of the
resource.
