Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B213C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655B521927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583850765;
	bh=IIeGbkbGEKcI1F91jMKQzXNSe7HNScRGiPXihi7FdKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LY6tXk6oSOU2tnq9RnPSFKbbNxLHp71YVpgmHuplTdyUp/Qx66LcV8ObCcV8Lu+9Q
	 5Ee+WbcHyUJ5/SH4Ji2f4KOs0I7iJ79o9mk26ouSE1g6GWTsDdoMSN+0ryfE+X3wEM
	 mYBbeZuryGNtog5DW11a+DGuKC95xO/xEHibJqNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCJOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:32:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50664 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCJOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:32:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so1667186wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5TkgCSJdwvYSMqqN/4rtYOLkn//sQSzstKXiDNR02g=;
        b=hNvYrdrAktgVYgU3a+nWmbsmWbhYuZPhLHiWeY3X5stE0O6gjzu8Yu9twr2UIv+lRt
         ExDYALrgVrRLubi9CStw1Brlz4KKPIYQUIaSIATlXwZ0FNxP+bGO4J8hktOsK/6chm2N
         VWOSnBUOnuHU/57tvfpYzr6R8o84vR57OD40aK67nB22fCwGeRcLH+tQRMUqZCp7+3Yk
         m6SXK7rJX0JP5Wlvo4EwDi6Uw/CXVj0idVAWx2bw5PLQbb1zjIctGXGq3dewJRp6s+jv
         nUOPz89RouGq7edxWWLlYXSaJhw3lWUqC8jEVm+tdjRlOqwglTMl3BVrHo85E3hfGRHe
         3iJw==
X-Gm-Message-State: ANhLgQ0d3dCIVf/iZ/vdC49WN70/RJ5iBbVJYEwG4S6CmWxSsve6PmFH
        1goBFbqjZnyY/dTUmaF2Ios=
X-Google-Smtp-Source: ADFU+vuNKevf40tKVPjkPKOpQIvUIXlmjSA+y00/NpTFU/LhFzwGVderdrxqDgSvuYVNPRGi5UznWw==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr2482540wmc.30.1583850762615;
        Tue, 10 Mar 2020 07:32:42 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z11sm4243298wmd.47.2020.03.10.07.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:32:41 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:32:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Remove the redundant conditional check
Message-ID: <20200310143240.GL8447@dhcp22.suse.cz>
References: <20200308013511.12792-1-bhe@redhat.com>
 <20200310101044.GE8447@dhcp22.suse.cz>
 <20200310142341.GG27711@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310142341.GG27711@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 22:23:41, Baoquan He wrote:
> On 03/10/20 at 11:10am, Michal Hocko wrote:
> > On Sun 08-03-20 09:35:11, Baoquan He wrote:
> > > In commit f70029bbaacbfa8f0 ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> > > the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY, so the
> > > conditional check in paging_init() doesn't make any sense any more.
> > > Remove it.
> > 
> > Please expand more. I would really have to refresh the intention of the
> > code but from a quick look at the code CONFIG_HIGHMEM still makes
> > N_MEMORY != N_NORMAL_MEMORY. So what what does this change mean for that
> > config?
> 
> Thanks for looking into this. I was trying to explain that
> CONFIG_MOVABLE_NODE made N_MEMORY have chance to take different enum
> value.
>  
> Do you think the below saying is OK to you?
>  
> ~~~
> In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY.  Before
> commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
> (N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
> doesn't have any chance to be equal to N_NORMAL_MEMORY. So the  conditional
> check in paging_init() doesn't make any sense any more. Let's remove it.

Yes this describes the matter much better. I have obviously misread the
code when looking at it this morning. Being explicit in the changelog
would have helped at least me. Thanks!

-- 
Michal Hocko
SUSE Labs
