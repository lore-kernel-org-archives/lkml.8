Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E4C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E576206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588059787;
	bh=Bvl6wPotY0ojjHfhGUKRiypq0KGYuwu8K2Z/ePOFazw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LXGu/1XKNIXZCoScFbksFf7pNNTVj70sEMD0C0SIzTYc9Nw4DdDsWgYyg6ku58nY7
	 jJVpR3V1JNrzl4KHA3jebjcF8N53ujJrC+5YpBdj1m9TStgN4gqr7LSjn1v7f5RZ6m
	 Do1r2izYwvx+gVzLQf9E6i+9MQ8fYk2CJyOCsdsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD1HnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:43:06 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54730 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1HnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:43:06 -0400
Received: by mail-wm1-f47.google.com with SMTP id h4so1557336wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4+wiF+sn2LhlnwSYXd62Wli00bERAEfEXjhtyHabBWQ=;
        b=ex1iTblDpoKbmxy8lzOkjpAQg3jBZDCf1WVyM6MetpUsmMzsOPj+lF3pb7wrBlqUEw
         pmfrM0E2FdPgd5qWM7XlLlPTdJu6L8fUBzSnRQnUIYaGIN7fMQX/gmK2GH40MCcr++Mn
         Ws0ksPrqysa1mfxtWL6xIZCDkg+aykrdU35RRgQriP9sYNzhSfAGFvddqO2FPvlCcJ9S
         6LPyqhmgr7Lodb3caXvIhq50WnqkJLQwH22yipycBinSFPVH6CmRkdyBcrT9+lURv6E/
         OK1WCk246XDiDf7bpU97irsZcfROxS/QXwU1t2y3hjN89h4yNtqbjxapwnoV0LM0xrNI
         lAHg==
X-Gm-Message-State: AGi0PuZAg2ojh9sDU735dFJwxJNk+zedCht3iUKR8SAVYCtf3PG7tfGp
        sCUFZqqJo2CnwJi6SwiwKqc=
X-Google-Smtp-Source: APiQypLsML2yykyX0NvZF5rI/vYISgHp62mPExEOmWKxWnhYyT5PuMEFfiAwaVwJTrYa2VvzGUnYeQ==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr2926649wma.43.1588059784050;
        Tue, 28 Apr 2020 00:43:04 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id c190sm2202066wme.10.2020.04.28.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:43:02 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:43:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-ID: <20200428074301.GK28637@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
 <20200427163558.5b08487d63da3cc7a89bf50b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427163558.5b08487d63da3cc7a89bf50b@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-04-20 16:35:58, Andrew Morton wrote:
[...]
> No consumer of GFP_ATOMIC memory should consume an unbounded amount of
> it.
> Subsystems such as networking will consume a certain amount and
> will then start recycling it.  The total amount in-flight will vary
> over the longer term as workloads change.  A dynamically tuning
> threshold system will need to adapt rapidly enough to sudden load
> shifts, which might require unreasonable amounts of headroom.

I do agree. __GFP_HIGH/__GFP_ATOMIC are bound by the size of the
reserves under memory pressure. Then allocatios start failing very
quickly and users have to cope with that, usually by deferring to a
sleepable context. Tuning reserves dynamically for heavy reserves
consumers would be possible but I am worried that this is far from
trivial.

We definitely need to understand what is going on here.  Why doesn't
kswapd + N*direct reclaimers do not provide enough memory to satisfy
both N threads + reserves consumers? How many times those direct
reclaimers have to retry?

We used to have the allocation stall warning as David mentioned in the
patch description and I have seen it triggering without heavy reserves
consumers (aka reported free pages corresponded to the min watermark).
The underlying problem was usually kswapd being stuck on some FS locks,
direct reclaimers stuck in shrinkers or way too overloaded system with
dozens if not hundreds of processes stuck in the page allocator each
racing with the reclaim and betting on luck. The last problem was the
most annoying because it is really hard to tune for.
-- 
Michal Hocko
SUSE Labs
