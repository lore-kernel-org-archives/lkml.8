Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7AC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287C20702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580287889;
	bh=5MJE4j7Z/7q626e6lcIpwRhmybGwoSOpv2O4Tv5DSUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sLfXhokvb7gWKqp88q+eYVboIGdboS1BppwTi3q1+jUtgcTwiJYIxpuVRwWyBsSrk
	 QdbjQRNT9eBAlz8otKb7LTNm8RFsQAclCdUX3UShnvwVA6fBwtt+odlxdsvOcNWJe1
	 0FvuwbzUeFHMVBjcVqjsag8Tpcyx696XgYSudlJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgA2Iv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:51:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2Iv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:51:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so1130194wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 00:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkkniSnhYF39e0ambtuN7BZvDABTNccNcMnMWmf9+G0=;
        b=V6unwzIgtVYuU6Pk1DLq5+4Al4Dd0mSYSmx4djw/dByXvovUZ/P76V2S8oJk2IAyn6
         Fu2aLWib6aS4DSp+nYGoZIZ/F16D4pJmcfJxNz7uQ2aFN5yd+8porW/h3TJq3VEpZy0S
         /kU6cG+W3PrbJQmDBxGHmQBytXF7oPfXmmUEx/zCG22gripsmrNuiBaDW/2IuzFqqxDz
         QcsZU2FDo8iejMZw+SfVs644hQYdTyDZkrfBYMbHXUC/CRktwZ5mAZfuMKRDVDUGPad1
         uUM4cgh980o6mAZZZpj4HRd6+FU5o0oPnyz72Lvn/Ovw8e6yymTg+Ol+4YtuB9EnqKJg
         BKtA==
X-Gm-Message-State: APjAAAVWCZuxHjyBm5zk094ypHlCGYJA+djp5a4HIFHHAk2Vp8gUT2DN
        n/KkSM4SsKXCXbZ1aPn9eu4=
X-Google-Smtp-Source: APXvYqxAcClCy9Tbc8kFQ33w3OvdBX7ImLjg3eAob7hClc84tEfHXC0dnF8MQaYbYRr2U6pvCySAOQ==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr10146279wml.107.1580287886283;
        Wed, 29 Jan 2020 00:51:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y20sm1499314wmi.23.2020.01.29.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:51:25 -0800 (PST)
Date:   Wed, 29 Jan 2020 09:51:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/page_counter: mark intentional data races
Message-ID: <20200129085124.GF24244@dhcp22.suse.cz>
References: <20200129042019.3632-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129042019.3632-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-01-20 23:20:19, Qian Cai wrote:
> The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
> had memcg->memsw->failcnt and ->watermark could be accessed concurrently
> as reported by KCSAN,
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge
> 
>  read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
>   page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
>   try_charge+0x131/0xd50
>   __memcg_kmem_charge_memcg+0x58/0x140
>   __memcg_kmem_charge+0xcc/0x280
>   __alloc_pages_nodemask+0x1e1/0x450
>   alloc_pages_current+0xa6/0x120
>   pte_alloc_one+0x17/0xd0
>   __pte_alloc+0x3a/0x1f0
>   copy_p4d_range+0xc36/0x1990
>   copy_page_range+0x21d/0x360
>   dup_mmap+0x5f5/0x7a0
>   dup_mm+0xa2/0x240
>   copy_process+0x1b3f/0x3460
>   _do_fork+0xaa/0xa20
>   __x64_sys_clone+0x13b/0x170
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  write to 0xffff8fb18c4cd190 of 8 bytes by task 1153 on cpu 120:
>   page_counter_try_charge+0x5b/0x150 mm/page_counter.c:139
>   try_charge+0x131/0xd50
>   mem_cgroup_try_charge+0x159/0x460
>   mem_cgroup_try_charge_delay+0x3d/0xa0
>   wp_page_copy+0x14d/0x930
>   do_wp_page+0x107/0x7b0
>   __handle_mm_fault+0xce6/0xd40
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
> Since the failcnt and watermark are tolerant of some inaccuracy, a data
> race will not be harmful, thus mark them as intentional data races with
> the data_race() macro.

I am not familiar with KCSAN and git grep for data_race on the current
linux-next doesn't really show any users of this macro. Is there a
general consensus that data_race is going to be used to silence all
KCSAN false positives?

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_counter.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..13934636eafd 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (data_race(new > c->watermark))
> +			data_race(c->watermark = new);
>  	}
>  }
>  
> @@ -126,7 +126,7 @@ bool page_counter_try_charge(struct page_counter *counter,
>  			 * This is racy, but we can live with some
>  			 * inaccuracy in the failcnt.
>  			 */
> -			c->failcnt++;
> +			data_race(c->failcnt++);
>  			*fail = c;
>  			goto failed;
>  		}
> @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		 * Just like with failcnt, we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (data_race(new > c->watermark))
> +			data_race(c->watermark = new);
>  	}
>  	return true;
>  
> -- 
> 2.21.0 (Apple Git-122.2)

-- 
Michal Hocko
SUSE Labs
