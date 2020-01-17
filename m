Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87018C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA342073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579274796;
	bh=0Mghe/7vpl8v8dMkysks1EcXYGX1SGzUQuMTJjHDNWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BlevhuDbTHn6fXKxtJnBhR+KZLA9bLjxZ2+QJn+Soq1UBzbbM5oUK8NewIk54kWSM
	 VrLej+rX79sgOOxPJli2PdrCTx5Zamzkr1Izw1j0sDHHREWBwbwlMoJYK3UwW9i1GZ
	 x9LFgJxhlvD2VWOHxjsvxns7XVUrPntWCyG5HIHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAQP0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:26:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38153 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:26:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so8019657wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54lYfq6O2/zCWOuTXiiiKBsbz1wekZ0hwyTR+nI95t4=;
        b=Dy8Wrbv/nKMxPj1s5A5JZLA//cgcQa27XzKQHHPlaVcn8Qb7Cmf3Ez3fZkrLTpf0Up
         hZ3938ZI5/dMDyY/2WpVjxvK779FUB39HF08yJFMY1IwaoI8iQDZWdHEd7FSG72COXWo
         FXHXbNUQ5hgRvZRrSw3OOpB2KOea+NKRppSPHgk0dWKSgUzlsljf9oOD0Ur8Xdymaxby
         XBgbg//vjaAdpap6oSioePWTc+As1vU4PhdVetAnxqLDhhYscOBkhjObyFSN3jG/5KXP
         s2jGIs2CQrrLSgwQ3vOlJGQzYdLwun5PTew2rtMhhfwqXJN2kL6f6pUHbcupdTQrFHI+
         UquA==
X-Gm-Message-State: APjAAAWs1rw9CsTF2FUud8aLjMovbv76LNSkTrTR/YBHnvMbiP7Ou1sg
        wmaNlaj+fVeOp9ytK3jpToE=
X-Google-Smtp-Source: APXvYqzmut3AbdodMKbldK91Sl/6ZksklT1nZbYZzRgc6raJH+ZG1nmNAZsmhjHD7gtmDf+4IZDX7A==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr5129791wmb.0.1579274793248;
        Fri, 17 Jan 2020 07:26:33 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n3sm32566714wrs.8.2020.01.17.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:26:32 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:26:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117152631.GJ19428@dhcp22.suse.cz>
References: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
 <6BED7E12-CC3B-4AED-ACC8-F3533D3F3C70@lca.pw>
 <20200117144209.GA19428@dhcp22.suse.cz>
 <0e9b9357-1982-edd3-dbfe-5350c8d6d0eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9b9357-1982-edd3-dbfe-5350c8d6d0eb@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 15:43:58, David Hildenbrand wrote:
> On 17.01.20 15:42, Michal Hocko wrote:
> > On Fri 17-01-20 07:40:15, Qian Cai wrote:
> >>
> >>
> >>> On Jan 17, 2020, at 3:51 AM, David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> -> you are accessing the pageblock without the zone lock. It could
> >>> change to "isolate" again in the meantime if I am not wrong!
> >>
> >> Since we are just dumping the state for debugging, it should be fine
> >> to accept a bit inaccuracy here due to racing. I could put a bit
> >> comments over there.
> > 
> > Sorry, I could have been more specific. The race I was talking about is
> > not about accuracy. The current code is racy in that sense already
> > because you are looking at a struct page you do not own so its state can
> > change at any time. Please note that the zone->lock doesn't really
> 
> The pageblock state cannot change with the zone->lock. That's what I was
> referring to here. (this specific check)

CMA pages tend to have a stable pageblock state. More importantly this
is not the most important information from my experience. It is usually
reference count and page flags that are of interest. Or details about
what kind of filesystem is owning the page and it doesn't want to
release it.
-- 
Michal Hocko
SUSE Labs
