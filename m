Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA1C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427042076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588151084;
	bh=xsDmjInsTE6sx8U9qk9AJe8ui+XAKa+TCBeP+74A2l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sClmEzrKS1Jrhj5zrP0qCIhFFoID9ocx6KONKvoyY3/8JpNWkjacOkjqY7P2AEHxe
	 WdoUUkQlmghTpc0m7ARksM7yqlrFFmMuoMC7cXTnMCYVpz3Qr7JV0RsXruHMRh4TvU
	 twRXQZFDTVrYYUxrzWDQaMU3aJ1FvW/RdhjQd+D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgD2JEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:04:43 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39667 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2JEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:04:43 -0400
Received: by mail-wr1-f45.google.com with SMTP id b11so1540741wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/HTkU1bfmWsDb9upjStS+UAKGn53qtpudufPqrt2js=;
        b=eSBLR5or4rhKMpgq+f9TAVrUCOnTqfATbIIrD+ymwgVCUCBHUIvsgYiqfy6M1uH/5q
         7ikK0nFTP2EHUEoTPnzzz9V11OqHMOf6y3QZc8gM0NWiZiEUAeC4G43N8aSkBI34T1NF
         kL5m2bP9pv7kG5sBwlKVNfsDyDT+q1QjZSTMyJfFQwNk1UOVkxqaOGlMOyGlzMpU9Mci
         qppHyMJIIyc+EX6OV6Iq3V0ETazLmL1tdCmyCHDO73Zd4QDknYxgGm4fqGoiVyHYkAk2
         f+J+dADtSrfGnTjPRjMw0asnLFYZH2y4e6W8X5t/Z64NG5IMJPSIS2Rsnb3QZlt+BIVO
         ZFDQ==
X-Gm-Message-State: AGi0PuaMDqKiJuqZW1TBzeaD8oI7yuISKBU/pyNmU27IluvBhVkuZAof
        2yc40TY4wbzLg/EdsQQ8QlqBSibd
X-Google-Smtp-Source: APiQypKBzVq9hAHjrmt5CnOX7VbjgNZ1ZHHVkGYmLrvZus0ULg3W8HouQceRFf0zkoU/icO53TTtbw==
X-Received: by 2002:adf:f704:: with SMTP id r4mr38773099wrp.5.1588151079925;
        Wed, 29 Apr 2020 02:04:39 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id a9sm6489202wmm.38.2020.04.29.02.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:04:38 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:04:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-ID: <20200429090437.GX28637@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
 <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
 <31f1f84d-c5fe-824b-3c28-1a9ad69fcae5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f1f84d-c5fe-824b-3c28-1a9ad69fcae5@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 09:51:39, Vlastimil Babka wrote:
> On 4/28/20 11:48 PM, David Rientjes wrote:
> > On Tue, 28 Apr 2020, Vlastimil Babka wrote:
> > 
> > Yes, order-0 reclaim capture is interesting since the issue being reported 
> > here is userspace going out to lunch because it loops for an unbounded 
> > amount of time trying to get above a watermark where it's allowed to 
> > allocate and other consumers are depleting that resource.
> > 
> > We actually prefer to oom kill earlier rather than being put in a 
> > perpetual state of aggressive reclaim that affects all allocators and the 
> > unbounded nature of those allocations leads to very poor results for 
> > everybody.
> 
> Sure. My vague impression is that your (and similar cloud companies) kind of
> workloads are designed to maximize machine utilization, and overshooting and
> killing something as a result is no big deal. Then you perhaps have more
> probability of hitting this state, and on the other hand, even an occasional
> premature oom kill is not a big deal?
> 
> My concers are workloads not designed in such a way, where premature oom kill
> due to temporary higher reclaim activity together with burst of incoming network
> packets will result in e.g. killing an important database. There, the tradeoff
> looks different.

Completely agreed! The in kernel OOM killer is to deal with situations
when memory is desperately depleted without any sign of a forward
progress. If there is a reclaimable memory then we are not there yet.
If a workload can benefit from early oom killing based on response time
then we have facilities to achieve that (e.g. PSI).
-- 
Michal Hocko
SUSE Labs
