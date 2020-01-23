Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119B8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB0C2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWJdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:33:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:56919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:33:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 01:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="287394507"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2020 01:33:48 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2] perf/core: fix mlock accounting in perf_mmap()
In-Reply-To: <20200122190447.1920297-1-songliubraving@fb.com>
References: <20200122190447.1920297-1-songliubraving@fb.com>
Date:   Thu, 23 Jan 2020 11:33:47 +0200
Message-ID: <8736c6bjpg.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

> sysctl_perf_event_mlock and user->locked_vm can change value
> independently, so we can't guarantee:

Looks good, I still have some suggestions below.

>
>    user->locked_vm <= user_lock_limit
>
> When user->locked_vm is larger than user_lock_limit, we cannot simply
> update extra and user_extra as:
>
>    extra = user_locked - user_lock_limit;
>    user_extra -= extra;
>
> Otherwise, user_extra will be negative. In extreme cases, this may lead to
> negative user->locked_vm (until this perf-mmap is closed), which break
> locked_vm badly.
>
> Fix this by adjusting user_locked before calculating extra and user_extra.

The commit message is just talking about the code. We can see the code
when we scroll down to the diff. What this can be instead is:

1. Problem statement: decreasing sysctl_perf_event_mlock between two
consecutive mmap()s of a perf ring buffer may lead to an integer
underflow in locked memory accounting. This may lead to the following
undesired behavior: <an example of bad behavior as opposed to expected
behavior>.

2. Fix description: address this by adjusting the accounting logic to
take into account the possibility that the amount of already locked
memory may exceed the current limit.

> Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again")
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/events/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2173c23c25b4..d25f2de45996 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5916,8 +5916,19 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  	 */
>  	user_lock_limit *= num_online_cpus();
>  
> -	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
> +	user_locked = atomic_long_read(&user->locked_vm);
>  
> +	/*
> +	 * sysctl_perf_event_mlock and user->locked_vm can change value
> +	 * independently. so we can't guarantee:
> +	 *     user->locked_vm <= user_lock_limit

"sysctl_perf_event_mlock may have changed, so that user->locked_vm >
user_lock_limit".

> +	 *
> +	 * Adjust user_locked to be <= user_lock_limit so we can calcualte
> +	 * correct extra and user_extra.

This comment is also verbalizing the C code that follows. I don't think
it's necessary.

> +	 */
> +	user_locked = min_t(unsigned long, user_locked, user_lock_limit);

A matter of preference, but to me the "if (user_locked >=
user_lock_limit)" is easier to read.

> +
> +	user_locked += user_extra;
>  	if (user_locked > user_lock_limit) {
>  		/*
>  		 * charge locked_vm until it hits user_lock_limit;

Thanks,
--
Alex
