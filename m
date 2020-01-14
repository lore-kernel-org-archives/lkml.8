Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68873C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F3214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWfWUtXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgANApl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:45:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40217 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgANApk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:45:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so5700320pfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=P0mMZ+uVbY36jjIU4US3NKX9DBFeOyvgQMQCr5rLz/c=;
        b=WWfWUtXoJx3LBANTRNfQDRZ1Ip0bzLjUlmwufJVLaIZ+JCgVK9U5BYULTGq1Iru4CC
         vPQVPlZYpSQxAd6oerw6i+b7of8zwFuol9DujpiIba4uYf5e3McibU904W6bm/R13X/+
         KU2okbjhAbtrSISfsZh0YDrfC16OiAOUjE1a4Wv8kNaA657TPTz7X+QURxE6jJQs8zw+
         HrCCZCcOp0u0fKRF6VJMVhHMGewKfmuLzxH4M6KCHunh+hqfea/12CpV4F6Y3PNQ9G+a
         pjQSh2URriqsoLS9QCwzrjalA8rMXDpjqYBJKeBA/CSX3zgAXVxJwCreh7OaDeXOg7lo
         jmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=P0mMZ+uVbY36jjIU4US3NKX9DBFeOyvgQMQCr5rLz/c=;
        b=stWJzqkx0ntdEC04AIeM5gtbwM8qMz2xMZLz4QBFeyvN0cxoPJH0FzZ4XM0PNnRH8Y
         agnBFpGsbK6+8jsxOa5RymNPmqwvJ7lhKbAd3IiW4KbDVFUHjCyTMjWwR12iqtZo884d
         KTYhZkOBQMA7T9XnmLRrvSp2JAsjlWAHOP0L8ZakMyWEiMG46LzUEYedTOSreRdo9hjE
         v+JoCjJrG15r7SfR3a2bKvHSiNsPeTNNWs0tEaRI6Pjq5gbcabEOIFt543J4nJxATqde
         170jiUe6ZTrdfK+uVaaKkFcXIzhcnGmN8G9JNNT1eNGK/5irMdnY5YLYrZnSKdayFDBX
         oDFQ==
X-Gm-Message-State: APjAAAWk9c8M7Z2wnlNvq+ho5zZdkNX4qpwaIKhJ1JkLy56gZ7J2Tl8L
        DW65kPrYQ1wF2Hydb89C1TDtzQ==
X-Google-Smtp-Source: APXvYqxVsPBfW1my8VenrcDRI9hRmRpdii0xSQUfZkkfY5D+N47unpBWBkkHVi+TozXjhdDePfCEhA==
X-Received: by 2002:aa7:9aa7:: with SMTP id x7mr6814242pfi.78.1578962739257;
        Mon, 13 Jan 2020 16:45:39 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g8sm15490727pfh.43.2020.01.13.16.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:45:38 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:45:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Mina Almasry <almasrymina@google.com>, shuah@kernel.org,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
