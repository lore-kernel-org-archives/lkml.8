Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6DC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40352075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgAMJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:44:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:44:09 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iqwG8-0003DP-1q; Mon, 13 Jan 2020 09:43:44 +0000
Date:   Mon, 13 Jan 2020 10:43:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        oleg@redhat.com, elena.reshetova@intel.com, jgg@ziepe.ca,
        christian@kellner.me, aarcange@redhat.com, viro@zeniv.linux.org.uk,
        cyphar@cyphar.com, ldv@altlinux.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/fork: put some fork variables into read-mostly
 section
Message-ID: <20200113094342.5ghlgttmhuxfqv2v@wittgenstein>
References: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:23:13AM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Since total_forks/nr_threads/max_threads global variables are
> frequently used for process fork, putting these variables into
> read_mostly section can avoid unnecessary cache line bouncing.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  kernel/fork.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0808095..163e152 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -120,10 +120,10 @@
>  /*
>   * Protected counters by write_lock_irq(&tasklist_lock)
>   */
> -unsigned long total_forks;	/* Handle normal Linux uptimes. */
> -int nr_threads;			/* The idle threads do not count.. */
> +unsigned long total_forks __read_mostly; /* Handle normal Linux uptimes. */
> +int nr_threads __read_mostly;  /* The idle threads do not count.. */

total_forks is incremented at every ~CLONE_THREAD and nr_threads at
CLONE_THREAD I wouldn't exactly say that this qualifies as mostly
reading.

>  
> -static int max_threads;		/* tunable limit on nr_threads */
> +static int max_threads __read_mostly; /* tunable limit on nr_threads */

That make sense.

Christian
