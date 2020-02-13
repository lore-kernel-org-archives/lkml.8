Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA38206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgBMRiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:38:22 -0500
Received: from foss.arm.com ([217.140.110.172]:51466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgBMRiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:38:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFA3328;
        Thu, 13 Feb 2020 09:38:21 -0800 (PST)
Received: from C02TF0J2HF1T.cambridge.arm.com (C02TF0J2HF1T.cambridge.arm.com [10.1.31.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407003F6CF;
        Thu, 13 Feb 2020 09:38:20 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:38:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/kmemleak: annotate various data races
 obj->ptr
Message-ID: <20200213173818.GA43109@C02TF0J2HF1T.cambridge.arm.com>
References: <1581615390-9720-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581615390-9720-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 12:36:30PM -0500, Qian Cai wrote:
> The value of object->pointer could be accessed concurrently as noticed
> by KCSAN,
> 
>  write to 0xffffb0ea683a7d50 of 4 bytes by task 23575 on cpu 12:
>   do_raw_spin_lock+0x114/0x200
>   debug_spin_lock_after at kernel/locking/spinlock_debug.c:91
>   (inlined by) do_raw_spin_lock at kernel/locking/spinlock_debug.c:115
>   _raw_spin_lock+0x40/0x50
>   __handle_mm_fault+0xa9e/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
>  read to 0xffffb0ea683a7d50 of 4 bytes by task 839 on cpu 60:
>   crc32_le_base+0x67/0x350
>   crc32_le_base+0x67/0x350:
>   crc32_body at lib/crc32.c:106
>   (inlined by) crc32_le_generic at lib/crc32.c:179
>   (inlined by) crc32_le at lib/crc32.c:197
>   kmemleak_scan+0x528/0xd90
>   update_checksum at mm/kmemleak.c:1172
>   (inlined by) kmemleak_scan at mm/kmemleak.c:1497
>   kmemleak_scan_thread+0xcc/0xfa
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
> 
>  write to 0xffff939bf07b95b8 of 4 bytes by interrupt on cpu 119:
>   __free_object+0x884/0xcb0
>   __free_object at lib/debugobjects.c:359
>   __debug_check_no_obj_freed+0x19d/0x370
>   debug_check_no_obj_freed+0x41/0x4b
>   slab_free_freelist_hook+0xfb/0x1c0
>   kmem_cache_free+0x10c/0x3a0
>   free_object_rcu+0x1ca/0x260
>   rcu_core+0x677/0xcc0
>   rcu_core_si+0x17/0x20
>   __do_softirq+0xd9/0x57c
>   run_ksoftirqd+0x29/0x50
>   smpboot_thread_fn+0x222/0x3f0
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
> 
>  read to 0xffff939bf07b95b8 of 8 bytes by task 838 on cpu 109:
>   scan_block+0x69/0x190
>   scan_block at mm/kmemleak.c:1250
>   kmemleak_scan+0x249/0xd90
>   scan_large_block at mm/kmemleak.c:1309
>   (inlined by) kmemleak_scan at mm/kmemleak.c:1434
>   kmemleak_scan_thread+0xcc/0xfa
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
> 
> crc32() will dereference object->pointer. If a shattered value was
> returned due to a data race, it will be corrected in the next scan.
> scan_block() will dereference a range of addresses (e.g., percpu
> sections) to search for valid pointers. Even if a data race heppens, it
> will cause no issue because the code here does not care about the exact
> value of a non-pointer. Thus, mark them as intentional data races using
> the data_race() macro.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