Subject: Re: [PATCH v9 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
In-Reply-To: <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
Message-ID: <alpine.DEB.2.21.2001131642270.164268@chino.kir.corp.google.com>
References: <20191217231615.164161-1-almasrymina@google.com> <20191217231615.164161-2-almasrymina@google.com> <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Mike Kravetz wrote:

> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > index 35415af9ed26f..b03270b0d5833 100644
> > --- a/mm/hugetlb_cgroup.c
> > +++ b/mm/hugetlb_cgroup.c
> > @@ -96,8 +96,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
> >  	int idx;
> > 
> >  	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
> > -		if (page_counter_read(&h_cg->hugepage[idx]))
> > +		if (page_counter_read(
> > +			    hugetlb_cgroup_get_counter(h_cg, idx, true)) ||
> > +		    page_counter_read(
> > +			    hugetlb_cgroup_get_counter(h_cg, idx, false))) {
> >  			return true;
> > +		}
> >  	}
> >  	return false;
> >  }
> > @@ -108,18 +112,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
> >  	int idx;
> > 
> >  	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
> > -		struct page_counter *counter = &h_cgroup->hugepage[idx];
> > -		struct page_counter *parent = NULL;
> > +		struct page_counter *fault_parent = NULL;
> > +		struct page_counter *reserved_parent = NULL;
> >  		unsigned long limit;
> >  		int ret;
> > 
> > -		if (parent_h_cgroup)
> > -			parent = &parent_h_cgroup->hugepage[idx];
> > -		page_counter_init(counter, parent);
> > +		if (parent_h_cgroup) {
> > +			fault_parent = hugetlb_cgroup_get_counter(
> > +				parent_h_cgroup, idx, false);
> > +			reserved_parent = hugetlb_cgroup_get_counter(
> > +				parent_h_cgroup, idx, true);
> > +		}
> > +		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
> > +							     false),
> > +				  fault_parent);
> > +		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
> > +							     true),
> > +				  reserved_parent);
> > 
> >  		limit = round_down(PAGE_COUNTER_MAX,
> >  				   1 << huge_page_order(&hstates[idx]));
> > -		ret = page_counter_set_max(counter, limit);
> > +
> > +		ret = page_counter_set_max(
> > +			hugetlb_cgroup_get_counter(h_cgroup, idx, false),
> > +			limit);
> > +		ret = page_counter_set_max(
> > +			hugetlb_cgroup_get_counter(h_cgroup, idx, true), limit);
> >  		VM_BUG_ON(ret);
> 
> The second page_counter_set_max() call overwrites ret before the check in
> VM_BUG_ON().
> 
> >  	}
> >  }
> > @@ -149,7 +167,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
> >  	kfree(h_cgroup);
> >  }
> > 
> > -
> >  /*
> >   * Should be called with hugetlb_lock held.
> >   * Since we are holding hugetlb_lock, pages cannot get moved from
> > @@ -165,7 +182,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
> >  	struct hugetlb_cgroup *page_hcg;
> >  	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> > 
> > -	page_hcg = hugetlb_cgroup_from_page(page);
> > +	page_hcg = hugetlb_cgroup_from_page(page, false);
> >  	/*
> >  	 * We can have pages in active list without any cgroup
> >  	 * ie, hugepage with less than 3 pages. We can safely
> > @@ -184,7 +201,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
> >  	/* Take the pages off the local counter */
> >  	page_counter_cancel(counter, nr_pages);
> > 
> > -	set_hugetlb_cgroup(page, parent);
> > +	set_hugetlb_cgroup(page, parent, false);
> >  out:
> >  	return;
> >  }
> > @@ -227,7 +244,7 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
> >  }
> > 
> >  int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> > -				 struct hugetlb_cgroup **ptr)
> > +				 struct hugetlb_cgroup **ptr, bool reserved)
> >  {
> >  	int ret = 0;
> >  	struct page_counter *counter;
> > @@ -250,13 +267,20 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> >  	}
> >  	rcu_read_unlock();
> > 
> > -	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
> > -				     &counter)) {
> > +	if (!page_counter_try_charge(hugetlb_cgroup_get_counter(h_cg, idx,
> > +								reserved),
> > +				     nr_pages, &counter)) {
> >  		ret = -ENOMEM;
> >  		hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
> >  			      HUGETLB_MAX);
> > +		css_put(&h_cg->css);
> > +		goto done;
> >  	}
> > -	css_put(&h_cg->css);
> > +	/* Reservations take a reference to the css because they do not get
> > +	 * reparented.
> 
> I'm hoping someone with more cgroup knowledge can comment on this and any
> consequences of not reparenting reservations.  We previously talked about
> why reparenting would be very difficult/expensive.  I understand why you are
> nopt doing it.  Just do not fully understand what needs to be done from the
> cgroup side.
> 

I don't see any description of how hugetlb_cgroup currently acts wrt 
reparenting in the last patch in the series and how this is the same or 
different for reservations.  I think the discussion that is referenced 
here is probably lost in some previous posting of the series.  I think 
it's particularly useful information that the end user will need to know 
about for its handling so it would benefit from some documentation in the 
last patch.
