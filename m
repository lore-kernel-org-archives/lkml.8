Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B6C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75986206B1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584351162;
	bh=v8XmfeBNcbxbhqd0XIx/4PozRgFvSeRgR01rqGyZfOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1j2z9ayrvxBmrSVQ60NLPXTnyxPsa90nWfphQcEtZOfh05DaPUlSE9agasPOZDi4
	 IAJYF0Tih8NtrTBtyKHtE94u9qcn2FZ72oApIXLN9RO7lhkdXCctA5JEpPr4xOsbhj
	 FAFGbpg6rdYcTx+aMY7T6b3RcGIYm0U1dqChJAus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgCPJcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:32:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:32:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so20247799wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oEYSbzcwvWV4DLx8To++eoIp8BYJ//m6HHg73CdsKHw=;
        b=g55uLz9/Zy16wZpzq2f8Q/G+Gns7WsSIhCd4XkVUs7azIxVFa9iJ0rXT5sZF+hVz7r
         5NkC//AlvMna1LFBnJeyoQSzYbgjUO1IPRFD+n++EUsjHvSy0icdYHaXwwnkN7pWU51T
         E2zTU2wzo/Zmn+PrkThwnv/D0ssNZ1lo73Z/hc6HIpZVX7ztTHbPn8IUw5mqZOLGD3p4
         tjG1t6v9WRraRldANI3PoP5wOj0IcY8kADLmEhD2ERt1t4Re4SsNP0ViJLP851PS7KlI
         s7gnquLbqBdOZUm89TMzkYiQDEmeY+EqsvMe6YWYW3JTGuICNpWhR3aXieH8ewtVLmu8
         pRkg==
X-Gm-Message-State: ANhLgQ1TMNcPCo4jmt40m7k4pXVGUEP7hP1bdWkgZrCpC4TZ7tSKGzYV
        U0auNs+slzOUnpLEuCIDjyLpxI9C
X-Google-Smtp-Source: ADFU+vt6YXM1CptagV/rpbnMHtj8W9qM4URMPJkfMe5NZq7b8cAbpDRqRecJiXokzAJI5m005xwVmQ==
X-Received: by 2002:adf:f688:: with SMTP id v8mr6409318wrp.344.1584351158748;
        Mon, 16 Mar 2020 02:32:38 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id p8sm24718070wrw.19.2020.03.16.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:32:38 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:32:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200316093236.GF11482@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <20200310221019.GE8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
 <20200311082736.GA23944@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
 <20200312083241.GT23944@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003121115480.158939@chino.kir.corp.google.com>
 <20200312201624.GD23944@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312201624.GD23944@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 21:16:27, Michal Hocko wrote:
> On Thu 12-03-20 11:20:33, David Rientjes wrote:
> > On Thu, 12 Mar 2020, Michal Hocko wrote:
> > 
> > > > I think the changelog clearly states that we need to guarantee that a 
> > > > reclaimer will yield the processor back to allow a victim to exit.  This 
> > > > is where we make the guarantee.  If it helps for the specific reason it 
> > > > triggered in my testing, we could add:
> > > > 
> > > > "For example, mem_cgroup_protected() can prohibit reclaim and thus any 
> > > > yielding in page reclaim would not address the issue."
> > > 
> > > I would suggest something like the following:
> > > "
> > > The reclaim path (including the OOM) relies on explicit scheduling
> > > points to hand over execution to tasks which could help with the reclaim
> > > process.
> > 
> > Are there other examples where yielding in the reclaim path would "help 
> > with the reclaim process" other than oom victims?  This sentence seems 
> > vague.
> 
> In the context of UP and !PREEMPT this also includes IO flushers,
> filesystems rely on workers and there are things I am very likely not
> aware of. If you think this is vaague then feel free to reformulate.
> All I really do care about is what the next paragraph is explaining.

Btw. do you plan to send a patch with an updated changelog?

> > > Currently it is mostly shrink_page_list which yields CPU for
> > > each reclaimed page. This might be insuficient though in some
> > > configurations. E.g. when a memcg OOM path is triggered in a hierarchy
> > > which doesn't have any reclaimable memory because of memory reclaim
> > > protection (MEMCG_PROT_MIN) then there is possible to trigger a soft
> > > lockup during an out of memory situation on non preemptible kernels
> > > <PUT YOUR SOFT LOCKUP SPLAT HERE>
> > > 
> > > Fix this by adding a cond_resched up in the reclaim path and make sure
> > > there is a yield point regardless of reclaimability of the target
> > > hierarchy.
> > > "
> > > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
