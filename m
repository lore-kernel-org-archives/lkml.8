Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE976C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AD62083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579276022;
	bh=FCadZVbrTnJdhC2tSCPz5DKRVsjw4WKCW2LDnjxNG/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1YUPcwwwkr6QSL2zHYI9y1WyNiToXngp5rpfXwimORGBY61XQ8T0ERcEVgHMwv8M
	 q7ZomdzM6DzPq1QKSxq4sXOUymmeY1aCQH52xQDb/4NtSYEql8lWdS6S23QR+D+P3e
	 S8fr1GJqQb+/EN/m6QgyiuRBe3v41YZ8L6e5icdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAQPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:47:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:47:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so7916555wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Bj0wpfeG4WUbynTokfuhSk08I/UsNl1uvGCOq3jYT0=;
        b=tzZRYC8OABVTP1W0y3Dim9rK+94HNd9Sw/aRkd6WTEwx4ae9Upw7FtE9ki9m6YQeUS
         UKpyXwudhvbhiKC1t2Q7ctyLIrPGs292gUUrQDXPxkK3HrHzUVGoSqsM7ArHlT9GNHGe
         B7+VQmhNzXqwY00sw5CSDfHdD0ns5JkavVh/GwMGoFu12rNpF+2Q2bns0sBPy9fpPN2X
         AvniLcTQ7gw1v8LEVwIKi8LqtIheFLwonAe8Um8/5Wp/rxPp0TcMarqheGDjlD/bFy4N
         jSFsbPEtmpm6ThEXqXactlCZiG+TNS6rc9i7e1QMe7Du62WESREdXb6BW7GvIWqx9WWt
         4slg==
X-Gm-Message-State: APjAAAWCk+F1RkePcrPhRzvQfB3y40B86uXPLdU2uPOiWcYOvkhYy3uf
        cuqqYUt9p4uq1SztuX1a+L4=
X-Google-Smtp-Source: APXvYqxvFy2I3vgmVlD3PjVc6nrcUsOWbf3nQbihKUYrVjXoA2ms3aHznTtU5u1TdPGXx8upDvD4lg==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr5462989wmc.128.1579276019240;
        Fri, 17 Jan 2020 07:46:59 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s128sm10370683wme.39.2020.01.17.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:46:58 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:46:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117154657.GL19428@dhcp22.suse.cz>
References: <20200117143905.GZ19428@dhcp22.suse.cz>
 <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 10:05:12, Qian Cai wrote:
> 
> 
> > On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Thanks a lot. Having it in a separate patch would be great.
> 
> I was thinking about removing that WARN together in this v5 patch,
> so there is less churn to touch the same function again. However, I
> am fine either way, so just shout out if you feel strongly towards a
> separate patch.

I hope you meant moving rather than removing ;). The warning is useful
because we shouldn't see unmovable pages in the movable zone. And a
separate patch makes more sense because the justification is slightly
different. We do not want to have a way for userspace to trigger the
warning from userspace - even though it shouldn't be possible, but
still. Only the offlining path should complain.

-- 
Michal Hocko
SUSE Labs
