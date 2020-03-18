Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D7FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EA520767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCRIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:51:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCRIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:51:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D166131B;
        Wed, 18 Mar 2020 01:51:08 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079D03F52E;
        Wed, 18 Mar 2020 01:51:07 -0700 (PDT)
Date:   Wed, 18 Mar 2020 08:51:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: silence KCSAN splats in checksum
Message-ID: <20200318085105.GQ3005@mbp>
References: <20200317182754.2180-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317182754.2180-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:27:54PM -0400, Qian Cai wrote:
> Even if KCSAN is disabled for kmemleak, update_checksum() could still
> call crc32() (which is outside of kmemleak.c) to dereference
> object->pointer. Thus, the value of object->pointer could be accessed
> concurrently as noticed by KCSAN,
> 
>  BUG: KCSAN: data-race in crc32_le_base / do_raw_spin_lock
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
> If a shattered value was returned due to a data race, it will be
> corrected in the next scan. Thus, let KCSAN ignore all reads in the
> region to silence KCSAN in case the write side is non-atomic.
> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
