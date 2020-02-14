Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B61CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE7E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581669291;
	bh=osMFQiQwW3BsOXhKFgeRt9NFNY6MzlyjRlJNGmbPmQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bnJWTrRGOdBnGEEhEUnbd9DQjPFmKBlS+5yus6SIHbOyieZ1v6uqhxinCMqLQEsuo
	 iuwhO/LML9UsDkqhp28yux28HpOpdLMKj40oWtBUafCX2EugAN+QTW/1j+NsVjuxS2
	 J7ACuZ6iGy6QydBnN5YeUKuJnWFzRlE6LHAFIwek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgBNIeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:34:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgBNIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:34:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so9891285wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m744gpvb7f0f8+A+ehtYqq9qidkXTz706TB8wS7XMPk=;
        b=sKMSz+9xvmKfUqW+Vm4R/tOQOSaIhFHjpla2Dv7vODy6vx1JkJIzR7E3NdMzkS0xko
         C4ujYO6dsxqQZUNCFHLePg0HsqDMIR+klQyxKj09D0gvH00d0W7KsWeisKSetb9P11je
         1NWvB46TZc5T+DduyjzwwW2xjUeUVKyb7VXrh2b1cs6bJ0wtiawQ8ZRim5VsUc5UZ9z+
         hcLqQ08M+vSXMnuFDtEYdSwNh8oKPspUv5hoeUfRFw75NaT+Jzz05n68coIFOUrqJZC9
         FS4d3xpXirorRIE46hZXb/bgwBVSGQs7K1P40aiNPu1KfYfg0Lj05tYxyXGotWfa76dT
         VN4g==
X-Gm-Message-State: APjAAAWuwfxmxmi4FDvV3wQMxoQlLhzSfdtM/vMBBYf1++W7O43A1ixf
        kVKbj2bos3UaUuqiE5UoFVlvuH+l
X-Google-Smtp-Source: APXvYqxGLu++IhPmvdaCcduZPUOaDQqPBeBzoAHKs2fmiofgdrfBT82oscGZw6XWPJIHhtRjLp/Z4g==
X-Received: by 2002:adf:a381:: with SMTP id l1mr2756332wrb.102.1581669285598;
        Fri, 14 Feb 2020 00:34:45 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id u62sm3585521wmu.17.2020.02.14.00.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:34:44 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:34:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate.c: migrate PG_readahead flag
Message-ID: <20200214083443.GO31689@dhcp22.suse.cz>
References: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-02-20 08:29:45, Yang Shi wrote:
> Currently migration code doesn't migrate PG_readahead flag.
> Theoretically this would incur slight performance loss as the
> application might have to ramp its readahead back up again.  Even though
> such problem happens, it might be hidden by something else since
> migration is typically triggered by compaction and NUMA balancing, any
> of which should be more noticeable.
> 
> Migrate the flag after end_page_writeback() since it may clear
> PG_reclaim flag, which is the same bit as PG_readahead, for the new
> page.

Looks like an omission. The readahead flag has been added later (2.6.23)
while the migration predates 2.6.17.

> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> I didn't experience any real problem, found by visual inspection. And, this was
> discussed in thread: https://lore.kernel.org/linux-mm/185ce762-f25d-a013-6daa-8c288f1ff791@linux.alibaba.com/T/#m1977ce1de513401b7d09d6fa14fcffe849580aae
> 
>  mm/migrate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index edf42ed..f3c492d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -647,6 +647,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
>  	if (PageWriteback(newpage))
>  		end_page_writeback(newpage);
>  
> +	/*
> +	 * PG_readahead share the same bit with PG_reclaim, the above
> +	 * end_page_writeback() may clear PG_readahead mistakenly, so set
> +	 * the bit after that.
> +	 */
> +	if (PageReadahead(page))
> +		SetPageReadahead(newpage);
> +
>  	copy_page_owner(page, newpage);
>  
>  	mem_cgroup_migrate(page, newpage);
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
