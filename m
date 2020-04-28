Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE5C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD62072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmOSABxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD1Vs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1Vs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:48:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B2BC03C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:48:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so15632pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dqAZuKTJWpaP05zkAPKfvVDCpl8ANdrvGruwthh838k=;
        b=pmOSABxHHiNio50lxIic4qwP9WYI6VAnjEJdNj3CIRNSv/qhFErqyzLrDgzP54fVQG
         jY/EwsdJGtcBF51kGChBHDO4NW4DZ8lLrpPx7az5sDeIeRXAG3HFf+ledNrcxwk5uY9f
         9GkOw0p2TSqF0AbuVbzmlxibAliWOYiIm+K4JKCumQVjJvGoD4CWX6/0RI81j8fcnVj3
         1RWDGEA7l36wamt9QA2jvJ5+HnFU30+FK5lyUgyV4KBVhtMXXd50VAAezNu0YV8ovhmE
         xZWMTeP6ckwgR7c4Uv3Og8j239e5DB+EgEbrdseHMd4b4aCEoAxFCeIRmbaJI6JUOOwJ
         whlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dqAZuKTJWpaP05zkAPKfvVDCpl8ANdrvGruwthh838k=;
        b=IyI6zlH3YmXr6B/+SDlRUG7Z7Fmq7s7/mjYj1vEKFn5l60zl8DuK3+DKajLNxQ7ZsF
         WhlV9hFgj3tDh8Bk6k+bP4z1YsIL+SEgog9uJZylBvgylqLdTtyVelx+GfGHx098t2xE
         OUSUhFV1+Vbuxq0El5q4kLO1N0cchnvhualxqx62EDW1sTLyNOF1x+Vs+RdfqQXPpI0D
         GOOFSX6FlcvaSkorOyZpY1IizSN83MH0hI0muA7/NgC8k53xMronRgBRUBchxEBjBOaE
         LDZM69ocw+TcTdr6Vo5RDRbC6/hbOSfx3cbcXQ7S1N+MJlyxWC+HXOZTvI+F1kCNpKHK
         a1VA==
X-Gm-Message-State: AGi0PuYb+GKrCWoM6Dz4VMmDvE7ixxm+UbfR9IiPwTrVgNgcL/nUkNt0
        icEzIxiYgb2tMH/UF+sISPqWIQ==
X-Google-Smtp-Source: APiQypKqrTPBNb6ixbHq6v58KY/gOdS/uMedCRi//Pq39dZ4/iXN5tqNLwo23B3PjW/4uTzXa48ChA==
X-Received: by 2002:a62:cf06:: with SMTP id b6mr33582254pfg.9.1588110507142;
        Tue, 28 Apr 2020 14:48:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a138sm15825113pfd.32.2020.04.28.14.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:48:26 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:48:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
In-Reply-To: <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com> <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org> <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com> <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Vlastimil Babka wrote:

> > I took a look at doing a quick-fix for the
> > direct-reclaimers-get-their-stuff-stolen issue about a million years
> > ago.  I don't recall where it ended up.  It's pretty trivial for the
> > direct reclaimer to free pages into current->reclaimed_pages and to
> > take a look in there on the allocation path, etc.  But it's only
> > practical for order-0 pages.
> 
> FWIW there's already such approach added to compaction by Mel some time ago,
> so order>0 allocations are covered to some extent. But in this case I imagine
> that compaction won't even start because order-0 watermarks are too low.
> 
> The order-0 reclaim capture might work though - as a result the GFP_ATOMIC
> allocations would more likely fail and defer to their fallback context.
> 

Yes, order-0 reclaim capture is interesting since the issue being reported 
here is userspace going out to lunch because it loops for an unbounded 
amount of time trying to get above a watermark where it's allowed to 
allocate and other consumers are depleting that resource.

We actually prefer to oom kill earlier rather than being put in a 
perpetual state of aggressive reclaim that affects all allocators and the 
unbounded nature of those allocations leads to very poor results for 
everybody.

I'm happy to scope this solely to an order-0 reclaim capture.  I'm not 
sure if I'm clear on whether this has been worked on before and patches 
existed in the past?

Somewhat related to what I described in the changelog: we lost the "page 
allocation stalls" artifacts in the kernel log for 4.15.  The commit 
description references an asynchronous mechanism for getting this 
information; I don't know where this mechanism currently lives.
