Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAEBC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E816246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgB1ELZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:11:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54396 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730712AbgB1ELY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:11:24 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01S4BEUH028088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 23:11:16 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 99EFC421A71; Thu, 27 Feb 2020 23:11:14 -0500 (EST)
Date:   Thu, 27 Feb 2020 23:11:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qian Cai <cai@lca.pw>
Cc:     elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/random: fix data races at timer_rand_state
Message-ID: <20200228041114.GC101220@mit.edu>
References: <1582648024-13111-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582648024-13111-1-git-send-email-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:27:04AM -0500, Qian Cai wrote:
> Fields in "struct timer_rand_state" could be accessed concurrently.
> Lockless plain reads and writes result in data races. Fix them by adding
> pairs of READ|WRITE_ONCE(). The data races were reported by KCSAN,
> 
>  BUG: KCSAN: data-race in add_timer_randomness / add_timer_randomness
> 
>  write to 0xffff9f320a0a01d0 of 8 bytes by interrupt on cpu 22:
>   add_timer_randomness+0x100/0x190
>   add_timer_randomness at drivers/char/random.c:1152
>   add_disk_randomness+0x85/0x280
>   scsi_end_request+0x43a/0x4a0
>   scsi_io_completion+0xb7/0x7e0
>   scsi_finish_command+0x1ed/0x2a0
>   scsi_softirq_done+0x1c9/0x1d0
>   blk_done_softirq+0x181/0x1d0
>   __do_softirq+0xd9/0x57c
>   irq_exit+0xa2/0xc0
>   do_IRQ+0x8b/0x190
>   ret_from_intr+0x0/0x42
>   cpuidle_enter_state+0x15e/0x980
>   cpuidle_enter+0x69/0xc0
>   call_cpuidle+0x23/0x40
>   do_idle+0x248/0x280
>   cpu_startup_entry+0x1d/0x1f
>   start_secondary+0x1b2/0x230
>   secondary_startup_64+0xb6/0xc0
> 
>  no locks held by swapper/22/0.
>  irq event stamp: 32871382
>  _raw_spin_unlock_irqrestore+0x53/0x60
>  _raw_spin_lock_irqsave+0x21/0x60
>  _local_bh_enable+0x21/0x30
>  irq_exit+0xa2/0xc0
> 
>  read to 0xffff9f320a0a01d0 of 8 bytes by interrupt on cpu 2:
>   add_timer_randomness+0xe8/0x190
>   add_disk_randomness+0x85/0x280
>   scsi_end_request+0x43a/0x4a0
>   scsi_io_completion+0xb7/0x7e0
>   scsi_finish_command+0x1ed/0x2a0
>   scsi_softirq_done+0x1c9/0x1d0
>   blk_done_softirq+0x181/0x1d0
>   __do_softirq+0xd9/0x57c
>   irq_exit+0xa2/0xc0
>   do_IRQ+0x8b/0x190
>   ret_from_intr+0x0/0x42
>   cpuidle_enter_state+0x15e/0x980
>   cpuidle_enter+0x69/0xc0
>   call_cpuidle+0x23/0x40
>   do_idle+0x248/0x280
>   cpu_startup_entry+0x1d/0x1f
>   start_secondary+0x1b2/0x230
>   secondary_startup_64+0xb6/0xc0
> 
>  no locks held by swapper/2/0.
>  irq event stamp: 37846304
>  _raw_spin_unlock_irqrestore+0x53/0x60
>  _raw_spin_lock_irqsave+0x21/0x60
>  _local_bh_enable+0x21/0x30
>  irq_exit+0xa2/0xc0
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks, applied.

					- Ted
