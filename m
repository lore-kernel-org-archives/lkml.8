Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C9C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524120B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585755956;
	bh=RsIivZZSghBD78I9Uptz4Drku1+98MabYwsmQQi7GTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2TjDtJgeXsSo5z2pzZ+pzYyZZhgtGORzMhSHTSdt5vWzAavbMuDr7q9TB/J4ZGobX
	 pAa8u0E09tFFG5BXP9NKQDT5vgXNjfMLcExsCnndNAKZVtQ6AW1M3IBuqyVaef2pHK
	 FzvndyYLO/NL/6QiRmJtnnJOagQZCIa/VD7T2SVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgDAPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:45:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732889AbgDAPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:45:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so597671wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYBj/J8veruCjTzX1o+wZprDrS+JzOwwWpvGNETVB3w=;
        b=eYjqW+6DHgp8kAFKlmCkcnRIZZd0EIWdOD8k2HqEGiH5cLe+U9Ar/BKn1ne0Te46s5
         9zbI6F4SCXwZo63LkLmhK1XHE29mTFgt35cqlCDVqgj2cDgpU8lfmMYsUlE9pso946r/
         7yOfsauJD04HyJYfv0BmC6/R3M6n4Js3oXvBj2sbi+o9td9hN6Mq6jr9VAlsYgFncxfI
         p16zMduE879jEqhPOoQ7/XY7TO1xC+4S/RJQHeqRmQQ3VY+5BIBHlV4ifi7flVTJfDrP
         J1imRfbdUFoaPGFejjpveZiKMhdwbz6qm6csGyHsYdh+lce9XQpQK0z/eFbJPMU2d9x7
         EdsQ==
X-Gm-Message-State: ANhLgQ2Dz5Po8DAiaEh81VSuQYfOmWaCHtjKxKtyKMq8LFhWffhzZcBQ
        8GHejB3NOGwtReCgwknq3Fk=
X-Google-Smtp-Source: ADFU+vsAEDOPLXQdjBGQtq0cDsSOpGqVXNrzozCxu7TMCJPYjXlwTpGvrXv06QSo+jG2WumpyNP3Hw==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr26245360wre.257.1585755953120;
        Wed, 01 Apr 2020 08:45:53 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id b67sm3133222wmh.29.2020.04.01.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:45:52 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:45:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: fix watchdog soft lockups during
 set_zone_contiguous()
Message-ID: <20200401154549.GS22681@dhcp22.suse.cz>
References: <20200401104156.11564-1-david@redhat.com>
 <20200401104156.11564-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401104156.11564-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 12:41:56, David Hildenbrand wrote:
> Without CONFIG_PREEMPT, it can happen that we get soft lockups detected,
> e.g., while booting up.
> 
> [  105.608900] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
> [  105.608933] Modules linked in:
> [  105.608933] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-next-20200331+ #4
> [  105.608933] Hardware name: Red Hat KVM, BIOS 1.11.1-4.module+el8.1.0+4066+0f1aadab 04/01/2014
> [  105.608933] RIP: 0010:__pageblock_pfn_to_page+0x134/0x1c0
> [  105.608933] Code: 85 c0 74 71 4a 8b 04 d0 48 85 c0 74 68 48 01 c1 74 63 f6 01 04 74 5e 48 c1 e7 06 4c 8b 05 cc 991
> [  105.608933] RSP: 0000:ffffb6d94000fe60 EFLAGS: 00010286 ORIG_RAX: ffffffffffffff13
> [  105.608933] RAX: fffff81953250000 RBX: 000000000a4c9600 RCX: ffff8fe9ff7c1990
> [  105.608933] RDX: ffff8fe9ff7dab80 RSI: 000000000a4c95ff RDI: 0000000293250000
> [  105.608933] RBP: ffff8fe9ff7dab80 R08: fffff816c0000000 R09: 0000000000000008
> [  105.608933] R10: 0000000000000014 R11: 0000000000000014 R12: 0000000000000000
> [  105.608933] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  105.608933] FS:  0000000000000000(0000) GS:ffff8fe1ff400000(0000) knlGS:0000000000000000
> [  105.608933] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  105.608933] CR2: 000000000f613000 CR3: 00000088cf20a000 CR4: 00000000000006f0
> [  105.608933] Call Trace:
> [  105.608933]  set_zone_contiguous+0x56/0x70
> [  105.608933]  page_alloc_init_late+0x166/0x176
> [  105.608933]  kernel_init_freeable+0xfa/0x255
> [  105.608933]  ? rest_init+0xaa/0xaa
> [  105.608933]  kernel_init+0xa/0x106
> [  105.608933]  ret_from_fork+0x35/0x40
> 
> The issue becomes visible when having a lot of memory (e.g., 4TB)
> assigned to a single NUMA node - a system that can easily be created
> using QEMU. Inside VMs on a hypervisor with quite some memory
> overcommit, this is fairly easy to trigger.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 084cabffc90d..cc4f07d52939 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1607,6 +1607,7 @@ void set_zone_contiguous(struct zone *zone)
>  		if (!__pageblock_pfn_to_page(block_start_pfn,
>  					     block_end_pfn, zone))
>  			return;
> +		cond_resched();
>  	}
>  
>  	/* We confirm that there is no hole */
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
