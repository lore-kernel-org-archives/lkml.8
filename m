Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A4C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C232078E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mLa9Jpn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgDANSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:18:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45075 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgDANSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:18:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id u59so29499094edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRtfl1L7m/hmmdMrJjjEwI1pP7Bc5OEwU2VO6GlHPfE=;
        b=mLa9Jpn/7nmZ8X8/zrYnvuKjQpbHBnGkUVnfZrnKUPQLlZWMqd3gteUNRQKM/sjBih
         4BcBc0W+HnDWtus32yVPb9j+yfncz9QVVKV/5231o/QNcyN5CPO+n4BwXaH9jDiX7kpl
         5+iG6odVHCM8duR7YSlIRaifEmMXlYXlh4tLp45HnSs+9DrttiliZvN5WBAJGHJAFKC+
         5XhXBV13ni0CJs8kDd6p88G/wwL7YeaP31FPmuQksm8y/UGWoeZsS1jxIbdmOG0vuYt2
         RcdhduLM0suTmgVDfDZv86HVQ9hcYW2r8CQHen3dYumLHa0ScLmEYGaE0fiOFaHfWjdC
         S9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRtfl1L7m/hmmdMrJjjEwI1pP7Bc5OEwU2VO6GlHPfE=;
        b=jE8nZWgChFlkHhqIUoJkp/U/e6LOBSq7bdALN8D30QtR8rfk24cFqDdZM0esPF+1d3
         uvJx0L1EY1grrCcspzYr6QAqT7khe1a7H/Lhk8dTOB9foTtvvhON7zQMbAlx/GICntV6
         5Uyje1qQ+0SwxypscnO2N4JGen3lJsgJhLBw19UHKZcNm6NCqJCQLWtbzZ44lM19r+Rq
         /uY5DZ3qY8D3rFqUMT83DHnQESo6NdawqOkj5DgdjvkQHfRVA8wpeeecMp8EV67vcRHn
         OuvsFeIuiWthZZb/K9ni4BoXkNNUszxndggI4k/41DAFJMAIwv/KR4+4h9IUomGSbwik
         0KDw==
X-Gm-Message-State: ANhLgQ2q/zYDfA37a/eMIt+1z+GRe2obQttWebpHpWlpOhV2xmwa7q+Q
        nGS2WVNRjaCxKtqMXJKrHPIxDRSXdz4b3uLudSJCKw==
X-Google-Smtp-Source: ADFU+vsXm4hnWTxb+zy5do50bdWqH0zJVcT4Wi+1GZBYUE1ANt/RW9WEiEjAQ0Fw//a+G0xXpEQ4pywFhxgv9Exl9wI=
X-Received: by 2002:a05:6402:1a3a:: with SMTP id be26mr21377179edb.342.1585747080166;
 Wed, 01 Apr 2020 06:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200401104156.11564-1-david@redhat.com> <20200401104156.11564-3-david@redhat.com>
In-Reply-To: <20200401104156.11564-3-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Apr 2020 09:17:49 -0400
Message-ID: <CA+CK2bAusE3X8f_Di8hD9WP3YHaQrRiOzbKnEsq+=OkkUQGqxQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 6:42 AM David Hildenbrand <david@redhat.com> wrote:
>
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

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
