Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5565BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412A5208A7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgFDRSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:18:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbgFDRSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:18:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71AA3ABC2;
        Thu,  4 Jun 2020 17:18:17 +0000 (UTC)
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz>
Date:   Thu, 4 Jun 2020 19:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 7:14 PM, Vegard Nossum wrote:
> 
> Hi all,
> 
> I ran into a boot problem with latest linus/master
> (6929f71e46bdddbf1c4d67c2728648176c67c555) that manifests like this:

Hi, what's the .config you use?

> hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> clocksource: Switched to clocksource tsc-early
> BUG: unable to handle page fault for address: 000000003ffe0018
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0+ #211
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
> Ubuntu-1.8.2-1ubuntu1 04/01/2014
> RIP: 0010:kmem_cache_alloc+0x70/0x1d0
> Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 6f cc e7 7e 4d 8b 20 
> 4d 85 e4 0f 84 3d 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a 01 <49> 8b 1c 
> 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
> RSP: 0000:ffffc90000013df8 EFLAGS: 00010206
> RAX: 0000000000000018 RBX: ffffffff81c49200 RCX: 0000000000000002
> RDX: 0000000000000001 RSI: 0000000000000dc0 RDI: 000000000002b300
> RBP: ffff88803e403d00 R08: ffff88803ec2b300 R09: 0000000000000001
> R10: 0000000000000dc0 R11: 0000000000000006 R12: 000000003ffe0000
> R13: ffffffff8110a583 R14: 0000000000000dc0 R15: ffffffff81c49a80
> FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000003ffe0018 CR3: 0000000001c0a001 CR4: 00000000003606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __trace_define_field+0x33/0xa0
>   event_trace_init+0xeb/0x2b4
>   tracer_init_tracefs+0x60/0x195
>   ? register_tracer+0x1e7/0x1e7
>   do_one_initcall+0x74/0x160
>   kernel_init_freeable+0x190/0x1f0
>   ? rest_init+0x9a/0x9a
>   kernel_init+0x5/0xf6
>   ret_from_fork+0x35/0x40
> CR2: 000000003ffe0018
> ---[ end trace 707efa023f2ee960 ]---
> RIP: 0010:kmem_cache_alloc+0x70/0x1d0
> 
> Bisection gives me:
> 
> commit 3202fa62fb43087387c65bfa9c100feffac74aa6
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Apr 1 21:04:27 2020 -0700
> 
>      slub: relocate freelist pointer to middle of object
> 
> Reverting these three commits fixes it:
> 
> 3202fa62fb43087387c65bfa9c100feffac74aa6 slub: relocate freelist pointer 
> to middle of object
> 89b83f282d8ba380cf2124f88106c57df49c538c slub: avoid redzone when 
> choosing freepointer location
> cbfc35a48609ceac978791e3ab9dde0c01f8cb20 mm/slub: fix incorrect 
> interpretation of s->offset
> 
> 
> Vegard
> 

