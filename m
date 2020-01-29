Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2828C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9261D2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580299386;
	bh=z0AkZ3HRLn4JzbF6rInQlO1PRXfj82t092r+2sIEY4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V72PwMtO+PvG7Ble8maIQ3ZtisnByldaO0S9dPxEX9w+BRVF0NjrM3SIO43kEmnB2
	 LUuBWUNngMHpVDXPh0F/36BUtg1fIRiyTBlgEV7AUFyFeIPqunYPnAcB7lI5gmHgIV
	 5KrudhnIdhcSPc5PP9aRDT06omeXoQfuKi3p4bAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA2MDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:03:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2MDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:03:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so239729wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 04:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHDiP2KDmNSPElT+l6SlS2SaHDShy9m3wLYtfmsohOA=;
        b=WXSWIQ3rPahkwmneejLfXWCgoWEfjr3lOKB9jhEVYA13KJ+0FjYuh/6J1t2+vhgU5H
         qABaXlYjBPYbi6T+FROTb6mEV11X8H32vEn0uxTUtW5KWp45oltCPN9auE2tbUFI2S+z
         vTzgv/w098TXToeJq1UYMMVN6Pz93SWMpee188HrGPaKuzwTTUOP0XyZmHlZS7qUN0pc
         CNcXVg/VU2z1yBfzF80ifnltblCvMEYvi8l2bkqBEcupvaFGgcE5NIiwXPujL+w/0hRa
         12/v//tqukzNhUAKzWW4DNV7WYiVue1NXHJVgYO5QsmYn1Wyd3PCZzchmdjJ0Qd86ev8
         Gm3A==
X-Gm-Message-State: APjAAAVrquXbgtFf8RbtWWGBgN4c8O8BU925RJqYJNqsuSPUSosFycim
        7bQAlmvRO9QUbgYWN5BQXmQ=
X-Google-Smtp-Source: APXvYqxZPw65aU6I3nm5k9SWeaHDqntcCdk2CBwNWFYbpTDRzHPkHuTiyTEPa25a+dwPAzHpv53IfQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr36565133wrq.419.1580299384093;
        Wed, 29 Jan 2020 04:03:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y185sm2183463wmg.2.2020.01.29.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 04:03:03 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:03:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_counter: fix various data races
Message-ID: <20200129120302.GJ24244@dhcp22.suse.cz>
References: <20200129105224.4016-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129105224.4016-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-01-20 05:52:24, Qian Cai wrote:
> The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters") could
> had memcg->memsw->watermark been accessed concurrently as reported by
> KCSAN,
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge
> 
>  read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
>   page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
>   try_charge+0x131/0xd50 mm/memcontrol.c:2405
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
>   try_charge+0x131/0xd50 mm/memcontrol.c:2405
>   mem_cgroup_try_charge+0x159/0x460
>   mem_cgroup_try_charge_delay+0x3d/0xa0
>   wp_page_copy+0x14d/0x930
>   do_wp_page+0x107/0x7b0
>   __handle_mm_fault+0xce6/0xd40
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
> Since watermark could be compared or set to garbage due to load or
> store tearing which would change the code logic, fix it by adding a pair
> of READ_ONCE() and WRITE_ONCE() in those places.

There is no actual problem and the report is false positive, right?
While compilers are free to do all sorts of stuff do we have any actual
proof that this particular path would ever be problematic.

I do not oppose to the patch. {READ,WRITE}_ONCE actually makes some
sense to me, but the changelog should be more clear on how serious this
is.
 
> Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_counter.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..a17841150906 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (new > READ_ONCE(c->watermark))
> +			WRITE_ONCE(c->watermark, new);
>  	}
>  }
>  
> @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		 * Just like with failcnt, we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (new > READ_ONCE(c->watermark))
> +			WRITE_ONCE(c->watermark, new);
>  	}
>  	return true;
>  
> -- 
> 2.21.0 (Apple Git-122.2)

-- 
Michal Hocko
SUSE Labs
