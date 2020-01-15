Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424FC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3B7207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579080261;
	bh=q8UPGf0Bf6QdDJ+8kJvFAqsHKbadPcqxaCbX7MSIPfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C3DFfqftYdwoM0HMdR5tCozvX4ixkXu0s1nwV75VdQEiJie6dWhOEvlYk+LyzbGXD
	 LErLmulaANE/jEoMjxRaAie2PpwGxIU/u9OXPmz6x/0a4OWsIyOpgHUuTZ5CVy+/ZS
	 rpKaEJNUTWofWFPAxaXTAm6NO/A23LlwNglOADaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgAOJYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:24:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37187 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgAOJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:24:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so16961717wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 01:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNU1cdwWt6cMZU4GfnwesKU3UK3hagQzMWT49N8oX9c=;
        b=QKe9cOkd7kB0CwfKvuBisMSou7qfU32PUF7eP5tDQymi2NqS0GJzlceGL0g+C5GFlP
         tdRFwSmZQElkfSde1kfMN5AddVqgHAkG1wgDzNma+nNUdeATr3tyPKs5NcgpZ941JOpD
         SyUl9Y4LQ3IslbjwUNcwTG3pQYQBJpBPE8IFoJLx4Q5F/E5s/nmqFlPTDhE282x3mlY0
         ZYUjmjXQ6VczQ/V+1hqP7RX2grgrpqMhkarySgZr3C5nAOyxymkATEWC+zLkyFKRfS+k
         kqQeTlHSosFeen5gXy5SNDRKxOfBnLbiW8T5VP3XaT/7oniQ4bIUfjdQc5+IvJEerIO+
         G1sw==
X-Gm-Message-State: APjAAAWYUZHYKLfCSlzYQ0hoJX+W61fGPCELMpNSsGgTvQJQfOSotNGN
        JrM4cWArt9y8a3DbL2A6ILQ=
X-Google-Smtp-Source: APXvYqzSl9fmAOaDZX3rSje+dh2SD0i/D/kj5x0Qr2JFd/bsHgU/welAYEaSe2RTcTtHz+oAyrfUiQ==
X-Received: by 2002:a05:600c:24d1:: with SMTP id 17mr31702639wmu.136.1579080258590;
        Wed, 15 Jan 2020 01:24:18 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j12sm23908802wrt.55.2020.01.15.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 01:24:17 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:24:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200115092417.GY19428@dhcp22.suse.cz>
References: <20200115053130.15490-1-cai@lca.pw>
 <20200115092221.GX19428@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115092221.GX19428@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 10:22:24, Michal Hocko wrote:
[...]
> > @@ -74,9 +75,9 @@ void __dump_page(struct page *page, const char *reason)
> >  			page->mapping, page_to_pgoff(page),
> >  			compound_mapcount(page));
> >  	else
> > -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
> > +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx cma:%d\n",
> >  			page, page_ref_count(page), mapcount,
> > -			page->mapping, page_to_pgoff(page));
> > +			page->mapping, page_to_pgoff(page), page_cma);
> 
> Is this correct? CMA pages cannot be comound? Btw. I would simply do
> 
> 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx%s\n",
> 			...., page_cmap ? "CMA": "");

Btw. if you rebased on top of http://lkml.kernel.org/r/9f884d5c-ca60-dc7b-219c-c081c755fab6@suse.cz
then the whole thing would be easier AFAICS.
-- 
Michal Hocko
SUSE Labs
