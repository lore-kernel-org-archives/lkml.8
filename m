Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A23C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C1222522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579596438;
	bh=JvhfrgQshurMQpThk4ErmUitg4KHleJhjDd22gZubIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nOvOuVwGGrtJgUF7uxTOL+6aAY6lC1uIs2EC1pNVMHEdwxLo8XwuvtzBP8x+p/cBA
	 h4gmml6BmtSFvlPiOVen/LVw9zSXYUAYr3c4ROZ/qhvu4AWELgVQlrypxAd5S/uvUA
	 sgL/cDgwEbDqNndKT1iejSCJWiHMxZl2hsGoOlUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:47:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40355 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:47:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2157706wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2Jq4UlfexjtmVkY83w3tCLe5tcHuhDfyWxnlQ/y19k=;
        b=DYcvUz9PRBdbY3i7K8eNMQ/krVzqvBjrAlY5GXlY5syu/FO6lESPBwJM6Zu9vhaWdb
         QQl3b7B4vf8b/Vk0kJNsoRI2WAhIotg9FAEoeHfwyrBzQcqp3PxLE9k83P3sFzzbArxZ
         zVLgnDybcPMAVW0thQsB3nfl3tCI/5Qv7xTjMROb9S0r3FZawFiSE1HlOoBsguQjAko0
         cDUB3RRWDwTQ1q0HAal5yV8hRkdT+ITaqeg+clujqQ4MTBlmS93lLj5ZM4g1sGoxcReb
         mWsWr6jAAywq6Z3VPum6R/H3JMSr214T0L7oJEb4ebtz0EymqcikSpruqiUiylFRGC+J
         cldA==
X-Gm-Message-State: APjAAAXHM7rmHenpTp53GUiUghFze2OercczTUCCK1JYCnME/w/CpGjJ
        pPW8I0ANBlMcJI6FaXdfhx4ss8Bn
X-Google-Smtp-Source: APXvYqw1p5Rcn7Z8ld4e+Gmx0HTfIMMJYbcXddl3v3YURFj3nrwbOyaH3Rq+L4haaBDPEgq1E9lk8A==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr3962551wrw.346.1579596435896;
        Tue, 21 Jan 2020 00:47:15 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f207sm3355865wme.9.2020.01.21.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 00:47:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:47:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 3/4] mm/page_alloc.c: pass all bad reasons to
 bad_page()
Message-ID: <20200121084714.GF29276@dhcp22.suse.cz>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-4-richardw.yang@linux.intel.com>
 <20200120102200.GW18451@dhcp22.suse.cz>
 <2288c80c-42f7-a161-58cf-47cf07699202@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2288c80c-42f7-a161-58cf-47cf07699202@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 11:38:29, Anshuman Khandual wrote:
> 
> 
> On 01/20/2020 03:52 PM, Michal Hocko wrote:
> > On Mon 20-01-20 11:04:14, Wei Yang wrote:
> >> Now we can pass all bad reasons to __dump_page().
> > And we do we want to do that? The dump of the page will tell us the
> > whole story so a single and the most important reason sounds like a
> > better implementation. The code is also more subtle because each caller
> > of the function has to be aware of how many reasons there might be.
> > Not to mention that you need a room for 5 pointers on the stack and this
> > and page allocator might be called from deeper call chains.
> > 
> 
> Two paths which lead to __dump_page(), dump_page() and bad_page().
> Callers of dump_page() can give a single reason what they consider the
> most important which leads to page dumping. This makes sense but gets
> trickier in bad_page() path. At present, free_pages_check_bad() and
> check_new_page_bad() has a sequence of 'if' statements which decides
> "most important" reason for __dump_page() without much rationale and
> similar in case of free_tail_pages_check() as well. As all information
> about the page for corresponding reasons are printed with __dump_page()
> anyways, do free_pages_check_bad() or check_new_page_bad() really need
> to provide any particular single reason ?

Do you see any particular problem with the existing logic? I find a
single reason sufficient and a good lead for what to check most of the
time.
-- 
Michal Hocko
SUSE Labs
