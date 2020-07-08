Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4915C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6F4206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594190729;
	bh=SPRIsKOmLPNjH3oXsx8+5rCbOj9PU4cPW3+Y5hYJXUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DSqVwwRT1GAjvAoAMKdgyTmIFrrkPXXg5SJZwYxUwhOgxKFQsfbDu3qJ1/aypeXf
	 veQy5rWwPrcAJQ23k8cE/bT6+u8iqk8jNaZJyUV5xLR02JiY+V5KHtFnlWrMYqkbS8
	 EgVbib6WOQ7+Ht8X3xFyNcbWEepmgJcr+01drH8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgGHGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:45:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgGHGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:45:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s10so47586453wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTz766jrS9kLMaLLgdH0q1srs9gRA5HbwAQdKRecpe8=;
        b=L0UK9y1Nt8ACuZAUQBFhEyz6qt1rEbaIA8Z12AoFjhVSv+lk6v9zfcwjDQpCKaayaj
         CJeLSXOAuJnAJjC5acOzkU13pEtYj5aMMlGGrrvJ7rc4zLBHGYFq2b20cyRIwH6+lbrk
         DVlsizOF4vCCyXWQ+t0KTpOgCNMjeObZUtqI2Is+0HvjVSCvlQF91Kz9Lh+5ag+mzPVd
         LH1uP9tdiMwpmqZ0ZKVz3XWKKTeKFm50LenOpKqEVLYOYNbEKd0VDOEJavGM/vL4tFeS
         GxJuSQaeDA20zzqv6kDmvfUHB0tbQM5ccSfoabeUr09+U85WoX2um6N1yMDw/r5bwTYx
         eynA==
X-Gm-Message-State: AOAM530uDCNnwLq8KzpdZvwaHYnIs1c8nwkUOSrTUZSeBKk2BFjGRnC6
        UY2p6Mzf9P1vzuNHbRyjWt2Oiram
X-Google-Smtp-Source: ABdhPJy8zVhJlQAscGLs009kKGfNYnLK/DzOEwXA0PD9XYTGtNiXApHOU2S0+TIDsPJIvfKwiKeZNQ==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr53285426wrx.44.1594190726440;
        Tue, 07 Jul 2020 23:45:26 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id 207sm5144885wme.13.2020.07.07.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:45:25 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:45:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
Message-ID: <20200708064524.GA7271@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
 <20200708012044.GC992@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708012044.GC992@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 21:20:44, Qian Cai wrote:
[...]
> migrate_pages() starts failing like this apparently using the new
> callback on NUMA systems,
> 
> [ 6147.019063][T45242] LTP: starting move_pages12
> [ 6147.475680][T64921] BUG: unable to handle page fault for address: ffffffffffffffe0

Hmm, this looks like -EPIPE (-32) which is unexpected to say the least.
Does the test pass without this patch applied? Also there has been v4
posted just yesterday. Does it suffer from the same problem?

-- 
Michal Hocko
SUSE Labs
