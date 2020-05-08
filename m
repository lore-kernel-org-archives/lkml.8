Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DA5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FB82192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkJiY+3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHSbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgEHSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:31:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1155C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:31:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l25so1245107pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pY+mOo2Ik3rWYLJPySMCfrE7K/NG/f57s6xPPFkwDCg=;
        b=PkJiY+3yDvfK1RMaphrVSJxAZpHPlVI96LEh2eF2DJK/y+VeUnFxraKDe7pkx2MuAA
         +cUITO2x/tJ7OBopd14bySnct6EKLJ3S0kFLbGGBTTtIos4FeYvFuzsNhG6LywDUEijZ
         MHedNbeyfE6eQ7j566t3oabeyBFhxHBGzyVUHnpMPdWonR03zIenUbDZj6QKdyKKMRDl
         xMIgEN1Cgv0PeI1K3qh50jsX5jkm5nkvUY9tRFUhN4UCCwxYLlDPhZ22/7pJRqk2K7cT
         c2CmPEWmMskfAjI6jWPYfQyl6ATM3UYK3zt28fKbe9omD0Su07J+GsklQlpC52qEvxjK
         xxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pY+mOo2Ik3rWYLJPySMCfrE7K/NG/f57s6xPPFkwDCg=;
        b=t5ij8q4XMebCFOqA/CfItFjAWYpajSjYyTm7sBzNMXqKA0anfgkemqlC89UM9zKuAA
         iVaXyFN6oe/VYtOafLvSvIOLS7PglLuzoDnQBMoW5Hy+GtFyHwyZIjU/qsT1hwaJ5t41
         D5JAJRl+xGVHuwMUb4uvbiAwFP/dKaUplGTT0FaDcrpm84PRzJq620a2HmwTKnSh0E7D
         l17O2LQ/GdbO1E5v6s+E4sSsDibvzpB7lnHWXQgBIII0AOiLuHteL+1CrDzhxgmMHlCz
         9AdJnTZnsL5BNg8OZylb21H8M2gjOorkaQ2HQcQAsmJP5Z3UntbkV+SBMKCRKZuyyhkX
         cvzw==
X-Gm-Message-State: AGi0PubDxmQ/RmzadxBWMAP9Ihh5ZqXp6wAkYHkIOGIq0HLwjRVbh1Cj
        PgTCI1WJFxakZvn5bgf+bENibg==
X-Google-Smtp-Source: APiQypJ1g8NDV78SKY142EWfkEa8+kvMzzernl5mLgqHih9spEDfMFhunr2OUyji/1PmP4qP5WrvNw==
X-Received: by 2002:a62:7656:: with SMTP id r83mr4109824pfc.71.1588962673869;
        Fri, 08 May 2020 11:31:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j7sm2407521pfi.160.2020.05.08.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:31:13 -0700 (PDT)
Date:   Fri, 8 May 2020 11:31:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
In-Reply-To: <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
References: <20200507215946.22589-1-gpiccoli@canonical.com> <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org> <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020, Guilherme G. Piccoli wrote:

> Well...you can think that the problem we are trying to solve was more
> like...admin forgot if they triggered or not the compaction hehe
> So, counting on the user to keep track of it is what I'd like to
> avoid. And thinking about drop_caches (that have an indication when
> triggered) makes me think this indeed does make sense for compaction
> too.
> Cheers,
> 

It doesn't make sense because it's only being done here for the entire 
system, there are also per-node sysfs triggers so you could do something 
like iterate over the nodemask of all nodes with memory and trigger 
compaction manually and then nothing is emitted to the kernel log.

There is new statsfs support that Red Hat is proposing that can be used 
for things like this.  It currently only supports KVM statistics but 
adding MM statistics is something that would be a natural extension and 
avoids polluting both the kernel log and /proc/vmstat.
