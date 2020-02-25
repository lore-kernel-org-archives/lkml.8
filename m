Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C00C35DFE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC5E218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582624951;
	bh=L9wVFDiG7i2e2QopiyF9lYRVNbRhhGOMTb9xiWy1gzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0soKilroePdfNUtyTJMVXpbx4QHNbqO0S6FTQY69RsxC8oWuJUzDHSOpINWOEEXEW
	 hRF3Sxo+v84lf4JSulmkkUyJxPXQTPkIcr5LA8BZPsOO8Gdc4kNITVx26zNSr1hNlc
	 k+Cwo43X7zLWD1Y4L27qqHRc4Tdu3Zd1shkUmR98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgBYKCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:02:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51944 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgBYKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:02:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so2330624wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnOg0BFJC0Xq2X5KIoU2QBkyMNBMepmyg8YCqkA6k7U=;
        b=W5pkAJ7vs+/eKUiyjkKoAdyaEr6gD+WDTwNHpqLhMbMG24m5oWZknwhCKJeRVzD6aQ
         XDbwYe3WQxHFS6SvwJYwsZxvjDyEfDpAzb5Yq80FmYrBqG80MncXLUH+Cjw2CBHmZ7rr
         WbjZY0/SSLqp/W1IW5MyDjQJUv0z6q4Z6h1+vne8dFmKabEUampqJvBm9V47r7OUEfIL
         vYGem9IGfyxigxShdBffLqOg8fsR7ImcX1wMhluRCMEREpivWH9oo0PnPM8kksmhjQDA
         IaMHk2F6gMUSUYqx60n7M70CroNivXMRmAcoLOTLd0mht9G0GckD8nB5FlRRnza4iC3C
         5f6A==
X-Gm-Message-State: APjAAAUyOwvIhwxmtA5P2nZttksbCAHlEV6KOuZZ7wDxQsqeD70x005q
        Z36O58vt611l9aXYwYJnkNM=
X-Google-Smtp-Source: APXvYqxzKot3XeUYUWdPD1zoO4zHgH+OtF66V+GASD3x4k3iPE0BSwi344jjt8FwnvA1YSzHJ7GvTQ==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr4418391wmh.84.1582624947879;
        Tue, 25 Feb 2020 02:02:27 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a13sm5808318wrt.55.2020.02.25.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:02:26 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:02:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, osalvador@suse.de,
        dan.j.williams@intel.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200225100226.GM22443@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
 <20200221142847.GG4937@MiWiFi-R3L-srv>
 <75b4f840-7454-d6d0-5453-f0a045c852fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75b4f840-7454-d6d0-5453-f0a045c852fa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-02-20 10:10:45, David Hildenbrand wrote:
> >>>  include/linux/mmzone.h |   2 +
> >>>  mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
> >>>  2 files changed, 127 insertions(+), 53 deletions(-)
> >>
> >> Why do we need to add so much code to remove a functionality from one
> >> memory model?
> > 
> > Hmm, Dan also asked this before.
> > 
> > The adding mainly happens in patch 2, 3, 4, including the two newly
> > added function defitions, the code comments above them, and those added
> > dummy functions for !VMEMMAP.
> 
> AFAIKS, it's mostly a bunch of newly added comments on top of functions.
> E.g., the comment for fill_subsection_map() alone spans 12 LOC in total.
> I do wonder if we have to be that verbose. We are barely that verbose on
> MM code (and usually I don't see much benefit unless it's a function
> with many users from many different places).

I would tend to agree here. Not that I am against kernel doc
documentation but these are internal functions and the comment doesn't
really give any better insight IMHO. I would be much more inclined if
this was the general pattern in the respective file but it just stands
out.
-- 
Michal Hocko
SUSE Labs
