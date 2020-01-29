Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F362FC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97312070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580304595;
	bh=WSfaj6iZUNvq/tzkmMf0eY3u1apppaSyX8HXl6Rg7+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DJhDo+Xid4eHUAz2kuU5pUbxNG7NoF2vQWsr6inqyfjmqMrKuoXVp2OaEP/y79Miz
	 HcSaalTt8LC4OhnZIohiyGh/oC0EoDXbOX+xUTFgULRhO93jSlY1vvMEXz1qt30mQ2
	 C9M9s//7OsUq1d4MmCOEANPUK7l+RPplJFq6ejWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgA2N3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:29:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43041 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:29:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so20185245wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prpS7rraPt/GjCivc8V6REqwcGP4nAyD1IPQ65+5P0g=;
        b=H3x1RDTwWkfTVU+QVGVfvJyiyRyR7hsr2qppvopieE5eq7yk1sz6nk245NneIF4MMY
         Ic+xPF8StU5BRphRNmiFbDnfMrj8x1kPVksxCTJyNjJcF0jPUUeH2Bny7L+6LmVNw1U5
         Qhq+ooZxh+GLxILQe5TIC7p6s7K50Scb6aIDWd9v3wGEURqn43DAQ21JFk9rV/ZcPgkl
         Ak/bmMXccHG49OhKt+rC5hZCYmhaUiGszE56083jj7kpyKobYBy7f//pb82PVS5P6x/a
         yU2yn4ggp0U4XNuSGzm2oo/y6YLBoL60w8K2AnI0emyEcy/2zKplqIu1f5McllgummkG
         jQvw==
X-Gm-Message-State: APjAAAXrg7UTfuQY0YySsGc8R9APTRDoJOk2ciBgZg3SdtRAwi5dicTu
        /Z56VgIZDWAt4g7VjtifF8Q=
X-Google-Smtp-Source: APXvYqwUgwcj23f6v0orkfDA43EGCM8GKFKUL1BSo+4dxdZTryjlU8NEkhX/qps/nQ25dswX65X1bQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr33967169wrv.86.1580304592326;
        Wed, 29 Jan 2020 05:29:52 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y20sm2334628wmi.23.2020.01.29.05.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 05:29:51 -0800 (PST)
Date:   Wed, 29 Jan 2020 14:29:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp,
        hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
Subject: Re: [PATCH -next] mm/page_counter: annotate an intentional data race
Message-ID: <20200129132950.GL24244@dhcp22.suse.cz>
References: <20200129131242.4329-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129131242.4329-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-01-20 08:12:42, Qian Cai wrote:
> The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters") could
> had memcg->memsw->failcnt been accessed concurrently as reported by
> KCSAN,
> 
> BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge
> 
> write to 0xffff88809bbf2158 of 8 bytes by task 11782 on cpu 0:
>  page_counter_try_charge+0x100/0x170 mm/page_counter.c:129
>  try_charge+0x185/0xbf0 mm/memcontrol.c:2405
>  __memcg_kmem_charge_memcg+0x4a/0xe0 mm/memcontrol.c:2837
>  __memcg_kmem_charge+0xcf/0x1b0 mm/memcontrol.c:2877
>  __alloc_pages_nodemask+0x26c/0x310 mm/page_alloc.c:4780
> 
> read to 0xffff88809bbf2158 of 8 bytes by task 11814 on cpu 1:
>  page_counter_try_charge+0xef/0x170 mm/page_counter.c:129
>  try_charge+0x185/0xbf0 mm/memcontrol.c:2405
>  __memcg_kmem_charge_memcg+0x4a/0xe0 mm/memcontrol.c:2837
>  __memcg_kmem_charge+0xcf/0x1b0 mm/memcontrol.c:2877
>  __alloc_pages_nodemask+0x26c/0x310 mm/page_alloc.c:4780
> 
> Since the "failcnt" counter is tolerant of some degree of inaccuracy and
> is only used to report stats, a data race will not be harmful, thus mark
> it as an intentional data races with the data_race() macro.
> 
> Reported-by: syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_counter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index a17841150906..7c82072cda25 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -126,7 +126,7 @@ bool page_counter_try_charge(struct page_counter *counter,
>  			 * This is racy, but we can live with some
>  			 * inaccuracy in the failcnt.
>  			 */
> -			c->failcnt++;
> +			data_race(c->failcnt++);
>  			*fail = c;
>  			goto failed;
>  		}
> -- 
> 2.21.0 (Apple Git-122.2)

-- 
Michal Hocko
SUSE Labs
