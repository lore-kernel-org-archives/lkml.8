Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12857C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40DC2100A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KacU4DCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGCOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:23:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B4C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 07:23:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 9so37156986ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAsbhYpysmstHPq0Op9MjqJaZ7YDRLDrp7Rg8i0eT+Q=;
        b=KacU4DChX8owr3WxGngcQJG0ITHWxa2x5YJZMRcO1Oq8g8suqMxqCIKz2KIVn+GX0G
         NlL4sAx7SWLe7wOoKqalqC8WPtCsOVDiIJl2ugaBNTqIy8m+xXXNOoboIPQNY0hU4eh5
         Cv+CRClsFvZBzHLaY4R8w4zl6/ZmyudVjt3Ym/CNTRtKSCKgM5mCowbGng/unHeM1X6G
         rX9V5/vB5ZifMJFjN2LTDNr4RYI0VvFlBsKbHhDWHWGHEv13TdNi3C8BfxPrrTetX9vs
         vMD4jQOdARdwlqk8ECDSA4gMLt9sQnF8RfswofOxXeklF/ny6lafGO5LMCzz1KNSzmw1
         ZJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAsbhYpysmstHPq0Op9MjqJaZ7YDRLDrp7Rg8i0eT+Q=;
        b=Ee94ZbzAQRSsh/bjvat0A1MG7r5lHfeQms+2ZixgxUYjYj7kWo0yw/PD6pwNbq35d0
         ypGLN2ETfUwpIwjyMihYpvBmiuchLRjWxi6pkAyNrkk7/25vB+hFSNOwM2q0XJUl/Bud
         4ArI1RYi3s12T7MoZH3LW9qC3b5P2FCsAB7SxqzHanzsZp01YXJjm+PzYizeGADToLdn
         AKvdLLF1XnJImvNkWwVRO2YnDY8edM4QdAoeYXL7X0B+yq/B0WSVuWZ6QqaZAWOOWdL8
         swkQAxbGsNgjjE+h+2BZde+R9aOzanviuVMHnv3RFJv27D6un8aGRf0b9hDuBbot/Ad1
         Y8+A==
X-Gm-Message-State: AOAM531AlHFENLcXalJARGqllHjTXtgawh0QbZ6BS3bZWdomryRWEfgi
        Mui1GXwkj3g43yabaiTeMFTmkQmo8Dar+vD3LTqOCA==
X-Google-Smtp-Source: ABdhPJypEhgBGtdvE+CIOFMTHTIs6098Z3PwdIVQlW6tkGvx5BOconTGtFOIQ4CnrlAXgXA8D+jLajNgHO9BeuTBN1U=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr20890425ljg.332.1593786205575;
 Fri, 03 Jul 2020 07:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
In-Reply-To: <20200703063548.GM18446@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Jul 2020 07:23:14 -0700
Message-ID: <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> [...]
> > Interface options:
> > ------------------
> >
> > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> >
> > + simple
> > + can be extended to target specific type of memory (anon, file, kmem).
> > - most probably restricted to cgroup v2.
> >
> > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> >
> > + more general and applicable to other FSes (actually we are using
> > something similar for tmpfs).
> > + can be extended in future to just age the LRUs instead of reclaim or
> > some new use cases.
>
> Could you explain why memory.high as an interface to trigger pro-active
> memory reclaim is not sufficient. Also memory.low limit to protect
> latency sensitve workloads?

Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
but note that it can also introduce stalls in the application running
in that memcg. Let's suppose the memory.current of a memcg is 100MiB
and we want to reclaim 20MiB from it, we can set the memory.high to
80MiB but any allocation attempt from the application running in that
memcg can get stalled/throttled. I want the functionality of the
reclaim without potential stalls.

The memory.min is for protection against the global reclaim and is
unrelated to this discussion.
