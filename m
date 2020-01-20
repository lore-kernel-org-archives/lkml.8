Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EEC33CBA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90E207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATIYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:24:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:34292 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATIYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:24:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 00:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="226990721"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2020 00:24:01 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
In-Reply-To: <20200117234503.1324050-1-songliubraving@fb.com>
References: <20200117234503.1324050-1-songliubraving@fb.com>
Date:   Mon, 20 Jan 2020 10:24:00 +0200
Message-ID: <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

> sysctl_perf_event_mlock and user->locked_vm can change value
> independently, so we can't guarantee:
>
>     user->locked_vm <= user_lock_limit

This means: if the sysctl got sufficiently decreased, so that the
existing locked_vm exceeds it, we need to deal with the overflow, right?

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a1f8bde19b56..89acdd1574ef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5920,11 +5920,31 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  	if (user_locked > user_lock_limit) {
>  		/*
> -		 * charge locked_vm until it hits user_lock_limit;
> -		 * charge the rest from pinned_vm
> +		 * sysctl_perf_event_mlock and user->locked_vm can change
> +		 * value independently, so we can't guarantee:
> +		 *
> +		 *    user->locked_vm <= user_lock_limit
> +		 *
> +		 * We need be careful to make sure user_extra >=0.
> +		 *
> +		 * Using "user_locked - user_extra" to avoid calling
> +		 * atomic_long_read() again.
>  		 */
> -		extra = user_locked - user_lock_limit;
> -		user_extra -= extra;
> +		if (user_locked - user_extra >= user_lock_limit) {
> +			/*
> +			 * already used all user_locked_limit, charge all
> +			 * to pinned_vm
> +			 */
> +			extra = user_extra;
> +			user_extra = 0;
> +		} else {
> +			/*
> +			 * charge locked_vm until it hits user_lock_limit;
> +			 * charge the rest from pinned_vm
> +			 */
> +			extra = user_locked - user_lock_limit;
> +			user_extra -= extra;
> +		}

How about the below for the sake of brevity?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 763cf34b5a63..632505ce6c12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5917,7 +5917,14 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	 */
 	user_lock_limit *= num_online_cpus();
 
-	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
+	user_locked = atomic_long_read(&user->locked_vm);
+	/*
+	 * If perf_event_mlock has changed since earlier mmaps, so that
+	 * it's smaller than user->locked_vm, discard the overflow.
+	 */
+	if (user_locked > user_lock_limit)
+		user_locked = user_lock_limit;
+	user_locked += user_extra;
 
 	if (user_locked > user_lock_limit) {
 		/*

Regards,
--
Alex
