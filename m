Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEC320B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="Jjh7JSIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE1G7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1G7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:59:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FDC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:59:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d7so1610157ote.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0n00Sh0q9ugLL0M7jdyJtvzSqJImGm0OrDZwPdP+eM=;
        b=Jjh7JSIn8/6N2Nkqi4tTtwzcgNFvf+6LPbujb4vVE8Bd7B2FMJDDYNZtaJ8wSz1zCg
         jw2p+AKn+4Y8qErOKh+90t1VkJ3tMCkrZ01T0HMpOzSc8UnmMeiJnAZE+FbNYG7VYA+f
         plpV9cAyYl6K1g6OKzgJpCrk4eYDwVWJ7IkJpyv0r0JJzMk/4E0dDinb9429J4hG1JXW
         l2MfxEZ1LgjODAlygmnta442uyM/sOXN/jNfS96XuvENQl+3GKOrDAfv46Uh93pBk30M
         wL/ThADrLKn52kAjjAopWxaCftMWuhzJtbbVTPC/zWjNHRV5k4aELUdTFpAzhHSrQKCC
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0n00Sh0q9ugLL0M7jdyJtvzSqJImGm0OrDZwPdP+eM=;
        b=WXXF/FWa7T0gIZ4Hj8AGP8tLXdjBAKnT1Y6smFm71U+dc9SLmgT+kPBaHh6Xi72Pt/
         Y3HHWLkbg6MNuDVdZrPiRnQXyEltp8Bi6P8xiN3qDw+igZk6gbBu2qLUOiRPQCjkZJcD
         Oajj9r/XUQqsCnQcaDBe/vr7JIsZ7q/Rg79ylF+Pz+d85KV9v7SWkYPfEuof3PTSajVD
         1EFi+Dgm4QFTD19JAGaVAq+kECxcRhs7HuWTYZ54T97yTIJdEgW+v3ewAiuAqEEzCUTs
         b8hyBUQgn/YD9g/2jYbt47tNlm4sfORN3lF3sdlyomEYsvIxMVt02Ux7Xh34vDAElTgm
         ekrw==
X-Gm-Message-State: AOAM530hTShb+hpgppj7g/KCJOzdCJKkPT9nlqXwEaQ4vkmB5PG7jI2B
        O7KVVcJ84YIXDCAx6rFosv/m1g==
X-Google-Smtp-Source: ABdhPJybnG9kn7Fe9crlVczZYlhpR65Y825LDiyVC4sKtFMjvOcjAgUah0EBsUWFk+Pirh8OrpEMqA==
X-Received: by 2002:a9d:124:: with SMTP id 33mr1206249otu.31.1590649191734;
        Wed, 27 May 2020 23:59:51 -0700 (PDT)
Received: from localhost ([51.19.80.112])
        by smtp.gmail.com with ESMTPSA id p5sm191090oof.7.2020.05.27.23.59.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 23:59:51 -0700 (PDT)
Date:   Thu, 28 May 2020 07:59:49 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf ordered_events: Optimise event object reuse
Message-ID: <20200528065949.GF19431@codeblueprint.co.uk>
References: <20200526135928.946-1-matt@codeblueprint.co.uk>
 <20200527102533.GG350217@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527102533.GG350217@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May, at 12:25:33PM, Jiri Olsa wrote:
> On Tue, May 26, 2020 at 02:59:28PM +0100, Matt Fleming wrote:
> > +/*
> > + * Allocate a new event object from the free event cache.
> > + *
> > + * Find the first address range in the cache and carve out enough bytes
> > + * for an ordered_event objects. The object with the lowest address is
> > + * always returned so that subsequent allocations benefit from
> > + * contiguous memory accesses (spatial locality).
> > + */
> > +static struct ordered_event *free_event_get_tree(struct ordered_events *oe)
> > +{
> > +	struct interval_tree_node *it;
> > +	struct ordered_event *new;
> > +	size_t bytes = sizeof(*new);
> > +
> > +	it = interval_tree_iter_first(&oe->cache.rb, 0, ULONG_MAX);
> > +	if (!it)
> > +		return NULL;
> > +
> > +	/* Has the cache memory been exhausted? */
> > +	assert(cache_region_size(it) >= bytes);
> > +
> > +	new = (void *)it->start;
> > +
> > +	if (cache_region_size(it) == bytes) {
> > +		interval_tree_remove(it, &oe->cache.rb);
> > +		free(it);
> > +	}
> > +
> > +	it->start += bytes;
> 
> this does not look right.. should this go to else path in above condition?

Urgh, yes. You're right -- this should be in the else path.
