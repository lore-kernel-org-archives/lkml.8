Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B25C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C3320776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek815OTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgDANur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:50:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732166AbgDANuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585749045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9AlHjbal+CRKsqN7tptbmen/61lg361HPLIsxDWfXU=;
        b=Ek815OTExn0Gk9HlMiwurcOTv/bTMhD5jLTPhMVAPYRAyaVzvqLG1TEpeTVbo8eL7zj3sd
        WHcHk2x1mcJvVBbUJgzo75Hy6b/6Pp7eQN3eE0OMKPS3zcQcBt6d11hGJdf0Mb0K4hhW3f
        l3GMuIskUlqUA8qu9B0Pi3MzF11/T5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-7P717SH4MUug_JidIqDKdg-1; Wed, 01 Apr 2020 09:50:44 -0400
X-MC-Unique: 7P717SH4MUug_JidIqDKdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76898017CE;
        Wed,  1 Apr 2020 13:50:42 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BEF55E020;
        Wed,  1 Apr 2020 13:50:38 +0000 (UTC)
Date:   Wed, 1 Apr 2020 21:50:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: fix watchdog soft lockups during
 set_zone_contiguous()
Message-ID: <20200401135036.GF2402@MiWiFi-R3L-srv>
References: <20200401104156.11564-1-david@redhat.com>
 <20200401104156.11564-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401104156.11564-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/20 at 12:41pm, David Hildenbrand wrote:
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

Reviewed-by: Baoquan He <bhe@redhat.com>

