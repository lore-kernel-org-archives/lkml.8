Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7296CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50320678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d74Z+4+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbgDBPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:33:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbgDBPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAB4FKmrAwMSXS3bFgkS7qXE7ubZhAEmx+ZEk9qYg0s=; b=d74Z+4+mRIMe2s36Wy2LEQt48U
        1h5Jf3ygWPQqdrwI+h0kaAoqYbmbHQJNAoHM5GZBZ3yMHA0D9IfACk/Ba56zbpVq/UvgW8AzE3cOg
        zWi0kCQyONwF9LLWdTyOpycmh/BIvxKMmxTPD10zDXQbkO0E6MrnR9nqMxmjV22KTQO4Nr9wASALT
        sSF3zuSfkXdSiK65xNpskImIu5ehqqTbAjmv9909CO2w3thudN5HiZ+fwre5fXVNy/AvuMIKMoAZe
        X2paHr38fcO4FMsr+1Ljqkud+BE9BwkSZUojlzTnYDy0Kxl+QS3/3hB7fqPTu1qTmyXHKthbB/N+0
        bi9mHZig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK1qI-00066Z-Cg; Thu, 02 Apr 2020 15:33:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 343263010BC;
        Thu,  2 Apr 2020 17:33:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 147CB2B0DECD2; Thu,  2 Apr 2020 17:33:16 +0200 (CEST)
Date:   Thu, 2 Apr 2020 17:33:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hejingxian <hejingxian@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Hushiyuan <hushiyuan@huawei.com>,
        "hewenliang (C)" <hewenliang4@huawei.com>
Subject: Re: [PATCH] fair sched: Fix signed integer overflow problem in fair
 sched
Message-ID: <20200402153316.GF20730@hirez.programming.kicks-ass.net>
References: <1D850B2B2FDCCD4EAD93967D2CFC56B113ABAB1E@dggemm501-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D850B2B2FDCCD4EAD93967D2CFC56B113ABAB1E@dggemm501-mbs.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:52:40PM +0000, hejingxian wrote:
> During execution applications in my arm64 virtual machine with UBSAN, the UBSAN error message is showed:
> UBSAN: Undefined behaviour in kernel/sched/fair.c
> signed integer overflow:
> 166982794708445 * 64885 cannot be represented in type 'long int'
> CPU: 40 PID: 4134072 Comm: stress-ng-sched Kdump: loaded Tainted: G    B   W  OE     4.19.95-vhulk2002.1.0.0041.eulerosv2r8.aarch64 #1
> Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 0.98 08/25/2019
> Call trace:
>         dump_backtrace+0x0/0x310
>         show_stack+0x28/0x38
>         dump_stack+0xd8/0x108
>         ubsan_epilogue+0x1c/0x94
>         handle_overflow+0x14c/0x19c
>         __ubsan_handle_mul_overflow+0x34/0x44
>         task_numa_find_cpu+0xdec/0x1058
>         task_numa_migrate+0x3ac/0x12d0
>         task_numa_fault+0x4f0/0x5f0
>         do_numa_page+0x480/0x848
>         __handle_mm_fault+0x8d8/0x9b0
>         handle_mm_fault+0x280/0x460
>         do_page_fault+0x3ec/0x890
>         do_translation_fault+0xe4/0x100
>         do_mem_abort+0xc0/0x1b0
>         el0_da+0x24/0x28
> 
> The multiplication of signed long integers in load_too_imbalanced may
> occur overflow, then we use unsigned long integers instead of signed integers.

NAK, UBSAN is smoking dope, and you patch is actively wrong.
